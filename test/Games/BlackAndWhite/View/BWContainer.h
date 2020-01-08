//
//  BWScrollView.h
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWConfig.h"

@interface BWContainer : UIView

/* 设置游戏配置 */
-(void)setupConfig:(BWConfig *)config;
/* 开始游戏 */
-(void)startGame;
/* 结束游戏 */
-(void)stopGame;

@end

