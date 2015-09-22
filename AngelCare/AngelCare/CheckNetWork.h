//
//  CheckNetWork.h
//  Project_OldAngel
//
//  Created by Lion User on 12/10/5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface CheckNetwork : NSObject

- (BOOL) check;

@end