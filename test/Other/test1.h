//
//  test1.h
//  test
//
//  Created by CBCT_MBP on 2020/2/26.
//  Copyright © 2020 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Cycler.h"

NS_ASSUME_NONNULL_BEGIN

@interface test1 : NSObject
@property(nonatomic,weak) id obj;
-(void)print;
-(void)fakeMethod1;
-(void)fakeMethod2;
-(void)fakeMethod3;
-(NSInteger)getTag;
-(float)getSelf;
+(void)classMethod;
@end

NS_ASSUME_NONNULL_END
