//
//  MyMapView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyMapView.h"
#import "MainClass.h"
#import "BMKMapView.h"
#import "Base64.h"
#import "ViewController.h"
#import "KMLocationManager.h"

@interface MyMapView()

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;

@end

@implementation MyMapView
{
    ViewController *vc;

    NSString *g_name;
    NSString *g_STR_MAP_IN;
    NSString *g_location;
    NSString *g_STR_MAP_WATCH;
    NSString *g_watch_time;
    NSString *g_STR_MAP_SERVER;
    NSString *g_server_time;
}

@synthesize privacyView,verificationText,GpsLocation,baiduMapView;

// ====   IOS MAP 基本設定
- (CLLocationCoordinate2D) convertCoordinateWithLongitude:(CLLocationDegrees)lng
                                                 latitude:(CLLocationDegrees)lat
{
    NSString *isoCode;
    if ([(MainClass *) MainObj CheckGoogle] == false) {
        NSURL *convertorURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.map.baidu.com/ag/coord/convert?from=2&to=4&x=%lf&y=%lf", lng, lat]];
        
        NSURLResponse *response;
        NSError *error;
        
        NSData *resultData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:convertorURL] returningResponse:&response error:&error];
        
        NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [resultString JSONValue];
        
        lng = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"x"]] encoding:NSUTF8StringEncoding] doubleValue];
        lat = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"y"]] encoding:NSUTF8StringEncoding] doubleValue];
    }
    else{//高德 偏移校準
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"ISOCode"]; //Add the file name
        isoCode = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"isoCode = %@",isoCode);
        //        NSString *isoCode = [defaults objectForKey:@"ISOCountryCode"];
        if ([isoCode isEqualToString:@"CN"]) {//中國
            NSURL *convertorURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.map.baidu.com/ag/coord/convert?from=0&to=2&x=%lf&y=%lf", lng, lat]];
            
            NSURLResponse *response;
            NSError *error;
            
            NSData *resultData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:convertorURL] returningResponse:&response error:&error];
            
            NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [resultString JSONValue];
            
            lng = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"x"]] encoding:NSUTF8StringEncoding] doubleValue];
            lat = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"y"]] encoding:NSUTF8StringEncoding] doubleValue];
        } else {
            NSLog(@"isoCode = %@",isoCode);
        }
    }

    return CLLocationCoordinate2DMake(lat, lng);
}


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    NSLog(@"init one");

    self = [super awakeAfterUsingCoder:aDecoder];    
    return self;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay] ;
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    if (mapType == 1) {
        circleView = [[BMKCircleView alloc] initWithOverlay:overlay] ;
    }
    if (isGPS_GSM_WIFI == 1) {//107 142 255
        circleView.strokeColor = [UIColor colorWithRed:107/255.0 green:142/255.0 blue:255/255.0 alpha:1];
        circleView.fillColor = [UIColor colorWithRed:107/255.0 green:142/255.0 blue:255/255.0 alpha:0.2];
    }
    else if(isGPS_GSM_WIFI == 2 || isGPS_GSM_WIFI == 3) {
        circleView.strokeColor = [UIColor redColor];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    }
    else{
        
    }

    circleView.lineWidth = 2;
    return circleView;
}

// for annoation
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation 
{
    MKAnnotationView *pin = (MKAnnotationView *) [map_view dequeueReusableAnnotationViewWithIdentifier: @"VoteSpotPin"];
    if (pin == nil)
    {
        pin = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"mapred"] ;
    }
    else
    {
        pin.annotation = annotation;
    }

    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        UIImage *tmpimage;

        if( isGPS_GSM_WIFI == 0)        // GPS
        {
            tmpimage = [UIImage imageNamed:@"mapgreen"];
        }
        else if( isGPS_GSM_WIFI == 1)   // WiFi
        {
            tmpimage = [UIImage imageNamed:@"mapblue"];
        }
        else if( isGPS_GSM_WIFI == 2 || isGPS_GSM_WIFI == 3)    // GSM
        {
            tmpimage = [UIImage imageNamed:@"mapp0"];
        }

        //圖形大小調整
        CGImageRef imgRef = tmpimage.CGImage;
        CGFloat width = CGImageGetWidth(imgRef);
        CGFloat height = CGImageGetHeight(imgRef);
        CGSize bounds = CGSizeMake(width/2, height/2);

        UIImage *tmpimage2 = [self reSizeImage:tmpimage toSize:bounds] ;   

        [pin setImage:tmpimage2];
        
        pin.canShowCallout = NO;

        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }

    return pin;
}

