//
//  HLTimeSegmentView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLTimeSegmentView.h"

@interface HLTimeSegmentView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation HLTimeSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1/1.0];
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
    
    [self.line removeFromSuperview];
    [self.topLine removeFromSuperview];
    [self.bottomLine removeFromSuperview];
    
    CGFloat count = self.titles.count;
    CGFloat width = self.bounds.size.width / count;
    
    for (int i = 0; i < self.titles.count; i++) {
        UIColor *normal_color =  [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1/1.0];
        UIColor *selected_color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        
        UIButton *button = [UIButton new];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateSelected];
        [button setTitleColor:normal_color forState:UIControlStateNormal];
        [button setTitleColor:selected_color forState:UIControlStateSelected];
        [button addTarget:self action:@selector(exchangedMainViewType:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(width * i, 0, width, self.bounds.size.height);
        [self addSubview:button];
        
        tmp_button = button;
        
        [self.buttons addObject:button];
    }
    
    CGFloat line_origin_x = width * self.currentSelectedIndex + (width - 30) * 0.5;
    self.line.frame = CGRectMake(line_origin_x, self.bounds.size.height - 3.5, 30, 3);
    
    self.topLine.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    
    [self addSubview:self.line];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
}

#pragma mark - Private

- (void)exchangedMainViewType:(UIButton *)button {
    self.currentSelectedIndex = button.tag;
    
    CGFloat count = self.titles.count;
    CGFloat width = self.bounds.size.width / count;
    CGFloat line_origin_x = width * self.currentSelectedIndex + (width - 30) * 0.5;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.line.frame = CGRectMake(line_origin_x, self.bounds.size.height - 3, 30, 3);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectIndex:)]) {
        [self.delegate segmentView:self didSelectIndex:button.tag];
    }
}

#pragma mark - Getter

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    [self layoutIfNeeded];
    
    
}

- (NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) {
        _buttons = @[].mutableCopy;
    }
    return _buttons;
}

- (UIImageView *)line {
    if (!_line) {
        _line = [UIImageView new];
        _line.image = [UIImage imageNamed:@"line"];
    }
    return _line;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
        _topLine.backgroundColor = HexColor(@"E6E6E6");
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = HexColor(@"E6E6E6");
    }
    return _bottomLine;
}

@end
