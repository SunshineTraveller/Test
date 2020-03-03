//
//  BWItemCreater.h
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWItemCreater : NSObject

/*
 方块儿创建工具
 */
+(instancetype)createrWithConfig:(BWConfig *)config;

/*
 通过游戏级别获取每屏方块儿
 level  :  游戏级别
 return :  每屏方块儿
 */
-(NSArray <BWModel *>*)getItems;

@end

NS_ASSUME_NONNULL_END
