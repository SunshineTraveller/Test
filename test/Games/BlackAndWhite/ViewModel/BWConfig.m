//
//  BWManager.m
//  test
//
//  Created by CBCT_MBP on 2020/1/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "BWConfig.h"

@implementation BWConfig

+(instancetype)defaultConfig {
    return [[self alloc] init];
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.level = BWLevelEasy;
    }
    return self;
}

/* 游戏速度 */
-(NSUInteger)speed {
    return [self getParam:0];
}
/* 每屏方块儿数 */
-(NSUInteger)itemCount {
    return [self getParam:1];
}

/*
 获取对应参数
 type   1:速度  2:黑白块数目
 */
-(NSUInteger)getParam:(NSInteger)type {
    
    NSUInteger param;       // 参数
    NSUInteger tmpSpeed;    // 速度
    NSUInteger tmpCount;    // 黑白块数目
    
    // 根据难易程度初始化参数
    switch (_level) {
            // 简单
        case BWLevelEasy:
            tmpSpeed    = 5;
            tmpCount    = 12;
            break;
            
            // 普通
        case BWLevelCommon:
            tmpSpeed    = 6;
            tmpCount    = 16;
            break;
            
            // 困难
        case BWLevelDifficult:
            tmpSpeed    = 7;
            tmpCount    = 150;
            break;
            
        default:
            tmpSpeed    = 5;
            tmpCount    = 12;
            break;
    }
    
    
    // 根据类型返回对应参数
    switch (type) {
            // 速度
        case 0:
            param   = tmpSpeed;
            break;
            // 黑白块数目
        case 1:
            param   = tmpCount;
            break;
            // 默认为速度
        default:
            param   = tmpSpeed;
            break;
    }
    return param;
}

@end
