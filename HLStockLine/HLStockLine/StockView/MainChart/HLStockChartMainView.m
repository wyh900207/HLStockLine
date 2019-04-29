//
//  HLStockChartMainView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLStockChartMainView.h"

@interface HLStockChartMainView ()

@property (nonatomic, assign) NSInteger                                startXPosition;
@property (nonatomic, assign) CGFloat                                  oldContentOffsetX;
@property (nonatomic, assign) CGFloat                                  oldScale;
@property (nonatomic, strong) NSMutableArray<HLKLineModel *>         * displayLineModel;
@property (nonatomic, strong) NSMutableArray<HLKLinePositionModel *> * displayLinePositionModel;
@property (nonatomic, strong) NSMutableArray *MA7Positions;
@property (nonatomic, strong) NSMutableArray *MA30Positions;
@property (nonatomic, strong) NSMutableArray *BOLL_MBPositions;
@property (nonatomic, strong) NSMutableArray *BOLL_UPPositions;
@property (nonatomic, strong) NSMutableArray *BOLL_DNPositions;

@end

@implementation HLStockChartMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.displayLineModel = @[].mutableCopy;
        self.displayLinePositionModel = @[].mutableCopy;
        self.MA7Positions = @[].mutableCopy;
        self.MA30Positions = @[].mutableCopy;
        
        self.BOLL_UPPositions = @[].mutableCopy;
        self.BOLL_DNPositions = @[].mutableCopy;
        self.BOLL_MBPositions = @[].mutableCopy;
        
        self.needDrawStartIndex = 0;
        self.oldContentOffsetX = 0;
        self.oldScale = 0;
    }
    return self;
}

- (void)didMoveToSuperview {
    _parentScrollView = (UIScrollView *)self.superview;
    [_parentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [super didMoveToSuperview];
}

#pragma mark - Public

- (void)draw {
    // 提取需要展示的Model
    [self extractNeedDrawModels];
    // 转换坐标
    [self modelsConvertToPostionsModels];
    [self setNeedsDisplay];
}

- (void)updateMainViewWidth {
    CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
    CGFloat kLineViewWidth = self.kLineModels.count * k_line_width + (self.kLineModels.count + 1) + 10;
    
    if (kLineViewWidth < self.parentScrollView.bounds.size.width) {
        kLineViewWidth = self.parentScrollView.bounds.size.width;
    }
    
    //CGRect rect = self.frame;
    
    if (self.pinchStartIndex) {
        CGFloat new_x = self.pinchStartIndex * (k_line_width + 1) + 1;
        [self.parentScrollView setContentOffset:CGPointMake(new_x, 0) animated:NO];
    }
    
    //    self.frame = CGRectMake(rect.origin.x, self.parentScrollView.contentOffset.x, rect.size.width, rect.size.height);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.parentScrollView);
        make.left.equalTo(self.parentScrollView).offset(self.parentScrollView.contentOffset.x);
    }];
    
    [self layoutIfNeeded];
    
    self.parentScrollView.contentSize = CGSizeMake(kLineViewWidth, self.parentScrollView.contentSize.height);
}

- (NSInteger)getNeedDrawStartIndexWithScroll:(BOOL)scorll {
    if (scorll) {
        CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0 : self.parentScrollView.contentOffset.x;
        
        CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
        
        NSUInteger leftArrCount = ABS(scrollViewOffsetX - 1) / (1 + k_line_width);
        _needDrawStartIndex = leftArrCount;
    }
    
    return _needDrawStartIndex;
}


#pragma mark - Private Methods

