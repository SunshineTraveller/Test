//
//  TTCell.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "TTCell.h"

@interface TTCell ()

@property(nonatomic,strong) UILabel *title;

@end

@implementation TTCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *identifier = [[self class] identifier];
    TTCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.title = [[UILabel alloc] init];
    self.title.textColor = kColor32;
    self.title.font = kFont16;
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

-(void)setModel:(TTModel *)model {
    _model = model;
    self.title.text = model.title;
}

@end
