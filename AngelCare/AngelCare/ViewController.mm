//
//  ViewController.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MainClass.h"
#import <QRCodeReader.h>
#import "AppDelegate.h"

#define UserDate_Camera NSLocalizedStringFromTable(@"UserDate_Camera", INFOPLIST, nil)
#define UserDate_Photo NSLocalizedStringFromTable(@"UserDate_Photo", INFOPLIST, nil)
#define UserDate_Select NSLocalizedStringFromTable(@"UserDate_Select", INFOPLIST, nil)
#define UserDate_CANCEL NSLocalizedStringFromTable(@"ALERT_MESSAGE_Back", INFOPLIST, nil)
//20140324 刪除照片
#define UserDate_Delete NSLocalizedStringFromTable(@"Delete", INFOPLIST, nil)
@interface ViewController ()
{
    UIButton *button;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;

@end

@implementation ViewController
@synthesize token,popover;

float alph = 0.7;

NSURLConnection *Update_Connect;
NSMutableData *Update_tempData;    //下載時暫存用的記憶體
long long Update_expectedLength;        //檔案大小

NSURLConnection *Safe_Connect;
NSMutableData *Safe_tempData;    //下載時暫存用的記憶體
long long Safe_expectedLength;        //檔案大小

NSURLConnection *SafeLog_Connect;
NSMutableData *SafeLog_tempData;    //下載時暫存用的記憶體
long long SafeLog_expectedLength;        //檔案大小

NSURLConnection *System_Connect;
NSMutableData *System_tempData;    //下載時暫存用的記憶體
long long System_expectedLength;        //檔案大小

NSURLConnection *News_Connect;
NSMutableData *News_tempData;    //下載時暫存用的記憶體
long long News_expectedLength;        //檔案大小

NSURLConnection *Person_Connect;
NSMutableData *Person_tempData;    //下載時暫存用的記憶體
long long Person_expectedLength;        //檔案大小

NSURLConnection *SystemLog_Connect;
NSMutableData *SystemLog_tempData;    //下載時暫存用的記憶體
long long SystemLog_expectedLength;        //檔案大小

//目前無使用
-(void)Check_Mode
{
    
    [(MainClass *)self.view Check_Mode];
}

//推播點選 ～ 依據內容後轉變顯示幕
-(void)Go_SelectState:(int )SelValue
{
    [(MainClass *)self.view Go_State:SelValue];
    
}

-(void)GetToken
{
    LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    NSLog(@"token = %@",[login returnToken]);
}


//設定ios推播token
-(void)Do_MySetValue:(NSString *)NewString
{
    
    //    [(MainClass *)self.view Set_DToekn:NewString];
    token = NewString;
    NSLog(@"tokenissssss = %@",token);
}

-(void)changePushUser:(NSString *)name
{
    [(MainClass *)self.view push_changeUser:name];
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Receive_Notification_Comm:)
                                                 name:@"Receive_Notification_Comm"
                                               object:nil];
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    userAccount = [defaults objectForKey:@"userAccount"];
    userHash = [defaults objectForKey:@"userHash"];
    token = [defaults objectForKey:@"token"];
    
    [self ReloadUserAccAndPwd];
    [self slider_init];
    [self checkUser];
    [(MainClass *)self.view setDelegate:self];
    [self getNewsMsg:userAccount andPwd:userHash];
    [self getSafeAcc:userAccount andPwd:userHash];
    [self getSystemAcc:userAccount andPwd:userHash];
    [self getPersonAcc:userAccount andPwd:userHash];
    isQRcode = 0;
    safecount = 0;
    systemcount = 0;
    [(MainClass*)self.view setHiddenBack:YES];
}


