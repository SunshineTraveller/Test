//
//  Cycler.m
//  test
//
//  Created by CBCT_MBP on 2020/2/26.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "Cycler.h"


@implementation Cycler

-(void)print {
    NSLog(@"Cycler Print.--- %@",self.obj);
}
-(void)dealloc {
    NSLog(@"%@ Cycler dealloc",self);
}

-(void)aFakeMethod {
    NSLog(@"%@ I'm a fake method ",self);
}




@end
