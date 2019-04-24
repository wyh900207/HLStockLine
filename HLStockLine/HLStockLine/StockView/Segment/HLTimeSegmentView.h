//
//  HLTimeSegmentView.h
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLTimeSegmentView;

@protocol HLTimeSegmentViewDelegate <NSObject>

@optional

- (void)segmentView:(HLTimeSegmentView *)segmentView didSelectIndex:(NSInteger)index;

@end

@interface HLTimeSegmentView : UIView

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, weak  ) id<HLTimeSegmentViewDelegate> delegate;

@end
