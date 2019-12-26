//
//  SFNavigationController.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "SFNavigationController.h"

@interface SFNavigationController ()
@property (nonatomic) BOOL pushing;
//是否是返回模式
@property (nonatomic) BOOL returnMode;
//手势开启时当前导航视图的x,y坐标
@property (nonatomic) CGPoint navStartPoint;
@end

@interface SFNavigationControllerDelgateHandle : NSObject
<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (weak,nonatomic) SFNavigationController *navController;
@property (weak,nonatomic) UIPanGestureRecognizer *gestureRecognizer;
@end


@implementation SFNavigationController{
    //是否已经初始化
    BOOL mInitialized;
    BOOL mViewDidAppear;
    //背景 View
    UIView *mBackgroundView;
    SFNavigationControllerDelgateHandle *mDelegateHandler;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pushing = NO;
    _enableSwipeReturn = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!mInitialized) {
        mInitialized = YES;
        mDelegateHandler = [[SFNavigationControllerDelgateHandle alloc]init];
        mDelegateHandler.navController = self;
        mBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
//        mBackgroundView.backgroundColor = kColor21;
        [self.view.superview insertSubview:mBackgroundView belowSubview:self.view];
    }
    self.delegate = mDelegateHandler;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (!mViewDidAppear) {
        mViewDidAppear = YES;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (animated) {
        _pushing = YES;
    }
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航子控制器按钮的加载样式
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    if (animated) {
        _pushing = YES;
    }
    
    [super setViewControllers:viewControllers animated:animated];
}

- (void)setIsHiddenNavLine:(BOOL)isHiddenNavLine{
    _isHiddenNavLine = isHiddenNavLine;
    //隐藏导航栏
    UIImageView *navigationImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navigationImageView.hidden = isHiddenNavLine;
}

//隐藏导航栏
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setEnableSwipeReturn:(BOOL)enableSwipeReturn{
    _enableSwipeReturn = enableSwipeReturn;
    self.interactivePopGestureRecognizer.enabled = enableSwipeReturn;
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
/** 隐藏底部横条 */
-(BOOL)prefersHomeIndicatorAutoHidden {
    return self.topViewController.prefersHomeIndicatorAutoHidden;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}
@end

@implementation SFNavigationControllerDelgateHandle
#pragma mark - 手势委托处理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //NSLog(@"gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer");
    //NSLog(@"form:%@ to:%@",NSStringFromClass([gestureRecognizer class]),NSStringFromClass([otherGestureRecognizer class]));
    //NSLog(@"self:%d, form:%d to:%d",self.gestureRecognizer.hash,gestureRecognizer.hash,otherGestureRecognizer.hash);
    //是否充多个手势同时触发。
    return NO;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return [self canBeginGestureRecognizer:gestureRecognizer
                                     touch:[gestureRecognizer locationInView:self.navController.view.superview]];
}

-(BOOL)canBeginGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer touch:(CGPoint)point {
    //如果手势不是 UIPanGestureRecognizer 的直接子类，则可能是一个返回手势
    if ([gestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        //当前视图是否隐藏了返回按钮
        BOOL hideReturnButton = NO;
        if (_navController.topViewController) {
            UIViewController *vc = _navController.topViewController;
            UINavigationBar *bar = _navController.navigationBar;
            //首先视图必须是在没有隐藏NavigationBar 的情况下，才证判断是否隐藏了返回按钮
            //如果隐藏了则有可能是自定义了一个导航栏，此时是无法做出判断的。
            if (bar && !bar.hidden && !_navController.navigationBarHidden){
                UIBarButtonItem *leftItem = vc.navigationItem.leftBarButtonItem;
                if (vc.navigationItem.hidesBackButton && (!leftItem || (leftItem.customView && leftItem.customView.hidden))){
                    hideReturnButton = YES;
                }
            }
        }
        if(_navController.viewControllers.count <= 1 ||  _navController.pushing || hideReturnButton){
            //1.侧滑返回手势在根视图上不可用
            //2.当正在 push 或 pop 时禁用。
            //3.当前视图的返回按钮被隐藏时禁用
            return NO;
        } else{
            //            NSLog(@"gestureRecognizerShouldBegin:YES");
            return YES;
        }
    }
    return NO;
}


#pragma mark - NavigationController 事件
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    
    _navController.pushing = NO;
    //iOS7.0 级以上系统，开启系统自动滑动返回功能
    //iOS7 系统必需在页面的 leftBarButtonItem 设置完成后设置 interactivePopGestureRecognizer 相关属性才有效，
    //因此将 interactivePopGestureRecognizer 属性设置放在此位置上。
    _navController.interactivePopGestureRecognizer.enabled = _navController.enableSwipeReturn;
    _navController.interactivePopGestureRecognizer.delegate = self;
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    //删除系统自带的tabBarButton
//    for (UIView *tabBar in navigationController.tabBarController.tabBar.subviews) {
//        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            tabBar.alpha = 0;
//            [tabBar removeFromSuperview];
//        }
//    }
//}

@end
