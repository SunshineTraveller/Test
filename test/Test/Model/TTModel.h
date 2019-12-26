//
//  TTModel.h
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//

typedef NS_ENUM(NSUInteger, TTType) {
    TTTypeGame,         // 跳转游戏
    TTTypePDFReader,    // PDF 阅读
    TTTypeNone,         // 暂无
};

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTModel : NSObject

@property(nonatomic,copy) NSString *title;  // 标题
@property(nonatomic,assign) TTType type;    // 跳转类型

+(instancetype)modelWithTitle:(NSString *)title
                         type:(TTType)type;

@end

NS_ASSUME_NONNULL_END
