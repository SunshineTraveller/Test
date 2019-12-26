//
//  UIColor+Extension.m
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
    return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexColorString:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
    return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithHexNumber:(NSUInteger)hexColor {
    float r = ((hexColor>>16) & 0xFF) / 255.0f;
    float g = ((hexColor>>8) & 0xFF) / 255.0f;
    float b = (hexColor & 0xFF) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [self colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    
    // 转换成标准16进制数  @"#38722c"
    NSString *string =  [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    // 16进制字符串转换成整形
    long colorLong = strtoul([string cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    return [UIColor colorWithRed:((float)((colorLong & 0xFF0000) >> 16))/255.0 green:((float)((colorLong & 0xFF00) >> 8))/255.0 blue:((float)(colorLong & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)random {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.f green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}

@end
