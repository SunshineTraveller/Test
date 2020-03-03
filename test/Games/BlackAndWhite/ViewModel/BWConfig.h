//
//  BWManager.h
//  test
//
//  Created by CBCT_MBP on 2020/1/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWModel.h"

typedef NS_ENUM(NSUInteger, BWLevel) {
    BWLevelEasy     =  1,    // 容易
    BWLevelCommon,           // 普通
    BWLevelDifficult,        // 困难
};

@interface BWConfig : NSObject

@property(nonatomic,assign) BWLevel  level;        // 关卡难度
/* config */
+(instancetype)defaultConfig;
/* 游戏速度 */
-(NSUInteger)speed;
/* 每屏方块儿数 */
-(NSUInteger)itemCount;

@end


