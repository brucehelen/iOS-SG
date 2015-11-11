//
//  KMCommonClass.h
//  3GSW
//
//  Created by bruce-zhu on 15/10/30.
//
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface KMCommonClass : NSObject

+ (NSString *)getWifiName;
+ (NSString *)getWifiMac;

@end
