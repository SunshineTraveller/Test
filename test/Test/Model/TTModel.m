//
//  TTModel.m
//  test
//
//  Created by CBCT_MBP on 2019/12/25.
//  Copyright © 2019 zgcx. All rights reserved.
//



#import "TTModel.h"

@implementation TTModel

+(instancetype)modelWithTitle:(NSString *)title
                         type:(TTType)type {
    TTModel *model = [[TTModel alloc] init];
    model.title    = title;
    model.type     = type;
    return model;
}

@end