//===============================

//清除大頭針
- (void)ClearPoint : (id)sender
{
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray: map_view.annotations]; 
    //Remove the object userlocation
    [annotationsToRemove removeObject: map_view.userLocation]; 
    //Remove all annotations in the array from the mapView
    [map_view removeAnnotations: annotationsToRemove];
    NSMutableArray *overlaysToRemove = [[NSMutableArray alloc] initWithArray: map_view.overlays];
    [map_view removeOverlays:overlaysToRemove];
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

//設定大頭針（會改變中心點）
- (void)Set_Point_ForAdd: (NSString *)longitude :(NSString *)latitude
{
    NSLog(@"here12345");
    map_view.delegate = self;
    CLLocationCoordinate2D NewPoint1;

    double v2= [latitude doubleValue] ;
    double v1=[longitude doubleValue] ;
    
    [self findAddressUseLat:v2 andLon:v1];
    
    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];
    
    NSLog(@"test 2. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);
    
    MKCoordinateRegion kaos_digital;

    kaos_digital.center.longitude = NewPoint1.longitude;
    kaos_digital.center.latitude = NewPoint1.latitude;

    // 設定縮放比例
    kaos_digital.span.latitudeDelta = (0.018* 1000)/1118.00f ;
    kaos_digital.span.longitudeDelta =(0.018* 1000)/1118.00f ;

    [map_view setRegion:kaos_digital];    

    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1 :TRUE  ];

    [map_view addAnnotation:aaas3];
}

//設定大頭針
- (void)Set_Point:(NSString *)longitude :(NSString *)latitude
{
    CLLocationCoordinate2D NewPoint1;
    
    double v2 = [latitude doubleValue] ;
    double v1 = [longitude doubleValue] ;
    
    [self findAddressUseLat:v2 andLon:v1];
    
    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];

    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1:TRUE  ];

    [map_view addAnnotation:aaas3];
}


//設定範圍顯示圈
- (void)Set_Circle:(NSString *)longitude
                  :(NSString *)latitude
                  :(NSString *)radius
{
    MKCoordinateRegion kaos_digital;

    NSLog(@"in. lat:%@, lng:%@", latitude, longitude);

    //設定經緯度
    CLLocationCoordinate2D newCoordinate = [self convertCoordinateWithLongitude:[longitude doubleValue] latitude:[latitude doubleValue]];

    NSLog(@"out. lat:%f, lng:%f", newCoordinate.latitude, newCoordinate.longitude);

    // 如果地址为空，重新解析
    __weak MyMapView *weakSelf = self;
    if (g_location.length == 0) {
        KMLocationManager *manger = [KMLocationManager locationManager];
        [manger startLocationWithLocation:[[CLLocation alloc] initWithLatitude:newCoordinate.longitude
                                                                     longitude:newCoordinate.latitude]
                              resultBlock:^(NSString *address) {
                                  [weakSelf Set_Text:address
                                                andE:nil
                                                andN:g_name
                                               andST:g_server_time
                                               andWT:g_watch_time];
                              }];
    }

    [self findAddressUseLat:newCoordinate.latitude andLon:newCoordinate.longitude];

    kaos_digital.center = newCoordinate;
    
    // 設定縮放比例
    kaos_digital.span.latitudeDelta = (0.018* [radius doubleValue])/1118.00f ;
    kaos_digital.span.longitudeDelta =(0.018* [radius doubleValue])/1118.00f ;
    
    //  // 把region設定給MapView
    [map_view setRegion:kaos_digital];
    map_view.delegate = self;

    CLLocationCoordinate2D NewPoint1 = newCoordinate;

    NSLog(@"set %f",[radius doubleValue]);

    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

    MKCircle *circle = [MKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];

    if (mapType == 1) {
        NSLog(@"BMKCircle");
        circle = [BMKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];
    }

    [map_view addOverlay:circle];

    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1:FALSE  ];
    [map_view addAnnotation:aaas3];
}

