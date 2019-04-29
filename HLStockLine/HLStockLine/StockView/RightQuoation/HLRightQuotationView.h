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
@property (nonatomic, copy  ) NSString * minLabelText;
// 是否为分时, 默认 NO
@property (nonatomic, assign) BOOL isMinutes;

@end
