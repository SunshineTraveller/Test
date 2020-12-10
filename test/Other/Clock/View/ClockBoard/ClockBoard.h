//
//  ClockBoard.h
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//
//  表盘

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockBoard : UIView

+(instancetype)boardView:(CGRect)frame;

-(void)setHour:(CGFloat)hour
        minute:(CGFloat)minute
        second:(CGFloat)second;
-(void)start;
-(void)stop;

@end

NS_ASSUME_NONNULL_END
