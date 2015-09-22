//
//  NSString+UrlEncode.h
//  HttpHelper
//
//  Created by Roger on 2014/10/16.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlEncode)
- (NSString *)urlEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)urlDecode;
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;
@end