// 收到推播訊息切換viewController
- (void)Receive_Notification_Comm:(NSNotification*)notify
{
    NSDictionary *userInfo = [notify object];
    NSLog(@"notify = %@",[userInfo objectForKey:@"loc-key"]);
    [self changePushUser:[[userInfo objectForKey:@"loc-args"] objectAtIndex:0]];

    NSLog(@"changePush user = %@", [[userInfo objectForKey:@"loc-args"] objectAtIndex:0]);

//    NSString *check1 = [NSString stringWithFormat:@"TURNOFF_BY_SELF"];//自行關閉電源
//    NSString *check2 = [NSString stringWithFormat:@"TURNOFF_BY_LOW_BATTERY"];
    NSString *check3 = [NSString stringWithFormat:@"EMERGENCY_SOS"];
//    NSString *check4 = [NSString stringWithFormat:@"EMERGENCY_GPS_SUCCESS"];
//    NSString *check5 = [NSString stringWithFormat:@"FALLDOWN_ACTIVATE"];
//    NSString *check6 = [NSString stringWithFormat:@"FALLDOWN_GPS_SUCCESS"];
//    NSString *check7 = [NSString stringWithFormat:@"VITAL_HIGH_BP"];
//    NSString *check8 = [NSString stringWithFormat:@"SMS_GPS_SUCCESS"];
//    NSString *check9 = [NSString stringWithFormat:@"VITAL_HIGH_BG"];
//    NSString *check10 = [NSString stringWithFormat:@"VITAL_HIGH_WT"];
//    NSString *check12 = [NSString stringWithFormat:@"SYSTEM_MESSAGE"];
//    NSString *check13 = [NSString stringWithFormat:@"DEVICE_LOWPOWER"];
//    NSString *check14 = [NSString stringWithFormat:@"NONMOVENT"];
//    NSString *check15 = [NSString stringWithFormat:@"GEOFENCE_OUT"];

    NSString *chk_nonmovent = @"NONMOVENT";
    //    NSString *chk_geoIn = @"GEOFENCE_IN";
    NSString *chk_geoOut = @"GEOFENCE_OUT";
    NSString *chk_AmberAlarm = @"AMBER_ALARM";

    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        //Do checking here.
        //        if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check1]   )
        //        {
        //            //        [ self Go_SelectState:1];
        //        }
        //        else if(  [[ userInfo objectForKey:@"loc-key"] isEqualToString:check2]   )
        //        {
        //            //        [ self Go_SelectState:2];
        //        }
        //        else if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check3]   )
        //        {
        //            [self getSafeAcc:userAccount andPwd:userHash];
        //            [ self Go_SelectState:3];
        //        }
        //        else if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check4]   )
        //        {
        //            [ self Go_SelectState:3];
        //        }
        //        else if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check5]   )
        //        {
        //            [ self Go_SelectState:5];
        //        }
        //        else if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check6]   )
        //        {
        //            [ self Go_SelectState:6];
        //        }
        //        else if(  [[userInfo objectForKey:@"loc-key"] isEqualToString:check7]   )
        //        {
        //            [ self Go_SelectState:4];
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check8]   )
        //        {
        //            [ self Go_SelectState:8];
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check9]   )
        //        {
        //            //        [ self Go_SelectState:9];
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check10]   )
        //        {
        //            //        [ self Go_SelectState:10];
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check12]   )
        //        {
        //            [self getSystemAcc:userAccount andPwd:userHash];
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check13]   )
        //        {
        //            //弱電推播
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check14]   )
        //        {
        //            //弱電推播
        //        }
        //        else if (  [[userInfo objectForKey:@"loc-key"] isEqualToString:check15]   )
        //        {
        //            //弱電推播
        //        }
        //        else{
        //
        //        }
        if([[userInfo objectForKey:@"loc-key"] isEqualToString:check3])
        {
            [self getSafeAcc:userAccount andPwd:userHash];
            [ self Go_SelectState:3];
        }
        else if([[userInfo objectForKey:@"loc-key"] isEqualToString:chk_nonmovent])
        {
            [ self Go_SelectState:205];
        }
        else if([[userInfo objectForKey:@"loc-key"] isEqualToString:chk_geoOut])
        {
            [ self Go_SelectState:206];
        }
        else if([[userInfo objectForKey:@"loc-key"] isEqualToString:chk_AmberAlarm])
        {
            [ self Go_SelectState:207];
        }
    }
}

- (void)ReloadUserAccAndPwd
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    userAccount = [defaults objectForKey:@"userAccount"];
    userHash = [defaults objectForKey:@"userHash"];
    token = [defaults objectForKey:@"token"];
}

