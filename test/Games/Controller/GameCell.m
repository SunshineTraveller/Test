//
//  GameCell.m
//  test
//
//  Created by CBCT_MBP on 2019/12/26.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *identifier = [[self class] identifier];
    GameCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
@end
