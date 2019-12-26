//
//  BWScrollView.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWScrollView.h"

@interface BWScrollView ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *contentView;
@property(nonatomic,strong) UIView       *topContainer;   // 第一个容器
@property(nonatomic,strong) UIView       *btmContainer;   // 第二个容器
@property(nonatomic,strong) NSTimer      *timer;          // 计时器

@property(nonatomic,assign) CGFloat      scrollUnit;      // 滚动单位长
@property(nonatomic,assign) CGFloat      speed;           // 滚动速度

@end

@implementation BWScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}
/* 基本配置 */
-(void)setupConfig {
    [self setupDefaultData];
    [self setupTimer];
    [self addCustomViews];
    [self layoutCustomviews];
}
-(void)setupDefaultData {
    _scrollUnit = 20;
    _speed      = 2*10;
}
/* 创建计时器 */
-(void)setupTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)fireTimer {
    [_timer fire];
}
/* 销毁计时器 */
-(void)invalidateTime {
    [_timer invalidate];
    _timer = nil;
}
/* 加载容器 */
-(void)addCustomViews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topContainer];
    [self.contentView addSubview:self.btmContainer];
}
/* 容器约束 */
-(void)layoutCustomviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenH);
    }];
    [self.btmContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topContainer.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenH);
    }];
}

#pragma mark ****************  actions  ****************
-(void)timerAction {
    _scrollUnit += _speed;
    [self.contentView setContentOffset:CGPointMake(0, _scrollUnit)];
}

#pragma mark ****************  UIScrollViewDelegate  ****************
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"-0---  %f",offset.y);
    if (offset.y) {
        
    }
}


#pragma mark ****************  public  ****************
-(void)startGame {
    [self fireTimer];
}
-(void)stopGame {
    [self invalidateTime];
}

#pragma mark ****************  getter  ****************
-(UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.contentSize = CGSizeMake(kScreenW, kScreenH);
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}
-(UIView *)topContainer {
    if (!_topContainer) {
        _topContainer = [[UIView alloc] init];
        _topContainer.backgroundColor = UIColor.redColor;
    }
    return _topContainer;
}
-(UIView *)btmContainer {
    if (!_btmContainer) {
        _btmContainer = [[UIView alloc] init];
        _btmContainer.backgroundColor = UIColor.blueColor;
    }
    return _btmContainer;
}


@end
