//
//  ViewController.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) HLStockChartView  * stockChartView;
@property (nonatomic, strong) HLKLineGroupModel * groupModel;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

#pragma mark - UI

- (void)setupSubviews {
    [self.view addSubview:self.stockChartView];
    [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.inset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.stockChartView.kLineModels = self.groupModel.models;
    [self.stockChartView draw];
}

#pragma mark - Getter

- (HLStockChartView *)stockChartView {
    if (!_stockChartView) {
        _stockChartView = [HLStockChartView new];
    }
    return _stockChartView;
}

#pragma mark - Private

- (HLKLineGroupModel *)groupModel {
    if (!_groupModel) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray<NSArray<NSString *> *> *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _groupModel = [HLKLineGroupModel objectWithArray:array];
    }
    return _groupModel;
}

// 模拟假数据
- (NSArray<HLKLineModel *> *)allKLineModels {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSArray<NSArray<NSString *> *> *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    __block NSMutableArray<HLKLineModel *> *entries = @[].mutableCopy;
    
    [array enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HLKLineModel *model = [HLKLineModel new];
        model.date = obj[0];
        model.open = @(obj[1].doubleValue);
        model.close = @(obj[2].doubleValue);
        model.high = @(obj[3].doubleValue);
        model.low = @(obj[4].doubleValue);
        
        [entries addObject:model];
    }];
    
    return entries;
}

@end
