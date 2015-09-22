//
//  MainClass.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainClass.h"



@implementation MainClass





int IF_State = IF_INDEX;


NSTimer *MyTimer = nil;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



-(void)Check_Http
{
    
    switch (IF_State) 
    {
        case IF_USERDATE:
            
            [self Send_UserDate:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
            
        case IF_USERSET:
            
            [self Send_UserSet:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
            
        case IF_EATSHOW:
               [self Send_Get2:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];           
            break;
            
        case IF_DATESHOW:
                   [self Send_Get1:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];         
            break;        
            
           
        case IF_SETTING:
            
            NSLog(@"do it");
            
            [(MySetView *)MySetView  Set_Go:NowUserNum];
            
            break;
            
        case IF_HIS:
             [self Set_NewGetNum:GetNum];
             break;
            
        case IF_ACT:
            
            
            [self Send_ActionLoc:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            
            break;
            
        case IF_MAP:
             [self Send_LocMap:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
           
        case IF_SHOWLIST:
            
            [self MyTest:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            
            
            
            
             break;

    }
    
    
}


-(void)Check_Error:(NSString *)ErrorData

{
    int ErrorValue;
    
    ErrorValue = [ErrorData intValue];

    
    ErrorValue =  ErrorValue%100;
    
    
    UIAlertView *alert;
    
    switch (ErrorValue)
    {
        case 1:
            
            alert = [[UIAlertView alloc] initWithTitle:
                                 [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  [self Get_DefineString:ERRORCODE_01]
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                  otherButtonTitles: nil];
            
            [alert show];
            
            break;
        
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:
                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message:
                     [self Get_DefineString:ERRORCODE_02]
                     delegate
                                                      : self cancelButtonTitle:
                     [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            
            [alert show]; 
            break;
  
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:
                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message:
                     [self Get_DefineString:ERRORCODE_03]
                     delegate
                                                      : self cancelButtonTitle:
                     [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
        
    
        case 90:
            alert = [[UIAlertView alloc] initWithTitle:
                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message:
                     [self Get_DefineString:ERRORCODE_90]
                     delegate
                                                      : self cancelButtonTitle:
                     [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
        
        case 99:
            alert = [[UIAlertView alloc] initWithTitle:
                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message:
                     [self Get_DefineString:ERRORCODE_99]
                     delegate
                                                      : self cancelButtonTitle:
                     [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            
            [alert show];
            break;        
        
        
        
        default:
            
            alert = [[UIAlertView alloc] initWithTitle:
                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message:
                     [self Get_DefineString:ERRORCODE_OTHER]
                     delegate
                                                      : self cancelButtonTitle:
                     [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            
            [alert show];
            
            
            break;
    }
    


}





-(void)Show_GoToSet
{
    
    GoToSetting_Sw = true;

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                    message:
                          [self Get_DefineString:ALERT_MESSAGE_INPUT]
                          delegate
                                                           : self cancelButtonTitle:
                          [self Get_DefineString:ALERT_MESSAGE_OK]
                                          otherButtonTitles: nil];
    
    
    alert.delegate = self;
    
    
    
    [alert show];
    
}



-(IBAction)Main_MouseDown:(id)sender
{
  
    
    
    if( StartUse_Sw == false )
    {
        if (sender == Bu_Login)
        {
            
            [Bu_Login setHidden:YES];
            [LoginBack setHidden:YES];
            [FlyBack setHidden:YES];
            
            
            
            if( [ self CheckTotal ] == true)
            {
                
                [self Show_GoToSet];    
            }
            
            StartUse_Sw = true;
            
        }
        
        return;
    }
    
    if( sender == Bu1 )
    {
        
        
        [self Send_UserDate:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
        
    }
    else if (sender == Bu2)
    {
        NSLog(@"Down 2");
        
        [self Send_UserSet:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
        
      
    }
    else if (sender == Bu3)
    {
        
        
        [self Change_State:IF_SHOWLSEL];
        
        
    }
    else if (sender == Bu4)
    {       
       // [self Change_State:IF_MAP ];
        
        
        if([checkNetwork check] == false)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  @"網路連線異常，請稍候再嘗試"
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                  otherButtonTitles: nil];
            
            [alert show];
        }
        else
        {
            [self Send_LocMap:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
     
        }
    }
    else if (sender == Bu5)
    {
        if([checkNetwork check] == false)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  @"網路連線異常，請稍候再嘗試"
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                  otherButtonTitles: nil];
            
            [alert show];
        }
        else
        {
            [self Send_ActionLoc:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
        }
    }
    else if (sender == Bu6)
    {
    //    [self Change_State:IF_HIS];
        [self Set_NewGetNum:1];
      
    }
    else if (sender == Bu7)
    {
        NSLog(@"Down 7");
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:[PhoneData objectAtIndex:NowUserNum]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
    }
    else if (sender == Bu8)
    {
        NSLog(@"Down 8");
        [self Send_Get2:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
        //   [self Change_State:IF_EATSHOW];
    }
    else if (sender == Bu9)
    {
        [self Send_Get1:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
        
   //     [self Change_State:IF_DATESHOW];
    }
    else if (sender == Bu_Index)
    {
        NSLog(@"Down index");
        
        
        if(HaveInsertLaw_Sw)
        {
            [MyLawView removeFromSuperview];
            HaveInsertLaw_Sw = false;
        }
        else
        {
            if(HaveInsertLaw2_Sw)
            {
                [MyLawView22 removeFromSuperview];

                HaveInsertLaw2_Sw = false;
            }
            else
            {
                
               [self Change_State:IF_INDEX];
                
            }
            
            
         
        }
        
        

        
    }
    else if (sender == Bu_Set)
    {
        NSLog(@"Down set");
        
        [self Change_State:IF_SETTING ];
        
    }
    else if (sender == Bu_Left)
    {
        if( NowUserNum >  0)
        {
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                                message:
                                      @"網路連線異常，請稍候再嘗試"
                                      delegate
                                                                       : self cancelButtonTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                      otherButtonTitles: nil];
                
                
                
                [alert show];
            }
            else
            {
                NowUserNum--;
                [ShowName setText:[UserData objectAtIndex:NowUserNum]];
                [self Check_Http ];
            
            }
           

        }
        
    }
    else if (sender == Bu_Right)
    {
        if( [UserData count] >  (NowUserNum+1))
        {
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                     [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                                message:
                                      @"網路連線異常，請稍候再嘗試"
                                      delegate
                                                                       : self cancelButtonTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                      otherButtonTitles: nil];
                
                [alert show];
            }
            else
            {
                NowUserNum++;
                [ShowName setText:[UserData objectAtIndex:NowUserNum]];
            
                [self Check_Http ];
            }
        }
        
    }   

}

NSMutableData *Get_tempData;    //下載時暫存用的記憶體
NSURLConnection *Get_connect;
long Get_expectedLength;        //檔案大小



NSURLConnection *Add_Connect;
NSMutableData *Add_tempData;    //下載時暫存用的記憶體
long Add_expectedLength;        //檔案大小


NSURLConnection *Loc_Connect;
NSMutableData *Loc_tempData;    //下載時暫存用的記憶體
long Loc_expectedLength;        //檔案大小


NSURLConnection *Act_Connect;
NSMutableData *Act_tempData;    //下載時暫存用的記憶體
long Act_expectedLength;        //檔案大小


NSString  *SaveAcc;
NSString  *SaveHash;


NSURLConnection *His_Connect;
NSMutableData *His_tempData;    //下載時暫存用的記憶體
long His_expectedLength;        //檔案大小



NSURLConnection *Save_Connect;
NSMutableData *Save_tempData;    //下載時暫存用的記憶體
long Save_expectedLength;        //檔案大小


NSURLConnection *Set_Connect;
NSMutableData *Set_tempData;    //下載時暫存用的記憶體
long Set_expectedLength;        //檔案大小



NSURLConnection *Date_Connect;
NSMutableData *Date_tempData;    //下載時暫存用的記憶體
long Date_expectedLength;        //檔案大小

NSURLConnection *Del_Connect;
NSMutableData *Del_tempData;    //下載時暫存用的記憶體
long Del_expectedLength;        //檔案大小


-(void) SetPrData:(NSString *)SaveDate
{
    tmpSaveData = [NSString stringWithFormat:@"%@", SaveDate];
}

-(void) Send_SaveData:(int)SaveNum:(NSString *)SaveDate:(BOOL)On
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSArray *arr = [SaveDate componentsSeparatedByString:@" "];
    
    NSString *tmpstr2;
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", [AccData objectAtIndex:NowUserNum],[HashData objectAtIndex:NowUserNum],dateString];
    
    NSArray *arr2 = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    
    
    if( On )
    {
        
        
        
      tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatehospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=on&datetime=%@%%20%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatehospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=off&datetime=%@%%20%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    

    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Save_tempData = [NSMutableData alloc];
    Save_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
   
    [self Ctl_LoadingView:true]; 
}



-(void) Send_SaveSmallData:(int)SaveNum:(NSString *)SaveDate:(BOOL)On
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", [AccData objectAtIndex:NowUserNum],[HashData objectAtIndex:NowUserNum],dateString];
    
    NSArray *arr2 = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *tmpstr2;
    
    if( On )
    {
    
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatemedicine.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=on&datetime=%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,SaveDate];
    }
    else
    {
        
           tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatemedicine.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=off&datetime=%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,SaveDate];
        
    }
    

    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Save_tempData = [NSMutableData alloc];
    Save_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self Ctl_LoadingView:true]; 
}




NSURLConnection *Get_Connect;
NSMutableData *Get_tempData;    //下載時暫存用的記憶體
long Get_expectedLength;        //檔案大小


BOOL    Is_Get1_Sw = false;

-(void) Send_Get1:(NSString *)Acc2:(NSString *)Hash2
{
    
    Is_Get1_Sw = true;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/apphospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Get_tempData = [NSMutableData alloc];
    Get_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 
    
    
}


-(void) Send_Get2:(NSString *)Acc2:(NSString *)Hash2
{
    
    Is_Get1_Sw = false;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appmedicine.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Get_tempData = [NSMutableData alloc];
    Get_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 
    
    
}



-(void) Send_UserDate:(NSString *)Acc2:(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/getinfo.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Date_tempData = [NSMutableData alloc];
    Date_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 
    
    
}


-(void) Send_UserSet:(NSString *)Acc2:(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/getstatus.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Set_tempData = [NSMutableData alloc];
    Set_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 
    
    
}



-(void) Send_Sos2:(NSString *)Acc2:(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appFALL.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 
    
    
}


-(void)Set_NewGetNum:(int)SetNum
{
    GetNum = SetNum;
    
    
    switch (GetNum)
    {
        case 1:
           [self Send_Sos:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
            
        case 2:
            [self Send_Sos2:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
            
        case 3:
            [self Send_Sos3:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            break;
            
    }
    
    
    
}

-(void) Send_Sos3:(NSString *)Acc2:(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appCALL.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    [self Ctl_LoadingView:true]; 
    
    
}

-(void) Send_Sos:(NSString *)Acc2:(NSString *)Hash2
{

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appSOS.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true]; 

}

//ok
-(void) Add_User:(NSString *)Acc:(NSString *)Pwd
{
    

    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc, Pwd,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
   

    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSString *tmpstr2;
    
    
    SaveAcc = [NSString stringWithFormat:@"%@", Acc];
    SaveHash = [NSString stringWithFormat:@"%@", Pwd];
    
    
    if(tmpSaveToken.length <10)
    {
      tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/addaccount.do?account=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=iOS&UUID=%@",InkUrl,Acc,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    }
    else
    {
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/addaccount.do?account=%@&data=%@&timeStamp=%@%%20%@&device=iOS&UUID=%@&token=%@",InkUrl,Acc,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID,tmpSaveToken];
        
        
        
         
         
    }
    


    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Add_tempData = [NSMutableData alloc];
    Add_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];    
 
}


//ok
- (void)Send_DeleteUser:(NSString *)Acc2:(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSString *tmpstr2;
    
    NSLog(@"send del");

    
    if(tmpSaveToken.length <10)
    {  
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delaccount.do?account=%@&UUID=%@&device=iOS&token=012345",InkUrl,Acc2,MyUUID];
    }
    else
    {
        
     tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delaccount.do?account=%@&UUID=%@&device=iOS&token=%@",InkUrl,Acc2,MyUUID,tmpSaveToken];       
    }
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Del_tempData = [NSMutableData alloc];
    Del_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
}



//ok
- (void)Send_ActionLoc:(NSString *)Acc2:(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSString *tmpstr2;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/apptrace.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Act_tempData = [NSMutableData alloc];
    Act_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
}

//ok
- (void)Send_LocMap:(NSString *)Acc2:(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/applocation.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Loc_tempData = [NSMutableData alloc];
    Loc_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    
    
    [self Ctl_LoadingView:true];
}

//ok
- (void)MyTest:(NSString *)Acc2:(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSString *tmpstr2;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    switch (ShowNum) 
    {
        case 1:
         tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalbp.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;
            
        case 2:
                tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalbs.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;  
            
        case 3:
              tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalwt.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;            
            
        case 4:
                  tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitaloxy.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;            
            
        default:
            
            return;
            
            break;
    }
    


    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Get_tempData = [NSMutableData alloc];
    Get_connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
   
    
    
    //  [super viewDidLoad];
    
    
    [self Ctl_LoadingView:true];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   
{

    if(GoToSetting_Sw)
    {
        GoToSetting_Sw = false;
        [self Change_State:IF_SETTING];   
   //     [(MySetView *)MySetView Show_Alert];
     
    }
    else
    {
        if(NeedQuit_Sw)
        {
            exit(0);
        }        
    }
    
    
    

    
   
}

- (IBAction)Big_MouseDown:(id)sender
{
    
    [ListView Set_Big];
    
}

- (IBAction)Small_MouseDown:(id)sender
{
    [ListView Set_Small];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{   
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          @"Wrong"
                                                    message:
                          @"介接發生錯誤"
                          delegate
                                                           : self cancelButtonTitle:
                          @"Close"
                                          otherButtonTitles: nil];
    
    [alert show];
    
    NeedQuit_Sw = true;
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    
    
    if(connection == Add_Connect)
    {
        [Add_tempData setLength:0];    
        Add_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度        
    }
    else if(connection == Get_connect)
    {
        [Get_tempData setLength:0];    
        Get_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == Loc_Connect)
    {
        [Loc_tempData setLength:0];    
        Loc_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == Act_Connect)
    {
        [Act_tempData setLength:0];    
        Act_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == His_Connect)
    {
        [His_tempData setLength:0];    
        His_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    else if(connection == Save_Connect)
    {
        [Save_tempData setLength:0];    
        Save_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    else if(connection == Get_Connect)
    {
        [Get_tempData setLength:0];    
        Get_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    else if(connection == Set_Connect)
    {
        [Set_tempData setLength:0];    
        Set_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    else if(connection == Date_Connect)
    {
        [Date_tempData setLength:0];    
        Date_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    else if(connection == Del_Connect)
    {
        [Del_tempData setLength:0];    
        Del_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度    
        
        
    }
    
    //  NSLog(@"%d & len : %d ", status,expectedLength);
}


-(void)Ctl_LoadingView:(BOOL)Enable_Sw
{
    
    if(Enable_Sw)
    {
        if( HaveLoading_Sw )
        {
            
        }
        else
        {
            [self addSubview:LoadingView];
            
            
            HaveLoading_Sw = true;
            
        }
    }
    else
    {
        if(HaveLoading_Sw)
        {
            [LoadingView removeFromSuperview];
            HaveLoading_Sw = false;

        }
    
    }
    
    
    
    
}

-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{   //收到封包，將收到的資料塞進緩衝中並修改進度條
    
    if(connection == Add_Connect)
    {
         [Add_tempData appendData:incomingData];
    }
    else if(connection == Get_connect)
    {
        [Get_tempData appendData:incomingData];
    }
    else if(connection == Loc_Connect)
    {
        [Loc_tempData appendData:incomingData];
    }
    else if(connection == Act_Connect)
    {
        [Act_tempData appendData:incomingData];
    }   
    else if(connection == His_Connect)
    {
        [His_tempData appendData:incomingData];

    } 
    else if(connection == Save_Connect)
    {
        [Save_tempData appendData:incomingData];
        
    }
    else if(connection == Get_Connect)
    {
        [Get_tempData appendData:incomingData];
        
    }
    else if(connection == Set_Connect)
    {
        [Set_tempData appendData:incomingData];
        
    }
    else if(connection == Date_Connect)
    {
        [Date_tempData appendData:incomingData];
        
    }
    else if(connection == Del_Connect)
    {
        [Del_tempData appendData:incomingData];
        
    }
}

-(void)Http_Process_Date
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Date_tempData encoding:NSUTF8StringEncoding];
    
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        [(UserDateView *) UserDateView Set_Init:self];
        
        
        if( [status isEqualToString:str1]  )
        {
            
            NSString *TValue1 = [usersOne objectForKey:@"name"];
            [(UserDateView *) UserDateView Set_Value:1:TValue1];
            
            NSString *TValue2 = [usersOne objectForKey:@"sex"];
            [(UserDateView *) UserDateView Set_Value:2:TValue2];

            NSString *TValue3 = [usersOne objectForKey:@"address"];
            [(UserDateView *) UserDateView Set_Value:3:TValue3];
            
            NSString *TValue4 = [usersOne objectForKey:@"imei"];
            [(UserDateView *) UserDateView Set_Value:4:TValue4];
            

            NSString *TValue5 = [usersOne objectForKey:@"phone"];
            [(UserDateView *) UserDateView Set_Value:5:TValue5];
            
            
            NSString *TValue6 = [usersOne objectForKey:@"service"];
            [(UserDateView *) UserDateView Set_Value:6:TValue6];
            
            NSString *TValue7 = [usersOne objectForKey:@"img_url"];
            [(UserDateView *) UserDateView Set_Value:7:TValue7];          
            
            Is_UserGet_Sw = true;
             
            [self Send_Get1:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]]; 
            
            
            
            [self Change_State:IF_USERDATE];
            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
        
    }
    
     [self Ctl_LoadingView:FALSE];
    
}

-(void)Http_Process_Set
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Set_tempData encoding:NSUTF8StringEncoding];
    
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    NSString *TValue32;
    NSString *TValue6;
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        [(UserSetView *) UserSetView Set_Init:self];
       
        
        if( [status isEqualToString:str1]  )
        {
           
             NSString *TValue1 = [usersOne objectForKey:@"time_on"];
             [(UserSetView *) UserSetView Set_Value:1:TValue1];
           
                        
            
            NSString *TValue2 = [usersOne objectForKey:@"time_on"];
            [(UserSetView *) UserSetView Set_Value:2:TValue2];
            
            
             NSString *TValue3 = [NSString stringWithFormat:@"%@",[usersOne objectForKey:@"off_type"]];
            
            
            if([TValue3 intValue]>0 && [TValue3 intValue] <4)
            {
                switch ([TValue3 intValue])
                {
                    case 1:
                        [(UserSetView *) UserSetView Set_Value:3:@"手動關機"];
                        break;
                        
                    case 2:
                        [(UserSetView *) UserSetView Set_Value:3:@"低電壓關機"];
                        break;
                        
                    case 3:
                        [(UserSetView *) UserSetView Set_Value:3:@"低電壓關機"];
                        break;
 
                }
            }
            else
            {
                TValue32 = [ NSString stringWithFormat:@"其他(%d)", [TValue3 intValue] ];
                
                [(UserSetView *) UserSetView Set_Value:3:TValue32];
            }
            

            
            
            
             NSString *TValue4 = [usersOne objectForKey:@"time_sync"];
            [(UserSetView *) UserSetView Set_Value:4:TValue4];
            
             NSString *TValue5 = [usersOne objectForKey:@"fw"];
            [(UserSetView *) UserSetView Set_Value:8:TValue5];
            
            
         
            
             TValue6 = [NSString stringWithFormat:@"%@",[usersOne objectForKey:@"electricity"]];
            
            float X6 = [TValue6 floatValue];
             
            NSString *TValue62 = [ NSString stringWithFormat:@"%.2f V", X6/100 ];
  
            [(UserSetView *) UserSetView Set_Value:5:TValue62];
            
            
            
             NSString *TValue7 = [NSString stringWithFormat:@"%@ ℃",[usersOne objectForKey:@"psr_temp"] ];
            [(UserSetView *) UserSetView Set_Value:6:TValue7];
            
            
            
             NSString *TValue8 = [usersOne objectForKey:@"location"];
            [(UserSetView *) UserSetView Set_Value:7:TValue8];
            
            
            
            [self Change_State:IF_USERSET];
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];  
        }
    }

    [self Ctl_LoadingView:FALSE];
}


-(void)Http_Process_Get2
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSString *Num1 = [usersOne objectForKey:@"num1"];
            NSString *Num2 = [usersOne objectForKey:@"num2"];
             NSString *Num3 = [usersOne objectForKey:@"num3"];
             NSString *Num4 = [usersOne objectForKey:@"num4"];
             NSString *Num5 = [usersOne objectForKey:@"num5"];
            
            
            
            
            
            NSString *Sw1= [usersOne objectForKey:@"switch1"];
            NSString *Sw2 = [usersOne objectForKey:@"switch2"];
             NSString *Sw3 = [usersOne objectForKey:@"switch3"];
             NSString *Sw4 = [usersOne objectForKey:@"switch4"];
             NSString *Sw5 = [usersOne objectForKey:@"switch5"];
            
            
            BOOL On1= false;
            BOOL On2= false;
            BOOL On3= false;
            BOOL On4= false;
            BOOL On5= false;
            
            
            NSString *check = [NSString stringWithFormat:@"on"];
            
            if( [Sw1 isEqualToString:check]  )
            {
                On1 = true;
            }
            
            if( [Sw2 isEqualToString:check]  )
            {
                On2 = true;
            }
            
            if( [Sw3 isEqualToString:check]  )
            {
                On3 = true;
            }
            
            if( [Sw4 isEqualToString:check]  )
            {
                On4 = true;
            }
            
            if( [Sw5 isEqualToString:check]  )
            {
                On5 = true;
            }
            
            if( Is_UserGet_Sw == true)
            {
                [(UserDateView *) UserDateView Set_Value:21:Num1];
                [(UserDateView *) UserDateView Set_Value:22:Num2];
                [(UserDateView *) UserDateView Set_Value:23:Num3];
                [(UserDateView *) UserDateView Set_Value:24:Num4];
                [(UserDateView *) UserDateView Set_Value:25:Num5];
 
                Is_UserGet_Sw = false;
            }
            else
            {
                [(MyEatShowView *)MyEatShowView Set_Value:Num1:Num2:Num3:Num4:Num5:On1:On2:On3:On4:On5];
                
                [self Change_State:IF_EATSHOW];                
            }
            
            

            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
    }
    [self Ctl_LoadingView:FALSE];
    
}

-(void)Http_Process_Get1
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSString *Num1 = [usersOne objectForKey:@"num1"];
            NSString *Num2 = [usersOne objectForKey:@"num2"];
            
            
            NSString *Sw1= [usersOne objectForKey:@"switch1"];
            NSString *Sw2 = [usersOne objectForKey:@"switch2"];
            
            
            BOOL On1= false;
            BOOL On2= false;
            
            
            NSString *check = [NSString stringWithFormat:@"on"];
            
            if( [Sw1 isEqualToString:check]  )
            {
                On1 = true;
            }
            
            if( [Sw2 isEqualToString:check]  )
            {
                On2 = true;
            }
            
            if( Is_UserGet_Sw == true)
            {
          
                 [(UserDateView *) UserDateView Set_Value:11:Num1];
                 [(UserDateView *) UserDateView Set_Value:12:Num2];
                
                [self Send_Get2:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]]; 
            }
            else
            {
               
                [(MyDateShowView *)MyDateShowView Set_Value:Num1:Num2:On1:On2];
                [self Change_State:IF_DATESHOW];                
            }
            
          
            

            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
    }

    [self Ctl_LoadingView:FALSE];
}


-(void)Http_Process_Del
{
   int Szlen = [UserData count];
    
    [self Ctl_LoadingView:false];
    
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Del_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@" del ok ");
            
            
            for(int j =0;j<Szlen;j++)
            {
                
                NSString *tmpstr = [UserData objectAtIndex:j];
                
                if( [tmpstr isEqualToString:DelName]  )
                {
                  
                    
               
                     
                     
                     NSUserDefaults* defaults;
                     defaults = [NSUserDefaults standardUserDefaults];
                     [defaults setInteger:0 forKey:@"totalcount"];
                     [defaults synchronize];
                     
                     
                     for (int z=0;z<Szlen; z++)
                     {
                     if(z == j)
                     continue;
                     
                     
                     NSLog(@"add one");
                     
                     
                     [self SaveNewData2:[UserData objectAtIndex:z]: [PhoneData objectAtIndex:z]: [AccData objectAtIndex:z]: [HashData objectAtIndex:z]];
                     
                     
                     
                     }
                     
                     
                     [self LoadUserData];
                     [self Set_SetView];
                     
                     
                     
                     [self Ctl_LoadingView:false];
                     
    
                    
                    return;
                }
                
            }

            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            [self Ctl_LoadingView:false];
        }
    }
    
    
    
    
}

-(void)Http_Process_Save
{
    
    [self Ctl_LoadingView:false];
    
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Save_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@" save ok ");
            
            if(IF_State == IF_EATSEL)
            {
             
                    [self Send_Get2:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];     
            }
            else if( IF_State == IF_DATESEL)
            {
                  [self Send_Get1:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            }

            
        }
        else
        {
            
            
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
    }
    
    

    
}


