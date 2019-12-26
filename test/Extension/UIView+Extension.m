//
//  UIView+Extension.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setTop:(CGFloat)t {
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left,b-self.height,self.width,self.height);
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l,self.top,self.width,self.height);
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r-self.width,self.top,self.width,self.height);
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setWidth:(CGFloat)w {
    self.frame = CGRectMake(self.left, self.top, w, self.height);
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)h {
    self.frame = CGRectMake(self.left, self.top, self.width, h);
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)centerx {
    return self.left +self.width/2;
}
- (CGFloat)centery {
    return self.top + self.height/2;
}
- (void)setCenterx:(CGFloat)centerx
{
    self.frame = CGRectMake(centerx-self.width/2, self.top, self.width, self.height);
}
- (void)setCentery:(CGFloat)centery
{
    self.frame = CGRectMake(self.left, centery-self.height/2, self.width, self.height);
}

#pragma mark --- set method
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

#pragma mark --- get method

- (CGSize)size {
    return self.frame.size;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void) moveBy: (CGPoint) delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

#pragma mark 设置阴影
- (void)shadowWithColor:(UIColor *_Nonnull)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
}

- (void)shadowWithColor:(UIColor *_Nonnull)color offset:(CGSize)offset opacity:(CGFloat)opacity cornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.cornerRadius = cornerRadius;
}


/**
 移除所有子视图的方法
 
 @param superView 需要移除子视图的父视图
 */
+ (void)removeAllSubViewsWithSuperView:(UIView *)superView {
    
    if (superView && [superView isKindOfClass:[UIView class]]) {
        
        for (UIView *tempView in superView.subviews) {
            
            [tempView removeFromSuperview];
        }
    }
}


/**
 移除所有子视图,并且置为空 的方法
 
 @param superView 需要移除子视图的父视图
 */
+ (void)removeAllSubViewsAndSetNilWithSuperView:(UIView *)superView {
    
    if (superView && [superView isKindOfClass:[UIView class]]) {
        for(int a = 0; a < superView.subviews.count; a ++) {
            UIView *tempView = superView.subviews[a];
            [tempView removeFromSuperview];
            tempView = nil;
        }
    }
}

-(void)setCorner:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}

/**
 设置圆角阴影
 */
-(void)setShadowCorner:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.shadowOffset = CGSizeMake(1, 1);
//    self.layer.shadowColor = SFhexColor(@"e3e3e3").CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 0.25;
}

/** 设置圆角 */
-(void)setCorner:(CGFloat)radius size:(CGSize)size {
//    self.layer.cornerRadius = cornerRadius;
//    self.clipsToBounds = YES;
//    [self setCornerRadius:cornerRadius byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(cxt, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(cxt, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角大小
 *  @param corners      圆角属性
 */
-(void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/** 圆角 */
-(void)layoutCornerRadius:(CGFloat)radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.masksToBounds = YES;
    self.layer.mask = maskLayer;
}

/** 添加高斯模糊 */
-(void)addBlurWithFrame:(CGRect)bounds {
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
//    toolBar.barStyle = UIBarStyleBlack;
//    toolBar.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25f];
//    [self addSubview:toolBar];
    
    UIBlurEffect *blueEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blueEffect];
    visualView.alpha = 0.25;
    visualView.frame = bounds;
    [self insertSubview:visualView atIndex:0];
}

/** 添加白色高斯模糊 */
-(void)addWhiteBlurWithFrame:(CGRect)bounds alpha:(CGFloat)alpha  {
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
//    toolBar.barStyle = UIBarStyleDefault;
//    toolBar.backgroundColor = kWhiteColor;
//    toolBar.alpha = alpha;
//    [self insertSubview:toolBar atIndex:0];

    UIBlurEffect *blueEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blueEffect];
    visualView.alpha = alpha;
    visualView.frame = bounds;
    [self insertSubview:visualView atIndex:0];
    
}

/** 添加指定颜色高斯模糊 */
-(void)addWhiteBlurWithFrame:(CGRect)bounds {
    [self addWhiteBlurWithFrame:bounds alpha:0.25];
}

/**
 添加竖直方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(void)addVerticalGradientColors:(NSArray *)colors
                           frame:(CGRect)frame {
    CAGradientLayer *layer = [self getVerticalGradientColors:colors frame:frame];
    [self.layer addSublayer:layer];
}

/**
 添加水平方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(void)addHorizontalGradientColors:(NSArray *)colors
                             frame:(CGRect)frame {
    CAGradientLayer *layer = [self getHorizontalGradientColors:colors frame:frame];
    [self.layer insertSublayer:layer atIndex:0];
}

/**
 获取竖直方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(CAGradientLayer *)getVerticalGradientColors:(NSArray *)colors
                                frame:(CGRect)frame {
    CAGradientLayer *layer = [CAGradientLayer layer];
    NSMutableArray *arr = @[].mutableCopy;
    for (UIColor *col in colors) {
        [arr addObject:(__bridge id)col.CGColor];
    }
    layer.colors = arr;
    layer.frame = frame;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    return layer;
}

/**
 添加水平方向渐变色
 
 @param colors 颜色组
 @param frame 渐变层frame
 */
-(CAGradientLayer *)getHorizontalGradientColors:(NSArray *)colors
                                  frame:(CGRect)frame {
    CAGradientLayer *layer = [CAGradientLayer layer];
    NSMutableArray *arr = @[].mutableCopy;
    for (UIColor *col in colors) {
        [arr addObject:(__bridge id)col.CGColor];
    }
    layer.colors = arr;
    layer.frame = frame;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    return layer;
}

@end
