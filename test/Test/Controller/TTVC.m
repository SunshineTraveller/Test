//
//  TTVC.m
//  test
//
//  Created by CBCT_MBP on 2018/11/22.
//  Copyright © 2018年 zgcx. All rights reserved.
//


#import "TTVC.h"
#import "TTCell.h"


#import "BWController.h"
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
    NSArray *titles = @[@"小游戏",@"PDF阅读器"];
    NSArray *types  = @[@(TTTypeGame),@(TTTypePDFReader)];
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
        BWController *vc = [[BWController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
