//
//  HLAssistView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLAssistView.h"

@interface HLAssistView ()

@property (nonatomic, strong) NSArray * displayAssistPositionModels;
// MACD
@property (nonatomic, strong) NSMutableArray * DIF_Positions;
@property (nonatomic, strong) NSMutableArray * DEA_Positions;
// KDJ
@property (nonatomic, strong) NSMutableArray * KDJ_K_Positions;
@property (nonatomic, strong) NSMutableArray * KDJ_D_Positions;
@property (nonatomic, strong) NSMutableArray * KDJ_J_Positions;

@end

@implementation HLAssistView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.DIF_Positions = @[].mutableCopy;
        self.DEA_Positions = @[].mutableCopy;
        self.KDJ_K_Positions = @[].mutableCopy;
        self.KDJ_D_Positions = @[].mutableCopy;
        self.KDJ_J_Positions = @[].mutableCopy;
        
        [self setupSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)setupSubviews {
    
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!self.displayAssistPositionModels) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.targetLineStatus != Y_StockChartTargetLineStatusKDJ) {
        // MACD
        HLAssistLine * assistLine = [[HLAssistLine alloc] initWithContext:context];
        [self.displayAssistPositionModels enumerateObjectsUsingBlock:^(HLVolumePostionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            assistLine.positionModel = obj;
            assistLine.kLineModel = self.displayKlineModels[idx];
            assistLine.lineColor = self.kLineColors[idx];
            [assistLine draw];
        }];
        
        HLMALine * MALine = [[HLMALine alloc] initWithContext:context];
        
        // DIF
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.DIF_Positions;
        [MALine draw];
        
        // DEA
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.DEA_Positions;
        [MALine draw];
    }
    else {
        // KDJ
        HLMALine * MALine = [[HLMALine alloc] initWithContext:context];
        
        // KDJ_K
        MALine.MAType = Y_MA7Type;
        MALine.MAPositions = self.KDJ_K_Positions;
        [MALine draw];
        
        // KDJ_D
        MALine.MAType = Y_MA30Type;
        MALine.MAPositions = self.KDJ_D_Positions;
        [MALine draw];
        
        // KDJ_J
        MALine.MAType = -1;
        MALine.MAPositions = self.KDJ_J_Positions;
        [MALine draw];
    }
}

- (void)draw {
    NSInteger kLineModelcount = self.displayKlineModels.count;
    NSInteger kLinePositionModelCount = self.displayPositionModels.count;
    NSInteger kLineColorCount = self.kLineColors.count;
//    NSAssert(self.displayKlineModels && self.displayPositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount, @"数据异常，无法绘制Volume");
    self.displayAssistPositionModels = [self convertModelToAssistModel:self.displayKlineModels];
    [self setNeedsDisplay];
}

