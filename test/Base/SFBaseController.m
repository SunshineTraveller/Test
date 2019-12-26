//
//  SFBaseController.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "SFBaseController.h"

#import "SFNavigationController.h"
#import "SFNavigationManager.h"

@interface SFBaseController ()
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;
/** back */
@property(nonatomic,strong) UIButton *backBtn;
/** back */
@property(nonatomic,copy) dispatch_block_t backHandler;

@property(nonatomic,assign) BOOL mineLock;        // 跳转我的锁

@end

@implementation SFBaseController{
    __weak UINavigationBar *mNavigationBarForKvo;
}

#pragma mark - 视图的生命周期
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _parameter  = [[NSMutableDictionary alloc]init];
        _analysisName = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor28;
    _autoPopVCWhenLogout = YES;

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {self.edgesForExtendedLayout = UIRectEdgeNone;}
    if (![SFNavigationManager getCurrentViewController]){ [SFNavigationManager setCurrentViewController:self];}
    if (self.navigationController && self.navigationController.viewControllers.count>1) {
        self.showBackButton = YES;
    }else if(self.presentingViewController){
        self.showBackButton = YES;
    }

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.backgroundColor = kColor28;
    [self.navigationController.navigationBar setBarTintColor:kColor28];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColor28] forBarMetrics:(UIBarMetricsDefault)];

}

#pragma mark ***** 网络通知回调 *****
/** 网络状态 */
-(void)networkStatusNoti:(NSNotification *)noti {

}
/** 子类实现 */
-(void)networkChangeWithStatus:(NSInteger)status {
    // TODO...
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isAppear = YES;
    [self.view endEditing:YES];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:self.hideNavigationBar animated:animated];
        
        //解决当滑动返回快速取消时导航条错乱的问题
        if (!mNavigationBarForKvo){
            mNavigationBarForKvo = self.navigationController.navigationBar;
            [mNavigationBarForKvo addObserver:self
                                   forKeyPath:@"hidden"
                                      options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                      context:NULL];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [SFNavigationManager setCurrentViewController:self];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isAppear = NO;
    if (mNavigationBarForKvo) {
        [mNavigationBarForKvo removeObserver:self forKeyPath:@"hidden"];
        mNavigationBarForKvo = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc{
    
    if ([SFNavigationManager getCurrentViewController] == self){
        [SFNavigationManager setCurrentViewController:nil];
    }
    if (mNavigationBarForKvo) {
        [mNavigationBarForKvo removeObserver:self forKeyPath:@"hidden"];
    }
    NSLog(@"\n❌------ %@ Dealloc ------❌\n",[self class]);
}

-(void)setShowBackButton:(BOOL)showBackButton{
    _showBackButton = showBackButton;
    if (_showBackButton) {
        if (!self.backButtonItem) {
            self.backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
        }
        self.navigationItem.leftBarButtonItem = self.backButtonItem;
    }else{
        [self.navigationItem setHidesBackButton:YES];
        if (self.navigationItem.leftBarButtonItem == self.backButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    if([keyPath isEqualToString:@"hidden"] &&
       [object isKindOfClass:[UINavigationBar class]]){
        if ([[change objectForKey:NSKeyValueChangeNewKey] boolValue] != self.hideNavigationBar){
            [self.navigationController setNavigationBarHidden:self.hideNavigationBar animated:NO];
        }
    }
}


- (void)finish{

    UINavigationController *nav = self.navigationController;
    if (nav){
        if (nav.topViewController != self){
            //vc 不是最顶层的，则重新生成导航栈
            NSMutableArray *vcs = [nav.viewControllers mutableCopy];
            [vcs removeObject:self];
            [nav setViewControllers:vcs animated:NO];
        }
        else{
            //vc 是最顶层的
            [nav popViewControllerAnimated:YES];
        }
    }
    else if (self.presentingViewController){
        //vc 是否是被 present 出来的，如果是则 dismiss
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     
                                 }];
    }
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

/** 隐藏底部横条 */
-(BOOL)prefersHomeIndicatorAutoHidden {
    return NO;
}

/** 返回前的回调 */
-(void)onBackAction:(dispatch_block_t)backHandler {
    
}

-(void)setAutoPopVCWhenLogout:(BOOL)autoPopVCWhenLogout {
    _autoPopVCWhenLogout = autoPopVCWhenLogout;
}
-(void)onReceiveShowRedDotNoti {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleNavbarRedDot];
    });
}

-(UIButton *)backBtn {
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:image(@"icon_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _backBtn.frame = CGRectMake(0, 0, 54, 44);
    }
    return _backBtn;
}


@end