//設定下方顯示欄位
- (void)Set_Text:(NSString *)location
            andE:(NSString *)event
            andN:(NSString *)name
           andST:(NSString *)server_time
           andWT:(NSString *)watch_time
{
    smsSendLbl.text = NSLocalizedStringFromTable(@"SMS_SEND", INFOPLIST, nil);
    NSString *AddText;

    g_name = name;
    g_STR_MAP_IN = [(MainClass *) MainObj Get_DefineString:STR_MAP_IN];
    g_location = location;
    g_STR_MAP_WATCH = [(MainClass *) MainObj Get_DefineString:STR_MAP_WATCH];
    g_watch_time = [watch_time substringWithRange:NSMakeRange(0, 16)];
    g_STR_MAP_SERVER = [(MainClass *) MainObj Get_DefineString:STR_MAP_SERVER];
    g_server_time = [server_time substringWithRange:NSMakeRange(0, 16)];

    event = nil;
    if (event == NULL) {
        AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@ : %@\n%@ : %@\n "
                   ,g_name
                   ,g_STR_MAP_IN
                   ,g_location
                   ,g_STR_MAP_WATCH
                   ,g_watch_time
                   ,g_STR_MAP_SERVER
                   ,g_server_time];
    } else {
        AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@\n%@ : %@\n%@ : %@\n ",
                   name,
                   [(MainClass *)MainObj Get_DefineString:STR_MAP_IN],
                   location,
                   event,
                   [(MainClass *) MainObj Get_DefineString:STR_MAP_WATCH],
                   [watch_time substringWithRange:NSMakeRange(0, 16)],
                   [(MainClass *) MainObj Get_DefineString:STR_MAP_SERVER],
                   [server_time substringWithRange:NSMakeRange(0, 16)]];
    }

    [ShowText setText:AddText];
    [ShowText setTextColor:[UIColor blackColor]];
}

///  初始化Ｖiew 上的設定
- (void)Do_Init:(id)sender
{
    MainObj = sender;

    smsSendLbl.text = NSLocalizedStringFromTable(@"SMS_SEND", INFOPLIST, nil);

    [map_view removeFromSuperview];

    if (MainObj != nil)
    {
        if ([(MainClass *) MainObj CheckGoogle] == false)
        {
            baiduMapView = [[BMKMapView alloc] initWithFrame:map_view.frame];
//            map.delegate = (id<BMKMapViewDelegate>)self;
            [self insertSubview:baiduMapView atIndex:2];
            googleMapView.hidden = YES;
            baiduMapView.hidden = NO;
            map_view = baiduMapView;
            NSLog(@"baiduMapXX:%@",map_view);
        }
        else{
            baiduMapView.hidden = YES;
            googleMapView.hidden = NO;
            
            [self insertSubview:googleMapView atIndex:2];
            
            map_view = googleMapView;

            NSLog(@"googleMap:%@XX",map_view);
        }
    }
    else
    {
        baiduMapView.hidden = YES;
        
        [self insertSubview:googleMapView atIndex:2];
        
        map_view = googleMapView;

        NSLog(@"googleMap:%@XX",map_view);
    }

    
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    
    map_view.mapType = MKMapTypeStandard;
    
    if (mapType == 1) {
        map_view.mapType = BMKMapTypeStandard;
    }

    [Bu_Right setEnabled:true];
    [Bu_Left setEnabled:false];
    
    [Bu_Left setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU3] forState:UIControlStateNormal];
    
    
    [Bu_Right setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU4] forState:UIControlStateNormal];
    [privacyTitleLbl setText:[(MainClass *)MainObj Get_DefineString:SMS_PRIVACY_TITLE]];
    
    [privacyContentLbl setText:[(MainClass *)MainObj Get_DefineString:SMS_PRIVACY_CONTENT] ];
    
    [privacyCode setText:[(MainClass *)MainObj Get_DefineString:SMS_PRIVACY_CODE]];
    
    
    [privacySubmitBtn setTitle:[(MainClass *)MainObj Get_DefineString:TITLE_MAP_BU5] forState:UIControlStateNormal];
    
    [privacyCancelBtn setTitle:[(MainClass *)MainObj Get_DefineString:TITLE_MAP_BU6] forState:UIControlStateNormal];
    [privacyView setHidden:YES];
    [backgroundBtn setHidden:YES];
}

