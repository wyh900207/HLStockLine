//
//  HLMALine.m
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLMALine.h"

@interface HLMALine ()

@property (nonatomic, assign) CGContextRef context;
// 最后一个绘制日期点
@property (nonatomic, assign) CGPoint lastDrawDatePoint;

@end

@implementation HLMALine

- (instancetype)initWithContext:(CGContextRef)context {
    self = [super init];
    if (self) {
        self.context = context;
    }
    return self;
}

- (void)draw {
    if (!self.context) return;
    
    if (_MAType == Y_BOLL_DN || _MAType == Y_BOLL_MB || _MAType == Y_BOLL_UP) {
        if (!self.BOLLPositions) return;
        
        UIColor * lineColor = self.MAType == Y_BOLL_UP? [UIColor purpleColor] : (self.MAType == Y_BOLL_MB ? [UIColor whiteColor] : self.MAType == Y_BOLL_DN ? [UIColor greenColor] : HexColor(@"E1E2E6"));
        CGContextSetStrokeColorWithColor(self.context, lineColor.CGColor);
        
        CGContextSetLineWidth(self.context, WIDTH_MA);
        
        CGPoint firstPoint = [self.BOLLPositions.firstObject CGPointValue];
        NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：BOLL画线");
        CGContextMoveToPoint(self.context, firstPoint.x, firstPoint.y);
        
        for (NSInteger idx = 1; idx < self.BOLLPositions.count ; idx++)
        {
            CGPoint point = [self.BOLLPositions[idx] CGPointValue];
            CGContextAddLineToPoint(self.context, point.x, point.y);
        }
    }
    else {
        if(!self.MAPositions) return;
        
        UIColor *lineColor = self.MAType == Y_MA7Type ? HexColor(@"ff783c") : (self.MAType == Y_MA30Type ? HexColor(@"49a5ff") : HexColor(@"e1e2e6"));
        CGContextSetStrokeColorWithColor(self.context, lineColor.CGColor);
        
        CGContextSetLineWidth(self.context, WIDTH_MA);
        CGPoint firstPoint = [self.MAPositions.firstObject CGPointValue];
        NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：MA画线");
        CGContextMoveToPoint(self.context, firstPoint.x, firstPoint.y);
        
        for (NSInteger idx = 1; idx < self.MAPositions.count ; idx++)
        {
            CGPoint point = [self.MAPositions[idx] CGPointValue];
            CGContextAddLineToPoint(self.context, point.x, point.y);
            //
            //        //日期
            //        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.kLineModel.Date.doubleValue/1000];
            //        NSDateFormatter *formatter = [NSDateFormatter new];
            //        formatter.dateFormat = @"HH:mm";
            //        NSString *dateStr = [formatter stringFromDate:date];
            //
            //        CGPoint drawDatePoint = CGPointMake(point.x + 1, self.maxY + 1.5);
            //        if(CGPointEqualToPoint(self.lastDrawDatePoint, CGPointZero) || point.x - self.lastDrawDatePoint.x > 60 )
            //        {
            //            [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11],NSForegroundColorAttributeName : [UIColor assistTextColor]}];
            //            self.lastDrawDatePoint = drawDatePoint;
            //        }
        }
    }
    
    CGContextStrokePath(self.context);
}

@end
