//
//  PPController.m
//  Games
//
//  Created by sunshine on 2019/12/25.
//  Copyright © 2019 Sunshine. All rights reserved.
//

#import "PPController.h"

#import "PPTable.h"

@interface PPController ()
/** table */
@property (nonatomic,strong) PPTable *table;
@end

@implementation PPController

- (void)viewDidLoad {
    [super viewDidLoad];
    _table = [[PPTable alloc] init];
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
