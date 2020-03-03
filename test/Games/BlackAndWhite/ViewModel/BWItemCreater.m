//
//  BWItemCreater.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWItemCreater.h"

@interface BWItemCreater ()
@property(nonatomic,strong) BWConfig *config;
@end

@implementation BWItemCreater

/*
 方块儿创建工具
 */
+(instancetype)createrWithConfig:(BWConfig *)config {
    BWItemCreater *instance = [[BWItemCreater alloc] init];
    if (!config) {
        config = [BWConfig defaultConfig];
    }
    instance.config = config;
    return instance;
}

/*
 通过游戏级别获取每屏方块儿数
 level  :  游戏级别
 return :  每屏方块儿数
 */
-(NSArray <BWModel *>*)getItems {
    
    if (!self.config) return nil;

    NSMutableArray *tmpItems = @[].mutableCopy;
    NSUInteger itemCount = [self.config itemCount];
    for (int i = 0; i<itemCount; i++) {
        BWModel *model = [[BWModel alloc] init];
        model.isSelected = [self getRandomColor];
        [tmpItems addObject:model];
    }
    return tmpItems;
}
-(BOOL )getRandomColor {
    return arc4random_uniform(2);
}


@end
