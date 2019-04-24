//
//  OTJDtaUtils.m
//  StockLineDemo
//
//  Created by wyh on 2019/4/22.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "OTJDateUtils.h"

@implementation OTJDateUtils

+ (NSString *)stringWith:(NSDate *)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    
    return [fmt stringFromDate:date];
}

+ (NSDate *)dateWith:(NSString *)dateString {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM-dd HH:mm";
    
    return [fmt dateFromString:dateString];
}

+ (NSString *)dateStringWith:(NSString *)dateString {
    NSDate *date = [OTJDateUtils dateWith:dateString];
    
    return [OTJDateUtils stringWith:date];
}

@end
