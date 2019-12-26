//
//  UIView+Extension.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (nonatomic,assign)CGFloat top;
@property (nonatomic,assign)CGFloat bottom;
@property (nonatomic,assign)CGFloat left;
@property (nonatomic,assign)CGFloat right;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat centerx;
@property (nonatomic,assign)CGFloat centery;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


/**
 移动

 @param delta 移动的位置
 */
- (void) moveBy: (CGPoint) delta;

/**
 设置view阴影
 
 @param color 颜色
 @param offset 偏移size
 @param opacity 不透明度
 */
- (void)shadowWithColor:(UIColor *_Nonnull)color offset:(CGSize)offset opacity:(CGFloat)opacity;

/**
 设置圆角view阴影
 
 @param color 颜色
 @param offset 偏移size
 @param opacity 不透明度
 @param cornerRadius 圆角大小
 */
- (void)shadowWithColor:(UIColor *_Nonnull)color offset:(CGSize)offset opacity:(CGFloat)opacity cornerRadius:(CGFloat)cornerRadius;

- (UIView *)whiteToBlackView;

/**
 移除某个父视图上所有的子视图
 
 @param superView 需要移除子视图的视图对象
 */
+ (void)removeAllSubViewsWithSuperView:(UIView *)superView;


/**
 移除所有子视图,并且置为空 的方法
 
 @param superView 需要移除子视图的父视图
 */
+ (void)removeAllSubViewsAndSetNilWithSuperView:(UIView *)superView;

/**
 设置圆角
 */
-(void)setCorner:(CGFloat)radius;

/**
 设置圆角阴影
 */
-(void)setShadowCorner:(CGFloat)radius;

/**
 设置圆角
 */
-(void)setCorner:(CGFloat)radius size:(CGSize)size;

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角大小
 *  @param corners      圆角属性
 */
-(void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners;

/** 圆角 */
-(void)layoutCornerRadius:(CGFloat)radius;

/** 添加白色高斯模糊 */
-(void)addWhiteBlurWithFrame:(CGRect)bounds alpha:(CGFloat)alpha;

/** 添加黑色高斯模糊 */
-(void)addBlurWithFrame:(CGRect)bounds;

/** 添加指定颜色高斯模糊 */
-(void)addWhiteBlurWithFrame:(CGRect)bounds;


/**
 添加竖直方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(void)addVerticalGradientColors:(NSArray *)colors
                           frame:(CGRect)frame;

/**
 添加水平方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(void)addHorizontalGradientColors:(NSArray *)colors
                             frame:(CGRect)frame;

/**
 获取竖直方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(CAGradientLayer *)getVerticalGradientColors:(NSArray *)colors
                                frame:(CGRect)frame;

/**
 添加水平方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(CAGradientLayer *)getHorizontalGradientColors:(NSArray *)colors
                             frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
