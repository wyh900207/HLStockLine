//
//  HLMinutesGroupModel.m
//  HLStockLine
//
//  Created by wyh on 2019/4/26.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLMinutesGroupModel.h"

@implementation HLMinutesGroupModel

+ (instancetype)convenienceInitWith:(NSDictionary *)dict {
    HLMinutesGroupModel * group_model = [HLMinutesGroupModel new];
    
    NSArray<HLMinutesModel *> * dataList = dict[@"dataList"];
    NSArray<NSString *> * dateList = dict[@"dateList"];
    
    NSMutableArray * array = @[].mutableCopy;
    NSMutableArray * dates = @[].mutableCopy;
    
    for (NSArray<NSString *> *minute in dataList) {
        HLMinutesModel *model = [HLMinutesModel convenienceInitWith:minute];
        [array addObject:model];
    }
    
    for (NSString * date in dateList) {
        [dates addObject:date];
    }
    
    group_model.dataList = array;
    group_model.dateList = dates;
    
    return group_model;
}

@end



@implementation HLMinutesModel

+ (instancetype)convenienceInitWith:(NSArray<NSString *> *)minutes {
    HLMinutesModel * model = [HLMinutesModel new];
    
    model.point = minutes[0];
    model.date = minutes[1];
    
    return model;
}

@end



@implementation HLMinutesPositionModel

@end
