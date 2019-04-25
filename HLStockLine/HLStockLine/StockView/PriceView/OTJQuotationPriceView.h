//
//  OTJQuotationPriceView.h
//  StockLineDemo
//
//  Created by wyh on 2019/4/22.
//  Copyright © 2019 wyh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HLKLineModel.h"

@interface OTJQuotationPriceView : UIView

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *pointsLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *openLabel;
@property (nonatomic, strong) UILabel *lowLabel;
@property (nonatomic, strong) UILabel *closeLabel;

@property (nonatomic, strong) HLKLineModel * model;

@end