-(void) Http_Process_His1
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:His_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@"ok la ");
 
            [self Ctl_LoadingView:true];
            
            id station = [usersOne objectForKey:@"Data"]; 
            
            
            if ([station isKindOfClass:[NSArray class]])
            {
                
                NSLog(@" get Array");
                
                NSArray *tmpb1 = station;
                  
                [(MyHisView *)MyHisView Set_Init:true:1:self];
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"datatime"];
                    NSString * tmpValue2 =[buf1 objectForKey:@"place"];
                    
                    if(tmpValue1 == NULL)
                    {
                        tmpValue1 = @"";
                    }                
                    
                    if(tmpValue2 == NULL)
                    {
                        tmpValue2 = @"";
                    }

                    
                    NSLog( @"data %d is  %@,%@  ",j+1,tmpValue1,tmpValue2);
                    
                    
                    [(MyHisView *)MyHisView Insert_Data:tmpValue1:tmpValue2:tmpValue1];
                }
                
                
                
                [ (MyHisView *)MyHisView Do_Init ];
                
            }
                
            [self Ctl_LoadingView:false];
            [self Change_State:IF_HIS];
            
            
        }
        else 
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];            
            
        }

    }
    
}


-(void) Http_Process_His2
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:His_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@"ok la ");
            
            [self Ctl_LoadingView:true];
            
            id station = [usersOne objectForKey:@"Data"]; 
            
            
            if ([station isKindOfClass:[NSArray class]])
            {
                
                NSLog(@" get Array");
                
                NSArray *tmpb1 = station;
                
                [(MyHisView *)MyHisView Set_Init:true:2:self];
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"datatime"];
                    NSString * tmpValue2 =[buf1 objectForKey:@"place"];
                    
                    
                    if(tmpValue1 == NULL)
                    {
                        tmpValue1 = @"";
                    }                
                    
                    if(tmpValue2 == NULL)
                    {
                        tmpValue2 = @"";
                    }
                    
                    
                    NSLog( @"data %d is  %@,%@  ",j+1,tmpValue1,tmpValue2);
                    
                    
                    [(MyHisView *)MyHisView Insert_Data:tmpValue1:tmpValue2:tmpValue1];
                }
                
                
                
                [ (MyHisView *)MyHisView Do_Init ];
                
            }
            
            [self Ctl_LoadingView:false];
            [self Change_State:IF_HIS];
            
            
        }
        else 
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];            
            
        }
        
    }
    
}


