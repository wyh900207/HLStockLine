//
//  HLRightQuotationView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLRightQuotationView : UIView

@property (nonatomic, assign) CGFloat    maxValue;
@property (nonatomic, assign) CGFloat    middleValue;
@property (nonatomic, assign) CGFloat    minValue;
@property (nonatomic, assign) CGFloat    quarterValue;
@property (nonatomic, assign) CGFloat    threeQuarterValue;

@property (nonatomic, assign) CGFloat    maxPercentValue;
@property (nonatomic, assign) CGFloat    middlePercentValue;
@property (nonatomic, assign) CGFloat    minPercentValue;
@property (nonatomic, assign) CGFloat    quarterPercentValue;
@property (nonatomic, assign) CGFloat    threeQuarterPercentValue;

@property (nonatomic, copy  ) NSString * minLabelText;
// 是否为分时, 默认 NO
@property (nonatomic, assign) BOOL isMinutes;

@end