//add by Bill slider init
-(void)slider_init
{
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
        UIViewController *under = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
        self.slidingViewController.underRightViewController = under;
        
    }
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//右側功能列表
- (IBAction)composeList:(id)sender
{
    [self ReloadUserAccAndPwd];
    [self.slidingViewController anchorTopViewTo:ECLeft];
    [self getUserAndUpdateAcc:userAccount andPwd:userHash andToken:token];
}

//取得使用者並更新
-(void)getUserAndUpdateAcc:(NSString *)acc andPwd:(NSString *)pwd andToken:(NSString *)tokens
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
    //    NSLog(tmpstr);
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    if(tokens.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=0&appid=%i",acc, hash,[arr objectAtIndex:0],[arr objectAtIndex:1],APPID];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@%%20%@&device=0&token=%@&appid=%i",acc, hash,[arr objectAtIndex:0],[arr objectAtIndex:1],token,APPID];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogin.html",INK_Url_1];
    
    
    NSLog(@"更新使用者資訊Api %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    
    
    
    Update_tempData = [NSMutableData alloc];
    Update_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//取得最新消息
-(void)getNewsMsg:(NSString *)acc andPwd:(NSString *)pwd
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/getMarquee.html",INK_Url_1];
    
    NSLog(@"跑馬燈Api %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    News_tempData = [NSMutableData alloc];
    News_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


//取得個人訊息
-(void)getPersonAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppGetPersonSMS.html",INK_Url_1];
    
    NSLog(@"個人訊息Api %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Person_tempData = [NSMutableData alloc];
    Person_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//取得安全訊息
-(void)getSafeAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    [safeCountImg removeFromSuperview];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&language=%@",acc, hash,dateString,NSLocalizedStringFromTable(@"LANGUAGE", INFOPLIST, nil)];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppGetMsgSafe.html",INK_Url_1];
    
    NSLog(@"安全訊息Api %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Safe_tempData = [[NSMutableData alloc] init];
    Safe_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}



//回寫安全訊息Log
-(void)setLogSafeAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&type=1",acc, hash,dateString];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppSetMsgReadTime.html",INK_Url_1];
    
    NSLog(@"安全訊息LogApi %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    SafeLog_tempData = [NSMutableData alloc];
    SafeLog_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}





//回寫系統訊息Log
-(void)setLogSystemAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&type=2",acc, hash,dateString];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppSetMsgReadTime.html",INK_Url_1];
    
    NSLog(@"系統訊息LogApi %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    SystemLog_tempData = [NSMutableData alloc];
    SystemLog_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//取得系統訊息
-(void)getSystemAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    [systemCountImg removeFromSuperview];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
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
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    
    //    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@",acc, hash,dateString];
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/getAopLog.html",INK_Url_1];
    
    NSLog(@"系統Api %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    System_tempData = [[NSMutableData alloc] init];
    System_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    NSLog(@"didReceiveData");
    
    if(connection == Update_Connect)
    {
        [Update_tempData appendData:incomingData];
    }else if (connection == Safe_Connect)
    {
        [Safe_tempData appendData:incomingData];
    }else if (connection == System_Connect)
    {
        [System_tempData appendData:incomingData];
    }else if (connection == News_Connect)
    {
        [News_tempData appendData:incomingData];
    }else if (connection == Person_Connect)
    {
        [Person_tempData appendData:incomingData];
    }else if (connection == SafeLog_Connect)
    {
        [SafeLog_tempData appendData:incomingData];
    }else if (connection == SystemLog_Connect)
    {
        [SystemLog_tempData appendData:incomingData];
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    
    NSLog(@"didReceiveResponse");
    
    //取得狀態
    if(connection == Update_Connect)
    {
        [Update_tempData setLength:0];
        Update_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }else if (connection ==Safe_Connect)
    {
        [Safe_tempData setLength:0];
        Safe_expectedLength = [aResponse expectedContentLength];//
    }else if (connection ==System_Connect)
    {
        [System_tempData setLength:0];
        System_expectedLength = [aResponse expectedContentLength];
    }else if (connection == News_Connect)
    {
        [News_tempData setLength:0];
        News_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Person_Connect)
    {
        [Person_tempData setLength:0];
        Person_expectedLength = [aResponse expectedContentLength];
    }else if (connection == SafeLog_Connect)
    {
        [SafeLog_tempData setLength:0];
        SafeLog_expectedLength = [aResponse expectedContentLength];
    }else if (connection == SystemLog_Connect)
    {
        [SystemLog_tempData setLength:0];
        System_expectedLength = [aResponse expectedContentLength];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    NSLog(@"connectionDidFinishLoading");
    
    if(connection == Update_Connect)
    {
        [self Update];
    }else if (connection == Safe_Connect)
    {
        [self SafeMessage];
    }else if (connection == System_Connect)
    {
        [self SystemMessage];
    }else if (connection == News_Connect)
    {
        [self NewsMessage];
    }else if (connection == Person_Connect)
    {
        [self PersonMessage];
    }else if (connection == SafeLog_Connect)
    {
        [self SafeLogMessage];
    }else if (connection == SystemLog_Connect)
    {
        [self SystemLogMessage];
    }
}


-(void)Update
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Update_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        //        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
        //        [self presentModalViewController:ViewController animated:YES];
        [self loadUserDic:[usersOne objectForKey:@"list"]];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}



//個人訊息
-(void)PersonMessage
{
    personcount = 0;
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Person_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        if (!personViewController) {
            personViewController = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        
        NSLog(@"data = %@",[usersOne objectForKey:@"data"]);
        
        personViewController.personArray = [usersOne objectForKey:@"data"];
        [personViewController reloadData];
        
        for (int i=0; i<[[usersOne objectForKey:@"data"] count]; i++)
        {
            int isread = [[[[usersOne objectForKey:@"data"] objectAtIndex:i] objectForKey:@"viewstatus"] integerValue];
            
            NSLog(@"isReadRead = %i",isread);
            
            
            if (isread == 1)
            {
                NSLog(@"isReadRead");
                personcount = personcount +1;
            }
        }
        
        NSLog(@"personcount = %i",personcount);
        
        if (personcount > 0) {
            
            int toLongSize = 0;
            
            if (personcount >9)
            {
                toLongSize = 5;
            }else
            {
                toLongSize = 4;
            }
            
            UIImage *readBg = [UIImage imageNamed:@"red_offline_icon.png"];
            
            UIImage *safeimg = [ViewController drawText:[NSString stringWithFormat:@"%i",personcount] inImage:readBg atPoint:CGPointMake(readBg.size.width/toLongSize, readBg.size.height/5)];
            
            
            personCountImg = [[UIImageView alloc] initWithImage:safeimg];
            personCountImg.frame = CGRectMake(170, 0, 30, 30);
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                personCountImg.frame = CGRectMake(445, 5, 40, 40);
            }
            
            [self.view addSubview:personCountImg];
        }
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}



//安全訊息
-(void)SafeMessage
{
    safecount = 0;
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Safe_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"SafeMessage users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        if (!safeViewController) {
            safeViewController = [[SafeViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        safeViewController.safeArray = [usersOne objectForKey:@"data"];
        [safeViewController reloadData];
        
        for (int i=0; i<[[usersOne objectForKey:@"data"] count]; i++)
        {
            NSString *readStr = [[[usersOne objectForKey:@"data"] objectAtIndex:i] objectForKey:@"read"];
            if ([readStr isEqualToString:@"1"])
            {
                safecount = safecount +1;
            }
        }
        
        if (safecount > 0) {
            
            int toLongSize = 0;
            
            if (systemcount >9)
            {
                toLongSize = 5;
            }else
            {
                toLongSize = 4;
            }
            
            UIImage *readBg = [UIImage imageNamed:@"red_offline_icon.png"];
            
            UIImage *safeimg = [ViewController drawText:[NSString stringWithFormat:@"%i",safecount] inImage:readBg atPoint:CGPointMake(readBg.size.width/toLongSize, readBg.size.height/5)];
            
            
            safeCountImg = [[UIImageView alloc] initWithImage:safeimg];
            
            safeCountImg.frame = CGRectMake(213, 0, 30, 30);
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                safeCountImg.frame = CGRectMake(572, 5, 40, 40);
            }
            
            
            
            
            [self.view addSubview:safeCountImg];
        }
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}


//安全Log回傳訊息
-(void)SafeLogMessage
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:SafeLog_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [self getSafeAcc:userAccount andPwd:userHash];
        NSLog(@"Send Log Successful");
    }else
    {
        //        NSString *str1 =[usersOne objectForKey:@"msg"];
        //        [CheckErrorCode Check_Error:str1 WithSender:self];
        //        NSLog(@"error happen");
    }
}

//安全Log回傳訊息
-(void)SystemLogMessage
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:SystemLog_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"Send Log Successful");
        [self getSystemAcc:userAccount andPwd:userHash];
        
    }else
    {
        //        NSString *str1 =[usersOne objectForKey:@"msg"];
        //        [CheckErrorCode Check_Error:str1 WithSender:self];
        //        NSLog(@"error happen");
    }
}

