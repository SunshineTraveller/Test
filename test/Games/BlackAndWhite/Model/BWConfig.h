//
//  BWManager.h
//  test
//
//  Created by CBCT_MBP on 2020/1/8.
//  Copyright © 2020 zgcx. All rights reserved.
//





#import <Foundation/Foundation.h>
@class BWModel;

typedef NS_ENUM(NSUInteger, BWLevel) {
    BWLevelEasy,        // 容易
    BWLevelCommon,      // 普通
    BWLevelDifficult,   // 困难
};

@interface BWConfig : NSObject

@property(nonatomic,assign) BWLevel  level;        // 关卡难度
/* config */
+(instancetype)manager;
/* 黑白块 */
-(NSArray <BWModel *> *)items;

/* 每关游戏(黑白块)数 */
+(NSUInteger)itemCount;
/* 游戏速度 */
+(NSUInteger)speed;
/* 左右间距 */
+(CGFloat)itemMargin;
/* item 宽 */
+(CGFloat)itemWid;
/* item 高 */
+(CGFloat)itemH;
/* 每滚动一屏需要的时间 */
+(NSUInteger)screenPerSecond;


@end


