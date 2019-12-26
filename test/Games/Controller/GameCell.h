//
//  GameCell.h
//  test
//
//  Created by CBCT_MBP on 2019/12/26.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameCell : UITableViewCell
@property(nonatomic,strong) UILabel *title;          
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
