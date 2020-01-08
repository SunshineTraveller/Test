//
//  BWScrollView.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWContainer.h"
#import "BWCell.h"
#import "BWModel.h"

@interface BWContainer ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView     *contentView;
@property(nonatomic,assign) CGFloat         speed;           // 滚动速度
@property(nonatomic,strong) BWConfig        *config;         // 配置项

@end

@implementation BWContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

/* 基本配置 */
-(void)setupConfig {
    [self setupDefaultConfig];
    [self addCustomViews];
    [self layoutCustomviews];
}

-(void)setupDefaultConfig {
    _config = [[BWConfig alloc] init];
    _config.level = BWLevelEasy;
}

-(void)setupConfig:(BWConfig *)config {
    if (config == nil) return;
    _config = config;
}

-(void)addCustomViews {
    [self addSubview:self.contentView];
}

-(void)layoutCustomviews {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


#pragma mark ****************  UITableViewDelegate,UITableViewDataSource  ****************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _config.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BWCell *cell   = [BWCell cellWithTableView:tableView];
    BWModel *model = [_config items][indexPath.row];
    cell.model     = model;
    return cell;
}

#pragma mark ****************  public  ****************
-(void)setupSpeed:(CGFloat)speed {
    _speed = speed;
}
-(void)startGame {
    if (_config.items.count > 1) {
        CGFloat sec = [BWConfig screenPerSecond];
        [UIView animateWithDuration:sec animations:^{
            [self.contentView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self->_config.items.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }];
    }
}
-(void)stopGame {
    [self.contentView setContentOffset:CGPointMake(0, _config.items.count-1*kScreenH)];
}


#pragma mark ****************  getter  ****************
-(UITableView *)contentView {
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.rowHeight = [BWConfig itemH];
    }
    return _contentView;
}

@end
