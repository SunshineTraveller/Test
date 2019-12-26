//
//  ReaderViewController.m
//  test
//
//  Created by CBCT_MBP on 2019/9/29.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "ReaderViewController.h"
#import "PDFReaderController.h"

@interface ReaderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *data;
@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PDFReaderController *reader = [[PDFReaderController alloc] init];
    reader.title = _data[indexPath.row];
    [self.navigationController pushViewController:reader animated:YES];
}
-(NSArray *)data {
    if (!_data) {
        _data = @[@"计算机网络",@"计算机科学概论"];
    }
    return _data;
}

-(BOOL)shouldAutorotate {
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
