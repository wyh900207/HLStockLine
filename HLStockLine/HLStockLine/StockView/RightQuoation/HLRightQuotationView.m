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
@property(nonatomic,strong) UILabel *quarterValueLabel;
@property(nonatomic,strong) UILabel *middleValueLabel;
@property(nonatomic,strong) UILabel *threeQuarterValueLabel;
@property(nonatomic,strong) UILabel *minValueLabel;

@property(nonatomic,strong) UILabel *maxPercentValueLabel;
@property(nonatomic,strong) UILabel *quarterPercentValueLabel;
@property(nonatomic,strong) UILabel *middlePercentValueLabel;
@property(nonatomic,strong) UILabel *threeQuarterPercentValueLabel;
@property(nonatomic,strong) UILabel *minPercentValueLabel;

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
    [self addSubview:self.quarterValueLabel];
    [self addSubview:self.threeQuarterValueLabel];
    [self addSubview:self.maxPercentValueLabel];
    [self addSubview:self.quarterPercentValueLabel];
    [self addSubview:self.middlePercentValueLabel];
    [self addSubview:self.threeQuarterPercentValueLabel];
    [self addSubview:self.minPercentValueLabel];
    
    [self.maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
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
    [self.quarterValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(0.5);
        make.right.equalTo(self);
        make.height.width.equalTo(self.maxValueLabel);
    }];
    [self.threeQuarterValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1.5);
        make.right.equalTo(self);
        make.height.width.equalTo(self.maxValueLabel);
    }];
    [self.maxPercentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
        make.height.equalTo(@20);
    }];
    [self.middlePercentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(self);
        make.height.width.equalTo(self.maxPercentValueLabel);
    }];
    [self.minPercentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self);
        make.height.width.equalTo(self.maxPercentValueLabel);
    }];
    [self.quarterPercentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(0.5);
        make.left.equalTo(self);
        make.height.width.equalTo(self.maxPercentValueLabel);
    }];
    [self.threeQuarterPercentValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(1.5);
        make.left.equalTo(self);
        make.height.width.equalTo(self.maxPercentValueLabel);
    }];
}

#pragma mark - Setter

- (void)setIsMinutes:(BOOL)isMinutes {
    _isMinutes = isMinutes;
    
    if (isMinutes) {
        self.maxValueLabel.textColor = HexColor(@"FC5A8C");
        self.quarterValueLabel.textColor = HexColor(@"FC5A8C");
        self.maxPercentValueLabel.textColor = HexColor(@"FC5A8C");
        self.quarterPercentValueLabel.textColor = HexColor(@"FC5A8C");
        
        self.threeQuarterValueLabel.textColor = HexColor(@"5CC895");
        self.threeQuarterPercentValueLabel.textColor = HexColor(@"5CC895");
        self.minValueLabel.textColor = HexColor(@"5CC895");
        self.minPercentValueLabel.textColor = HexColor(@"5CC895");
    }
}

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

- (void)setQuarterValue:(CGFloat)quarterValue {
    _quarterValue = quarterValue;
    self.quarterValueLabel.text = [NSString stringWithFormat:@"%.2f",quarterValue];
}

- (void)setThreeQuarterValue:(CGFloat)threeQuarterValue {
    _threeQuarterValue = threeQuarterValue;
    self.threeQuarterValueLabel.text = [NSString stringWithFormat:@"%.2f",threeQuarterValue];
}

- (void)setMaxPercentValue:(CGFloat)maxPercentValue {
    _maxPercentValue = maxPercentValue;
    self.maxPercentValueLabel.text = [NSString stringWithFormat:@"%.2f%@", maxPercentValue, @"%"];
}

- (void)setMiddlePercentValue:(CGFloat)middlePercentValue {
    _middlePercentValue = middlePercentValue;
    self.middlePercentValueLabel.text = [NSString stringWithFormat:@"%.2f%@", middlePercentValue, @"%"];
}

- (void)setQuarterPercentValue:(CGFloat)quarterPercentValue {
    _quarterPercentValue = quarterPercentValue;
    self.quarterPercentValueLabel.text = [NSString stringWithFormat:@"%.2f%@", quarterPercentValue, @"%"];
}

- (void)setThreeQuarterPercentValue:(CGFloat)threeQuarterPercentValue {
    _threeQuarterPercentValue = threeQuarterPercentValue;
    self.threeQuarterPercentValueLabel.text = [NSString stringWithFormat:@"%.2f%@", threeQuarterPercentValue, @"%"];
}

- (void)setMinPercentValue:(CGFloat)minPercentValue {
    _minPercentValue = minPercentValue;
    self.minPercentValueLabel.text = [NSString stringWithFormat:@"%.2f%@", minPercentValue, @"%"];
}

- (void)setMinLabelText:(NSString *)minLabelText {
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

#pragma mark - Getter

- (UILabel *)maxValueLabel {
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel:NSTextAlignmentRight];
    }
    return _maxValueLabel;
}

- (UILabel *)quarterValueLabel {
    if (!_quarterValueLabel) {
        _quarterValueLabel = [self private_createLabel:NSTextAlignmentRight];
    }
    return _quarterValueLabel;
}

- (UILabel *)middleValueLabel {
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel:NSTextAlignmentRight];
    }
    return _middleValueLabel;
}

- (UILabel *)threeQuarterValueLabel {
    if (!_threeQuarterValueLabel) {
        _threeQuarterValueLabel = [self private_createLabel:NSTextAlignmentRight];
    }
    return _threeQuarterValueLabel;
}

- (UILabel *)minValueLabel {
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel:NSTextAlignmentRight];
    }
    return _minValueLabel;
}

- (UILabel *)maxPercentValueLabel {
    if (!_maxPercentValueLabel) {
        _maxPercentValueLabel = [self private_createLabel:NSTextAlignmentLeft];
    }
    return _maxPercentValueLabel;
}

- (UILabel *)quarterPercentValueLabel {
    if (!_quarterPercentValueLabel) {
        _quarterPercentValueLabel = [self private_createLabel:NSTextAlignmentLeft];
    }
    return _quarterPercentValueLabel;
}

- (UILabel *)middlePercentValueLabel {
    if (!_middlePercentValueLabel) {
        _middlePercentValueLabel = [self private_createLabel:NSTextAlignmentLeft];
    }
    return _middlePercentValueLabel;
}

- (UILabel *)threeQuarterPercentValueLabel {
    if (!_threeQuarterPercentValueLabel) {
        _threeQuarterPercentValueLabel = [self private_createLabel:NSTextAlignmentLeft];
    }
    return _threeQuarterPercentValueLabel;
}

- (UILabel *)minPercentValueLabel {
    if (!_minPercentValueLabel) {
        _minPercentValueLabel = [self private_createLabel:NSTextAlignmentLeft];
    }
    return _minPercentValueLabel;
}

#pragma mark - Private

- (UILabel *)private_createLabel:(NSTextAlignment)align {
    UILabel *label = [UILabel new];
    label.textColor = HexColor(@"000000");
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = align;
    
    return label;
}

@end