+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:30];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    //ios7 modify
    NSDictionary *attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName:[UIColor whiteColor]};
    [text drawWithRect:CGRectIntegral(rect) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    //    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//系統訊息
-(void)SystemMessage
{
    [self ReloadUserAccAndPwd];
    systemcount =0;
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:System_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        if (!systemViewController) {
            systemViewController = [[SystemViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        systemViewController.systemArray = [usersOne objectForKey:@"Data"];
        [systemViewController reloadData];
        
        
        
        for (int i=0; i<[[usersOne objectForKey:@"Data"] count]; i++)
        {
            if ([[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"read"])
            {
                NSString *readStr = [[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"read"];
                
                if ([readStr isEqualToString:@"1"])
                {
                    systemcount = systemcount +1;
                }
                
            }else
            {
                
                systemcount = systemcount +1;
            }
            
            
        }
        
        if (systemcount > 0) {
            UIImage *readBg = [UIImage imageNamed:@"red_offline_icon.png"];
            
            int toLongSize = 0;
            
            if (systemcount >9)
            {
                toLongSize = 5;
            }else
            {
                toLongSize = 4;
            }
            
            UIImage *safeimg = [ViewController drawText:[NSString stringWithFormat:@"%i",systemcount] inImage:readBg atPoint:CGPointMake(readBg.size.width/toLongSize, readBg.size.height/5)];
            
            
            systemCountImg = [[UIImageView alloc] initWithImage:safeimg];
            systemCountImg.frame = CGRectMake(255, 0, 30, 30);
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                systemCountImg.frame = CGRectMake(630, 5, 40, 40);
            }
            
            [self.view addSubview:systemCountImg];
        }
        
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}






//儲存所有佩戴者帳號
-(void)loadUserDic:(NSArray *)arr
{
    NSLog(@"%@",arr);
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    //清空所有佩戴者資料
    for (int i=0; i<[[defaults objectForKey:@"totalcount"] integerValue]; i++) {
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Acc%i",i+1]];
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Phone%i",i+1]];
        
    }
    [defaults synchronize];
    int accNum = 0;
    for (int i=0; i<[arr count]; i++) {
        //擋住使用者
        //        if ([[[arr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
        if ([[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType1] ||
            [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType2]
            )
        {
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
            accNum++;
        }
    }
    
    [defaults setInteger:accNum forKey:@"totalcount"];
    [defaults setInteger:0 forKey:@"MAP_TYPE"];
    [defaults setInteger:1 forKey:@"nowuser"];
    [defaults synchronize];
    
    NSLog(@"default = %@",[defaults objectForKey:@"Name1"]);
    [(MainClass *)self.view reloadAcc];
}



//個人訊息列表
- (IBAction)personList:(id)sender
{
    /*GA Start*/
    /*
     id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
     
     [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Main_Fragment"// Event category (required)
     action:@"Btn_Click"  // Event action (required)
     label:@"Click_Person_Info"          // Event label
     value:nil] build]];    // Event value
     [[GAI sharedInstance] dispatch];
     */
    /*GA End*/
    
    [self ReloadUserAccAndPwd];
    [personCountImg removeFromSuperview];
    //the controller we want to present as a popover
    [self getPersonAcc:userAccount andPwd:userHash];
    
    if (!personViewController) {
        personViewController = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    
    
    popover = [[FPPopoverController alloc] initWithViewController:personViewController];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    popover.contentSize = CGSizeMake(250, 400);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(300, 700);
    }
    
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
}

//安全訊息列表
- (IBAction)safeList:(id)sender
{
    /*GA Start*/
    /*
     id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
     
     [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Main_Fragment"// Event category (required)
     action:@"Btn_Click"  // Event action (required)
     label:@"Click_Safe_Info"          // Event label
     value:nil] build]];    // Event value
     [[GAI sharedInstance] dispatch];
     */
    /*GA End*/
    
    [self ReloadUserAccAndPwd];
    [safeCountImg removeFromSuperview];
    //寫Log回Server
    [self setLogSafeAcc:userAccount andPwd:userHash];
    
    Btnsender = sender;
    
    
    
    
    if (!safeViewController) {
        safeViewController = [[SafeViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    
    //the controller we want to present as a popover
    //    safeViewController = [[SafeViewController alloc] initWithStyle:UITableViewStylePlain];
    
    popover = [[FPPopoverController alloc] initWithViewController:safeViewController];
    
    [safeViewController Do_Init:self];
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    popover.contentSize = CGSizeMake(250, 400);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(300, 700);
    }
    
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
}

//系統訊息列表
- (IBAction)systemList:(id)sender {
    
    /*GA Start*/
    /*
     id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
     
     [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Main_Fragment"// Event category (required)
     action:@"Btn_Click"  // Event action (required)
     label:@"Click_System_Info"          // Event label
     value:nil] build]];    // Event value
     [[GAI sharedInstance] dispatch];
     */
    /*GA End*/
    
    [self ReloadUserAccAndPwd];
    //紅色數字消失
    [systemCountImg removeFromSuperview];
    //寫Log回Server
    [self setLogSystemAcc:userAccount andPwd:userHash];
    
    
    //the controller we want to present as a popover
//    if (!systemViewController) {
        systemViewController = [[SystemViewController alloc] initWithStyle:UITableViewStylePlain];
//    }
    
    
    popover = [[FPPopoverController alloc] initWithViewController:systemViewController];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    popover.contentSize = CGSizeMake(250, 400);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(300, 700);
    }
    
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];

}





- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

-(void)ShowSafe:(NSDictionary *)dic
{
    [popover dismissPopoverAnimated:YES];
    [(MainClass *)self.view Show_SafeMap:dic];
}

- (void)checkUser
{
    if( [(MainClass *)self.view CheckTotal] == YES)
    {
        [(MainClass *)self.view Show_GoToSet];
    }
}




//點擊照片
-(IBAction)cameraBtnClick:(id)sender
{
    NSLog(@"PersonCamera Click");
    AlbumViewController *album = [self.storyboard instantiateViewControllerWithIdentifier:@"Album"];
    [self.navigationController pushViewController:album animated:YES];
    
    /*
     //檢查相片來源是否可以使用
     if ([UIImagePickerController isSourceTypeAvailable:
     UIImagePickerControllerSourceTypePhotoLibrary])
     {
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
     
     //設定圖片來源為照相機
     picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
     //設定要顯示預設的相機界面
     //        picker.showsCameraControls = YES;
     [self presentViewController:picker animated:YES completion:nil];
     }
     */
    
    /*
     //可以使用相機
     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
     
     //設定圖片來源為照相機
     picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     //設定要顯示預設的相機界面
     //        picker.showsCameraControls = YES;
     [self presentViewController:picker animated:YES completion:nil];
     }
     */
    
}


//拍攝完成後按下使用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //for iOS7
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if (isQRcode == 0) {
        
        
        UIImage *cameraImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"info imageOrientation = %d",cameraImg.imageOrientation);
        NSLog(@"info = %@",info);
        
        UIImage *fixImg = [self fixrotation:cameraImg];
        
        //http://stackoverflow.com/questions/4565507/camera-image-changes-orientation
        
        
        /*
         if (cameraImg.imageOrientation != 6 && cameraImg.imageOrientation != 3) {
         CGImageRef cgImage = cameraImg.CGImage;
         cameraImg = [UIImage imageWithCGImage:cgImage scale:1
         orientation:UIImageOrientationRight];
         }
         */
        NSLog(@"info imageOrientation = %@",[cameraImg description]);
        /*//照片轉向
         CGImageRef cgImage = cameraImg.CGImage;
         UIImage* result = [UIImage imageWithCGImage:cgImage scale:1
         orientation:UIImageOrientationRight];
         
         NSLog(@"result = %d",result.imageOrientation);
         */
        /*
         AlbumViewController *album = [self.storyboard instantiateViewControllerWithIdentifier:@"Album"];
         [album setPhoto:cameraImg];
         [self.navigationController pushViewController:album animated:NO];
         */
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            if (upload_type == 0) {
                //            [(MainClass *)self.view uploadJPEGImage:fixImg];
                [self cropped_img:fixImg];
            }else if (upload_type == 1)
            {
                //裁切為1:1
                [self cropped_img:fixImg];
                
            }else if (upload_type ==2)
            {
                [self cropped_img:fixImg];
            }
            
            
            
        }];
        
    }
    
    if (isQRcode == 1) {
        // 得到条形码结果
        /*
         id<NSFastEnumeration> results =
         [info objectForKey: ZBarReaderControllerResults];
         ZBarSymbol *symbol = nil;
         for(symbol in results)
         // EXAMPLE: just grab the first barcode
         break;
         
         //取得
         NSLog(@"symbol.data = %@",symbol.data);
         
         
         // 扫描界面退出
         [self dismissViewControllerAnimated:YES completion:^{
         [(MainClass *)self.view addAccByImei:symbol.data];
         }];
         */
    }
}





- (UIImage *)fixrotation:(UIImage *)image{
    
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


//裁切圖1:1
-(void)cropped_img:(UIImage *)image
{
    float imagewidth = 1200.0f;
    
    
    if (image.size.width > image.size.height)
    {
        imagewidth = image.size.height;
        if (imagewidth > 1200) {
            imagewidth = 1200.0f;
        }
        //取小邊
        
    }else
    {
        imagewidth = image.size.width;
        if (imagewidth > 1200) {
            imagewidth = 1200.0f;
        }
    }
    
    
    NSLog(@"new image width = %f",imagewidth);
    
    CGRect cropRect = CGRectMake(image.size.width/2 - imagewidth/2, image.size.height/2 - imagewidth/2, imagewidth, imagewidth);
    CGImageRef cropped_img = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    
    NSLog(@"cropRect x = %f y = %f width = %f height = %f",cropRect.origin.x,cropRect.origin.y,cropRect.size.width,cropRect.size.height);
    
    
    UIImage *newImg = [UIImage imageWithCGImage:cropped_img];
    
    if (upload_type == 1)
    {
        [(MainClass *)self.view uploadFamilyJPEGImage:newImg andType:upload_number];
    }
    else if (upload_type == 2)
    {
        [(MainClass *)self.view uploadShowImage:newImg andType:upload_number];
    }
    else if(upload_type == 0){
        [(MainClass *)self.view uploadJPEGImage:newImg];
    }
    
}


-(void)OpenCamera//UserDateView點選照片後開啓相簿
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UserDate_Select message:@"" delegate:self cancelButtonTitle:UserDate_CANCEL otherButtonTitles:UserDate_Photo,UserDate_Camera, nil];
    [alertView setTag:0];
    upload_type = 0;
    [alertView show];
}
//親情照片
-(void)OpenPersonCamera:(int)number
{
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UserDate_Select message:@"" delegate:self cancelButtonTitle:UserDate_CANCEL otherButtonTitles:UserDate_Photo,UserDate_Camera,UserDate_Delete, nil];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UserDate_Select message:@"" delegate:self cancelButtonTitle:UserDate_CANCEL otherButtonTitles:UserDate_Photo,UserDate_Camera, nil];
    [alertView setTag:1];
    upload_number = number;
    upload_type = 1;
    [alertView show];
}

