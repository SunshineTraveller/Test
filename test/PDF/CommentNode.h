//
//  CommentNode.h
//  test
//
//  Created by CBCT_MBP on 2019/9/29.
//  Copyright © 2019 zgcx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentNode : NSObject{
    CGPDFObjectType type;
    CGPDFObjectRef object;
    CGPDFDictionaryRef catalog;
    NSString *name;
    NSMutableArray *children;
}


- (id)initWithCatalog:(CGPDFDictionaryRef)value;
- (id)initWithObject:(CGPDFObjectRef)value name:(NSString *)name;

- (NSString *)name;
- (CGPDFObjectType)type;
- (NSString *)typeAsString;
- (CGPDFObjectRef)object;
- (NSString *)value;
- (NSArray *)children;
- (CommentNode *)childrenForName:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
