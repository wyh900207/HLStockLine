//
//  HLKLineModel.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLKLineModel : NSObject

// 日期
@property (nonatomic, copy) NSString *date;

// 开盘价
@property (nonatomic, strong) NSNumber *open;

// 收盘价
@property (nonatomic, strong) NSNumber *close;

// 最高价
@property (nonatomic, strong) NSNumber *high;

// 最低价
@property (nonatomic, strong) NSNumber *low;

@end
