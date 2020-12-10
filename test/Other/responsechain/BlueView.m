//
//  BlueView.m
//  test
//
//  Created by CBCT_MBP on 2020/9/24.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kBlueColor;
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"BlueView hitTest");
    return [super hitTest:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"BlueView touchesBegin");
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"BlueView  pointInside %d",[super pointInside:point withEvent:event]);
    return [super pointInside:point withEvent:event];
}
@end
