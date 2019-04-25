//
//  HLKLineGroupModel.m
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLKLineGroupModel.h"

@implementation HLKLineGroupModel

+ (instancetype)objectWithArray:(NSArray *)array {
    HLKLineGroupModel * groupModel = [HLKLineGroupModel new];
    NSMutableArray * mutableArray = @[].mutableCopy;
    __block HLKLineModel * preModel = [HLKLineModel new];
    
    for (NSArray * item in array) {
        HLKLineModel * model = [HLKLineModel new];
        model.PreviousKlineModel = preModel;
        [model initWithArray:item];
        model.ParentGroupModel = groupModel;
        [mutableArray addObject:model];
        
        preModel = model;
    }
    
    groupModel.models = mutableArray;
    
    HLKLineModel * firstModel = mutableArray[0];
    [firstModel initFirstModel];
    
    [mutableArray enumerateObjectsUsingBlock:^(HLKLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];
    
    return groupModel;
}

@end
