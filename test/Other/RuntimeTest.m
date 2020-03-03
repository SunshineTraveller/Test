//
//  RuntimeTest.m
//  test
//
//  Created by CBCT_MBP on 2020/3/3.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "RuntimeTest.h"

#import "Cycler.h"

@implementation RuntimeTest

@synthesize p2;
@synthesize p3 = _p3;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"_p1=%@ ，  p2=%@  ， _p2=%@,  _p3=%@", _p1,p2,_p2,_p3];
}
+(BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"aFakeMethod"]) {
        return NO;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}
-(id)forwardingTargetForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"aFakeMethod"]) {
        return nil;
//        return [Cycler new];
    }else {
        return [super forwardingTargetForSelector:aSelector];
    }
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"aFakeMethod"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}
-(void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    Cycler *qqq = [Cycler new];
    if ([qqq respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:qqq];
    }else {
        [self doesNotRecognizeSelector:sel];
    }
}
-(void)aTrueMethod {
    NSLog(@"\nI am a true method\n");
}
@end
