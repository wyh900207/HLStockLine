//
//  HLIndicationSegmentView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLIndicationSegmentView.h"

@interface HLIndicationSegmentView ()

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@end

@implementation HLIndicationSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexColor(@"FFFFFF");
        self.currentSelectedIndex = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton *tmp_button;
    
    for (UIButton *btn in self.buttons) {
        [btn removeFromSuperview];
    }
    [self.bottomLine removeFromSuperview];
    
    CGFloat count = self.titles.count;
    CGFloat width = self.bounds.size.width / count - 24;
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton new];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateSelected];
        [button setTitleColor:HexColor(@"878787") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(exchangedMainViewType:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(self.bounds.size.width / count * i + 12, 5, width, 20);
        [self addSubview:button];
        
        tmp_button = button;
        
        [self.buttons addObject:button];
    }
    
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    [self addSubview:self.bottomLine];
    
    if (!self.titles) return;
    self.selectedButton = self.buttons[self.currentSelectedIndex];
    self.selectedButton.backgroundColor = HexColor(@"F1F1F1");
}

#pragma mark - Private

- (void)exchangedMainViewType:(UIButton *)button {
    UIButton *old_button = self.selectedButton;
    UIButton *new_button = button;
    
    old_button.backgroundColor = self.backgroundColor;
    new_button.backgroundColor = HexColor(@"F1F1F1");
    
    if (old_button == new_button) return;
    
    self.selectedButton = new_button;
    self.currentSelectedIndex = button.tag;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(indicationView:didSelectIndex:)]) {
        [self.delegate indicationView:self didSelectIndex:button.tag];
    }
}

#pragma mark - Getter

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = HexColor(@"E6E6E6");
    }
    return _bottomLine;
}

#pragma mark - Setter

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    [self layoutIfNeeded];
}

@end
