//
//  HLStockChartViewConfig.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLStockChartViewConfig.h"

// 是否为EMA线
static Y_StockChartTargetLineStatus Y_StockChartKLineIsEMALine = Y_StockChartTargetLineStatusMA;
// K线宽度
static CGFloat StockLineWidth = 5;

@implementation HLStockChartViewConfig

+ (CGFloat)lineWidth {
    return StockLineWidth;
}

+ (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth > MAX_K_LINE_WIDTH) {
        lineWidth = MAX_K_LINE_WIDTH;
    }
    if (lineWidth < MIN_K_LINE_WIDTH) {
        lineWidth = MIN_K_LINE_WIDTH;
    }
    
    StockLineWidth = lineWidth;
}

+ (CGFloat)lineShadowWidth {
    return 1;
}

+ (CGFloat)isEMALine {
    return Y_StockChartKLineIsEMALine;
}

@end
