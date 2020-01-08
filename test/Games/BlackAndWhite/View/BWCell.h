//
//  BWItm.h
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWModel;
NS_ASSUME_NONNULL_BEGIN

@interface BWCell : UITableViewCell

@property(nonatomic,copy) void(^itemTapHandler)(BOOL success);    // 点击黑白块回调，success = NO 时 game over ...
@property(nonatomic,strong) BWModel *model;

+(instancetype)cellWithTableView:(UITableView *)table;

@end

NS_ASSUME_NONNULL_END
