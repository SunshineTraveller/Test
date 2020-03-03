//
//  BWGameView.m
//  test
//
//  Created by CBCT_MBP on 2020/1/20.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "BWGameView.h"
#import "BWGameCell.h"


@interface BWGameView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray   *models;

@end

@implementation BWGameView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBlueColor;
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cubicBtnAction:)];
    [self.collectionView addGestureRecognizer:tap];
}

-(void)cubicBtnAction:(UITapGestureRecognizer *)tap {
    CGPoint clickPoint = [tap locationInView:self];
    for (BWGameCell *cell in [self.collectionView subviews]) {
        if ([cell.cubicBtn.layer.presentationLayer hitTest:clickPoint]) {
            [cell.cubicBtn setSelected:!cell.cubicBtn.selected];
        }
    }
}

/* 刷新数据 */
-(void)reloadWithModels:(NSArray <BWModel *>*)models {
    if(!models.count) return;
    [self.models removeAllObjects];
    [self.models addObjectsFromArray:models];
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BWGameCell *cell = [BWGameCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.model = [self.models objectAtIndex:indexPath.item];
    WeakSelfDefault
    cell.cubicClickHandler = ^(BOOL success) {
        StrongSelfDefault
        if (self.cubicClickHandler) {
            self.cubicClickHandler(success);
        }
    };
    return cell;
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenW-5)/4, kScreenH/4);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = kClearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 1, 0, 1);
        _collectionView.scrollEnabled = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _collectionView;
}
-(NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
