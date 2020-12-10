//
//  RedView.m
//  test
//
//  Created by CBCT_MBP on 2020/9/24.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kRedColor;
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"RedView hitTest");
    return [super hitTest:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"RedView touchesBegin");
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"RedView  pointInside %d",[super pointInside:point withEvent:event]);
    return [super pointInside:point withEvent:event];
}

@end
