//
//  GameController.m
//  test
//
//  Created by CBCT_MBP on 2019/12/26.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "GameController.h"

#import "GameModel.h"
#import "GameCell.h"

@interface GameController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *data;

@end

@implementation GameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    NSArray *titles = @[@"黑白块",@"乒乓球"];
    [titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GameModel *model = [[GameModel alloc] init];
        model.title = [titles objectAtIndex:idx];
        [_data addObject:model];
    }];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameCell*cell = [GameCell cellWithTableView:tableView];
    GameModel *model = _data[indexPath.row];
    cell.detailTextLabel.text = model.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    }else {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