-(void) Http_Process_His3
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:His_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@"ok la ");
            
            [self Ctl_LoadingView:true];
            
            id station = [usersOne objectForKey:@"Data"]; 
            
            
            if ([station isKindOfClass:[NSArray class]])
            {
                
                NSLog(@" get Array");
                
                NSArray *tmpb1 = station;
                
                [(MyHisView *)MyHisView Set_Init:false:3:self];
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"start_time"];
                    NSString * tmpValue2 =[buf1 objectForKey:@"end_time"];
                    NSString * tmpValue3 =[buf1 objectForKey:@"duration"];
                    
                    if(tmpValue1 == NULL)
                    {
                        tmpValue1 = @"";
                    }                
                    
                    if(tmpValue2 == NULL)
                    {
                        tmpValue2 = @"";
                    }
                    
                    if(tmpValue3 == NULL)
                    {
                        tmpValue3 = @"";
                    }  
                    
                    
                    
                    NSLog( @"data %d is  %@,%@  ",j+1,tmpValue1,tmpValue2);
                    
                    
                    [(MyHisView *)MyHisView Insert_Data:tmpValue1:tmpValue2:tmpValue3];
                }
                
                
                
                [ (MyHisView *)MyHisView Do_Init ];
                
            }
            
            [self Ctl_LoadingView:false];
            [self Change_State:IF_HIS];
            
            
        }
        else 
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];            
            
        }
        
    }
    
}


