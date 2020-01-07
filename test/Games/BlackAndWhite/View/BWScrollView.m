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
@property(nonatomic,strong) UIView       *midContainer;   // 第一个容器
@property(nonatomic,strong) UIView       *btmContainer;   // 第二个容器
@property(nonatomic,strong) NSTimer      *timer;          // 计时器

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
    [self.contentView addSubview:self.midContainer];
    [self.contentView addSubview:self.btmContainer];
}
/* 容器约束 */
-(void)layoutCustomviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    [self.topContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(kScreenH);
        make.width.mas_equalTo(kScreenW);
    }];
    [self.midContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.topContainer.mas_bottom);
        make.height.mas_equalTo(kScreenH);
        make.width.mas_equalTo(kScreenW);
    }];
    [self.btmContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.midContainer.mas_bottom);
        make.height.mas_equalTo(kScreenH);
        make.width.mas_equalTo(kScreenW);
    }];
}

#pragma mark ****************  actions  ****************
-(void)timerAction {
    [UIView animateWithDuration:_speed animations:^{
        [self.contentView setContentOffset:CGPointMake(0, kScreenH)];
    }];
}

#pragma mark ****************  UIScrollViewDelegate  ****************
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.y == 2*kScreenH) {
        [self.topContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btmContainer.mas_bottom);
        }];
    }
    
}


#pragma mark ****************  public  ****************
-(void)setupSpeed:(CGFloat)speed {
    _speed = speed;
}
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
        _contentView.contentSize = CGSizeMake(kScreenW, 2*kScreenH);
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
-(UIView *)midContainer {
    if (!_midContainer) {
        _midContainer = [[UIView alloc] init];
        _midContainer.backgroundColor = UIColor.cyanColor;
    }
    return _midContainer;
}

@end
