//
//  HLMALine.h
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Y_MAType){
    Y_MA7Type = 0,
    Y_MA30Type,
    Y_BOLL_MB,
    Y_BOLL_UP,
    Y_BOLL_DN
};

@interface HLMALine : NSObject

@property (nonatomic, strong) NSArray *MAPositions;
@property (nonatomic, strong) NSArray *BOLLPositions;
@property (nonatomic, assign) Y_MAType MAType;

/**
 *  k线的model
 */
@property (nonatomic, strong) HLKLineModel *kLineModel;

/**
 *  最大的Y
 */
@property (nonatomic, assign) CGFloat maxY;

- (instancetype)initWithContext:(CGContextRef)context;
- (void)draw;

@end
