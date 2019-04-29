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

- (void)setIsMinutes:(BOOL)isMinutes {
    _isMinutes = isMinutes;
    if (isMinutes) {
        [self addSubview:self.quarterValueLabel];
        [self addSubview:self.threeQuarterValueLabel];
        
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
    }
    
    NSInteger max_text = self.maxValueLabel.text.integerValue;
    NSInteger min_text = self.minValueLabel.text.integerValue;
    
    NSString * quator_text = [NSString stringWithFormat:@"%.2f", (max_text + min_text) * 0.25];
    NSString * three_quator_text = [NSString stringWithFormat:@"%.2f", (max_text + min_text) * 0.75];
    
    self.quarterValueLabel.text = quator_text;
    self.threeQuarterValueLabel.text = three_quator_text;
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
