//
//  BWItm.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWCell.h"
#import "BWModel.h"
#import "BWConfig.h"

@interface BWCell ()

@property(nonatomic,strong) UIButton *leftItem;        // 左侧块
@property(nonatomic,strong) UIButton *rightItem;       // 右侧块

@end

@implementation BWCell

+(instancetype)cellWithTableView:(UITableView *)table {
    NSString *cellIdentifier = NSStringFromClass([self class]);
    id cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kClearColor;
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews {
    [self addSubview:self.leftItem];
    [self addSubview:self.rightItem];
    
    [self.leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset([BWConfig itemMargin]);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([BWConfig itemWid]);
        make.height.mas_equalTo([BWConfig itemH]);
    }];
    [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-[BWConfig itemMargin]);
        make.width.height.top.equalTo(_leftItem);
    }];
}
-(void)setModel:(BWModel *)model {
    _model = model;
    self.leftItem.selected  = !_model.leftColorWhite;
    self.rightItem.selected = _model.leftColorWhite;
}

/* 踩黑白块儿 */
-(void)itemClickAction:(UIButton *)btn {
    BOOL success = [btn isEqual:_leftItem] ? !_model.leftColorWhite : _model.leftColorWhite;
    if (self.itemTapHandler) {
        self.itemTapHandler(success);
    }
    if (btn.selected) {
        [btn setSelected:NO];
    }
}

-(UIButton *)leftItem {
    if (!_leftItem) {
        _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftItem addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftItem setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forState:UIControlStateNormal];
        [_leftItem setBackgroundImage:[UIImage imageWithColor:kBlackColor] forState:UIControlStateSelected];
    }
    return _leftItem;
}
-(UIButton *)rightItem {
    if (!_rightItem) {
        _rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightItem addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightItem setBackgroundImage:[UIImage imageWithColor:kWhiteColor] forState:UIControlStateNormal];
        [_rightItem setBackgroundImage:[UIImage imageWithColor:kBlackColor] forState:UIControlStateSelected];
    }
    return _rightItem;
}
@end