-(void)Http_Process_AddUser
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Add_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            
            NSLog(@"add ok");
            
            [self SaveNewData:[usersOne objectForKey:@"name"]: [usersOne objectForKey:@"phone"]:SaveAcc:SaveHash ];
            

            [self LoadUserData];
            [self Set_SetView];
            
        }
        else 
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];

        }
        
        
        
    }
}





-(void) procTime:(NSTimer*)timer
{
    
    switch (IF_State)
    {
        case IF_ACT:
            
            TickCount++;
            
            if( TickCount > 9)
            {
                
                
                TickCount =0;
                
                [(MyActView *)MyActView TimeProc];
                
            }
            
            
            break;
            
        default:
            break;
    }
    
    
}


-(void)Ctl_MyTimer:(BOOL)Enable_Sw
{
	if(Enable_Sw)
	{
		if(MyTimer == nil)
		{
			
			MyTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f/20.0f
													 target:self selector:@selector(procTime:)
												   userInfo: nil repeats: YES];
		}
	}
	
    
}


-(void) Http_Process_GetLocAct
{
    NSLog(@"get ActLoc");
   
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Act_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
         NSLog(@"get ActLoc 2");
    }
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
         NSLog(@"get ActLoc 3");
        
        [(MyMapView *)MyMapView ClearPoint:self];
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@" get Act");
            [self Ctl_LoadingView:false];
            
            id station = [usersOne objectForKey:@"time"]; 
            id station2 = [usersOne objectForKey:@"location"]; 
            id station3 = [usersOne objectForKey:@"longitude"]; 
            id station4 = [usersOne objectForKey:@"latitude"]; 
            id station5 = [usersOne objectForKey:@"electiicity"];
            id station6 = [usersOne objectForKey:@"radius"]; 

            
            if ([station isKindOfClass:[NSArray class]])
            {
                
                NSLog(@" get Array");
                
                NSArray *tmpb1 = station;
                NSArray *tmpb2 = station2;
                NSArray *tmpb3 = station3;
                NSArray *tmpb4 = station4;
                NSArray *tmpb5 = station5;
                NSArray *tmpb6 = station6;
                
                [(MyActView *)MyActView Set_Init:self];
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    id buf2 = [tmpb2 objectAtIndex:j];
                    id buf3 = [tmpb3 objectAtIndex:j];
                    id buf4 = [tmpb4 objectAtIndex:j];
                    id buf5 = [tmpb5 objectAtIndex:j];
                    id buf6 = [tmpb6 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"time"];
                    NSString * tmpValue2 =[buf2 objectForKey:@"location"];
                    NSString * tmpValue3 =[buf3 objectForKey:@"longitude"];
                    NSString * tmpValue4 =[buf4 objectForKey:@"latitude"];
                    NSString * tmpValue5 =[buf5 objectForKey:@"electricity"];
                    NSString * tmpValue6 =[buf6 objectForKey:@"radius"];
                    
                    NSLog( @"data %d is  %@,%@,%@,%@,%@,%@  ",j+1,tmpValue1,tmpValue2,tmpValue3,tmpValue4,tmpValue6,tmpValue4 );
                    
                    
                    [(MyActView *)MyActView Insert_Data:tmpValue1:tmpValue2:tmpValue3:tmpValue5:tmpValue6:tmpValue4];
                }
                
               
               
               [ (MyActView *)MyActView Do_Init: [UserData objectAtIndex:NowUserNum] ];
   
                
                
                
                [self Change_State:IF_ACT];
                
 
            }

            
               
        } 
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];            
        }
    }

    
    
}

