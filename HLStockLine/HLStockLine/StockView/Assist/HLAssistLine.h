//
//  HLAssistLine.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAssistLine : NSObject

/**
 *  位置model
 */
@property (nonatomic, strong) HLVolumePostionModel * positionModel;

/**
 *  k线model
 */
@property (nonatomic, strong) HLKLineModel * kLineModel;

/**
 *  线颜色
 */
@property (nonatomic, strong) UIColor * lineColor;

/**
 *  根据context初始化均线画笔
 */
- (instancetype)initWithContext:(CGContextRef)context;

/**
 *  绘制成交量
 */
- (void)draw;

@end
