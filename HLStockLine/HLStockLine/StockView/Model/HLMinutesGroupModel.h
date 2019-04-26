//
//  HLMinutesGroupModel.h
//  HLStockLine
//
//  Created by wyh on 2019/4/26.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HLMinutesModel;

@interface HLMinutesGroupModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> * dateList;
@property (nonatomic, strong) NSArray<HLMinutesModel *> * dataList;

+ (instancetype)convenienceInitWith:(NSDictionary *)dict;

@end



@interface HLMinutesModel : NSObject

@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *date;

+ (instancetype)convenienceInitWith:(NSArray<NSString *> *)minutes;

@end


@interface HLMinutesPositionModel : NSObject

@property (nonatomic, assign) CGPoint point;

@end
