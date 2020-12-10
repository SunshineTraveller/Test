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


#import "RedView.h"
#import "BlueView.h"
#import "GreenView.h"

#import "Clock.h"

#import <SDWebImage/SDWebImageDownloader.h>

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
    self.view.backgroundColor = kWhiteColor;
    
    [self addClock];
}

-(void)addClock {
    Clock *clock = [Clock clockView:CGRectMake(375/2-100, 100, 200, 200)];
    [self.view addSubview:clock];
    
    CGFloat hour = 19;
    CGFloat min  = 40;
    CGFloat sec  = 30;
    
    [clock.board setHour:hour minute:min second:sec];

    [clock.board start];
}

-(void)drawLine {
    
    // drawLine 1
//    UIBezierPath *line1 = [UIBezierPath bezierPath];
//    CGPoint starter1 = CGPointMake(50, 50);
//    CGPoint ender1 = CGPointMake(300,50);
//    CGPoint p1 = CGPointMake(300, 100);
//    CGPoint p2 = CGPointMake(50, 100);
//
////    line1.lineJoinStyle = kCGLineJoinMiter;
//    line1.lineCapStyle = kCGLineCapButt;
//    line1.lineWidth = 10.f;
//    [line1 moveToPoint:starter1];
//    [line1 addLineToPoint:ender1];
//    [line1 addLineToPoint:p1];
//    [line1 addLineToPoint:p2];
//    [line1 addLineToPoint:starter1];
//
//    CAShapeLayer *layer1 = [CAShapeLayer layer];
//    layer1.strokeColor = kBlueColor.CGColor;
//    layer1.fillColor   = kClearColor.CGColor;
//    layer1.path = line1.CGPath;
//
//    [self.view.layer addSublayer:layer1];
    

}


-(void)atest {
    
    UIButton *btn;
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    [self.view addSubview:imv];
    
    __block UIImage *image1;
    __block UIImage *image2;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSLog(@"开始 -- ");
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1907928680,2774802011&fm=26&gp=0.jpg"];
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//            image1 = [UIImage imageWithData:data];
//            NSLog(@" 加载图片1完毕 -- ");
//        }];
//        NSLog(@" 开始加载图片1 -- ");
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1412439743,1735171648&fm=26&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
        NSLog(@" 加载图片2完毕 -- ");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" 合并图片 -- ");

        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        [image1 drawInRect:CGRectMake(0, 0, 200, 100)];
        [image2 drawInRect:CGRectMake(0, 100, 200, 100)];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            imv.image = img;
            NSLog(@" 合并完成 渲染UI -- ");
        }];
        
    }];
    
    [operation2 addDependency:operation1];
    [op3 addDependency:operation1];
    [op3 addDependency:operation2];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:op3];
    
}

@end
