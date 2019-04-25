//
//  OTJQuotationPriceView.m
//  StockLineDemo
//
//  Created by wyh on 2019/4/22.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "OTJQuotationPriceView.h"

@interface OTJQuotationPriceView ()

@end

@implementation OTJQuotationPriceView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.priceLabel];
    [self addSubview:self.pointsLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.openLabel];
    [self addSubview:self.highLabel];
    [self addSubview:self.lowLabel];
    [self addSubview:self.closeLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).inset(12);
        make.width.greaterThanOrEqualTo(@150);
        make.height.equalTo(@50);
    }];
    [self.pointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom);
        make.left.right.equalTo(self.priceLabel);
        make.height.equalTo(@20);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(7);
        make.left.equalTo(self.priceLabel.mas_right);
        make.right.equalTo(self).inset(12);
        make.height.equalTo(@18);
    }];
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(4);
        make.right.equalTo(self.dateLabel);
        make.height.equalTo(@18);
    }];
    [self.highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openLabel);
        make.right.equalTo(self.openLabel.mas_left).offset(-10);
        make.width.height.equalTo(self.openLabel);
    }];
    [self.lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openLabel.mas_bottom).offset(4);
        make.left.height.width.equalTo(self.highLabel);
    }];
    [self.closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lowLabel);
        make.left.right.width.height.equalTo(self.openLabel);
    }];
}

#pragma mark - Setter

- (void)setModel:(HLKLineModel *)model {
    _model = model;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", model.high.floatValue];
    self.pointsLabel.text = [NSString stringWithFormat:@"%@   %@", model.changePoints, model.changePercent];
}

#pragma mark - Getter

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.text = @"3375.08";
        _priceLabel.font = [UIFont systemFontOfSize:40];
        _priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:49/255.0 blue:92/255.0 alpha:1/1.0];
    }
    return _priceLabel;
}

- (UILabel *)pointsLabel {
    if (!_pointsLabel) {
        _pointsLabel = [UILabel new];;
        _pointsLabel.text = @"-25  -0.65%";
        _pointsLabel.font = [UIFont systemFontOfSize:14];
        _pointsLabel.textColor = [UIColor colorWithRed:255/255.0 green:49/255.0 blue:92/255.0 alpha:1/1.0];
    }
    return _pointsLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"2/3 13:53:32";
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1/1.0];
    }
    return _dateLabel;
}

- (UILabel *)highLabel {
    if (!_highLabel) {
        _highLabel = [UILabel new];
        _highLabel.text = @"最高 4033";
        _highLabel.font = [UIFont systemFontOfSize:12];
        _highLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1/1.0];
    }
    return _highLabel;
}

- (UILabel *)openLabel {
    if (!_openLabel) {
        _openLabel = [UILabel new];
        _openLabel.text = @"今开 3808";
        _openLabel.font = [UIFont systemFontOfSize:12];
        _openLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1/1.0];
    }
    return _openLabel;
}

- (UILabel *)lowLabel {
    if (!_lowLabel) {
        _lowLabel = [UILabel new];
        _lowLabel.text = @"最低 3780";
        _lowLabel.font = [UIFont systemFontOfSize:12];
        _lowLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1/1.0];
    }
    return _lowLabel;
}

- (UILabel *)closeLabel {
    if (!_closeLabel) {
        _closeLabel = [UILabel new];
        _closeLabel.text = @"昨收 3967";
        _closeLabel.font = [UIFont systemFontOfSize:12];
        _closeLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1/1.0];
    }
    return _closeLabel;
}

@end
