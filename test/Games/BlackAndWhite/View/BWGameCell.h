//
//  BWGameCell.h
//  test
//
//  Created by CBCT_MBP on 2020/1/20.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWModel;
NS_ASSUME_NONNULL_BEGIN

@interface BWGameCell : UICollectionViewCell
@property(nonatomic,strong) UIButton *cubicBtn;          // 方块儿

@property(nonatomic,copy) void (^cubicClickHandler)(BOOL success);
@property(nonatomic,strong) BWModel *model;         

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