//Google Map 衛星模式按鈕Mousedown觸發
-(IBAction)Right_MouseDown:(id)sender
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    map_view.mapType = MKMapTypeSatellite;
    
    if (mapType == 1) {
        map_view.mapType = BMKMapTypeSatellite;
    }
    
    [Bu_Right setEnabled:false];
    [Bu_Left setEnabled:true];
}

//Google一般模式按鈕Mousedown觸發
-(IBAction)Left_MouseDown:(id)sender
{
    
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    map_view.mapType = MKMapTypeStandard;
    
    if (mapType == 1) {
        map_view.mapType = BMKMapTypeStandard;
    }
    
    [Bu_Right setEnabled:true];
    [Bu_Left setEnabled:false];
}

//20130312 add by Bill sms簡訊啟動GPS Button
- (IBAction)smsBtnClick:(id)sender
{
    NSLog(@"smsBtnClick");

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:DUser]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }

    [(MainClass *)MainObj Send_MapUserImei];
}

BOOL keyboarshow;

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"begin edit");
    keyboarshow = YES;
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
    
    textFieldFrame = privacyView.frame;
    int offset = textFieldFrame.origin.y  - (privacyView.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = privacyView.frame.size.width;
    float height = privacyView.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(self.frame.size.width/2-privacyView.frame.size.width/2, -offset,width,height);
        privacyView.frame = rect;
    }
    [UIView commitAnimations];
    }
}


