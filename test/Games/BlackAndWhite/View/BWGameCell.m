//
//  BWGameCell.m
//  test
//
//  Created by CBCT_MBP on 2020/1/20.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "BWGameCell.h"
#import "BWModel.h"

@interface BWGameCell ()

@end

@implementation BWGameCell

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews {
    [self.contentView addSubview:self.cubicBtn];
    [self.cubicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)setModel:(BWModel *)model {
    _model = model;
    _cubicBtn.selected = model.isSelected;
}
-(void)cubicBtnAction:(UIGestureRecognizer *)tap {
    /*
     黑--选中状态  |  白--非选中状态
     踩到黑块儿，将黑变白
     踩到白块儿，游戏结束
     */
    
    
}

-(UIButton *)cubicBtn {
    if (!_cubicBtn) {
        _cubicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_cubicBtn addTarget:self action:@selector(cubicBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cubicBtn setBackgroundImage:[UIImage imageWithColor:UIColor.whiteColor] forState:UIControlStateNormal];
        [_cubicBtn setBackgroundImage:[UIImage imageWithColor:UIColor.blackColor] forState:UIControlStateSelected];
    }
    return _cubicBtn;
}
@end
