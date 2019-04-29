//
//  HLMinuteView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/26.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLMinuteView.h"

@interface HLMinuteView ()

@property (nonatomic, strong) HLRightQuotationView * rightQuotationView;
@property (nonatomic, strong) NSMutableArray<HLMinutesPositionModel *> * postionModels;

@end

@implementation HLMinuteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.postionModels = @[].mutableCopy;
        [self setupSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)setupSubviews {
    [self addSubview:self.rightQuotationView];
    
    [self.rightQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 模型转换
    [self convertMinutesModelToPostionModel];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 背景色
    CGContextSetFillColorWithColor(context, HexColor(@"FFFFFF").CGColor);
    CGContextFillRect(context, rect);
    
    //  画虚线
    for (int i = 1; i < 4; i++) {
        CGFloat origin_x = rect.size.width * (0.25 * i);
        CGFloat origin_y = rect.size.height * (0.25 * i);
        CGFloat lengths[] = {5, 5};
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, HexColor(@"EEEEEE").CGColor);
        CGContextBeginPath(context);
        CGContextSetLineDash(context, 0, lengths, 2);
        // 纵向
        CGContextMoveToPoint(context, origin_x, 0);
        CGContextAddLineToPoint(context, origin_x, rect.size.height);
        // 横向
        CGContextMoveToPoint(context, 0, origin_y);
        CGContextAddLineToPoint(context, rect.size.width, origin_y);
        
        CGContextStrokePath(context);
    }
    
    CGContextSetLineWidth(context, 1);
    UIColor * strock_color = HexColor(@"1BA1C6");//266EBF
    CGContextSetStrokeColorWithColor(context, strock_color.CGColor);
    
    CGFloat lengths[] = {5, 0};
    CGContextSetLineDash(context, 0, lengths, 2);
    
    for (int idx = 0; idx < self.postionModels.count; idx++) {
        HLMinutesPositionModel * position_model = self.postionModels[idx];
        if (idx == 0) {
            CGContextMoveToPoint(context, position_model.point.x, position_model.point.y);
        }
        else {
            CGContextAddLineToPoint(context, position_model.point.x, position_model.point.y);
        }
    }
    CGContextStrokePath(context);

    
    CGContextClosePath(context);
}

#pragma mark - Public Methods

- (void)draw {
//    [self convertMinutesModelToPostionModel];
    [self setNeedsDisplay];
}

#pragma mark - Private Methods

- (void)convertMinutesModelToPostionModel {
    NSMutableArray * points = @[].mutableCopy;
    
    for (int i = 0; i < self.groupModel.dataList.count; i++) {
        HLMinutesModel * model = self.groupModel.dataList[i];
        if (model.point) [points addObject:model.point];
    }
    
    // 最大值 & 最小值
    NSInteger maxValue = [[points valueForKeyPath:@"@max.integerValue"] integerValue];
    NSInteger minValue = [[points valueForKeyPath:@"@min.integerValue"] integerValue];
    
    NSInteger max_point_y = 0;
    NSInteger min_point_y = 0;
    
    if (!self.yestodayClosePoints) return;
    
    // 最大偏离点 & 最小偏离点
    NSInteger max_reduce = maxValue - self.yestodayClosePoints.integerValue;
    NSInteger min_reduce = self.yestodayClosePoints.integerValue - minValue;
    
    if (max_reduce > min_reduce) {
        min_point_y = self.yestodayClosePoints.integerValue - max_reduce;
        max_point_y = self.yestodayClosePoints.integerValue + max_reduce;
    }
    else {
        max_point_y = self.yestodayClosePoints.integerValue + min_reduce;
        min_point_y = self.yestodayClosePoints.integerValue - min_reduce;
    }
    
    CGFloat max = max_point_y;
    CGFloat quarter = (max_point_y - min_point_y) * 0.75 + min_point_y;
    CGFloat middle = (max_point_y + min_point_y) * 0.5;
    CGFloat three_quarter = (max_point_y - min_point_y) * 0.25 + min_point_y;
    CGFloat min = min_point_y;
    
    self.rightQuotationView.maxValue = max;
    self.rightQuotationView.minValue = min;
    self.rightQuotationView.middleValue = middle;
    self.rightQuotationView.quarterValue = quarter;
    self.rightQuotationView.threeQuarterValue = three_quarter;
    
    self.rightQuotationView.maxPercentValue = (max / middle) - 1;
    self.rightQuotationView.quarterPercentValue = (quarter / middle) - 1;
    self.rightQuotationView.middlePercentValue = 0;
    self.rightQuotationView.threeQuarterPercentValue = 1 - (quarter / middle);
    self.rightQuotationView.minPercentValue = 1 - (max / middle);
    
    // X 坐标
    //__block NSMutableArray<HLMinutesPositionModel *> * postion_models = @[].mutableCopy;
    [self.postionModels removeAllObjects];
    CGFloat unit_value_x = self.bounds.size.width / self.groupModel.dateList.count;
    CGFloat unit_value_y = (max_point_y - min_point_y) / (self.bounds.size.height - 40);
    //CGFloat min_Y = self.frame.origin.y;
    CGFloat max_Y = self.bounds.size.height - 20;
    
    @weakify(self);
    [self.groupModel.dataList enumerateObjectsUsingBlock:^(HLMinutesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongtify(self);
        CGFloat postion_y = ABS(max_Y - (obj.point.floatValue - minValue) / unit_value_y);
        HLMinutesPositionModel * minute_position = [HLMinutesPositionModel new];
        minute_position.point = CGPointMake(unit_value_x * idx, postion_y);
        [self.postionModels addObject:minute_position];
    }];
}

#pragma mark - Getter

- (HLRightQuotationView *)rightQuotationView {
    if (!_rightQuotationView) {
        _rightQuotationView = [HLRightQuotationView new];
        _rightQuotationView.maxValue = 100;
        _rightQuotationView.minValue = 0;
        _rightQuotationView.middleValue = 50;
        _rightQuotationView.userInteractionEnabled = NO;
        _rightQuotationView.isMinutes = YES;
    }
    return _rightQuotationView;
}

- (HLMinutesGroupModel *)groupModel {
    if (!_groupModel) {
        _groupModel = [self dataSource];
    }
    return _groupModel;
}

#pragma mark - Test

- (HLMinutesGroupModel *)dataSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minute_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    HLMinutesGroupModel *group_model = [HLMinutesGroupModel convenienceInitWith:dict];
    
    return group_model;
}

@end
