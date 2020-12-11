//
//  ClockPointer.m
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "ClockPointer.h"

@interface ClockPointer ()

// type
@property(nonatomic,assign) ClockPointerType pointerType;
// layer
@property(nonatomic,strong) CAShapeLayer     *ptrLayer;

@end

@implementation ClockPointer

/*
 指针的长度 颜色
 */
+(instancetype)pointerWithType:(ClockPointerType)pointerType {
    ClockPointer *pointer   = [ClockPointer layer];
    pointer.pointerType     = pointerType;
    return pointer;
}

-(void)setPointerType:(ClockPointerType)pointerType {
    _pointerType = pointerType;
    [self setupLayer];
}

-(void)setupLayer {
    
    CGFloat length  = [[self getConfig][@"length"] floatValue];
    UIColor *color  = [self getConfig][@"color"];
    CGFloat width   = [[self getConfig][@"width"] floatValue];
    
    _bezierPath     = [UIBezierPath bezierPath];

    CGFloat pointLength = width/(2*0.557);
    
    CGPoint firstPoi = CGPointMake(-width/2, 0);
    CGPoint secondPoi = CGPointMake(width/2, 0);
    CGPoint thirdPoi = CGPointMake(width/2, length - pointLength);
    CGPoint fourthPoi = CGPointMake(0, length);
    CGPoint fifthPoi = CGPointMake(-width/2, length - pointLength);
    
    [_bezierPath moveToPoint:firstPoi];
    [_bezierPath addLineToPoint:secondPoi];
    [_bezierPath addLineToPoint:thirdPoi];
    [_bezierPath addLineToPoint:fourthPoi];
    [_bezierPath addLineToPoint:fifthPoi];
    [_bezierPath addLineToPoint:firstPoi];
    
    self.fillColor = color.CGColor;
    self.lineJoin = kCALineJoinRound;
    self.strokeColor = color.CGColor;
    self.anchorPoint = CGPointMake(0, 0);
    self.lineWidth = 1;
    self.path = _bezierPath.CGPath;
}

-(CGFloat)length {
    return [[self getConfig][@"length"] floatValue];
}

-(NSDictionary *)getConfig {
    switch (_pointerType) {
        case ClockPointerTypeHour:
            return @{
                @"color":SFhexColor(@"ffd700"),
                @"length":@(50),
                @"width":@(5),
            };
            break;
        case ClockPointerTypeMin:
            return @{
                @"color":SFhexColor(@"fad204"),
                @"length":@(75),
                @"width":@(2.5),
            };
            break;
        case ClockPointerTypeSec:
            return @{
                @"color":SFhexColor(@"fbd108"),
                @"length":@(90),
                @"width":@(1),
            };
            break;
        default:
            return @{};
            break;
    }
}

@end
