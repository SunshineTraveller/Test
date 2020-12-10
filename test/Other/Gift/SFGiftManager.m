//
//  SFGiftManager.m
//  test
//
//  Created by CBCT_MBP on 2020/10/28.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import "SFGiftManager.h"

#import "SFGiftContainer.h"
#import "SFGiftOperation.h"

@interface SFGiftManager ()

// sourceView
@property(nonatomic,weak) UIView *sourceView;
// container
@property(nonatomic,strong) SFGiftContainer *giftContainer;
// operationQueue
@property(nonatomic,strong) NSOperationQueue *queue;


@end

@implementation SFGiftManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

-(void)setupConfig {
    [self setupQueue];
    [self addGiftContainer];
}

-(void)setupQueue {
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = 1;
}
-(void)addGiftContainer {
    _giftContainer = [[SFGiftContainer alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.sourceView addSubview:_giftContainer];
}

#pragma mark ****************  public  ****************
+(instancetype)managerWithSourceView:(UIView *)view {
    return [[self alloc] managerWithSourceView:view];
}
-(instancetype)managerWithSourceView:(UIView *)view {
    if(!view) return nil;
    SFGiftManager *instance = [[SFGiftManager alloc] init];
    instance.sourceView = view;
    return instance;
}

-(void)showGiftWithModel:(SFGiftModel *)model {
    
    SFGiftOperation *operation = [SFGiftOperation blockOperationWithBlock:^{
        
    }];
    [_queue addOperation:operation];
}

@end
