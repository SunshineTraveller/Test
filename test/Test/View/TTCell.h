//
//  TTCell.h
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TTModel.h"

@interface TTCell : UITableViewCell

@property(nonatomic,strong) TTModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

