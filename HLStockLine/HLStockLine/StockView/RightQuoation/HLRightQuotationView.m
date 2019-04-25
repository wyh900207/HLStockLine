//
//  HLRightQuotationView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/25.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLRightQuotationView.h"

@interface HLRightQuotationView ()

@property(nonatomic,strong) UILabel *maxValueLabel;
@property(nonatomic,strong) UILabel *middleValueLabel;
@property(nonatomic,strong) UILabel *minValueLabel;

@end

@implementation HLRightQuotationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)setupSubviews {
    [self addSubview:self.maxValueLabel];
    [self addSubview:self.middleValueLabel];
    [self addSubview:self.minValueLabel];
    
    [self.maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.width.equalTo(self);
        make.height.equalTo(@20);
    }];
    [self.middleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self);
        make.height.width.equalTo(self.maxValueLabel);
    }];
    [self.minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.height.width.equalTo(self.maxValueLabel);
    }];
}

#pragma mark - Setter

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    self.maxValueLabel.text = [NSString stringWithFormat:@"%.2f", maxValue];
}

- (void)setMiddleValue:(CGFloat)middleValue {
    _middleValue = middleValue;
    self.middleValueLabel.text = [NSString stringWithFormat:@"%.2f",middleValue];
}

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;
    self.minValueLabel.text = [NSString stringWithFormat:@"%.2f",minValue];
}

- (void)setMinLabelText:(NSString *)minLabelText {
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

#pragma mark - Getter

- (UILabel *)maxValueLabel {
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel];
    }
    return _maxValueLabel;
}

- (UILabel *)middleValueLabel {
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel];
    }
    return _middleValueLabel;
}

- (UILabel *)minValueLabel {
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel];
    }
    return _minValueLabel;
}

#pragma mark - Private

- (UILabel *)private_createLabel {
    UILabel *label = [UILabel new];
    label.textColor = HexColor(@"000000");
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentRight;
    
    return label;
}

@end
