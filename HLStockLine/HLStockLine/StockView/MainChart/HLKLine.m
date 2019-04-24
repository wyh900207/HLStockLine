//
//  HLKLine.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLKLine.h"

@interface HLKLine ()

@property (nonatomic, assign) CGContextRef context;
@property (nonatomic, assign) CGPoint lastDrawDatePoint;

@end

@implementation HLKLine

#pragma mark - Init

- (instancetype)initWithContext:(CGContextRef)context {
    self = [super init];
    if (self){
        _context = context;
        _lastDrawDatePoint = CGPointZero;
    }
    return self;
}

#pragma mark - Public Methods

- (UIColor *)draw {
    if (!self.model || !self.context) return nil;
    
    CGContextRef context = self.context;
    
    UIColor *strokeColor = self.model.open.floatValue < self.model.close.floatValue ? COLOR_INCREASING : COLOR_DECREASING;
    
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    
    CGContextSetLineWidth(context, [HLStockChartViewConfig lineWidth]);
    const CGPoint solidPoints[] = {self.postionModel.open, self.postionModel.close};
    CGContextStrokeLineSegments(context, solidPoints, 2);
    
    CGContextSetLineWidth(context, [HLStockChartViewConfig lineShadowWidth]);
    const CGPoint shadowPoints[] = {self.postionModel.high, self.postionModel.low};
    CGContextStrokeLineSegments(context, shadowPoints, 2);
    
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.line_model.date.doubleValue * 0.001];
    //    NSDateFormatter *format = [NSDateFormatter new];
    //    format.dateFormat = @"HH:mm";
    //    NSString *dateStr = [format stringFromDate:date];
    
    NSString *dateStr = [OTJDateUtils dateStringWith:self.model.date];
    
    CGPoint draw_date_point = CGPointMake(self.postionModel.low.x + 1, self.maxY + 6);
    if (CGPointEqualToPoint(self.lastDrawDatePoint, CGPointZero) || draw_date_point.x - self.lastDrawDatePoint.x > 60) {
        [dateStr drawAtPoint:draw_date_point withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11],
                                                              NSForegroundColorAttributeName: ASSIST_TEXT_COLOR
                                                              }];
        self.lastDrawDatePoint = draw_date_point;
    }
    
    return strokeColor;
}

@end