-(void) Http_Process_GetLocMap
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Loc_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        [(MyMapView *)MyMapView ClearPoint:self];
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
         
        if( [status isEqualToString:str1]  )
        {
            NSLog(@" get loc");
            [self Ctl_LoadingView:false];
            
            
            [self Change_State:IF_MAP ];
            
            id station = [usersOne objectForKey:@"station"]; 
           
            NSString *longitude;
            NSString *latitude;
            NSString *radius;      
            
            
            NSString *location;
            NSString *event;
            NSString *name;     
            NSString *server_time;
            NSString *watch_time;
            
  

            
            
            
            if ([station isKindOfClass:[NSArray class]])
            {
                
                NSLog(@" get Array");
                
                NSArray *tmpb1 = station;
              


                
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                   id buf1 = [tmpb1 objectAtIndex:j];

                    
                    NSDictionary *true1 =    buf1;

                    longitude = [true1 objectForKey:@"longitude"];
                    latitude = [true1 objectForKey:@"latitude"];
                    radius = [true1 objectForKey:@"radius"];
                    
                    NSLog( @" get  %@,%@,%@",longitude,latitude,radius ); 

                    [(MyMapView *)MyMapView Set_Circle:longitude:latitude:radius];
                    
                }
                
                
            }
            
            
            id station2 = [usersOne objectForKey:@"data"];
            
            if ([station2 isKindOfClass:[NSArray class]])
            {
                NSLog(@" get Array 2");
                
                NSArray *tmpb2 = station2;
                
                
                for(int j =0;j< tmpb2.count;j++ )
                {
                    id buf1 = [tmpb2 objectAtIndex:j];
                    
                    
                    NSDictionary *true1 =    buf1;
                    
                    location = [true1 objectForKey:@"location"];
                    event = [true1 objectForKey:@"event"];
                    name = [true1 objectForKey:@"name"];
                    server_time = [true1 objectForKey:@"server_time"];
                    watch_time = [true1 objectForKey:@"watch_time"];          
                    
                    NSLog( @" get  %@,%@,%@,%@,%@",location,event,name,server_time,watch_time ); 
                    
                    
                    [(MyMapView *)MyMapView Set_Text:location:event:name:server_time:watch_time];
                    
     

                    
                }
                
            }
            
            
             
             id station3 = [usersOne objectForKey:@"mark"];
            
            if ([station3 isKindOfClass:[NSArray class]])
            {
                NSLog(@" get Array 3");
                
                NSArray *tmpb3 = station3;
               

                
                for(int j =0;j< tmpb3.count;j++ )
                {
                    id buf1 = [tmpb3 objectAtIndex:j];
                    
                    
                    NSDictionary *true1 =    buf1;
                   
                                        longitude = [true1 objectForKey:@"longitude"];
                    latitude = [true1 objectForKey:@"latitude"];     
                    
                    
                   
                    NSLog( @" get  %@,%@",longitude,latitude ); 
                    
                    if( longitude!= NULL  && latitude != NULL )
                    {
                        [(MyMapView *)MyMapView Set_Point_ForAdd:longitude:latitude];    
                    }
                    
                    
                    
                    

                    
                }
                 
                 
                
            }
              
              
            
        } 
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];            
        }
    }
}



-(void)Http_Process_GetData2
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        
        if( [status isEqualToString:str1]  )
        {
            
            
            [ListView Do_Init:2:self];
            
            NSString *YearData;
            NSString *Value1;
            
            
            id heartbeat = [usersOne objectForKey:@"blood_sugar"]; 
            
            
            
            if ([heartbeat isKindOfClass:[NSArray class]])
            {
                
                NSArray *tmpb1 = heartbeat;
                
                
                
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    
                    NSDictionary *true1 =    buf1;
                    
                    
                    YearData =[true1 objectForKey:@"time"];
                    
                    Value1 =[true1 objectForKey:@"value"] ;
                    
                    
                    
                    NSArray *arr = [YearData componentsSeparatedByString:@" "];
                    NSString *str;
                    str = [arr objectAtIndex:0];
                    
                    [ListView Insert_Data : [arr objectAtIndex:0]:[arr objectAtIndex:1]: [Value1 floatValue] :0:0 ];
                    
                }
            }
            
            [self Change_State:IF_SHOWLIST];
            
            [ListView Set_Init:2];
            
            
            [self Ctl_LoadingView:false];
            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            
            [self Ctl_LoadingView:false];
        }
    }
   
}


-(void)Http_Process_GetData3
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        
        
        
        
        if( [status isEqualToString:str1]  )
        {
            
            
            [ListView Do_Init:3:self];
            
            NSString *YearData;
            NSString *Value1;
            NSString *Value2;
            NSString *Value3;
            
            
            id heartbeat = [usersOne objectForKey:@"weight"]; 
            id systolic = [usersOne objectForKey:@"bmi"];
            id diastolic = [usersOne objectForKey:@"body_fat"];
            

            if ([heartbeat isKindOfClass:[NSArray class]])
            {
                
                NSArray *tmpb1 = heartbeat;
                
                NSArray *tmpb2 = systolic;
                NSArray *tmpb3 = diastolic;
                
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    id buf2 = [tmpb2 objectAtIndex:j];
                    id buf3 = [tmpb3 objectAtIndex:j];
                    
                    NSDictionary *true1 =    buf1;
                    NSDictionary *true2 =    buf2;
                    NSDictionary *true3 =    buf3;
                    
                    
                    
                    YearData =[true1 objectForKey:@"time"];
                    
                    Value1 =[true1 objectForKey:@"value"] ;
                    Value2 =[true2 objectForKey:@"value"] ;
                    Value3 =[true3 objectForKey:@"value"] ;
                    
                    
                    NSArray *arr = [YearData componentsSeparatedByString:@" "];
                    NSString *str;
                    str = [arr objectAtIndex:0];
                    
                    [ListView Insert_Data : [arr objectAtIndex:0]:[arr objectAtIndex:1]: [Value1 floatValue] :[Value2 floatValue]:[Value3 floatValue] ];
                    
                }
            }
            
            [self Change_State:IF_SHOWLIST];
            
            [ListView Set_Init:3];
            
            
            [self Ctl_LoadingView:false];
            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            
            [self Ctl_LoadingView:false];
        }
        
        

        
    }
 
  
}


