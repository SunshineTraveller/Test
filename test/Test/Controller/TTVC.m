//
//  TTVC.m
//  test
//
//  Created by CBCT_MBP on 2018/11/22.
//  Copyright © 2018年 zgcx. All rights reserved.
//


#import "TTVC.h"
#import "TTCell.h"

#import "OtherViewController.h"
#import "GameController.h"
#import "ReaderViewController.h"

#import <WebKit/WebKit.h>

@interface TTVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *data;
@end

@implementation TTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self setupData];
}

-(void)setupData {
    _data = @[].mutableCopy;
    NSArray *titles = @[@"小游戏",@"PDF阅读器",@"其他"];
    NSArray *types  = @[@(TTTypeGame),@(TTTypePDFReader),@(TTTypeOther)];
    [titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTModel *model = [TTModel modelWithTitle:titles[idx] type:[types[idx] integerValue]];
        [_data addObject:model];
    }];
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCell *cell = [TTCell cellWithTableView:tableView];
    cell.model = [_data objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTModel *model = [_data objectAtIndex:indexPath.row];
    // 游戏相关
    if (model.type == TTTypeGame) {
        GameController *gameVC = [[GameController alloc] init];
        [self.navigationController pushViewController:gameVC animated:YES];
    }else if(model.type == TTTypePDFReader){
        ReaderViewController *read = [[ReaderViewController alloc] init];
        [self.navigationController pushViewController:read animated:YES];
    }else if (model.type == TTTypeOther) {
        OtherViewController *other = [[OtherViewController alloc] init];
        [self.navigationController pushViewController:other animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

@end

