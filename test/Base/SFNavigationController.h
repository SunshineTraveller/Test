//
//  SFNavigationController.h
//  SeeFM
//
//  Created by CBCT_MBP on 2018/9/27.
//  Copyright © 2018年 CBCT_MBP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFNavigationController : UINavigationController
//是否显示导航栏分割线,默认YES
@property (nonatomic ,assign) BOOL isHiddenNavLine;
//是否充许滑动返回（pop)
@property (nonatomic) BOOL enableSwipeReturn;
@end

NS_ASSUME_NONNULL_END