- (NSArray *)extractNeedDrawModels {
    CGFloat lineGap = [HLStockChartViewConfig lineShadowWidth];
    CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
    
    // 数组个数
    CGFloat scrollViewWidth = self.parentScrollView.frame.size.width;
//    CGFloat scrollViewWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger needDrawKLineCount = (scrollViewWidth - lineGap) / (lineGap + k_line_width);
    
    // 起始位置
    NSInteger needDrawKLineStartIndex;
    
    if (self.pinchStartIndex > 0) {
        needDrawKLineStartIndex = self.pinchStartIndex;
        _needDrawStartIndex = self.pinchStartIndex;
        self.pinchStartIndex = -1;
    } else {
        needDrawKLineStartIndex = [self getNeedDrawStartIndexWithScroll:YES];
    }
    
    needDrawKLineStartIndex = [self getNeedDrawStartIndexWithScroll:YES];
    
    // 重新计算需要显示的 数据源
    [self.displayLineModel removeAllObjects];
    
    if (needDrawKLineStartIndex < self.kLineModels.count) {
        if (needDrawKLineStartIndex + needDrawKLineCount < self.kLineModels.count) {
            [self.displayLineModel addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, needDrawKLineCount)]];
        } else {
            [self.displayLineModel addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, self.kLineModels.count - needDrawKLineStartIndex)]];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(stockMainViewDisplayModels:)]) {
        [self.delegate stockMainViewDisplayModels:self.displayLineModel];
    }
    
    return self.displayLineModel;
}

