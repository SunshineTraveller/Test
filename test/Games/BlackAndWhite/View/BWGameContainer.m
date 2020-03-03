//
//  BWScrollView.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWGameContainer.h"
#import "BWGameView.h"
#import "BWItemCreater.h"
#import "BWModel.h"

@interface BWGameContainer ()

@property(nonatomic,strong) BWItemCreater   *creater;         // 配置项

@property(nonatomic,assign) CGFloat         speed;           // 滚动速度
@property(nonatomic,strong) CADisplayLink   *displayLink;    // 计时器
@property(nonatomic,assign) CGFloat         stepPace;        // 步长
@property(nonatomic,assign) CGFloat         second;          // 秒针

@property(nonatomic,strong) UIView          *contentView;
@property(nonatomic,strong) BWGameView      *topView;
@property(nonatomic,strong) BWGameView      *btmView;

@end

@implementation BWGameContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

/* 基本配置 */
-(void)setupConfig {
    [self setupDefaultConfig];
    [self addCustomViews];
}

-(void)setupDefaultConfig {
    BWConfig *config = [BWConfig defaultConfig];
    config.level = BWLevelCommon;
    _creater = [BWItemCreater createrWithConfig:config];
}

-(void)addCustomViews {
    [self addSubview:self.contentView];
    self.topView = [[BWGameView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.btmView = [[BWGameView alloc] initWithFrame:CGRectMake(0, kScreenH, kScreenW, kScreenH)];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.btmView];
    
    WeakSelfDefault
    self.topView.cubicClickHandler = ^(BOOL success) {
        StrongSelfDefault
        [self onClickCubic:success];
    };
    self.btmView.cubicClickHandler = ^(BOOL success) {
        StrongSelfDefault
        [self onClickCubic:success];
    };
}
-(void)onClickCubic:(BOOL)success {
    // 踩对了,继续游戏
    if (success) {
        
    // 踩错了,结束游戏
    }else {
        [self stopGame];
    }
}
-(void)onTopViewDismiss {
    self.topView.y = kScreenH;
    [self.topView reloadWithModels:[_creater getItems]];
    [self commitAnimation];
}
-(void)onBtmViewDismiss {
    self.btmView.y = kScreenH;
    [self.btmView reloadWithModels:[_creater getItems]];
    [self commitAnimation];
}

#pragma mark ****************  public  ****************
-(void)setupSpeed:(CGFloat)speed {
    _speed = speed;
}
-(void)startGame {
    [self commitAnimation];
    [self.btmView reloadWithModels:[_creater getItems]];
}
-(void)stopGame {
    [self.topView.layer removeAllAnimations];
    [self.btmView.layer removeAllAnimations];
}
-(void)commitAnimation {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.topView.y -= kScreenH;
        self.btmView.y -= kScreenH;
    } completion:^(BOOL finished) {
        if (self.topView.y == -kScreenH) {
            [self onTopViewDismiss];
        }else if (self.btmView.y == -kScreenH) {
            [self onBtmViewDismiss];
        }
    }];
}




#pragma mark ****************  getter  ****************
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, kScreenW, 2*kScreenH)];
    }
    return _contentView;
}

@end
