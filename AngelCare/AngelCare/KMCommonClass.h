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
/**
 *  当前的手机是否是中文
 *
 *  @return 如果是中文 -> YES
 */
+ (BOOL)currentLanguageCN;

@end