- (NSArray *)convertModelToAssistModel:(NSArray *)kLineModels {
    CGFloat minY = Y_StockChartKLineAccessoryViewMinY;
    CGFloat maxY = Y_StockChartKLineAccessoryViewMaxY;
    
    __block CGFloat minValue = CGFLOAT_MAX;
    __block CGFloat maxValue = CGFLOAT_MIN;
    
    NSMutableArray *volumePositionModels = @[].mutableCopy;
    
    if(self.targetLineStatus != Y_StockChartTargetLineStatusKDJ) {
        [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            if(model.DIF)
            {
                if(model.DIF.floatValue < minValue) {
                    minValue = model.DIF.floatValue;
                }
                if(model.DIF.floatValue > maxValue) {
                    maxValue = model.DIF.floatValue;
                }
            }

            if(model.DEA)
            {
                if (minValue > model.DEA.floatValue) {
                    minValue = model.DEA.floatValue;
                }
                if (maxValue < model.DEA.floatValue) {
                    maxValue = model.DEA.floatValue;
                }
            }
            
            if(model.MACD)
            {
                if (minValue > model.MACD.floatValue) {
                    minValue = model.MACD.floatValue;
                }
                if (maxValue < model.MACD.floatValue) {
                    maxValue = model.MACD.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.DIF_Positions removeAllObjects];
        [self.DEA_Positions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            HLKLinePositionModel *kLinePositionModel = self.displayPositionModels[idx];
            CGFloat xPosition = kLinePositionModel.high.x;
            
            CGFloat yPosition = -(model.MACD.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
            
            CGPoint startPoint = CGPointMake(xPosition, yPosition);
            
            CGPoint endPoint = CGPointMake(xPosition,Y_StockChartKLineAccessoryViewMiddleY);
            HLVolumePostionModel *volumePositionModel = [HLVolumePostionModel modelWithStartPoint:startPoint endPoint:endPoint];
            [volumePositionModels addObject:volumePositionModel];
            
            //MA坐标转换
            CGFloat DIFY = maxY;
            CGFloat DEAY = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.DIF)
                {
                    DIFY = -(model.DIF.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
                    //                    DIFY = maxY - (model.DIF.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.DEA)
                {
                    DEAY = -(model.DEA.floatValue - 0)/unitValue + Y_StockChartKLineAccessoryViewMiddleY;
                    //                    DEAY = maxY - (model.DEA.floatValue - minValue)/unitValue;
                    
                }
            }
            
            NSAssert(!isnan(DIFY) && !isnan(DEAY), @"出现NAN值");
            
            CGPoint DIFPoint = CGPointMake(xPosition, DIFY);
            CGPoint DEAPoint = CGPointMake(xPosition, DEAY);
            
            if(model.DIF)
            {
                [self.DIF_Positions addObject: [NSValue valueWithCGPoint: DIFPoint]];
            }
            if(model.DEA)
            {
                [self.DEA_Positions addObject: [NSValue valueWithCGPoint: DEAPoint]];
            }
        }];
    }
    else {
        [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.KDJ_K)
            {
                if (minValue > model.KDJ_K.floatValue) {
                    minValue = model.KDJ_K.floatValue;
                }
                if (maxValue < model.KDJ_K.floatValue) {
                    maxValue = model.KDJ_K.floatValue;
                }
            }
            
            if(model.KDJ_D)
            {
                if (minValue > model.KDJ_D.floatValue) {
                    minValue = model.KDJ_D.floatValue;
                }
                if (maxValue < model.KDJ_D.floatValue) {
                    maxValue = model.KDJ_D.floatValue;
                }
            }
            if(model.KDJ_J)
            {
                if (minValue > model.KDJ_J.floatValue) {
                    minValue = model.KDJ_J.floatValue;
                }
                if (maxValue < model.KDJ_J.floatValue) {
                    maxValue = model.KDJ_J.floatValue;
                }
            }
        }];
        
        CGFloat unitValue = (maxValue - minValue) / (maxY - minY);
        
        [self.KDJ_K_Positions removeAllObjects];
        [self.KDJ_D_Positions removeAllObjects];
        [self.KDJ_J_Positions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HLKLinePositionModel *kLinePositionModel = self.displayPositionModels[idx];
            CGFloat xPosition = kLinePositionModel.high.x;
            
            //MA坐标转换
            CGFloat KDJ_K_Y = maxY;
            CGFloat KDJ_D_Y = maxY;
            CGFloat KDJ_J_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_K)
                {
                    KDJ_K_Y = maxY - (model.KDJ_K.floatValue - minValue)/unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_D)
                {
                    KDJ_D_Y = maxY - (model.KDJ_D.floatValue - minValue)/unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_J)
                {
                    KDJ_J_Y = maxY - (model.KDJ_J.floatValue - minValue)/unitValue;
                }
            }
            
            NSAssert(!isnan(KDJ_K_Y) && !isnan(KDJ_D_Y) && !isnan(KDJ_J_Y), @"出现NAN值");
            
            CGPoint KDJ_KPoint = CGPointMake(xPosition, KDJ_K_Y);
            CGPoint KDJ_DPoint = CGPointMake(xPosition, KDJ_D_Y);
            CGPoint KDJ_JPoint = CGPointMake(xPosition, KDJ_J_Y);
            
            
            if(model.KDJ_K)
            {
                [self.KDJ_K_Positions addObject: [NSValue valueWithCGPoint: KDJ_KPoint]];
            }
            if(model.KDJ_D)
            {
                [self.KDJ_D_Positions addObject: [NSValue valueWithCGPoint: KDJ_DPoint]];
            }
            if(model.KDJ_J)
            {
                [self.KDJ_J_Positions addObject: [NSValue valueWithCGPoint: KDJ_JPoint]];
            }
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(assistViewCurrentMaxValue:minValue:)]) {
        [self.delegate assistViewCurrentMaxValue:maxValue minValue:minValue];
    }
    
    return volumePositionModels;
}

@end
