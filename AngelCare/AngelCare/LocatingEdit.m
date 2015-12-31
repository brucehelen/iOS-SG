//
//  LocatingEdit.m
//  3GSW
//
//  Created by Roger on 2015/3/30.
//
//

#import "LocatingEdit.h"
#import "MainClass.h"
#import "ViewController.h"
#import "MainClass.h"
#import "KMLocationManager.h"
#import "KMCommonClass.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define s_time 10

@interface LocatingEdit()

@property (nonatomic, assign) CLLocation *currentLocation;

@end

@implementation LocatingEdit
{
    NSString *imei;
    NSString *phone;
    ViewController *vc;
    NSTimer *myTimer;
    id      MainObj;
    
    NSString *user;
    NSString *userHash;
    
    NSString *g_gps_latlng;
}

- (void)Do_init:(id)sender
{
    [self.nameTextField setText:self.nameString];

    self.nameTitleLabel.text = NSLocalizedStringFromTable(@"Position_TOP_name", INFOPLIST, nil);
    self.addressTitleLabel.text = NSLocalizedStringFromTable(@"Position_TOP_address", INFOPLIST, nil);

    [self.WIFIMACLabel setTextColor:[UIColor blackColor]];
    [self.WIFITitleLabel setTextColor:[UIColor blackColor]];
    self.WIFIMACLabel.text = NSLocalizedStringFromTable(@"Position_Get_Wifi_info", INFOPLIST, nil);

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    if(IS_OS_8_OR_LATER) {
        [self.locationManager startUpdatingLocation];
    }
    self.map.delegate = self;
    [self.map setShowsUserLocation:YES];
    [self.map setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    
    [[self.saveButton layer] setCornerRadius:10]; // THIS IS THE RELEVANT LINE
    [self.saveButton.layer setMasksToBounds:YES]; ///missing in your code
    [self.saveButton setTitle:NSLocalizedStringFromTable(@"Position_TOP_save", INFOPLIST, nil)
                     forState:UIControlStateNormal];

    self.WIFITitleLabel.text = [KMCommonClass getWifiName];
    NSString *macAddress = [[KMCommonClass getWifiMac] stringByReplacingOccurrencesOfString:@":"
                                                                                 withString:@""];
    self.WIFIMACLabel.text = [NSString stringWithFormat:@"WiFi MAC: %@", macAddress];
    self.WiFiMac = macAddress;

    //[self warningShow];

    MainObj = sender;
    [(MainClass *)MainObj Send_MapUserImei];//get phone data
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self.map setRegion:region animated:YES];

    self.currentLocation = [locations objectAtIndex:0];

    [self findAddressUseLat:self.currentLocation.coordinate.latitude
                     andLon:self.currentLocation.coordinate.longitude];
    g_gps_latlng = [NSString stringWithFormat:@"%f,%f",
                    self.currentLocation.coordinate.latitude,
                    self.currentLocation.coordinate.longitude];

    // 只需要定位一次即停止
    [manager stopUpdatingLocation];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    NSArray *subviews = [self subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}

- (CLLocationCoordinate2D) convertCoordinateToBaiDuWithLongitude:(CLLocationDegrees) lng
                                                        latitude:(CLLocationDegrees)lat
{
    // bruce@20151127
    return CLLocationCoordinate2DMake(lat, lng);

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
    // bruce@20151127
    return;

    __weak LocatingEdit *weakSelf = self;

    KMLocationManager *locationManager = [KMLocationManager locationManager];
    [locationManager startLocationWithLocation:[[CLLocation alloc] initWithLatitude:lat
                                                                          longitude:lon]
                                   resultBlock:^(NSString *address) {
                                       [weakSelf updateTextFieldWithAddress:address];
                                   }];
}

- (void)updateTextFieldWithAddress:(NSString *)address
{
    self.AddressTextField.text = address;
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"正常结果 = %@",result.address);
        self.AddressTextField.text = result.address;
        [self.locationManager stopUpdatingLocation];
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - 保存WiFi地址
- (IBAction)ibaSave:(id)sender
{
    if (self.WiFiMac.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Position_TIP_title", INFOPLIST, nil)
                                                        message:NSLocalizedStringFromTable(@"Position_Get_WiFi_result", INFOPLIST, nil)
                                                       delegate:self
                                              cancelButtonTitle:kLoadString(@"Position_TIP_CANCEL")
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }

    NSMutableDictionary *m_dict = [[NSMutableDictionary alloc]init];
    [m_dict setObject:self.g_no forKey:@"no"];
    [m_dict setObject:self.nameTextField.text forKey:@"name"];
    [m_dict setObject:self.WiFiMac forKey:@"mac"];
    [m_dict setObject:g_gps_latlng forKey:@"gps_latlng"];
    [m_dict setObject:self.AddressTextField.text forKey:@"address"];
    [(MainClass*)MainObj SetWiFiWithDict:m_dict];
}

- (void)warningShow
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Position_TIP_title", INFOPLIST, nil)
                                                    message:NSLocalizedStringFromTable(@"Position_TIP_message", INFOPLIST, nil)
                                                   delegate:self
                                          cancelButtonTitle:kLoadString(@"Position_TIP_CANCEL")
                                          otherButtonTitles:NSLocalizedStringFromTable(@"Position_TIP_OK", INFOPLIST, nil), nil];
    alert.tag = 1001;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        //call api
        if (buttonIndex == 1) {
            [self sendMsg];
        } else {
            [self startCallAPI];
        }
    }
}

#pragma mark - SMS發送簡訊
- (void)sendMsg
{
    //簡訊驗證碼
    if (phone.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)
                                                        message:NSLocalizedStringFromTable(@"NOPHONENUMBER", INFOPLIST, nil)
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
        //判斷裝置是否在可傳送訊息的狀態
        if([MFMessageComposeViewController canSendText]) {
//            #sYc#%@#%@#
            NSString *smsbody = [NSString stringWithFormat:@"#sYc#%@#%@#",imei,@"1122"];
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

        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:@"您的设备不支援简讯发送功能，无法发送SMS简讯。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//使用者完成操作時所呼叫的內建函式
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSString *alertString;
    UIAlertView *sendAlertView = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    switch (result) {
        case MessageComposeResultSent:
            //訊息傳送成功
            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            [sendAlertView setTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)];
            [sendAlertView setMessage:alertString];
            [sendAlertView show];
            
            //            privacyView.hidden = YES;
            break;
            
        case MessageComposeResultFailed:
            //訊息傳送失敗
            //            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            break;
            
        case MessageComposeResultCancelled:
            //訊息被使用者取消傳送
            //            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            
            break;
            
        default:
            break;
    }
    //ios7 modify
    [vc dismissViewControllerAnimated:YES completion:^{
        [self startCallAPI];
    }];
}

- (void)startCallAPI
{
    NSLog(@"startCallAPI 10s");
    myTimer = [NSTimer scheduledTimerWithTimeInterval:s_time
                                               target:self
                                             selector:@selector(callAPI)
                                             userInfo:nil
                                              repeats:YES];
}

- (void)callAPI
{
    NSLog(@"callAPI");
    [(MainClass*)MainObj  getWiFi];
}

- (void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone
{
    imei = getimei;
    phone = _phone;
}

- (void)stopTimer
{
    [myTimer invalidate];
    myTimer = nil;
}


@end
