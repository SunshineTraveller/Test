//
//  BWController.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWController.h"

#import "BWContainer.h"

@interface BWController ()
@property(nonatomic,strong) UILabel     *guide;
@property(nonatomic,strong) BWContainer *gameView;
@property(nonatomic,assign) NSInteger   timer;
@end

@implementation BWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hideNavigationBar = YES;
    _gameView = [[BWContainer alloc] init];
    [self.view addSubview:_gameView];
    [_gameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self setupGuide];
}
-(void)setupGuide {
    _timer = 4;
    _guide = [[UILabel alloc] init];
    _guide.textAlignment = NSTextAlignmentCenter;
    _guide.backgroundColor = [SFhexColorAlpha(@"000000", 0.3) colorWithAlphaComponent:0.3];
    _guide.textColor = kColor33;
    _guide.font = kFont(30);
    [self.view addSubview:_guide];
    [_guide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self countDown];
}
-(void)countDown {
    if (_timer <= -1) {
        [self canPerformAction:@selector(countDown) withSender:nil];
        [self startGame];
        _guide.hidden = YES;
        return;
    }
    _timer -= 1;
    _guide.text = [NSString stringWithFormat:@"%ld",(long)_timer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self countDown];
    });
}
-(void)startGame {
    [_gameView startGame];
}


@end
