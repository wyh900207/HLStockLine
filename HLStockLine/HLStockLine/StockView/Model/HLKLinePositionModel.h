//
//  HLKLinePositionModel.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLKLinePositionModel : NSObject

// 开盘点
@property (nonatomic, assign) CGPoint open;
// 收盘点
@property (nonatomic, assign) CGPoint close;
// 最高盘点
@property (nonatomic, assign) CGPoint high;
// 最低点
@property (nonatomic, assign) CGPoint low;

+ (instancetype)modelWithOpen:(CGPoint)open close:(CGPoint)close high:(CGPoint)high low:(CGPoint)low;

@end