//20130312 add by Bill privacyBtn_submit
-(IBAction)privacyBtn_submit:(id)sender
{
    //簡訊驗證碼
    verificationText.text = @"1122";
    if(([MyMapView CheckInput:verificationText.text]) && ((verificationText.text.length >= 4) && (verificationText.text.length <= 8 )))
    {
        if (keyboarshow) {
            [self returnTextField];
        }
        NSLog(@"YES");
        if (phone.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"NOPHONENUMBER", INFOPLIST, nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else
        {
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
            //判斷裝置是否在可傳送訊息的狀態
            if([MFMessageComposeViewController canSendText]) {
                
                NSString *smsbody = [NSString stringWithFormat:@"#gPs#%@#%@#",imei,verificationText.text];
                //設定SMS訊息內容
                controller.body = smsbody;
                
                //設定接傳送對象的號碼
                controller.recipients = [NSArray arrayWithObjects:phone,nil];
                
                //設定代理
                controller.messageComposeDelegate = self;
                
                //開啟SMS訊息
                //            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:controller animated:YES];
                
                vc = (ViewController*)[[self nextResponder] nextResponder];
                NSLog(@"%@",[[self nextResponder] nextResponder]);
                [vc presentViewController:controller animated:YES completion:nil];
                
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:[(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_3] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:[(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_2] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void)readLocalData
{
    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"totalcount"];
    NSLog(@"value 1 = %i",Value1);
    NSMutableArray *UserData = [NSMutableArray array];
    NSMutableArray *PhoneData = [NSMutableArray array];
    NSMutableArray *AccData = [NSMutableArray array];
    NSMutableArray *HashData = [NSMutableArray array];
    
    for(int i=0;i<Value1;i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"Name%d", i+1];
        NSString *savedValue = [defaults   stringForKey:str1];
        NSLog(@"save value = %@",savedValue);
        [UserData addObject:savedValue];
        
        //        if(i==0)
        //        {
        //            [ShowName setText:savedValue];
        //        }
        
        
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
    
    NSLog(@"now user = %i ",NowUser);
}

//20130312 add by Bill privacyBtn_submit
-(IBAction)privacyBtn_cancel:(id)sender
{
    if (keyboarshow) {
        [self returnTextField];
    }
    privacyView.hidden = YES;
    backgroundBtn.hidden = YES;
}


//還原TextField高度與隱藏KeyBoard
-(void)returnTextField
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
    privacyView.frame = textFieldFrame;
    }
    [verificationText resignFirstResponder];
    keyboarshow = NO;
}

//檢查是否為四位數字
+ (BOOL)CheckInput:(NSString *)Number
{
    NSString *Regex = @"^\\d+$";
    NSPredicate *phone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [phone evaluateWithObject:Number];
}

//使用者完成操作時所呼叫的內建函式
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    NSString *alertString;
    UIAlertView *sendAlertView = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    switch (result) {
        case MessageComposeResultSent:
            //訊息傳送成功
            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            [sendAlertView setTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)];
            [sendAlertView setMessage:alertString];
            [sendAlertView show];
            privacyView.hidden = YES;
            break;

        case MessageComposeResultFailed:
            break;

        case MessageComposeResultCancelled:
            break;
            
        default:
            break;
    }

    [vc dismissViewControllerAnimated:YES completion:nil];
}



-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    NSLog(@"start receiveData");
    [Date_tempData appendData:incomingData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"FinishLoading");
    [self Http_Process_Date];
}

-(void)Http_Process_Date
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Date_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        imei = [usersOne objectForKey:@"imei"];
        phone = [usersOne objectForKey:@"phone"];
        
    } else
    {

    }
    
}

//20130312 add by Bill 按下背景Btn將privacyView與KeyBoard隱藏
-(IBAction)backgroundBtn:(id)sender
{
    if (keyboarshow) {
        [self returnTextField];
    }
    privacyView.hidden = YES;
    backgroundBtn.hidden = YES;
}

//20130315 add by Bill 更新Map地圖
-(IBAction)refreshBtnClick:(id)sender
{
    [(MainClass *)MainObj Check_Http];
}

-(void)setGpsLocation:(BOOL)gpsLocation
{
    GpsLocation = gpsLocation;
}



//設定地圖模式
-(void)MapMoushDown:(int)type
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    //判斷百度地圖或是GoogleMap
    if (mapType == 1) {
        //百度地圖
        //再判斷type類型為一般地圖或是衛星地圖
        if (map_view.mapType == BMKMapTypeStandard)
        {
            map_view.mapType = BMKMapTypeSatellite;//衛星地圖
        }else
        {
            map_view.mapType = BMKMapTypeStandard;
        }
    }else
    {
        //Google Map
        //再判斷type類型為一般地圖或是衛星地圖
        if (map_view.mapType == MKMapTypeStandard)
        {
            map_view.mapType = MKMapTypeSatellite;//衛星地圖
        }else
        {
            map_view.mapType = MKMapTypeStandard;
        }
    }
}

-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)phoneStr
{
    imei = getimei;
    phone = phoneStr;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tmp = [defaults objectForKey:@"SOSSendDontShowMSG"];
    if ([tmp isEqualToString:@"yes"]) {
        [self privacyBtn_submit:self];
    }
    else{
        UIAlertView *alert;
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"MsgSendAlertInfo", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles:NSLocalizedStringFromTable(@"DontShowAgain", INFOPLIST, nil), nil];
        alert.tag = 808;
        [alert show];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 808) {
        NSLog(@"button = %d",buttonIndex);
        if (buttonIndex == 1) {
            NSString *SOSSendDontShowMSG = @"yes";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:SOSSendDontShowMSG forKey:@"SOSSendDontShowMSG"];
        }
        [self privacyBtn_submit:self];
    }
}


