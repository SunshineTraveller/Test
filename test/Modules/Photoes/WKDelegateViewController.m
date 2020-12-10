//
//  SFWebController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/11/28.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//


#import "WKDelegateViewController.h"

@interface WKDelegateViewController ()

@end

@implementation WKDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
