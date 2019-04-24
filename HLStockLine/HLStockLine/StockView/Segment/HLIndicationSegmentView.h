//
//  HLIndicationSegmentView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLIndicationSegmentView;

@protocol HLIndicationSegmentViewDelegate <NSObject>

@optional

- (void)indicationView:(HLIndicationSegmentView *)indicationView didSelectIndex:(NSInteger)index;

@end

@interface HLIndicationSegmentView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, weak  ) id<HLIndicationSegmentViewDelegate> delegate;

@end
