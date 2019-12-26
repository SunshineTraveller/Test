//
//  UIImage+Extension.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)


#pragma mark - 拉伸图片
/**
 *  返回颜色生成的图片
 */
+ (UIImage *_Nonnull)imageWithColor:(UIColor * _Nonnull)color;

/** 圆角图片 */
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius;

/**
 *  返回自由拉伸的图片
 */
+ (UIImage *_Nonnull)resizedImageWithName:(NSString *_Nonnull)name;

/**
 *  返回自由拉伸的图片
 *  @param left 左边
 *  @param top 顶部
 */
+ (UIImage *_Nullable)resizedImageWithName:(NSString *_Nonnull)name left:(CGFloat)left top:(CGFloat)top;

#pragma mark - 颜色渐变图片
/**
 *  获取矩形的渐变色的UIImage
 *
 *  @param bounds       UIImage的bounds
 *  @param colors       渐变色数组，可以设置两种颜色
 *  @param gradientType 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */
+ (UIImage *_Nonnull)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*_Nonnull)colors andGradientType:(int)gradientType;

#pragma mark - 压缩图片
/**
 获取图片的大小，单位：M
 @return 多少M，例如：2M、3M；
 */
- (CGFloat)getImageDataSize;

/**
 将图片压缩至理想的多少KB以内
 @param size 理想大小（单位：KB）
 @return 压缩后的图片数据
 */
- (NSData *_Nonnull)imageDataCompressedToSize:(CGFloat)size;

/** 拉伸后的图片 */
+(UIImage *)resizabledImg:(NSString *)imgName;


#pragma mark - 边框图片
/**
 *  带边框的图片
 *
 *  @param imageName   图片名
 *  @param imageWidth  图片宽度
 *  @param imageHeight 图片高度
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 带边框的图片
 */
+ (UIImage *_Nonnull)imageWithImageName:(NSString *_Nonnull)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor;

/**
 带边框的图片
 
 @param imageWidth 图片宽度
 @param imageHeight 图片高度
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (UIImage *_Nonnull)imageWithWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner;

/**
 圆角边框图片(图片名称)
 
 @param name 源图片名称
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param cornerRadius 圆角角度
 @param isHaveRoundCorner 是否有圆角
 */
+ (instancetype _Nonnull )imageWithRoundCornerImageWithName:(NSString *_Nonnull)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner;

/**
 圆角边框图片(图片)
 
 @param image 源图片
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param cornerRadius 圆角角度
 @param isHaveRoundCorner 是否有圆角
 */
+ (instancetype _Nonnull )imageWithRoundCornerImageWithImage:(UIImage *_Nonnull)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *_Nonnull)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner;


/**
 Rounds a new image with a given corner size.
  */
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

/**
 Rounds a new image with a given corner size.
 */
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

/**
 Rounds a new image with a given corner size.
 */
- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

-(UIImage *)alwaysOriginal;

/** 高斯模糊后的照片 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/** GIF */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;
+ (UIImage *)imageWithGIFData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
