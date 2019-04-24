//
//  HLStockChartView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLStockChartView : UIView

// 数据源
@property (nonatomic, assign) NSArray<HLKLineModel *> *kLineModels;

- (void)draw;

@end
