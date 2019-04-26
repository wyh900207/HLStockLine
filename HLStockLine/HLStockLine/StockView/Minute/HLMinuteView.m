//
//  HLMinuteView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/26.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLMinuteView.h"

@interface HLMinuteView ()

@property (nonatomic, strong) HLRightQuotationView * rightQuotationView;
@property (nonatomic, strong) HLMinutesGroupModel  * groupModel;

@end

@implementation HLMinuteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)setupSubviews {
    [self addSubview:self.rightQuotationView];
    
    [self.rightQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0.5);
    UIColor * strock_color = [UIColor blueColor];
    CGContextSetStrokeColorWithColor(context, strock_color.CGColor);
    
    [self convertMinutesModelToPostionModel];
}

#pragma mark - Private Methods

- (void)convertMinutesModelToPostionModel {
    NSMutableArray * points = @[].mutableCopy;
    
    for (int i = 0; i < self.groupModel.dataList.count; i++) {
        HLMinutesModel * model = self.groupModel.dataList[i];
        if (model.point) [points addObject:model.point];
    }
    
    NSInteger maxValue = [[points valueForKeyPath:@"@max.integerValue"] integerValue];
    NSInteger minValue = [[points valueForKeyPath:@"@min.integerValue"] integerValue];
    
    if (!self.yestodayClosePoints) return;
    
    NSInteger max_reduce = maxValue - self.yestodayClosePoints.integerValue;
    NSInteger min_reduce = self.yestodayClosePoints.integerValue - minValue;
    
    if (max_reduce > min_reduce) {
        min_reduce = self.yestodayClosePoints.integerValue - max_reduce;
    }
    else {
        max_reduce = self.yestodayClosePoints.integerValue + min_reduce;
    }
}

#pragma mark - Getter

- (HLRightQuotationView *)rightQuotationView {
    if (!_rightQuotationView) {
        _rightQuotationView = [HLRightQuotationView new];
        _rightQuotationView.maxValue = 100;
        _rightQuotationView.minValue = 0;
        _rightQuotationView.middleValue = 50;
        _rightQuotationView.userInteractionEnabled = NO;
    }
    return _rightQuotationView;
}

- (HLMinutesGroupModel *)groupModel {
    if (!_groupModel) {
        _groupModel = [self dataSource];
    }
    return _groupModel;
}

#pragma mark - Test

- (HLMinutesGroupModel *)dataSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"minute_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    HLMinutesGroupModel *group_model = [HLMinutesGroupModel convenienceInitWith:dict];
    
    return group_model;
}

@end
