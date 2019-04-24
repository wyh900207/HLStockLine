//
//  HLKLine.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLKLine : NSObject

@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, strong) HLKLineModel *model;
@property (nonatomic, strong) HLKLinePositionModel *postionModel;

- (instancetype)initWithContext:(CGContextRef)context;

- (UIColor *)draw;

@end