-(void)Http_Process_GetData4
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        
        
        
        
        if( [status isEqualToString:str1]  )
        {
            
            
            [ListView Do_Init:4:self];
            
            NSString *YearData;
            NSString *Value1;
            NSString *Value2;

            
            
            id heartbeat = [usersOne objectForKey:@"oxygen"]; 
            id systolic = [usersOne objectForKey:@"heartbeat"];

            
            
            if ([heartbeat isKindOfClass:[NSArray class]])
            {
                
                NSArray *tmpb1 = heartbeat;
                
                NSArray *tmpb2 = systolic;

                
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    id buf2 = [tmpb2 objectAtIndex:j];

                    
                    NSDictionary *true1 =    buf1;
                    NSDictionary *true2 =    buf2;
 
                    
                    
                    
                    YearData =[true1 objectForKey:@"time"];
                    
                    Value1 =[true1 objectForKey:@"value"] ;
                    Value2 =[true2 objectForKey:@"value"] ;

                    
                    NSArray *arr = [YearData componentsSeparatedByString:@" "];
                    NSString *str;
                    str = [arr objectAtIndex:0];
                    
                    [ListView Insert_Data : [arr objectAtIndex:0]:[arr objectAtIndex:1]: [Value1 floatValue] :[Value2 floatValue]:0 ];
                    
                }
            }
            
            [self Change_State:IF_SHOWLIST];
            
            [ListView Set_Init:4];
            
            
            [self Ctl_LoadingView:false];
            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            
            [self Ctl_LoadingView:false];
        }
        
        
        
        
    }
    
 
   
}


-(void)Http_Process_GetData1
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    
    NSString* json_string = [[NSString alloc] initWithData:Get_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        
        
        
        
        if( [status isEqualToString:str1]  )
        {
            
            
            [ListView Do_Init:1:self];
            
            NSString *YearData;
            NSString *Value1;
            NSString *Value2;
            NSString *Value3;
            
            
            id heartbeat = [usersOne objectForKey:@"heartbeat"]; 
            id systolic = [usersOne objectForKey:@"systolic"];
            id diastolic = [usersOne objectForKey:@"diastolic"];
            
            
            
            
            if ([heartbeat isKindOfClass:[NSArray class]])
            {
                
                NSArray *tmpb1 = heartbeat;
                
                NSArray *tmpb2 = systolic;
                NSArray *tmpb3 = diastolic;
                
                
                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb2 objectAtIndex:j];
                    id buf2 = [tmpb3 objectAtIndex:j];
                    id buf3 = [tmpb1 objectAtIndex:j];
                    
                    NSDictionary *true1 =    buf1;
                    NSDictionary *true2 =    buf2;
                    NSDictionary *true3 =    buf3;
                    
                    
                    
                    YearData =[true1 objectForKey:@"time"];
                    
                    Value1 =[true1 objectForKey:@"value"] ;
                    Value2 =[true2 objectForKey:@"value"] ;
                    Value3 =[true3 objectForKey:@"value"] ;
                    
                    
                    NSArray *arr = [YearData componentsSeparatedByString:@" "];
                    NSString *str;
                    str = [arr objectAtIndex:0];
                    
                    [ListView Insert_Data : [arr objectAtIndex:0]:[arr objectAtIndex:1]: [Value1 floatValue] :[Value2 floatValue]:[Value3 floatValue] ];
                    
                }
            }
            
            [self Change_State:IF_SHOWLIST];
            
            [ListView Set_Init:1];
            
            
            [self Ctl_LoadingView:false];
            
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            
            [self Ctl_LoadingView:false];
        }

        
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    
    
    if(connection == Add_Connect)
    {
        [self Http_Process_AddUser];
    }
    else if( connection == Get_connect )
    {
        
        switch (ShowNum)
        {
            case 1:
                
                NSLog(@"1 ok");
                
                [self Http_Process_GetData1];
                break;
            case 2:
                NSLog(@"2 ok");
                [self Http_Process_GetData2];
                break;              
            case 3:
                NSLog(@"3 ok");
                [self Http_Process_GetData3];
                break;
            case 4:
                NSLog(@"4 ok");
                [self Http_Process_GetData4];
                break;                
        }
        
        
    }
    else if( connection == Loc_Connect )
    {
        [self Http_Process_GetLocMap];
    }  
    else if( connection == Act_Connect )
    {
        [self Http_Process_GetLocAct];
    }     
    else if( connection == His_Connect )
    {
        
        switch (GetNum)
        {
            case 1:
               [self Http_Process_His1];
                break;
                
            case 2:
                [self Http_Process_His2];
                break;
                
            case 3:
                [self Http_Process_His3];
                break;                
                
        }

    }    
    else if( connection == Save_Connect )
    {
        
        [self Http_Process_Save];

        
    } 
    else if( connection == Get_Connect )
    {
        if(Is_Get1_Sw)
        {
            [self Http_Process_Get1];
        }
        else
        {
            [self Http_Process_Get2];
        }
        
        
        
        
    } 
    else if( connection == Set_Connect )
    {
        [self Http_Process_Set];
 
        
    }
    else if( connection == Date_Connect )
    {
        [self Http_Process_Date];
        
        
    } 
    else if( connection == Del_Connect )
    {
        [self Http_Process_Del];
        
        
    } 
    
    
     
}


-(void) Other_MouseDown:(int)DownNum
{
    switch (DownNum)
    {
        case 1:
        case 2:
        case 3:            
        case 4:
            
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                      @"提示"
                                                                message:
                                      @"網路連線異常，請稍候再嘗試"
                                      delegate
                                                                       : self cancelButtonTitle:
                                      @"Close"
                                                      otherButtonTitles: nil];
                
                [alert show];
            }
            else
            {
            
                ShowNum = DownNum;
            
                NSLog(@"send %@ & %@",[AccData objectAtIndex:NowUserNum],[HashData objectAtIndex:NowUserNum]);
            
                [self MyTest:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
            }
            
     //       [self Change_State:IF_SHOWLIST];
            break;
            
        case 41:
        case 42:
            [(MyDatePickerView *)MyDatePickerView Set_Label:DownNum-40:tmpSaveData:TRUE];  
            [self Change_State:IF_DATESEL];
            break;
            
        case 81:
        case 82:
            [(MyDatePickerView *)MyDatePickerView Set_Label:DownNum-80:tmpSaveData:FALSE];  
            [self Change_State:IF_DATESEL];
            break;           
            
           
        case 51:
        case 52:
        case 53:
        case 54:
        case 55:
            [(MyEatPickView *)MyEatPickView Set_Label:DownNum-50:TRUE];            
            [self Change_State:IF_EATSEL];
            break;

        case 91:
        case 92:
        case 93:
        case 94:
        case 95:
            [(MyEatPickView *)MyEatPickView Set_Label:DownNum-90:FALSE];            
            [self Change_State:IF_EATSEL];
            break;
            
            
            
        case 61:
        case 62:
            [self Change_State:IF_EATSHOW];
            break;
            
        case 71:
        case 72:
            [self Change_State:IF_DATESHOW];
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)Set_DToekn:(NSString *)Mytoken
{
    /*
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          @"Wrong"
                                                    message:
                          Mytoken
                          delegate
                                                           : self cancelButtonTitle:
                          @"Close"
                                          otherButtonTitles: nil];
    
    [alert show];

     */
    
    
  
    
    tmpSaveToken = [NSString stringWithFormat:@"%@", Mytoken];
}

