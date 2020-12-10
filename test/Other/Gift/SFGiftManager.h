//
//  SFGiftManager.h
//  test
//
//  Created by CBCT_MBP on 2020/10/28.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SFGiftModel;

@interface SFGiftManager : NSObject

+(instancetype)managerWithSourceView:(UIView *)view;

-(void)showGiftWithModel:(SFGiftModel *)model;

@end

NS_ASSUME_NONNULL_END
