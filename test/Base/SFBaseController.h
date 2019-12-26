//
//  SFBaseController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFBaseController : UIViewController

//当前页面的参数
@property (strong,nonatomic,readonly,nullable)NSMutableDictionary* parameter;
//是否需要隐藏导航条。
@property (assign,nonatomic) BOOL                  hideNavigationBar;
// 视图是否显现。
@property (assign,nonatomic,readonly) BOOL         isAppear;
//是否显示返回按钮，与leftBarButtonItem冲突，两者择其一
@property (nonatomic, assign) BOOL                 showBackButton;
//统计用的名称
@property (nonatomic, nonnull, strong) NSString    *analysisName;
/** 当前网络是否为WiFi */
@property (nonatomic,assign) BOOL                  isWiFi;
/** 是否自动退出界面当退出登录的时候 */
@property(nonatomic,assign) BOOL                   autoPopVCWhenLogout;


/**
 *  结束当前页面返回上一页。
 */
-(void)finish;

#pragma mark - 网络状态变化 子类实现
/** 子类实现 */
-(void)networkChangeWithStatus:(NSInteger)status;

/** 页面消失前的回调 */
-(void)onBackAction:(dispatch_block_t)backHandler;
/** 抢登 */
-(void)logoutNotification:(NSNotification *)noti;

/** 小红点 */
-(void)handleNavbarRedDot;

@end

NS_ASSUME_NONNULL_END
