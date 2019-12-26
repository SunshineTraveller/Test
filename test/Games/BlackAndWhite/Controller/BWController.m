//
//  BWController.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import "BWController.h"

#import "BWScrollView.h"

@interface BWController ()
@property(nonatomic,strong) UIButton     *guide;
@property(nonatomic,strong) BWScrollView *contentView;
@end

@implementation BWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"黑白块";
    _contentView = [[BWScrollView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _guide = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_guide];
    
}




@end
