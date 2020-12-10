//
//  SFWebController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/11/28.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//
//  H5页面


#import "WKDelegateViewController.h"
#import "SFNavigationController.h"


@interface SFWebController : SFBaseController

#pragma mark ****************  通用  ****************
/* 分享的数据全部保存在字典里，和网页的url一一对应 */
@property(nonatomic,strong) NSMutableDictionary *shareData;
/* 当前网页路径 */
@property(nonatomic,copy) NSString              *currentUrlString;
/* finish */
@property(nonatomic,copy) void(^finish)(void);
/* webview */
@property (nonatomic,strong) WKWebView          *wkWebView;
/* url */
@property(nonatomic, copy) NSString             *url;




@end