//展示照片
-(void)OpenShowImageCamera:(int)number
{
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UserDate_Select message:@"" delegate:self cancelButtonTitle:UserDate_CANCEL otherButtonTitles:UserDate_Photo,UserDate_Camera,UserDate_Delete, nil];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UserDate_Select message:@"" delegate:self cancelButtonTitle:UserDate_CANCEL otherButtonTitles:UserDate_Photo,UserDate_Camera, nil];
    [alertView setTag:1];
    upload_number = number;
    upload_type = 2;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 888) {
        NSLog(@"%d",buttonIndex);
    }
    if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypePhotoLibrary])
        {
            /*GA Start*/
            /*
             id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
             [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Care_Info"// Event category (required)
             action:@"Btn_Click"  // Event action (required)
             label:@"Click_Edit_Self_Photo"          // Event label
             value:nil] build]];    // Event value
             [[GAI sharedInstance] dispatch];
             */
            /*GA End*/
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            //設定圖片來源為照相機
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            //設定要顯示預設的相機界面
            //        picker.showsCameraControls = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
    if (buttonIndex == 2) {
        /*GA Start*/
        /*
         id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
         [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Care_Info"// Event category (required)
         action:@"Btn_Click"  // Event action (required)
         label:@"Click_Edit_Self_Photo"          // Event label
         value:nil] build]];    // Event value
         [[GAI sharedInstance] dispatch];
         */
        /*GA End*/
        
        //可以使用相機
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            //設定圖片來源為照相機
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //設定要顯示預設的相機界面
            picker.showsCameraControls = YES;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
    if (buttonIndex == 3) {
        if (upload_type == 1) {
            NSLog(@"Delete 親情照片 idx %d",upload_number);
            NSNumber *idx = @(upload_number);
            [(MainClass *)self.view DeleteFamilyImage:userAccount AndHash:userHash AndIdx:idx];
        }
        else{
            NSLog(@"Delete 展示照片 idx %d",upload_number);
            NSNumber *idx = @(upload_number);
            [(MainClass *)self.view DeleteShowImage:userAccount AndHash:userHash AndIdx:idx];
        }
    }
}

//RightViewController Delegate
//重新取值
-(void)UpdateSetting
{
    NSLog(@"update ");
    //切換使用者時 判斷是否需要重新取值
    [(MainClass *)self.view Check_Http];
}

//QRCode新增
- (IBAction) scanButtonTapped
{
    isQRcode = 1;
    
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            //            [_bbitemStart setTitle:@"Stop"];
            //            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
        // The bar button item's title should change again.
        //        [_bbitemStart setTitle:@"Start!"];
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}


//最新消息解析
-(void)NewsMessage
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:News_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if([status isEqualToString:str1])
    {
        [(MainClass *)self.view NewsAnimate:[NSString stringWithFormat:@"%@",[usersOne objectForKey:@"Data"]]];
        //        NewsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 21)];
        //        NewsLbl.backgroundColor = [UIColor clearColor];
        //        [self NewsAnimateWithString:[NSString stringWithFormat:@"%@",[usersOne objectForKey:@"Data"]] AndLabel:NewsLbl];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");
    }
}

