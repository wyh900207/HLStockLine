//
//  HLStockChartViewConfig.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLStockChartViewConfig : NSObject

//Kline种类
typedef NS_ENUM(NSInteger, Y_StockChartCenterViewType) {
    Y_StockChartcenterViewTypeKline= 1, //K线
    Y_StockChartcenterViewTypeTimeLine,  //分时图
    Y_StockChartcenterViewTypeOther
};


//Accessory指标种类
typedef NS_ENUM(NSInteger, Y_StockChartTargetLineStatus) {
    Y_StockChartTargetLineStatusMACD = 100,    //MACD线
    Y_StockChartTargetLineStatusKDJ,    //KDJ线
    Y_StockChartTargetLineStatusAccessoryClose,    //关闭Accessory线
    Y_StockChartTargetLineStatusMA , //MA线
    Y_StockChartTargetLineStatusEMA,  //EMA线
    Y_StockChartTargetLineStatusBOLL,  //BOLL线
    Y_StockChartTargetLineStatusCloseMA  //MA关闭线
    
};

#define ASSIST_TEXT_COLOR HexColor(@"565a64")
// 涨
#define COLOR_INCREASING HexColor(@"0ADC71")
// 跌
#define COLOR_DECREASING HexColor(@"FF315C")

// K线图的副图上最小的Y
#define Y_StockChartKLineAccessoryViewMinY 20
// K线图的副图最大的Y
#define Y_StockChartKLineAccessoryViewMaxY (self.frame.size.height)

+ (CGFloat)lineWidth;
+ (CGFloat)lineShadowWidth;

@end
