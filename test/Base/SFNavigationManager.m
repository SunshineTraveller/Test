//
//  SFNavigationManager.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "SFNavigationManager.h"
#import <mach/mach_time.h>
#import "NSObject+Extention.h"

@interface SFNavigationManager ()

//是否push或pop视图太快
@property (assign,nonatomic,readonly) BOOL isPopOrPushTooFast;
/**当前的最顶层的 ViewController*/
@property (weak,nonatomic) UIViewController *currentViewController;
//缓存
@property (nonatomic, weak) UINavigationController *navOfCurrentViewController;


@end

@implementation SFNavigationManager{
    //最后一次pop或push视图的时间（cpu时间），单位毫秒。
    uint64_t  lastPopOrPushTime;
}

#pragma mark - 初始化

static SFNavigationManager *_instance = nil;

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (uint64_t)getMachAbsoluteTime
{
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    uint64_t time = mach_absolute_time();
    return time * info.numer / info.denom;
}

#pragma mark Get & Set Methods
+ (UIViewController *)getCurrentViewController{
    return [SFNavigationManager sharedInstance].currentViewController;
}

+ (void)setCurrentViewController:(UIViewController *)currentViewController{
    [SFNavigationManager sharedInstance].currentViewController = currentViewController;
    [SFNavigationManager sharedInstance].navOfCurrentViewController = currentViewController.navigationController;
}

+ (UIViewController*) viewControllerWithClassName:(NSString*)className
{
    if (!className) return nil;
    
    NSString *realClssName  = [@"SF" stringByAppendingFormat:@"%@ViewController",className];
    UIViewController *vc    = [[NSClassFromString(realClssName) alloc] init];
    if (!vc) {
        return nil;
    }
    
    return vc;
}

+ (BOOL)openWithClassName:(NSString *)className
                parameter:(NSDictionary *)parameter
                   option:(SFOpenViewControllerOption)option
                 animated:(BOOL)animated{
    UIViewController *vc = [self viewControllerWithClassName:className];
    
    if (!vc) return NO;
    
    return [[SFNavigationManager sharedInstance] openWithViewController:vc
                                                              parameter:parameter
                                                                 option:option
                                                               animated:animated];
}

+ (BOOL)openWithViewControler:(UIViewController *)vc
                    parameter:(NSDictionary *)parameter
                       option:(SFOpenViewControllerOption)option
                     animated:(BOOL)animated{
    return [[SFNavigationManager sharedInstance] openWithViewController:vc
                                                              parameter:parameter
                                                                 option:option
                                                               animated:animated];
}

- (BOOL)openWithViewController:(UIViewController *)vc
                     parameter:(NSDictionary*)parameter
                        option:(SFOpenViewControllerOption)option
                      animated:(BOOL)animated{
    
    if (!vc) return NO;
    [self resetOpenWithViewController:vc parameter:parameter option:option animated:animated];
    return YES;
}