//執行跑馬燈動畫
-(void)NewsAnimateWithString:(NSString *)news AndLabel:(UILabel *)label
{
    //    [animateView addSubview:label];
    
}


-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self LoadAndChangeLogo];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate setViewController:self];
    
    
    
}

//下載並更換Logo
-(void)LoadAndChangeLogo
{
    //Definitions
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //Load Image From Directory
    UIImage * imageFromWeb = [self loadImage:@"ios_bar" ofType:@"png" inDirectory:documentsDirectoryPath];
    
    if (imageFromWeb)
    {
        img_bar.image = imageFromWeb;
    }else
    {
        img_bar.image = [UIImage imageNamed:@"logo.png"];
    }
    
}



//開起相簿不顯示 status bar
- (void)navigationController:(UINavigationController *)navigationController     willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    //    self.screenName = @"View_Main_Fragment";
    [super viewDidAppear:animated];
    
}

#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    //add back
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(removeLayer)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}
-(void)removeLayer{
    [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
    [button removeFromSuperview];
    
}

-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            //            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            //            [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            _isReading = NO;
            
            // If the audio player is not nil, then play the sound effect.
            //            if (_audioPlayer) {
            //                [_audioPlayer play];
            //            }
            //成功！call api
            NSLog(@"%@",[metadataObj stringValue]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                //                [self Send_AddMemberdataAcc:[metadataObj stringValue]];
                [self removeLayer];
                [(MainClass *)self.view addAccByImei:[metadataObj stringValue]];
            });
            
        }
    }
    
    
}

@end
