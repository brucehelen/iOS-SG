#import "HashSHA256.h"

#import <CommonCrypto/CommonHMAC.h>


@implementation HashSHA256


- (NSString *) hashedValue :(NSString *) key andData: (NSString *) data {
    
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    /*
    sprintf(cData, "TEST12342011/2/14 14:00:00");
    sprintf(data2, "1234");
    sprintf(data3, "2011/2/14 14:00:00");
     */
    
 //   CCHmac(kCCHmacAlgSHA256, "2011/2/14 14:00:00", strlen("2011/2/14 14:00:00"), "//TEST12342011/2/14 14:00:00", strlen("TEST12342011/2/14 14:00:00"), cHMAC);
    
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString   stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    return hash;
    
}

@end