//
//  OtherViewController.m
//  test
//
//  Created by CBCT_MBP on 2020/2/26.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "OtherViewController.h"
#import "Cycler.h"
#import <objc/runtime.h>
#import <objc/message.h>
#include <objc/objc.h>
#import "RuntimeTest.h"


/*
 要测试 objc_msgSend(id obj,SEL op) 方法时， 需要
 1、引入头文件 | #import <objc/runtime.h> |  #import <objc/message.h> |
 2、更改 buildSettings -- Enable Strict Checking of objc_msgSend Calls 这个选项为 NO
 */

@interface OtherViewController ()
@property(nonatomic,strong) Cycler *cycler;
@property(nonatomic,strong) test1 *test;
@property(nonatomic,assign) id  oj;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"其他";
    [self setCler];
    
    // Do any additional setup after loading the view.
}
-(void)setCler {
    
    test1 *test = [[test1 alloc] init];
    Cycler *cycler = [[Cycler alloc] init];
    
    self.cycler = cycler;
    self.test = test;
    
    cycler.obj = test;
    [cycler print];
    
    test.obj = cycler;
    [test print];
    SEL selector = @selector(selfPrint);
    objc_msgSend(self, selector);
    
    RuntimeTest *tttt = [[RuntimeTest alloc] init];
    tttt.p1 = @"p1";
    tttt.p2 = @"p2";
    tttt.p3 = @"p3";
    NSLog(@"%@",tttt);
    
    [tttt aTrueMethod];
    [tttt aFakeMethod];
    
}

-(void)selfPrint {
    NSLog(@"self print");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"self.test.obj -- %@",self.test.obj);
//    NSLog(@"self.cycler.obj -- %@",self.cycler.obj);
    NSLog(@"%@",self.cycler);
//    [self.test fakeMethod3];
//    [self.test getSelf];
//    [self.test getTag];
//    [test1 classMethod];
//    [test1 fakeClassMethod];
}

@end
