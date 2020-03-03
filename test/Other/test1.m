//
//  test1.m
//  test
//
//  Created by CBCT_MBP on 2020/2/26.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "test1.h"
#import <objc/runtime.h>

@implementation test1

-(void)print {
    NSLog(@"test1 print -- %@",self.obj);
}
-(void)dealloc {
    NSLog(@"test1 dealloc");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    Method aMethod = class_getInstanceMethod(self, @selector(handleFakeMethod));
    BOOL add = class_addMethod(self, sel, method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
    return YES;
}

+(BOOL)resolveClassMethod:(SEL)sel {
    Method tmpMethod = class_getClassMethod(self, @selector(handleFakeMethod));
    class_addMethod(self, sel, method_getImplementation(tmpMethod), method_getTypeEncoding(tmpMethod));
    return YES;
}

-(void)handleFakeMethod {
    NSLog(@"通过resolveInstanceMethod 转发消息 handleFakeMethod");
}
    

@end
