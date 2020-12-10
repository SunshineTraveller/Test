//
//  GreenView.m
//  test
//
//  Created by CBCT_MBP on 2020/9/24.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "GreenView.h"

@implementation GreenView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kGreenColor;
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"GreenView hitTest");
    return [super hitTest:point withEvent:event];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"GreenView touchesBegin");
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"GreenView  pointInside %d",[super pointInside:point withEvent:event]);
    return [super pointInside:point withEvent:event];
}
@end
