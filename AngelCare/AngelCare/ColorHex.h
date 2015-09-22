//
//  ColorHex.h
//  angelbaby
//
//  Created by macmini on 13/9/27.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorHex : NSObject
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert withAlpha:(float)alpha;
@end
