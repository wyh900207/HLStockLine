//
//  HLStockChartViewConfig.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLStockChartViewConfig.h"

/**
 *  是否为EMA线
 */
static Y_StockChartTargetLineStatus Y_StockChartKLineIsEMALine = Y_StockChartTargetLineStatusMA;

@implementation HLStockChartViewConfig

+ (CGFloat)lineWidth {
    return 5;
}

+ (CGFloat)lineShadowWidth {
    return 1;
}

+ (CGFloat)isEMALine {
    return Y_StockChartKLineIsEMALine;
}

@end
