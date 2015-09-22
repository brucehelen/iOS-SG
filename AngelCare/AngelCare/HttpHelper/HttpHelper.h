//
//  HttpHelper.h
//  HttpHelper
//
//  Created by Roger on 2014/10/15.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <CommonCrypto/CommonDigest.h>


@interface HttpHelper : NSObject

+ (BOOL)NetWorkIsOK;//检查网络是否可用
+ (void)post:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装
+ (void)post:(NSString *)URL RequestBody:(NSString *)httpBodyStr FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;
+ (NSString*) dictToJSONString:(NSDictionary*)dict;
+ (NSString *)getSha256Encode:(NSString *)str andTimeStamp:(NSString*) TimeStamp;
+ (NSString*) getGKey;
+ (NSString*) getTimeStamp;

//return httpbody
//input: data (AppDataJson)
+ (NSString*) returnHttpBody:(NSDictionary *)data;

//return api url
//input: api number
+ (NSString*) returnAPIByNumber:(int)Number;
@end
