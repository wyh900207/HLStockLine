//
//  HLVolumePostionModel.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLVolumePostionModel.h"

@implementation HLVolumePostionModel

+ (instancetype) modelWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    HLVolumePostionModel *volumePositionModel = [HLVolumePostionModel new];
    volumePositionModel.StartPoint = startPoint;
    volumePositionModel.EndPoint = endPoint;
    
    return volumePositionModel;
}

@end
