//
//  HLAssistView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLAssistView;

@protocol HLAssistViewDelegate <NSObject>

@optional

/**
 *  当前AccessoryView的最大值和最小值
 */
- (void)assistViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue;

@end

@interface HLAssistView : UIView

@property (nonatomic, strong) NSArray<HLKLineModel *>         * displayKlineModels;
@property (nonatomic, strong) NSArray<HLKLinePositionModel *> * displayPositionModels;
@property (nonatomic, strong) NSArray                         * kLineColors;
@property (nonatomic, assign) Y_StockChartTargetLineStatus      targetLineStatus;
@property (nonatomic, weak  ) id<HLAssistViewDelegate>          delegate;

- (void)draw;

@end
