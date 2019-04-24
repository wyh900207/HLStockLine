//
//  HLKLinePositionModel.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLKLinePositionModel.h"

@implementation HLKLinePositionModel

+ (instancetype)modelWithOpen:(CGPoint)open close:(CGPoint)close high:(CGPoint)high low:(CGPoint)low {
    HLKLinePositionModel *model = [HLKLinePositionModel new];
    model.open = open;
    model.close = close;
    model.high = high;
    model.low = low;
    
    return model;
}


@end
