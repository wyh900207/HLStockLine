//
//  HLStockChartViewModule.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#ifndef HLStockChartViewModule_h
#define HLStockChartViewModule_h

#import "HLStockChartViewConfig.h"

// Model
#import "HLKLineModel.h"
#import "HLKLineGroupModel.h"
#import "HLKLinePositionModel.h"
#import "HLVolumePostionModel.h"
#import "HLMinutesGroupModel.h"

// 价格信息
#import "OTJQuotationPriceView.h"

// 时间选择
#import "HLTimeSegmentView.h"

// 主/辅 视图指标选择
#import "HLIndicationSegmentView.h"

// K线坐标

// 主视图
#import "HLKLine.h"
#import "HLStockChartMainView.h"
#import "HLMinuteView.h"
// 辅助视图
#import "HLAssistLine.h"
#import "HLAssistView.h"
#import "HLMALine.h"
#import "HLRightQuotationView.h"
// 成交量视图 (无需求)

// 完整视图
#import "HLStockChartView.h"

#define weakify(o) autoreleasepool{} __weak typeof(o) o##_weak = o;
#define strongtify(o) autoreleasepool{} __strong typeof(o) o = o##_weak;

#endif /* HLStockChartViewModule_h */