-(void)InsertLaw
{
    HaveInsertLaw_Sw = true;
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
    
        MyLawView.frame  =   CGRectMake(0, 90, 320, 390);
    
   
    
        [self addSubview:MyLawView ];  
    }
    else
    {
        MyLawView.frame  =   CGRectMake(0, 194, 768 , 830);
        
        
        
        [self addSubview:MyLawView ];      
    }
    
    
}

-(void)InsertLaw2
{
    HaveInsertLaw2_Sw = true;
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        
    
        MyLawView22.frame  =   CGRectMake(0, 90, 320, 390);

    
        [self addSubview:MyLawView22 ];  
    }
    else
    {
        MyLawView22.frame  =   CGRectMake(0, 194, 768 , 830);
        
        
        [self addSubview:MyLawView22 ];       
    }
    
    
}


-(void)awakeFromNib
{
    StartUse_Sw = false;
    
    GoToSetting_Sw = false;
    
    HaveInsertLaw2_Sw = false;
    HaveInsertLaw_Sw = false;
    
    InkUrl = @"http://angel.guidercare.com:18087";
    
    Is_UserGet_Sw = false;
    
    MyUUID =   [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] uniqueIdentifier]];  
 
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* arrayLanguages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [arrayLanguages objectAtIndex:0];
    

    
    NSString *check1 = [NSString stringWithFormat:@"en"];
    NSString *check2 = [NSString stringWithFormat:@"zh-Hans"];
    
    if( [currentLanguage isEqualToString:check1]  )
    {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_en" ofType:@"plist"];
        Array_show =   [  [  NSMutableDictionary  alloc  ]  initWithContentsOfFile : plistPath] ;
    }
    else
    {
        if( [currentLanguage isEqualToString:check2]  )
        {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_cn" ofType:@"plist"];
            Array_show =   [  [  NSMutableDictionary  alloc  ]  initWithContentsOfFile : plistPath] ;  
        }
        else
        {
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_tw" ofType:@"plist"];
            Array_show =   [  [  NSMutableDictionary  alloc  ]  initWithContentsOfFile : plistPath] ;            
            
        }      
        
    }
    

    
    
    tmpSaveToken = [NSString stringWithFormat:@"s"];

    ShowNum =0;
    
    NeedQuit_Sw = false;
    
    HaveLoading_Sw = false;
    
     checkNetwork = [[CheckNetwork alloc] init];
    
    
    
    [Bu1 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU1  ]  ] forState:UIControlStateNormal];
    
        [Bu2 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU2  ] ] forState:UIControlStateNormal];
    
        [Bu3 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU3  ] ] forState:UIControlStateNormal];
    
        [Bu4 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU4  ] ] forState:UIControlStateNormal];
    
        [Bu5 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU5  ] ] forState:UIControlStateNormal];
    
        [Bu6 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU6  ] ] forState:UIControlStateNormal];
    
        [Bu7 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU7  ] ] forState:UIControlStateNormal];
    
        [Bu8 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU8  ] ] forState:UIControlStateNormal];
    
        [Bu9 setImage:[UIImage imageNamed: [  Array_show objectForKey : IMAGE_INDEX_BU9  ] ] forState:UIControlStateNormal];
    
    
    

    
    
           [Bu_Index setTitle:[  Array_show objectForKey : INDEX_BU_BACK  ] forState:UIControlStateNormal];
    
           [Bu_Set setTitle:[  Array_show objectForKey : INDEX_BU_SET  ] forState:UIControlStateNormal];
    

    
    // YES = connect / NO = death
  
     
    
  /*
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:0 forKey:@"totalcount"];
   [defaults synchronize];
   */
    
    UserData = [[NSMutableArray alloc] init];
    UserData = [NSMutableArray arrayWithCapacity:100];
    
    PhoneData= [[NSMutableArray alloc] init];
    PhoneData = [NSMutableArray arrayWithCapacity:100];
    
    AccData= [[NSMutableArray alloc] init];
    AccData = [NSMutableArray arrayWithCapacity:100];
    
    HashData= [[NSMutableArray alloc] init];
    HashData = [NSMutableArray arrayWithCapacity:100];    

    
    [ListView setHidden:YES];
    
   
    
    
    

     
    [(MyEatPickView *)MyEatPickView Do_Init:self];
    [(MyDatePickerView *)MyDatePickerView Do_Init:self];  
    
    
     

     
    [(MyDateShowView *)MyDateShowView Do_Init:self];
    [(MyEatShowView *)MyEatShowView Do_Init:self];
    
    [ListView Do_Init:1:self];
    
    //   [self Add_User];
    
    [ShowName setText:@""];
    [self LoadUserData];
     NowUserNum =0;
    
    
    
    [self Ctl_MyTimer:true];
 
       [Bu_Login setTitle:[  Array_show objectForKey : TITLE_BU_LOGIN  ] forState:UIControlStateNormal];
    
}

- (void)viewDidLoad
{
    

    
 //   [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
     
    //    myImageView.frame = CGRectMake(0, 0, myImageView.image.size.width/2, myImageView.image.size.height/2);
    
}

-(void)LoadUserData
{
    
    [UserData removeAllObjects];
    [PhoneData removeAllObjects];
    
    [AccData removeAllObjects];
    [HashData removeAllObjects];
    
    
    int Value1 =1;   
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"totalcount"];
    
    for(int i=0;i<Value1;i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"Name%d", i+1];
        NSString *savedValue = [defaults   stringForKey:str1];
        [UserData addObject:savedValue];
        
        if(i==0)
        {
            [ShowName setText:savedValue];
        }
        
        
         NSString *str2 = [NSString stringWithFormat:@"Phone%d", i+1];
         NSString *savedValue2 = [defaults   stringForKey:str2];
        [PhoneData addObject:savedValue2];
        
        
        NSString *str3 = [NSString stringWithFormat:@"Acc%d", i+1];
        NSString *savedValue3 = [defaults   stringForKey:str3];
        [AccData addObject:savedValue3];
        
        
        NSString *str4 = [NSString stringWithFormat:@"Hash%d", i+1];
        NSString *savedValue4 = [defaults   stringForKey:str4];
        [HashData addObject:savedValue4];
        
        

    }
    
    NowUserNum =0;
    
     [(MySetView *)MySetView  Set_Go:NowUserNum];
 }


-(void) Set_Go:(int)NowSetNum
{
    NowUserNum = NowSetNum;
    
    [ShowName setText:[UserData objectAtIndex:NowUserNum]];
    [(MySetView *)MySetView  Set_Go:NowUserNum];
}



-(void)SaveNewData2:(NSString*)Name:(NSString*)Phone:(NSString*)Acc:(NSString*)Hash
{
    int Value1 =1;   
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    Value1 = [defaults integerForKey:@"totalcount"];
    
     
    
    Value1++;
    
    NSString *str1 = [NSString stringWithFormat:@"Name%d", Value1];
    [defaults setObject:Name forKey:str1];
    
    NSString *str2 = [NSString stringWithFormat:@"Phone%d", Value1];
    [defaults setObject:Phone forKey:str2];
    [defaults setInteger:Value1 forKey:@"totalcount"];
    
    
    NSString *str3 = [NSString stringWithFormat:@"Acc%d", Value1];
    [defaults setObject:Acc forKey:str3];
    
    
    NSString *str4 = [NSString stringWithFormat:@"Hash%d", Value1];
    [defaults setObject:Hash forKey:str4];
    
    
    
    
    [defaults synchronize];
    
}


