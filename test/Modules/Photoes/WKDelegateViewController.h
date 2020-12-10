//
//  SFWebController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/11/28.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end


@interface WKDelegateViewController : UIViewController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end
