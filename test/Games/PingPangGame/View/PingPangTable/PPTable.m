//
//  PPTable.m
//  Games
//
//  Created by sunshine on 2019/12/25.
//  Copyright © 2019 Sunshine. All rights reserved.
//

#import "PPTable.h"


#import "PPBall.h"
#import "PPBat.h"

@interface PPTable ()

/* 中间的拦网 */
@property (nonatomic,strong) UIImageView *ppNet;
/* 乒乓球 */
@property (nonatomic,strong) PPBall      *ppBall;
/** 玩家的球拍 */
@property (nonatomic,strong) PPBat       *userBat;
/** 电脑的球拍 */
@property (nonatomic,strong) PPBat       *autoBat;

@end

@implementation PPTable

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews {
    [self addSubview:self.ppNet];
    [self addSubview:self.ppBall];
    [self addSubview:self.userBat];
    [self addSubview:self.autoBat];
    
    [self.ppNet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    [self.ppBall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(90);
        make.top.equalTo(self).offset(100);
        make.width.height.mas_equalTo(30);
    }];
    [self.userBat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [self.autoBat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.width.height.equalTo(self.userBat);
    }];
    
}

-(PPBat *)userBat {
    if (!_userBat) {
        _userBat = [[PPBat alloc] init];
        _userBat.backgroundColor = UIColor.redColor;
    }
    return _userBat;
}
-(PPBat *)autoBat {
    if (!_autoBat) {
        _autoBat = [[PPBat alloc] init];
        _autoBat.backgroundColor = UIColor.blueColor;
    }
    return _autoBat;
}
-(UIImageView *)ppNet {
    if (!_ppNet) {
        _ppNet = [[UIImageView alloc] init];
        _ppNet.image = [UIImage imageNamed:@"icon_ppNet"];
    }
    return _ppNet;
}
-(PPBall *)ppBall {
    if (!_ppBall) {
        _ppBall = [[PPBall alloc] init];
        _ppBall.image = [UIImage imageNamed:@"icon_ppBall"];
    }
    return _ppBall;
}

@end
