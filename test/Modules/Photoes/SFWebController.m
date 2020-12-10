//
//  SFWebController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/11/28.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "SFWebController.h"

@interface SFWebController ()<WKUIDelegate,WKNavigationDelegate,
WKScriptMessageHandler,
WKDelegate>


/* WK代理VC */
@property (nonatomic,strong) WKUserContentController  *userContentController;
/* WKConfig */
@property (nonatomic,strong) WKWebViewConfiguration   *config;
/* cv */
@property (nonatomic,strong) WKDelegateViewController *delegateVC;
/* webview 进度条 */
@property (nonatomic, strong) UIProgressView          *progressView;
/* 埋点相关 */
@property(nonatomic,strong) NSDictionary              *events;


@end

@implementation SFWebController

#pragma mark ***** 生命周期 *****
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBaseConfig];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self handleStuff:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self handleStuff:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    if (self.finish) {
        self.finish();
    }
    [self.wkWebView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(title))];
    [self.wkWebView removeObserver:self
                        forKeyPath:@"URL"];
}

#pragma mark ***** 自定义 *****
-(void)setupBaseConfig {
    
    // 背景颜色等
    self.hideNavigationBar = YES;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 监听URL变化
    [self.wkWebView addObserver:self
                     forKeyPath:@"URL"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    // 注册
    self.delegateVC = [[WKDelegateViewController alloc] init];
    self.delegateVC.delegate = self;
    
}

/* 加载数据 */
-(void)loadData {
    
    //add progress view
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.wkWebView];
    self.wkWebView.backgroundColor = kWhiteColor;
    
    // 监听webview的 进度 及 title
    [self.wkWebView addObserver:self
                 forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                    options:0
                    context:nil];
    [self.wkWebView addObserver:self
                     forKeyPath:@"title"
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"3dphotoes/"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    if (@available(iOS 9.0, *)) {
        [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    } else {
        // Fallback on earlier versions
    }
}

/* 登出通知 */
-(void)onReceiveLogoutNotification {
    [self.navigationController popViewControllerAnimated:YES];
}

/* 杂项 */
-(void)handleStuff:(BOOL)handle {
    /* 埋点 */
    [self eventTrackingBegin:handle];
    /* H5交互相关 */
    if (handle) {
        // 添加回调
        [self.userContentController addScriptMessageHandler:self.delegateVC name:@"onAppResponse"];
    }else {
        // 删除回调
        [self.userContentController removeScriptMessageHandlerForName:@"onAppResponse"];
    }
}

/* 埋点事件处理 */
-(void)eventTrackingBegin:(BOOL)isPageBegin {
    
}

/* 返回事件 */
-(void)onClickBackAction {

    // 是否能返回 webview 上级页面
    if(self.wkWebView && self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark ****************  WKNavigationDelegate  ****************
/* 页面开始加载时调用 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让进度条显示
    self.progressView.hidden = NO;
}

/* 当内容开始返回时调用 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

/* 页面加载完成之后调用 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

/* 页面加载失败时调用 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
   
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

/* 接收到服务器跳转请求之后调用 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

/* 在收到响应后，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/* 在发送请求之前，决定是否跳转 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    //如果是跳转一个新页面
//    NSString *urlString = [[navigationAction.request URL] absoluteString];
//    urlString = [urlString stringByRemovingPercentEncoding];
//
//    // 打电话得自己处理。。。
//    if ([urlString hasPrefix:@"tel"]) {
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//
//    }else {
//
//        if (navigationAction.targetFrame == nil) {
//            [webView loadRequest:navigationAction.request];
//        }
//        //允许跳转
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
    if(webView != self.wkWebView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = navigationAction.request.URL;
    
    if ([url.scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);


}

#pragma mark ****************  WKUIDelegate  ****************
/* 创建一个新的WebView */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    //假如是重新打开窗口的话
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/* 输入框 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil]; 
    completionHandler(@"http");
    
}

/* 确认框 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

/* 警告框 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    completionHandler();
}

/* JS 调 OC */
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    
}

/* kvo监听wkwebview的加载进度 title URL 变化等 */
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkWebView) {
        
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress
                              animated:animated];
        
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                [self.progressView setAlpha:0.0f];
            }
                             completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
        
    }else if([keyPath isEqualToString:@"title"]){
        
       
        
    }else if([keyPath isEqualToString:@"URL"]) {
        NSLog(@"webviewURL: --   %@",self.wkWebView.URL.absoluteString);
        // 网页URL发生变化时，通过URL去拿页面的分享数据，有数据则显示右侧分享按钮，无数据则隐藏
        
    }else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
    
}


#pragma mark ****************  懒加载  ****************
-(WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88+self.progressView.height, self.view.width, kScreenH - 88 - self.progressView.height) configuration:self.config];
        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = kWhiteColor;
        _wkWebView.opaque = NO;
        _wkWebView.navigationDelegate = self;
        _wkWebView.userInteractionEnabled = YES;
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _wkWebView;
}

-(WKWebViewConfiguration *)config {
    if (_config == nil) {
        _config = [[WKWebViewConfiguration alloc] init];
        _config.userContentController = self.userContentController;
        WKPreferences *prefer = [[WKPreferences alloc] init];
        prefer.javaScriptEnabled = YES;
        prefer.javaScriptCanOpenWindowsAutomatically = YES;
        _config.preferences = prefer;
        _config.allowsInlineMediaPlayback = YES;
    }
    return _config;
}

-(WKUserContentController *)userContentController {
    if (_userContentController == nil) {
        _userContentController = [[WKUserContentController alloc] init];
    }
    return _userContentController;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 88, kScreenW, 5);
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255
                                                         green:240.0/255
                                                          blue:240.0/255
                                                         alpha:1.0]];
        _progressView.progressTintColor = kMainRedColor;
    }
    return _progressView;
}

-(NSMutableDictionary *)shareData {
    if (!_shareData) {
        _shareData = [NSMutableDictionary dictionary];
    }
    return _shareData;
}


@end

