//
//  HLKLineGroupModel.h
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLKLineGroupModel : NSObject

@property (nonatomic, strong) NSArray<HLKLineModel *> *models;

+ (instancetype)objectWithArray:(NSArray *)array;

@end
