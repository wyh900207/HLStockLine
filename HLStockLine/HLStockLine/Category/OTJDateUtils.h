//
//  OTJDtaUtils.h
//  StockLineDemo
//
//  Created by wyh on 2019/4/22.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTJDateUtils : NSObject

+ (NSString *)stringWith:(NSDate *)date;
+ (NSDate *)dateWith:(NSString *)dateString;
+ (NSString *)dateStringWith:(NSString *)dateString;

@end

NS_ASSUME_NONNULL_END
