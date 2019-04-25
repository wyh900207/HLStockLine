//
//  HLStockChartMainView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLStockChartMainViewDelegate <NSObject>

// 长按显示手指按着的Y_KLinePosition和KLineModel
- (void)stockMainViewLongPressPositionModel:(HLKLinePositionModel *)positionModel kLineModel:(HLKLineModel *)model;
// 当前MainView的最大值和最小值
- (void)stockMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice;
// 当前需要绘制的K线模型数组
- (void)stockMainViewDisplayModels:(NSArray *)displayModels;
// 当前需要绘制的K线位置模型数组
- (void)stockMainViewDisplayPostionModels:(NSArray *)displayPostionModels;
// 当前需要绘制的K线颜色数组
- (void)stockMainViewDisplayColors:(NSArray *)colors;

@end

@interface HLStockChartMainView : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id<HLStockChartMainViewDelegate> delegate;

/**
 模型数组
 */
@property (nonatomic, strong) NSArray<HLKLineModel *> *kLineModels;

/**
 *  父ScrollView
 */
@property (nonatomic, weak, readonly) UIScrollView *parentScrollView;

/**
 *  需要绘制Index开始值
 */
@property (nonatomic, assign) NSInteger needDrawStartIndex;

/**
 *  捏合点
 */
@property (nonatomic, assign) NSInteger pinchStartIndex;

/**
 *  是否为图表类型
 */
@property (nonatomic, assign) Y_StockChartCenterViewType MainViewType;

/**
 *  Accessory指标种类
 */
@property (nonatomic, assign) Y_StockChartTargetLineStatus targetLineStatus;

/**
 画MainView所有线
 */
- (void)draw;

/**
 更新MainView宽度
 */
- (void)updateMainViewWidth;

/**
 获取needDrawStartIndex
 
 @param scorll 是否在视图滚动的时候获取
 @return needDrawStartIndex
 */
- (NSInteger)getNeedDrawStartIndexWithScroll:(BOOL)scorll;

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (CGFloat)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition;

/**
 移除所有监听
 */
- (void)removeAllObserver;

@end