- (NSArray<HLKLinePositionModel *> *)modelsConvertToPostionsModels {
    if (!self.displayLineModel) return nil;
    
    NSArray<HLKLineModel *> *kLineModels = self.displayLineModel;
    
    HLKLineModel *firstModel = kLineModels.firstObject;
    __block CGFloat minAssert = firstModel.low.floatValue;
    __block CGFloat maxAssert = firstModel.high.floatValue;
    
    @weakify(self);
    
    [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.high.floatValue > maxAssert) {
            maxAssert = obj.high.floatValue;
        }
        if (obj.low.floatValue < minAssert) {
            minAssert = obj.low.floatValue;
        }
        
//        minAssert = obj.low.floatValue > minAssert ? minAssert : obj.low.floatValue;
//        maxAssert = obj.high.floatValue < maxAssert ? maxAssert : obj.high.floatValue;
        
        @strongtify(self);
        if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
            if (obj.BOLL_MB) {
                if (minAssert > obj.BOLL_MB.floatValue) {
                    minAssert = obj.BOLL_MB.floatValue;
                }
                if (maxAssert < obj.BOLL_MB.floatValue) {
                    maxAssert = obj.BOLL_MB.floatValue;
                }
            }
            if(obj.BOLL_UP)
            {
                if (minAssert > obj.BOLL_UP.floatValue) {
                    minAssert = obj.BOLL_UP.floatValue;
                }
                if (maxAssert < obj.BOLL_UP.floatValue) {
                    maxAssert = obj.BOLL_UP.floatValue;
                }
            }
            
            if(obj.BOLL_DN)
            {
                if (minAssert > obj.BOLL_DN.floatValue) {
                    minAssert = obj.BOLL_DN.floatValue;
                }
                if (maxAssert < obj.BOLL_DN.floatValue) {
                    maxAssert = obj.BOLL_DN.floatValue;
                }
            }
        }
        else {
            if(obj.MA7)
            {
                if (minAssert > obj.MA7.floatValue) {
                    minAssert = obj.MA7.floatValue;
                }
                if (maxAssert < obj.MA7.floatValue) {
                    maxAssert = obj.MA7.floatValue;
                }
            }
            if(obj.MA30)
            {
                if (minAssert > obj.MA30.floatValue) {
                    minAssert = obj.MA30.floatValue;
                }
                if (maxAssert < obj.MA30.floatValue) {
                    maxAssert = obj.MA30.floatValue;
                }
            }
        }
    }];
    
    CGFloat minY = 20;
    CGFloat maxY = self.bounds.size.height - 24;
    CGFloat unitValue = (maxAssert - minAssert) / (maxY - minY);  // 没个物理像素对应多少大盘点
    
    /*
     Y坐标: 最大值 - (实际值 - 最小值) / unitValue
     
     如: View.bounds = (0, 0, 100, 100)
     0 - 3000点            -----
     
     最高 2800点              |
     收盘 2600点             ---
     | |
     | |
     开盘 2500点             ---
     |
     最低 2200点
     
     100 - 2000点          -----
     
     unitValue = (3000 - 2000) / (100 - 0) = 10
     
     high  = 100 - (2800 - 2000) / 10 = 20
     close = 100 - (2600 - 2000) / 10 = 40
     open  = 100 - (2500 - 2000) / 10 = 50
     low   = 100 - (2200 - 2000) / 10 = 80
     */
    
    [self.displayLinePositionModel removeAllObjects];
    [self.MA7Positions removeAllObjects];
    [self.MA30Positions removeAllObjects];
    
    [self.BOLL_MBPositions removeAllObjects];
    [self.BOLL_UPPositions removeAllObjects];
    [self.BOLL_DNPositions removeAllObjects];
    
    for (NSUInteger idx = 0; idx < kLineModels.count; idx++) {
        HLKLineModel *klineModel = kLineModels[idx];
        
        CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
        CGFloat line_gap = [HLStockChartViewConfig lineShadowWidth];
        CGFloat x_position = self.startXPosition + idx * (k_line_width + line_gap) + k_line_width * 0.5;
        
        CGFloat open_point_y = ABS(maxY - (klineModel.open.floatValue - minAssert) / unitValue);
        CGFloat close_point_y = ABS(maxY - (klineModel.close.floatValue - minAssert) / unitValue);
        CGFloat high_point_y = ABS(maxY - (klineModel.high.floatValue - minAssert) / unitValue);
        CGFloat low_point_y = ABS(maxY - (klineModel.low.floatValue - minAssert) / unitValue);
        
        CGPoint open_point = CGPointMake(x_position, open_point_y);
        
        if (ABS(close_point_y - open_point_y) < 2) {
            if (open_point_y > close_point_y) {
                open_point_y = close_point_y + 2;
            }
            else if (open_point_y < close_point_y) {
                close_point_y = open_point_y + 2;
            }
            else {
                if (idx > 0) {
                    HLKLineModel *pre_line_model = kLineModels[idx - 1];
                    if (klineModel.open.floatValue > pre_line_model.close.floatValue) {
                        open_point_y = close_point_y + 2;
                    } else {
                        close_point_y = open_point_y + 2;
                    }
                } else if (idx + 1 < kLineModels.count) {
                    HLKLineModel *sub_line_model = kLineModels[idx + 1];
                    if (klineModel.close.floatValue < sub_line_model.open.floatValue) {
                        open_point_y = close_point_y + 2;
                    }
                    else {
                        close_point_y = open_point_y + 2;
                    }
                }
            }
        }
        
        CGPoint close_point = CGPointMake(x_position, close_point_y);
        CGPoint high_point = CGPointMake(x_position, high_point_y);
        CGPoint low_point = CGPointMake(x_position, low_point_y);
        
        HLKLinePositionModel *line_position_model = [HLKLinePositionModel modelWithOpen:open_point close:close_point high:high_point low:low_point];
        [self.displayLinePositionModel addObject:line_position_model];
        
        // MA坐标转换
        CGFloat ma7Y = maxY;
        CGFloat ma30Y = maxY;
        if(unitValue > 0.0000001)
        {
            if(klineModel.MA7)
            {
                ma7Y = maxY - (klineModel.MA7.floatValue - minAssert)/unitValue;
            }
            
        }
        if(unitValue > 0.0000001)
        {
            if(klineModel.MA30)
            {
                ma30Y = maxY - (klineModel.MA30.floatValue - minAssert)/unitValue;
            }
        }
        
        NSAssert(!isnan(ma7Y) && !isnan(ma30Y), @"出现NAN值");
        
        CGPoint ma7Point = CGPointMake(x_position, ma7Y);
        CGPoint ma30Point = CGPointMake(x_position, ma30Y);
        
        if(klineModel.MA7)
        {
            [self.MA7Positions addObject:[NSValue valueWithCGPoint: ma7Point]];
        }
        if(klineModel.MA30)
        {
            [self.MA30Positions addObject:[NSValue valueWithCGPoint: ma30Point]];
        }
        
        
        if(_targetLineStatus == Y_StockChartTargetLineStatusBOLL){
            
            
            //BOLL坐标转换
            CGFloat boll_mbY = maxY;
            CGFloat boll_upY = maxY;
            CGFloat boll_dnY = maxY;
            
            NSLog(@"position：\n上: %@ \n中: %@ \n下: %@",klineModel.BOLL_UP,klineModel.BOLL_MB,klineModel.BOLL_DN);
            
            
            if(unitValue > 0.0000001)
            {
                
                if(klineModel.BOLL_MB)
                {
                    boll_mbY = maxY - (klineModel.BOLL_MB.floatValue - minAssert)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(klineModel.BOLL_DN)
                {
                    boll_dnY = maxY - (klineModel.BOLL_DN.floatValue - minAssert)/unitValue ;
                }
            }
            
            if(unitValue > 0.0000001)
            {
                if(klineModel.BOLL_UP)
                {
                    boll_upY = maxY - (klineModel.BOLL_UP.floatValue - minAssert)/unitValue;
                }
            }
            
            NSAssert(!isnan(boll_mbY) && !isnan(boll_upY) && !isnan(boll_dnY), @"出现BOLL值");
            
            CGPoint boll_mbPoint = CGPointMake(x_position, boll_mbY);
            CGPoint boll_upPoint = CGPointMake(x_position, boll_upY);
            CGPoint boll_dnPoint = CGPointMake(x_position, boll_dnY);
            
            
            if (klineModel.BOLL_MB) {
                [self.BOLL_MBPositions addObject:[NSValue valueWithCGPoint:boll_mbPoint]];
            }
            
            if (klineModel.BOLL_UP) {
                [self.BOLL_UPPositions addObject:[NSValue valueWithCGPoint:boll_upPoint]];
            }
            if (klineModel.BOLL_DN) {
                [self.BOLL_DNPositions addObject:[NSValue valueWithCGPoint:boll_dnPoint]];
            }
            
        }
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(stockMainViewCurrentMaxPrice:minPrice:)]) {
            [self.delegate stockMainViewCurrentMaxPrice:maxAssert minPrice:minAssert];
        }
        if ([self.delegate respondsToSelector:@selector(stockMainViewDisplayPostionModels:)]) {
            [self.delegate stockMainViewDisplayPostionModels:self.displayLinePositionModel];
        }
    }
    
    return self.displayLinePositionModel;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextFillRect(context, rect);
    
    if (!self.displayLineModel) return;
    
    NSMutableArray *kLineColors = @[].mutableCopy;
    
    // K线图上部的各种指标
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // ASSIST_BACKGROUND_COLOR.CGColor | HexColor(@"1d2227") | [UIColor whiteColor]
    CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 15));
    
    // 日期区域背景色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // ASSIST_BACKGROUND_COLOR.CGColor | HexColor(@"1d2227") | [UIColor whiteColor]
    CGContextFillRect(context, CGRectMake(0, rect.size.height - 24, rect.size.width, 24));
    
    // 日期上&下线条
    CGContextSetLineWidth(context, 0.5);
    CGPoint left_top_point = CGPointMake(0, rect.size.height - 24);
    CGPoint right_top_point = CGPointMake(rect.size.width, rect.size.height - 24);
    CGPoint left_bottom_point = CGPointMake(0, rect.size.height - 0.5);
    CGPoint right_bottom_point = CGPointMake(rect.size.width, rect.size.height - 0.5);
    CGContextSetStrokeColorWithColor(context, HexColor(@"E6E6E6").CGColor);
    const CGPoint top_line[] = {left_top_point, right_top_point};
    const CGPoint bottom_line[] = {left_bottom_point, right_bottom_point};
    CGContextStrokeLineSegments(context, top_line, 2);
    CGContextStrokeLineSegments(context, bottom_line, 2);
    
    //  画虚线
    for (int i = 1; i < 4; i++) {
        CGFloat origin_x = rect.size.width * (0.25 * i);
        CGFloat origin_y = (rect.size.height - 24) * (0.25 * i);
        CGFloat lengths[] = {5, 5};
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, HexColor(@"EEEEEE").CGColor);
        CGContextBeginPath(context);
        CGContextSetLineDash(context, 0, lengths, 2);
        // 纵向
        CGContextMoveToPoint(context, origin_x, 0);
        CGContextAddLineToPoint(context, origin_x, rect.size.height - 24);
        // 横向
        CGContextMoveToPoint(context, 0, origin_y);
        CGContextAddLineToPoint(context, rect.size.width, origin_y);
        
        CGContextStrokePath(context);
    }
    
    // 取消虚线和圆角
    CGFloat lengths[] = {5, 0};
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineDash(context, 0, lengths, 2);
    
    HLMALine *MALine = [[HLMALine alloc] initWithContext:context];
    
    if (self.MainViewType == Y_StockChartcenterViewTypeKline) {
        HLKLine *line = [[HLKLine alloc] initWithContext:context];
        line.maxY = rect.size.height - 24;
        
        [self.displayLinePositionModel enumerateObjectsUsingBlock:^(HLKLinePositionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            line.postionModel = obj;
            line.model = self.displayLineModel[idx];
            UIColor *color = [line draw];
            [kLineColors addObject:color];
        }];
    }
    else {
        __block NSMutableArray *positions = @[].mutableCopy;
        [self.displayLinePositionModel enumerateObjectsUsingBlock:^(HLKLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            UIColor *strokeColor = positionModel.open.y < positionModel.close.y ? COLOR_INCREASING : COLOR_DECREASING;
            [kLineColors addObject:strokeColor];
            [positions addObject:[NSValue valueWithCGPoint:positionModel.close]];
        }];
        MALine.MAPositions = positions;
        MALine.MAType = -1;
        [MALine draw];
        //
        __block CGPoint lastDrawDatePoint = CGPointZero;//fix
        [self.displayLinePositionModel enumerateObjectsUsingBlock:^(HLKLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGPoint point = [positions[idx] CGPointValue];
            
            //日期
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.displayLineModel[idx].date.doubleValue];
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"HH:mm";
            NSString *dateStr = [formatter stringFromDate:date];
            
            CGPoint drawDatePoint = CGPointMake(point.x + 1, rect.size.height - 15 + 1.5);
            if(CGPointEqualToPoint(lastDrawDatePoint, CGPointZero) || point.x - lastDrawDatePoint.x > 60 )
            {
                [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName: HexColor(@"565a64")}];
                lastDrawDatePoint = drawDatePoint;
            }
        }];
    }

    if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        // 画BOLL MB线 标准线
        MALine.MAType = Y_BOLL_MB;
        MALine.BOLLPositions = self.BOLL_MBPositions;
        [MALine draw];
        
        // 画BOLL UP 上浮线
        MALine.MAType = Y_BOLL_UP;
        MALine.BOLLPositions = self.BOLL_UPPositions;
        [MALine draw];
        
        // 画BOLL DN下浮线
        MALine.MAType = Y_BOLL_DN;
        MALine.BOLLPositions = self.BOLL_DNPositions;
        [MALine draw];
    }
    else if (self.targetLineStatus != Y_StockChartTargetLineStatusCloseMA) {
        // MA7
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.MA7Positions;
        [MALine draw];
        
        // MA30
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.MA30Positions;
        [MALine draw];
    }
    
    if (self.delegate && kLineColors > 0) {
        if ([self.delegate respondsToSelector:@selector(stockMainViewDisplayColors:)]) {
            [self.delegate stockMainViewDisplayColors:kLineColors];
        }
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
       
        CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
        CGFloat k_line_gap = [HLStockChartViewConfig lineShadowWidth];
        
        CGFloat difValue = ABS(self.parentScrollView.contentOffset.x - self.oldContentOffsetX);
//        if (difValue >= (k_line_width + k_line_gap)) {
            self.oldContentOffsetX = self.parentScrollView.contentOffset.x;
            [self draw];
            //            CGRect rect = self.frame;
            //            self.frame = CGRectMake(self.parentScrollView.contentOffset.x, rect.origin.y, rect.size.width, rect.size.height);
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.parentScrollView).offset(self.parentScrollView.contentOffset.x);
                make.width.equalTo(self.parentScrollView);
            }];
//        }
    }
}

#pragma mark - Getter

- (NSInteger)startXPosition {
    return 0;
}

- (NSInteger)needDrawStartIndex {
    CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
    CGFloat scrollViewOffsetX = self.parentScrollView.contentOffset.x < 0 ? 0: self.parentScrollView.contentOffset.x;
    NSUInteger leftArrCount = ABS(scrollViewOffsetX - 1) / (1 + k_line_width);
    _needDrawStartIndex = leftArrCount;
    
    return _needDrawStartIndex;
}

- (void)setKLineModels:(NSArray<HLKLineModel *> *)kLineModels {
    _kLineModels = kLineModels;
    [self updateMainViewWidth];
}

@end
