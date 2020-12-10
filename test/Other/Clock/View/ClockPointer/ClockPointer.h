//
//  ClockPointer.h
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//
//  表针

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ClockPointerType) {
    ClockPointerTypeHour,
    ClockPointerTypeMin,
    ClockPointerTypeSec,
};

NS_ASSUME_NONNULL_BEGIN

@interface ClockPointer : CAShapeLayer

// path
@property(nonatomic,strong) UIBezierPath *bezierPath;

/*
 指针的长度 颜色
 */
+(instancetype)pointerWithType:(ClockPointerType)pointerType;

-(CGFloat)length;

@end

NS_ASSUME_NONNULL_END