- (void)setGPS_GSM_WIFI:(int)_GPS_GSM_WIFI
{
    isGPS_GSM_WIFI = _GPS_GSM_WIFI;
}

- (CLLocationCoordinate2D) convertCoordinateToBaiDuWithLongitude:(CLLocationDegrees) lng latitude:(CLLocationDegrees)lat{
    NSURL *convertorURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.map.baidu.com/ag/coord/convert?from=0&to=4&x=%lf&y=%lf", lng, lat]];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *resultData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:convertorURL] returningResponse:&response error:&error];
    
    NSString *resultString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    NSDictionary *result = [resultString JSONValue];
    
    lng = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"x"]] encoding:NSUTF8StringEncoding] doubleValue];
    lat = [[[NSString alloc] initWithData:[Base64 decode:[result objectForKey:@"y"]] encoding:NSUTF8StringEncoding] doubleValue];
    return CLLocationCoordinate2DMake(lat, lng);
}

- (void)findAddressUseLat:(double)lat andLon:(double)lon
{
    __weak MyMapView *weakSelf = self;

    self.lat = lat;
    self.lon = lon;

    KMLocationManager *locationManager = [KMLocationManager locationManager];
    [locationManager startLocationWithLocation:[[CLLocation alloc] initWithLatitude:lat
                                                                          longitude:lon]
                                   resultBlock:^(NSString *address) {
                                       [weakSelf updateTextFieldWithAddress:address];
                                   }];
}

#pragma mark - 导航
- (IBAction)navButtonDidClicked:(UIButton *)sender
{
    [self loadMapView];
}

- (void)loadMapView
{
    //目的地位置
    NSLog(@"开始导航，目的地：%f, %f", self.lat, self.lon);
    CLLocationCoordinate2D coords2 = CLLocationCoordinate2DMake(self.lat, self.lon);

    //当前的位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];

    //目的地的位置
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2
                                                                                       addressDictionary:nil]];
    
    toLocation.name = @"Destination";
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    // 打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

/// 更新地址信息
- (void)updateTextFieldWithAddress:(NSString *)address
{
    if (address) {
        NSString *AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@ : %@\n%@ : %@\n "
                             ,g_name
                             ,g_STR_MAP_IN
                             ,address
                             ,g_STR_MAP_WATCH
                             ,g_watch_time
                             ,g_STR_MAP_SERVER
                             ,g_server_time];
        
        [ShowText setText:AddText];
        [ShowText setTextColor:[UIColor blackColor]];
    } else {
        NSString *AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@ : %@\n%@ : %@\n "
                             ,g_name
                             ,g_STR_MAP_IN
                             ,@" "
                             ,g_STR_MAP_WATCH
                             ,g_watch_time
                             ,g_STR_MAP_SERVER
                             ,g_server_time];
        [ShowText setText:AddText];
        ShowText.textColor = [UIColor blackColor];
    }
}

//接收反向地理编码结果
- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                            result: (BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"正常结果 = %@",result.address);

        NSString *AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@ : %@\n%@ : %@\n "
                             ,g_name
                             ,g_STR_MAP_IN
                             ,result.address
                             ,g_STR_MAP_WATCH
                             ,g_watch_time
                             ,g_STR_MAP_SERVER
                             ,g_server_time];

        [ShowText setText:AddText];
        [ShowText setTextColor:[UIColor blackColor]];
    } else {
        NSLog(@"抱歉，未找到结果");
        NSString *AddText = [[NSString alloc] initWithFormat:@"%@ %@ %@\n%@ : %@\n%@ : %@\n "
                             ,g_name
                             ,g_STR_MAP_IN
                             ,@"抱歉，未找到结果，请稍候重试"
                             ,g_STR_MAP_WATCH
                             ,g_watch_time
                             ,g_STR_MAP_SERVER
                             ,g_server_time];
        [ShowText setText:AddText];
    }
}

@end
