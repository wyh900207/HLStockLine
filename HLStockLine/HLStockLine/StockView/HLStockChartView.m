//
//  HLStockChartView.m
//  HLStockLine
//
//  Created by wyh on 2019/4/24.
//  Copyright © 2019 wyh. All rights reserved.
//

#import "HLStockChartView.h"

@interface HLStockChartView () <UIScrollViewDelegate, HLTimeSegmentViewDelegate, HLIndicationSegmentViewDelegate>

@property (nonatomic, strong) HLAssistView            * assistView;
@property (nonatomic, strong) UIScrollView            * scrollView;
@property (nonatomic, strong) HLTimeSegmentView       * timeSegmentView;
@property (nonatomic, strong) HLStockChartMainView    * kLineView;
@property (nonatomic, strong) OTJQuotationPriceView   * priceView;
@property (nonatomic, strong) HLIndicationSegmentView * mainSegmentView;
@property (nonatomic, strong) HLIndicationSegmentView * assistSegmentView;

@end

@implementation HLStockChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)setupSubviews {
    [self addSubview:self.priceView];
    [self addSubview:self.timeSegmentView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.kLineView];
    [self addSubview:self.mainSegmentView];
    [self addSubview:self.assistSegmentView];
    [self.scrollView addSubview:self.assistView];
    
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@70);
    }];
    [self.timeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeSegmentView.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
    [self.mainSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeSegmentView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@30);
    }];
    [self.kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainSegmentView.mas_bottom);
        //make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
        make.height.equalTo(@300);
        make.width.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
    }];
    [self.assistSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.kLineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@30);
    }];
//    [self.assistView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.assistSegmentView.mas_bottom);
//        make.left.equalTo(self.kLineView);
//        make.width.equalTo(self.kLineView);
//        make.bottom.equalTo(self.scrollView);
//    }];
}

#pragma mark - 画KLineMainView

- (void)drawKLineMainView {
    self.kLineView.kLineModels = self.kLineModels;
    [self.kLineView draw];
}

#pragma mark - 重绘

- (void)draw {
//    self.kLineMainView.type = self.mainViewType;
    
    [self.kLineView draw];
}

#pragma mark - Getter

- (OTJQuotationPriceView *)priceView {
    if (!_priceView) {
        _priceView = [OTJQuotationPriceView new];
    }
    return _priceView;
}

- (HLTimeSegmentView *)timeSegmentView {
    if (!_timeSegmentView) {
        _timeSegmentView = [HLTimeSegmentView new];
        _timeSegmentView.delegate = self;
        _timeSegmentView.titles = @[@"分时", @"1分", @"5分", @"15分", @"30分", @"60分"];
    }
    return _timeSegmentView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.maximumZoomScale = 1.f;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        // 缩放
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        // 长按
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
    }
    return _scrollView;
}

- (HLStockChartMainView *)kLineView {
    if (!_kLineView) {
        _kLineView = [HLStockChartMainView new];
        _kLineView.backgroundColor = [UIColor orangeColor];
        //_kLineView.delegate = self;
    }
    return _kLineView;
}

- (HLIndicationSegmentView *)mainSegmentView {
    if (!_mainSegmentView) {
        _mainSegmentView = [HLIndicationSegmentView new];
        _mainSegmentView.delegate = self;
        _mainSegmentView.titles = @[@"SMA", @"EMA", @"BOLL"];
    }
    return _mainSegmentView;
}

- (HLIndicationSegmentView *)assistSegmentView {
    if (!_assistSegmentView) {
        _assistSegmentView = [HLIndicationSegmentView new];
        _assistSegmentView.delegate = self;
        _assistSegmentView.titles = @[@"MACD", @"KDJ", @"RSI"];
    }
    return _assistSegmentView;
}

- (HLAssistView *)assistView {
    if (!_assistView) {
        _assistView = [HLAssistView new];
        _assistView.backgroundColor = [UIColor orangeColor];
    }
    return _assistView;
}

#pragma mark - Setter

- (void)setKLineModels:(NSArray<HLKLineModel *> *)kLineModels {
    _kLineModels = kLineModels;
    
    if (!kLineModels) return;
    
    [self drawKLineMainView];
    
    // 设置contentOffset
    CGFloat k_line_width = [HLStockChartViewConfig lineWidth];
    CGFloat kLineViewWidth = self.kLineModels.count * k_line_width + self.kLineModels.count + 1 + 10;
    CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
    
    if (offset > 0) {
        self.scrollView.contentOffset = CGPointMake(offset, 0);
    }
    else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - Touch Event

- (void)pichMethod:(UIPinchGestureRecognizer *)pinch {
    
}

- (void)longPressMethod:(UILongPressGestureRecognizer *)longPress {
    
}

#pragma mark - HLTimeSegmentViewDelegate

- (void)segmentView:(HLTimeSegmentView *)segmentView didSelectIndex:(NSInteger)index {
    
}

#pragma mark - HLIndicationSegmentViewDelegate

- (void)indicationView:(HLIndicationSegmentView *)indicationView didSelectIndex:(NSInteger)index {
    
}

#pragma mark - UIScrollViewDelegate



@end
