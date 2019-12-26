//
//  NSObject+Extention.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "NSObject+Extention.h"

#import <objc/runtime.h>

@implementation NSObject (Extention)

//+ (void)load{
//
//    SEL originalSelector = @selector(doesNotRecognizeSelector:);
//    SEL swizzledSelector = @selector(sw_doesNotRecognizeSelector:);
//
//    Method originalMethod = class_getClassMethod(self, originalSelector);
//    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
//
//    if(class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))){
//        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    }else{
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}

//+ (void)sw_doesNotRecognizeSelector:(SEL)aSelector{
//    [self sw_doesNotRecognizeSelector:aSelector];
//}

- (UIViewController *)getCurrentVisibleViewController{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController){
        
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]]){
            vc = [(UINavigationController *)vc visibleViewController];
        }else if ([vc isKindOfClass:[UITabBarController class]]){
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        for (UINavigationController *navVc in vc.childViewControllers) {
            if (navVc.topViewController.isViewLoaded && navVc.topViewController.view.window) {
                vc = navVc.topViewController;
            }
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        vc = [(UINavigationController *)vc visibleViewController];
    }else{
        
    }
    return vc;
}

/**
 获取当前view的控制器
 */
- (UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView{
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setAssociateCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setAssociateStrongValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}



@end
