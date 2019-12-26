//
//  NSObject+Extention.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extention)
/**
 获取当前正在显示的控制器
 */
- (UIViewController *)getCurrentVisibleViewController;
/**
 获取当前view的控制器
 */
- (UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView;


#pragma mark - Associate value

/**
 Associate one object to `self`, as if it was a strong property (copy, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)setAssociateCopyValue:(nullable id)value withKey:(void *)key;


/**
 Associate one object to `self`, as if it was a strong property (strong, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)setAssociateStrongValue:(nullable id)value withKey:(void *)key;

/**
 Associate one object to `self`, as if it was a weak property (week, nonatomic).
 
 @param value  The object to associate.
 @param key    The pointer to get value from `self`.
 */
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/**
 Get the associated value from `self`.
 
 @param key The pointer to get value from `self`.
 */
- (nullable id)getAssociatedValueForKey:(void *)key;

/**
 Remove all associated values.
 */
- (void)removeAssociatedValues;

@end

NS_ASSUME_NONNULL_END
