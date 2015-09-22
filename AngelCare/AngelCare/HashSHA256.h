//
//  HashSHA256.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface HashSHA256 : NSObject {
    
    
}

- (NSString *) hashedValue :(NSString *) key andData: (NSString *) data ; 


@end