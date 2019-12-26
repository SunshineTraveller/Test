//
//  UIImage+Extension.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "UIImage+Extension.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (Extension)

- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius
{
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // 绘制图片
    [original drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 拉伸图片
+ (UIImage *)resizedImageWithName:(NSString *)name{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //1.宽高 1个点宽高
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //2.在这个范围内开启一段上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //3.在这段上下文中获取到颜色UIColor
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //4.用这个颜色填充这个上下文
    CGContextFillRect(context, rect);
    //5.从这段上下文中获取Image属性
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

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
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType{
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    
    switch (gradientType) {
            case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
            case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - 压缩图片
- (CGFloat)getImageDataSize{
    //1.获取imagedata
    NSData * imageData = UIImageJPEGRepresentation(self,1);
    //2.返回数据大小，单位：M
    NSString *length = [NSString stringWithFormat:@"%lu",(unsigned long)[imageData length]];
    return length.floatValue/1000000;
}

- (NSData *)imageDataCompressedToSize:(CGFloat)size{
    UIImage *image = [self imageWithImage:self scaledToSize:CGSizeMake(self.size.width, self.size.height)];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    while (data.length / 1024.0 > size) {
        CGFloat ratio = (CGFloat)data.length/1000.0<=size?1:size/((CGFloat)data.length/1000.0);
        ratio = sqrt(ratio);
        image = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width * ratio, image.size.height * ratio)];
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    return data;
}

/** 拉伸后的图片 */
+(UIImage *)resizabledImg:(NSString *)imgName {
    UIImage *image;
    return image;
}

//对图片尺寸进行压缩
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - 边框图片
+ (UIImage *)imageWithImageName:(NSString *)imageName imageWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize size = CGSizeMake(imageWidth + 2 * borderWidth, imageHeight + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWidth, imageHeight)];
    [path addClip];
    [image drawInRect:CGRectMake(borderWidth, borderWidth, imageWidth + borderWidth, imageHeight + borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *_Nonnull)imageWithWidth:(CGFloat)imageWidth imageHeight:(CGFloat)imageHeight borderWidth:(CGFloat)borderWidth borderColor:(UIColor * _Nonnull)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner{
    UIImage *newImage = nil;
    if (isHaveRoundCorner) {
        CGSize size = CGSizeMake(imageWidth + 2 * borderWidth, imageHeight + 2 * borderWidth);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [borderColor set];
        [path fill];
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth, borderWidth, imageWidth, imageHeight) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [path addClip];
        [self drawInRect:CGRectMake(borderWidth, borderWidth, imageWidth + borderWidth, imageHeight + borderWidth)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
        CGSize size = CGSizeMake(imageWidth + 2 * borderWidth, imageHeight + 2 * borderWidth);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
        [borderColor set];
        [bezierPath fill];
        bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderWidth, borderWidth, imageWidth, imageHeight)];
        [bezierPath addClip];
        [self drawInRect:CGRectMake(borderWidth, borderWidth, imageWidth + borderWidth, imageHeight + borderWidth)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newImage;
    
}

+ (instancetype)imageWithRoundCornerImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner{
    
    //1.加载原图片
    UIImage *oldImage = [UIImage imageNamed:name];
    return [self imageWithRoundCornerImageWithImage:oldImage borderWidth:borderWidth borderColor:borderColor cornerRadius:cornerRadius isHaveRoundCorner:isHaveRoundCorner];
    
}

+ (instancetype)imageWithRoundCornerImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius isHaveRoundCorner:(BOOL)isHaveRoundCorner{
    
    //1.开启位图上下文
    CGFloat imageW = image.size.width / 10;
    CGFloat imageH = image.size.height / 10;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    //2.获得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (isHaveRoundCorner) {//存在圆角
        //3.画边框
        [borderColor set];
        CGFloat bigRadius = cornerRadius;
        CGContextMoveToPoint(ctx, 0, bigRadius);
        //左上角
        CGContextAddArc(ctx, bigRadius, bigRadius, bigRadius, M_PI, 1.5 * M_PI, 0);
        CGContextAddLineToPoint(ctx, imageW - bigRadius, 0);
        //右上角
        CGContextAddArc(ctx, imageW - bigRadius, bigRadius, bigRadius, - 0.5 * M_PI, 0, 0);
        CGContextAddLineToPoint(ctx, imageW, imageH - bigRadius);
        //右下角
        CGContextAddArc(ctx, imageW - bigRadius, imageH - bigRadius, bigRadius, 0, M_PI_2, 0);
        CGContextAddLineToPoint(ctx, bigRadius, imageH);
        //左下角
        CGContextAddArc(ctx, bigRadius, imageH - bigRadius, bigRadius, M_PI_2, M_PI, 0);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        //4.画小边框
        CGFloat smallRadius = bigRadius - borderWidth;
        CGContextMoveToPoint(ctx, borderWidth, bigRadius);
        //左上角
        CGContextAddArc(ctx, bigRadius, bigRadius, smallRadius, M_PI, 1.5 * M_PI, 0);
        CGContextAddLineToPoint(ctx, imageW - bigRadius, borderWidth);
        //右上角
        CGContextAddArc(ctx, imageW - bigRadius, bigRadius, smallRadius, - 0.5 * M_PI, 0, 0);
        CGContextAddLineToPoint(ctx, imageW - borderWidth, imageH - bigRadius);
        //右下角
        CGContextAddArc(ctx, imageW - bigRadius, imageH - bigRadius, smallRadius, 0, M_PI_2, 0);
        CGContextAddLineToPoint(ctx, bigRadius, imageH - borderWidth);
        //左下角
        CGContextAddArc(ctx, bigRadius, imageH - bigRadius, smallRadius, M_PI_2, M_PI, 0);
        CGContextClosePath(ctx);
        
        //5.裁剪
        CGContextClip(ctx);
        //6.画图
        [image drawInRect:CGRectMake(borderWidth,borderWidth, imageW - borderWidth, imageH - borderWidth)];
    }else{//不存在圆角
        //3.设置贝塞尔曲线的颜色和线宽
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        //4.画贝塞尔曲线（矩形）
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageW, imageH)];
        
        CGContextAddPath(ctx, bezierPath.CGPath);
        CGContextStrokePath(ctx);
        //5.画图
        [image drawInRect:CGRectMake(borderWidth/2,borderWidth/2, imageW - borderWidth, imageH - borderWidth)];
    }
    //7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //8.关闭位图
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

///////////////////////////////////////////////////////////////////////////

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)alwaysOriginal {
    UIImage *img = [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return img;
}

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name {
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    return [self GIFName:name scale:scale];
}

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    if (!imagePath) {
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    if (imagePath) {
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage imageWithGIFData:imageData];
    } else {
        imagePath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        if (imagePath) {
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage imageWithGIFData:imageData];
        } else {
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}
/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data{
    if (!data) return nil;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            // 拿出了Gif的每一帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            //Learning... 设置动画时长 算出每一帧显示的时长(帧时长)
            NSTimeInterval frameDuration = [UIImage sd_frameDurationAtIndex:i source:source];
            duration += frameDuration;
            // 将每帧图片添加到数组中
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            // 释放真图片对象
            CFRelease(image);
        }
        // 设置动画时长
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    // 释放源Gif图片
    CFRelease(source);
    return animatedImage;
}
#pragma mark - <关于GIF图片帧时长(Learning...)>

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See and
    // for more information.
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
