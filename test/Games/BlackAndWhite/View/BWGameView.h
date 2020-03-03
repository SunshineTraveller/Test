//
//  BWGameView.h
//  test
//
//  Created by CBCT_MBP on 2020/1/20.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWModel;
NS_ASSUME_NONNULL_BEGIN

@interface BWGameView : UIView

@property(nonatomic,copy) void (^cubicClickHandler)(BOOL success);

/* 刷新数据 */
-(void)reloadWithModels:(NSArray <BWModel *>*)models;

@end

NS_ASSUME_NONNULL_END
