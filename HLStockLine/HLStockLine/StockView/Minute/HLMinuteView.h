//
//  HLMinuteView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/26.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLMinuteView : UIView

@property (nonatomic, strong) HLMinutesGroupModel  * groupModel;
// 昨日收盘价
@property (nonatomic, strong) NSNumber * yestodayClosePoints;

- (void)draw;

@end
