//
//  SFNavigationManager.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    /**在栈顶开启新视图*/
    SFOpenViewControllerOptionStackTop   = 0x00000000,
    /**弹出栈顶视图然后Push新视图*/
    SFOpenViewControllerOptionPopTopAndPush,
    /**弹出栈顶两层视图然后Push新视图*/
    SFOpenViewControllerOptionPopTop2AndPush,
    /**将新视图放在栈底视图之上，并弹出其之上的所有视图*/
    SFOpenViewControllerOptionAboveBottom,
    /**弹出所有视图，将新视图放在栈底*/
    SFOpenViewControllerOptionClearStack,
    /**如果当前导航栈顶已经有该视图则不开启新视图*/
    SFOpenViewControllerOptionSingleTop,
    /**如果当前导航栈中已经有该视图则不在开启新视图，并且弹出之上的所有视图。*/
    SFOpenViewControllerOptionSingleTask,
    /** 当前导航栈中存在该视图，跳转并弹出该视图之前所有视图 */
    SFOpenViewControllerClearAobve
    
}SFOpenViewControllerOption;

NS_ASSUME_NONNULL_BEGIN

@interface SFNavigationManager : NSObject

/**
 *  获取当前栈激活（前台）的 ViewController
 */
+ (UIViewController *)getCurrentViewController;

/**
 *  设置当前栈激活（前台）的 ViewController
 */
+ (void)setCurrentViewController:(UIViewController *)currentViewController;

/**
 *  根据 className 实例化 ViewController 并 push 到导航栈中。
 *
 *  @param className  　ViewController的类名中间部分，例如 MS*****ViewController，这里 className 应该为 ******。
 *  @param parameter 参数
 *  @param option open 选项
 *  @param animated Push动画开关。
 */
+ (BOOL)openWithClassName:(NSString*)className
                parameter:(NSDictionary*)parameter
                   option:(SFOpenViewControllerOption)option
                 animated:(BOOL)animated;

+ (BOOL)openWithViewControler:(UIViewController *)vc
                    parameter:(NSDictionary *)parameter
                       option:(SFOpenViewControllerOption)option
                     animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
