//
//  BWManager.m
//  test
//
//  Created by CBCT_MBP on 2020/1/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "BWConfig.h"
#import "BWModel.h"

@implementation BWConfig

+(instancetype)manager {
    return [[self alloc] init];
}

/* 黑白块 */
-(NSArray <BWModel *> *)items {
    NSMutableArray *tmpItems = [NSMutableArray array];
    for (int i = 0; i < [BWConfig itemCount]; i++) {
        BWModel *model = [[BWModel alloc] init];
        model.leftColorWhite = [self getRandomState];
        [tmpItems addObject:model];
    }
    return tmpItems;
}
-(BOOL)getRandomState {
    return arc4random_uniform(2);
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
            tmpCount    = 50;
            break;
            
            // 普通
        case BWLevelCommon:
            tmpSpeed    = 4;
            tmpCount    = 100;
            break;
            
            // 困难
        case BWLevelDifficult:
            tmpSpeed    = 3;
            tmpCount    = 150;
            break;
            
        default:
            tmpSpeed    = 5;
            tmpCount    = 50;
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

/* 游戏速度 */
+(NSUInteger)speed {
    return [[self alloc] getParam:0];
}

/* 每关游戏(黑白块)数 */
+(NSUInteger)itemCount {
    return [[self alloc] getParam:1];
}

// 左右间距
+(CGFloat)itemMargin {
    return 20.f;
}

// item 宽
+(CGFloat)itemWid {
    return (kScreenW - [BWConfig itemMargin] * 4) / 2;
}

// item 高
+(CGFloat)itemH {
    return ((kScreenW - [BWConfig itemMargin] * 4) / 2) * 16 / 9;
}

/* 每滚动一屏需要的时间 */
+(NSUInteger)screenPerSecond {
    // 规定每5秒滚动一屏的高度
    NSUInteger sepCount   = kScreenH / [BWConfig itemH] + 1;      // 每屏竖向展示个数
    NSUInteger perSHCount = [self itemCount] / sepCount;     // 多少个屏高
    return perSHCount * [self speed];
}

@end
