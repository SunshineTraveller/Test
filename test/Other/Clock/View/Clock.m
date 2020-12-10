//
//  Clock.m
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "Clock.h"


#import "ClockTime.h"
#import "ClockPointer.h"

@interface Clock ()


@end

@implementation Clock

+(instancetype)clockView:(CGRect)frame {
    Clock *clock = [[Clock alloc] initWithFrame:frame];
    return clock;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _board = [ClockBoard boardView:self.bounds];
        [self addSubview:_board];
    }
    return self;
}



@end
