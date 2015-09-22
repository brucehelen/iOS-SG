//
//  HttpHelper.m
//  HttpHelper
//
//  Created by Roger on 2014/10/15.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#define GKey @"AAAAAAAAZZZZZZZZZZZZ999999999"


#import "HttpHelper.h"
#import "NSString+UrlEncode.h"


@implementation HttpHelper

//这个函数是判断网络是否可用的函数（wifi或者蜂窝数据可用，都返回YES）
+ (BOOL)NetWorkIsOK{
    if(
       ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]
        != NotReachable)
       &&
       ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]
        != NotReachable)
       ){
        return YES;
    }else{
        return NO;
    }
}

//post异步请求封装函数
+ (void)post:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:postData];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    //    return result;
}


+ (void)post:(NSString *)URL RequestBody:(NSString *)httpBodyStr FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30];
    //url 需要 encode
//    NSString *httpEncodeStr = [httpBodyStr urlEncodeUsingEncoding:NSUTF8StringEncoding];
    httpBodyStr = [httpBodyStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSData *httpBody = [httpBodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@?%@",URL,httpBodyStr);
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
}

+(NSString*) dictToJSONString:(NSDictionary*)dict{
    
    NSString *JSONString;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
    
    
}
//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}

+ (NSString*) getGKey{
    return GKey;
}

+ (NSString*) getTimeStamp{
    NSDate* now = [NSDate date];
    return [NSString stringWithFormat:@"%.0f",[now timeIntervalSince1970]];
}
+ (NSString *)getSha256Encode:(NSString *)str andTimeStamp:(NSString*) TimeStamp{
//    NSString *GKey = @"AAAAAAAAZZZZZZZZZZZZ999999999";

    NSString *AppDataJson = str;
    
    str = [NSString stringWithFormat:@"%@%@%@",[self getGKey],TimeStamp,AppDataJson];
    
    NSLog(@"hash = %@",str);
    const char *buf = [str cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(buf, (CC_LONG)strlen(buf), result);
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [resultString appendFormat:@"%02x",result[i]];
    }
    
    return [resultString uppercaseString];
}

#pragma mark - return httpBody
+ (NSString*) returnHttpBody:(NSDictionary *)data{
    
    NSString *httpbody = @"";
    
    NSString *AppDataJson = [HttpHelper dictToJSONString:data];
    
    NSString *TimeStamp = [HttpHelper getTimeStamp];
    
    NSString *GKeyID = [NSString stringWithFormat:@"%d",GKEYID];
    
    NSString *DataHash = [HttpHelper getSha256Encode:AppDataJson andTimeStamp:TimeStamp]
    ;

    httpbody =[NSString stringWithFormat:@"DataHash=%@&GKeyId=%@&TimeStamp=%@&AppDataJson=%@",DataHash,GKeyID,TimeStamp,AppDataJson];
    return httpbody;
}

#pragma mark - return API url
+ (NSString*) returnAPIByNumber:(int)Number{
    NSString *api = @"";
    return api;
}
@end
