//
//  CheckErrorCode.m
//  AngelCare
//
//  Created by macmini on 13/6/25.
//
//

#import "CheckErrorCode.h"

@implementation CheckErrorCode

//Error Code字串判斷
+ (void)Check_Error:(NSString *)ErrorData
{
    int ErrorValue;
    ErrorValue = [ErrorData intValue];
    ErrorValue =  ErrorValue%100;
    UIAlertView *alert;

    switch (ErrorValue)
    {
        case 1:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_01", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];

            
            [alert show];
            
            break;
            
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_02", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_03", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            
            [alert show];
            break;
         
        case 4:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_04", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:4];
            [alert show];
            break;
            
        case 5:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_05", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:5];
            [alert show];
            break;
            
        case 6:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_06", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:6];
            [alert show];
            break;
            
        case 7:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_07", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:7];
            [alert show];
            break;
            
        case 8:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_08", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:8];
            [alert show];
            break;
            
            
        case 90:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_90", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 99:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_99", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            
            [alert show];
            break;
            
            
            
        default:
            
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_999", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            
            [alert show];
            
            
            break;
    }
}

//Error Code字串判斷
+ (void)Check_Error:(NSString *)ErrorData WithSender:(id)sender
{
    int ErrorValue;

    ErrorValue = [ErrorData intValue];
    ErrorValue =  ErrorValue%100;

    UIAlertView *alert;
    switch (ErrorValue)
    {
        case 1:
            alert = [[UIAlertView alloc] initWithTitle:kLoadString(@"ALERT_MESSAGE_TITLE")
                                               message:kLoadString(@"ErrorCode_01")
                                              delegate:sender
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles: nil];
            [alert setTag:1];
            [alert show];
            break;
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:kLoadString(@"ALERT_MESSAGE_TITLE")
                                               message:kLoadString(@"ErrorCode_02")
                                              delegate:sender
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles: nil];
            [alert setTag:2];
            [alert show];
            break;
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:kLoadString(@"ALERT_MESSAGE_TITLE")
                                               message:kLoadString(@"ErrorCode_03")
                                              delegate:sender
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles:kLoadString(@"ALERT_MESSAGE_RESEND"), nil];
            [alert setTag:3];
            [alert show];
            break;
        case 4:
            alert = [[UIAlertView alloc] initWithTitle:kLoadString(@"ALERT_MESSAGE_TITLE")
                                               message:kLoadString(@"ErrorCode_04")
                                              delegate:sender
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles: nil];
            [alert setTag:4];
            [alert show];
            break;
        case 5:
            alert = [[UIAlertView alloc] initWithTitle:kLoadString(@"ALERT_MESSAGE_TITLE")
                                               message:kLoadString(@"ErrorCode_05")
                                              delegate:sender
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles: nil];
            [alert setTag:5];
            [alert show];
            break;
        case 6:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_06", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:6];
            [alert show];
            break;
            
        case 7:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_07", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:7];
            [alert show];
            break;
        case 8:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_08", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:8];
            [alert show];
            break;
        case 90:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_90", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:90];
            [alert show];
            break;
            
        case 99:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_99", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:99];
            [alert show];
            break;
        default:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ErrorCode_999", INFOPLIST, nil) delegate:sender cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil) otherButtonTitles: nil];
            [alert setTag:99];
            [alert show];
            break;
    }
}

@end
