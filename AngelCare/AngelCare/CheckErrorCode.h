//
//  CheckErrorCode.h
//  AngelCare
//
//  Created by macmini on 13/6/25.
//
//

#import <Foundation/Foundation.h>
#import "define.h"

@interface CheckErrorCode : NSObject
//Error Code字串判斷
+(void)Check_Error:(NSString *)ErrorData;

//Error Code字串判斷
+(void)Check_Error:(NSString *)ErrorData WithSender:(id)sender;
@end
