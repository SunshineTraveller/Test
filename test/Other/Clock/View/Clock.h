//
//  Clock.h
//  test
//
//  Created by CBCT_MBP on 2020/12/8.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClockBoard.h"

NS_ASSUME_NONNULL_BEGIN

@interface Clock : UIView

// board
@property(nonatomic,strong) ClockBoard *board;

+(instancetype)clockView:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
