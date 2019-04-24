//
//  HLAssistLine.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLAssistLine.h"

@interface HLAssistLine()

@property (nonatomic, assign) CGContextRef context;

@end


@implementation HLAssistLine

- (instancetype)initWithContext:(CGContextRef)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (void)draw {
//    if(!self.kLineModel || !self.positionModel || !self.context || !self.lineColor) return;
//
//    CGContextRef context = self.context;
//    CGContextSetStrokeColorWithColor(context, COLOR_INCREASING.CGColor);
//    CGContextSetLineWidth(context, [HLStockChartViewConfig lineWidth]);
//
//    CGPoint solidPoints[] = {self.positionModel.StartPoint, self.positionModel.EndPoint};
//
//    if(self.kLineModel.MACD.floatValue > 0)
//    {
//        CGContextSetStrokeColorWithColor(context, COLOR_DECREASING.CGColor);
//    }
//    CGContextStrokeLineSegments(context, solidPoints, 2);
}

@end