-(void)SaveNewData:(NSString*)Name:(NSString*)Phone:(NSString*)Acc:(NSString*)Hash
{
    int Value1 =1;   
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    Value1 = [defaults integerForKey:@"totalcount"];
   
    int Szlen = [UserData count];
    
    for(int j =0;j<Szlen;j++)
    {
        
       NSString *tmpstr = [UserData objectAtIndex:j];
        
        if( [tmpstr isEqualToString:Name]  )
        {
            NSLog(@"Have data");
            
            
            return;
        }
        
    }
    
    Value1++;
    
    NSString *str1 = [NSString stringWithFormat:@"Name%d", Value1];
    [defaults setObject:Name forKey:str1];
    
    NSString *str2 = [NSString stringWithFormat:@"Phone%d", Value1];
    [defaults setObject:Phone forKey:str2];
    [defaults setInteger:Value1 forKey:@"totalcount"];
    
    
    NSString *str3 = [NSString stringWithFormat:@"Acc%d", Value1];
    [defaults setObject:Acc forKey:str3];
    
    
    NSString *str4 = [NSString stringWithFormat:@"Hash%d", Value1];
    [defaults setObject:Hash forKey:str4];
    

    
    
    [defaults synchronize];
    
}





-(void) Remove_State:(int)NewState
{
    
    switch (NewState)
    {
        case IF_USERDATE:
           [ (UIView *)UserDateView removeFromSuperview];
            break;
            
            
        case IF_HIS:
            [(UIView *)MyHisView removeFromSuperview];

            break;
            
        case IF_ACT:
                
             [(UIView *)MyActView removeFromSuperview];
            
            break;
            
        case IF_EATSEL:
            [(UIView *)MyEatPickView removeFromSuperview];
            break;
            
        case IF_EATSHOW:
            [(UIView *)MyEatShowView removeFromSuperview];

            break;
            
        case IF_DATESHOW:
            [(UIView *)MyDateShowView removeFromSuperview];
             break;
            
        case IF_DATESEL:
            [(UIView *)MyDatePickerView removeFromSuperview];

            
            break;
            
        case IF_SHOWLSEL:
            
            [(UIView *)MySelView removeFromSuperview];
            break;
            
        case IF_USERSET:
            [(UIView *)UserSetView removeFromSuperview];
            break;
            
            
        case IF_SETTING:
            
            
            
            [(UIView *)MySetView removeFromSuperview];
            break;
            
        case IF_MAP:
            
            
            [(UIView *)MyMapView removeFromSuperview];
            
            break;
            
        case IF_SHOWLIST:
            [ListView setHidden:YES];
            break;
            
        default:
            break;
    }
}


-(bool)CheckTotal
{
    if([UserData count] <1)
    {
        return  true;
    }
    
    
    
    return false;
}


-(void)Del_User:(NSString *)UserName
{
    [self Ctl_LoadingView:true];
    
    int Szlen = [UserData count];
     NSLog(@"Del data");
    
    
    for(int j =0;j<Szlen;j++)
    {
        
        NSString *tmpstr = [UserData objectAtIndex:j];
        
        if( [tmpstr isEqualToString:UserName]  )
        {
            NSLog(@"Have data");
            
            DelName = [NSString stringWithFormat:@"%@", UserName];
            
            
            [self Send_DeleteUser:[AccData objectAtIndex:j]:[HashData objectAtIndex:j] ];
            
            /*
            
            
            NSUserDefaults* defaults;
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:0 forKey:@"totalcount"];
            [defaults synchronize];
            
            
            for (int z=0;z<Szlen; z++)
            {
                if(z == j)
                    continue;
                
                
                 NSLog(@"add one");
                
                
                [self SaveNewData2:[UserData objectAtIndex:z]: [PhoneData objectAtIndex:z]: [AccData objectAtIndex:z]: [HashData objectAtIndex:z]];

                              
                                   
            }
            
            
            [self LoadUserData];
            [self Set_SetView];

            
            
             [self Ctl_LoadingView:false];
             
             */
            
            return;
        }
        
    }

    [self Ctl_LoadingView:false];
    
}


//取得plist設定字串
-(NSString *)Get_DefineString:(NSString *)SetStr
{
    
    return [  Array_show objectForKey : SetStr  ];
    
       
    
    return @"";
}


-(void)Set_SetView
{
    
    [(MySetView *)MySetView Do_Init:self];
    
    for(int j =0;j<[UserData count];j++)
    {
        
        [(MySetView *)MySetView Insert_Data:[UserData objectAtIndex:j] ];
    }
}


-(void) Change_State:(int)NewState
{
    if( IF_State != NewState )
    {
        [self Remove_State:IF_State];
        
        TickCount =0;
        
        switch (NewState)
        {   
            case IF_USERDATE:
                
                
                [TitleName setText: [  Array_show objectForKey : TITLE_USERDATE  ]  ];
                 [self insertSubview:UserDateView atIndex:10];  
                break;
                
                
            case IF_USERSET:
                
                 [TitleName setText: [  Array_show objectForKey : TITLE_USERSET  ]  ];
                [self insertSubview:UserSetView atIndex:10];  
                break;
                
            case IF_HIS:
                [TitleName setText: [  Array_show objectForKey : TITLE_HIS  ] ];
                [self insertSubview:MyHisView atIndex:10];
                break;
                
            case IF_ACT:
                
                 [TitleName setText: [  Array_show objectForKey : TITLE_ACT  ] ];
                  [self insertSubview:MyActView atIndex:10];
                break;
                
                
            case IF_EATSEL:
                [self insertSubview:MyEatPickView atIndex:10];
                break;
                
            case IF_EATSHOW:
                [TitleName setText: [  Array_show objectForKey : TITLE_EATSEL  ] ];
                [self insertSubview:MyEatShowView atIndex:10];
                break;
                
            case IF_DATESHOW:
                [TitleName setText: [  Array_show objectForKey : TITLE_DATESEL ] ];
                 [self insertSubview:MyDateShowView atIndex:10];
                break;                
                
                
            case IF_DATESEL:
          //      [(MySelView *) MyDatePickerView Do_Init:self];
                [self insertSubview:MyDatePickerView atIndex:10];
                break;
                
            case IF_SHOWLSEL:
                [TitleName setText: [  Array_show objectForKey : TITLE_SHOWLSEL  ] ];
              
                
                [(MySelView *) MySelView Do_Init:self];
                [self insertSubview:MySelView atIndex:10];
                break;
                
                
            case IF_SHOWLIST:
                
                
                switch (ShowNum)
               {
                    case 1:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW1  ] ];
                        break;
                        
                    case 2:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW2  ] ];
                        break;
                        
                    case 3:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW3  ]]; 
                        break;
                    
                    case 4:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW4  ]];
                        break;
                }
                
                
                [ListView setHidden:NO];
                
                break;
                
            case IF_INDEX:
                
                Is_UserGet_Sw = false;
                
                 [TitleName setText: [  Array_show objectForKey : TITLE_INDEX  ] ];
                
                
                if( [ self CheckTotal ] == true)
                {
                    
                    [self Show_GoToSet];
                    
                }
                
                
                break;
                
                
            case IF_SETTING:
                [TitleName setText:@"設定"];
                 [(MySetView *)MySetView  Set_Go:NowUserNum];
                [self Set_SetView];
                
                
                [self insertSubview:MySetView atIndex:10];
                break;
                
            case IF_MAP:
                
                
                [TitleName setText: [  Array_show objectForKey : TITLE_MAP  ] ];

                [(MyMapView *)MyMapView Do_Init:self];
                [self insertSubview:MyMapView atIndex:10];
                break;
                
            default:
                break;
        }    
        
        IF_State = NewState;
    }
    
    
    
}



@end
