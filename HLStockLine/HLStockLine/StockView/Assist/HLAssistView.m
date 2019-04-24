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
    }
}

- (void)draw {
    NSInteger kLineModelcount = self.displayKlineModels.count;
    NSInteger kLinePositionModelCount = self.displayPositionModels.count;
    NSInteger kLineColorCount = self.kLineColors.count;
    NSAssert(self.displayKlineModels && self.displayPositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount, @"数据异常，无法绘制Volume");
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
        [kLineModels enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if(model.DIF)
//            {
//                if(model.DIF.floatValue < minValue) {
//                    minValue = model.DIF.floatValue;
//                }
//                if(model.DIF.floatValue > maxValue) {
//                    maxValue = model.DIF.floatValue;
//                }
//            }
//
//            if(model.DEA)
//            {
//                if (minValue > model.DEA.floatValue) {
//                    minValue = model.DEA.floatValue;
//                }
//                if (maxValue < model.DEA.floatValue) {
//                    maxValue = model.DEA.floatValue;
//                }
//            }
//            if(model.MACD)
//            {
//                if (minValue > model.MACD.floatValue) {
//                    minValue = model.MACD.floatValue;
//                }
//                if (maxValue < model.MACD.floatValue) {
//                    maxValue = model.MACD.floatValue;
//                }
//            }
        }];
    }
    
    return volumePositionModels;
}

@end