- (BOOL)resetOpenWithViewController:(UIViewController *)vc
                     parameter:(NSDictionary*)parameter
                        option:(SFOpenViewControllerOption)option
                      animated:(BOOL)animated {
    
    if ([self isPopOrPushTooFast] && animated) {
//        SFLog(@"NavigationManager openViewController: pop or push too fast.");
        return NO;
    }
    
    [self setParameter:parameter
        viewController:vc];
    
    if (!self.currentViewController){
//        SFLog(@"NavigationManager openViewController: currentViewController is nil.");
        return NO;
    }
    
    //获取当前视图的 NativationController
    UINavigationController *nav = [self getNavigationController];
    if (!nav) {
        nav = [self getCurrentVisibleViewController].navigationController;
    }
    if (!nav){
//        SFLog(@"NavigationManager openViewController: NavigationController is nil.");
        return NO;
    }
    
    vc.hidesBottomBarWhenPushed = YES;
    
    switch (option) {
            //当前导航栈中存在该视图，跳转并弹出该视图之前所有视图
        case SFOpenViewControllerClearAobve: {
            
            for (id subVC in nav.viewControllers) {
                if ([subVC isKindOfClass:[vc class]]) {
                    NSInteger index = [nav.viewControllers indexOfObject:subVC];
                    NSArray *vcs = [nav.viewControllers subarrayWithRange:NSMakeRange(0, index+1)];
                    [nav setViewControllers:vcs];
                }
            }
            break;
        }
            
        case SFOpenViewControllerOptionStackTop:
        default:
        {
            
            //将视图 push 到栈顶
            [nav pushViewController:vc animated:animated];
            break;
        }
            
        case SFOpenViewControllerOptionPopTopAndPush:
        {
            //弹出栈顶视图然后Push新视图
            
            if (nav.viewControllers.count < 1) {
                //栈中无视图直接 push。
                [nav pushViewController:vc animated:animated];
                break;
            }
            
            NSMutableArray *vcs =  [NSMutableArray arrayWithArray:nav.viewControllers];
            [vcs removeLastObject];
            [vcs addObject:vc];
            
            [nav setViewControllers:vcs animated:animated];
            
            break;
        }
            
        case SFOpenViewControllerOptionPopTop2AndPush:
        {
            //弹出栈顶两层视图然后Push新视图
            
            if (nav.viewControllers.count < 1) {
                //栈中无视图直接 push。
                [nav pushViewController:vc animated:animated];
                break;
            }
            
            NSMutableArray *vcs =  [NSMutableArray arrayWithArray:nav.viewControllers];
            [vcs removeLastObject];
            [vcs removeLastObject];
            [vcs addObject:vc];
            
            [nav setViewControllers:vcs animated:animated];
            
            break;
        }
            
        case SFOpenViewControllerOptionAboveBottom:
        {
            //将视图 push 到根视图的上面
            
            if (nav.viewControllers.count <=1) {
                //当前视图已经是栈顶，直接push 即可。
                [nav pushViewController:vc animated:animated];
                break;
            }
            
            NSMutableArray *vcs = [[NSMutableArray alloc]init];
            [vcs addObject:nav.viewControllers[0]];
            [vcs addObject:vc];
            
            [nav setViewControllers:vcs animated:animated];
            
            break;
        }
            
        case SFOpenViewControllerOptionClearStack:
        {
            //将视图放到栈底，弹出其它所有视图。
            NSMutableArray *vcs = [[NSMutableArray alloc]init];
            [vcs addObject:vc];
            [nav setViewControllers:vcs animated:animated];
            break;
        }
            
        case SFOpenViewControllerOptionSingleTop:
            //如果当前导航栈顶已经有该视图则不是开启新视图
            
            if (![self compareVcType:nav.topViewController vc2:vc]) {
                //栈顶不是新视图的实例，直接 push 新视图
                [nav pushViewController:vc animated:animated];
            }
            break;
            
        case SFOpenViewControllerOptionSingleTask:
            //如果当前导航栈顶已经有该视图则不在开启新视图，并且弹出之上的所有视图
            
            if (nav.topViewController) {
                //在导航栈中查找新视图的实例
                UIViewController *oldvcinstance = nil;
                for (UIViewController *oldvc in nav.viewControllers) {
                    if ([self compareVcType:oldvc vc2:vc]) {
                        oldvcinstance = oldvc;
                        break;
                    }
                }
                
                //在导航栈中找到了新视的实例，则不开启新视图并弹出旧实例之上的所有视图
                if (oldvcinstance) {
                    //则刷新视图参数
                    [self setParameter:parameter
                        viewController:oldvcinstance];
                    
                    [nav popToViewController:oldvcinstance animated:animated];
                    break;
                }
            }
            
            //导航栈中没有新视图的实例，直接push 新视图
            [nav pushViewController:vc animated:animated];
            
            break;
    }
    
    [self recordLastPorOrPushTime];
    return YES;
}

/**
 *  记录最后一次pop或push视图的时间（cpu时间），单位毫秒。
 */
-(void)recordLastPorOrPushTime
{
    lastPopOrPushTime = [self getMachAbsoluteTime] / 1000000;
}


/**
 *  是否 push 或 pop 视图太快
 *  根据最后一次 pop 或 push 的时间决定是否可以继续 pop 或 push,两次操作的间隔不能小于 0.25 秒。
 *
 *  @return 如果 push 或 pop 视图太快，则返回 YES。
 */
-(BOOL)isPopOrPushTooFast
{
    uint64_t currTime = [self getMachAbsoluteTime] / 1000000;
    
    if (currTime - lastPopOrPushTime > 250) {
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark - 类私有方法

/**
 *  比较 vc1 是否是 vc2 同一个类型，如果是则返回 YES 否则返回 NO。
 *  是否是相同类型判断方法如下：
 *  必须是相同类的实例
 *
 *  @param vc1 UIViewController
 *  @param vc2 UIViewController
 *
 *  @return 比较 vc1 是否是 vc2 同一个类型，如果是则返回 YES 否则返回 NO。
 */
-(BOOL)compareVcType:(UIViewController*)vc1 vc2:(UIViewController*)vc2
{
    if ((!vc1 && vc2) || (vc1 && !vc2)){
        return NO;
    }
    
    if (!vc1 && !vc2) {
        return YES;
    }
    
    if (![vc1 isMemberOfClass:[vc2 class]]) {
        return NO;
    }
    
    if (vc1 == vc2) {
        return YES;
    }
    else{
        return NO;
    }
}

-(void)setParameter:(NSDictionary*)parm
     viewController:(UIViewController*)vc{
    
    if (parm && [vc respondsToSelector:NSSelectorFromString(@"parameter")]){
        NSMutableDictionary *parameter = [vc valueForKey:@"parameter"];
        if (!parameter) {
            parameter = [[NSMutableDictionary alloc]init];
            [vc setValue:parameter forKey:@"parameter"];
        }
        
        [parameter addEntriesFromDictionary:parm];
    }
}

-(UINavigationController* _Nullable)getNavigationController
{
    if (self.currentViewController.navigationController){
        return self.currentViewController.navigationController;
    }
    else {
        UIViewController* vc = self.currentViewController;
        while (vc){
            if ([vc isKindOfClass:[UINavigationController class]]) {
                return (UINavigationController*)vc;
            }
            vc = vc.parentViewController;
        }
    }
    
    return [SFNavigationManager sharedInstance].navOfCurrentViewController;
}

@end
