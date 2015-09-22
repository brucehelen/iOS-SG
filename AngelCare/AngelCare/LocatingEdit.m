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
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define s_time 10
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)Do_init:(id)sender{
    [self.nameTextField setText:self.nameString];
    
    
    
    [self.WIFIMACLabel setTextColor:[UIColor blackColor]];
    [self.WIFITitleLabel setTextColor:[UIColor blackColor]];
    self.WIFIMACLabel.text = @"取得MAC中...";
     
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER) {
//        //[self.locationManager requestWhenInUseAuthorization];
//        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    self.map.delegate = self;
    [self.map setShowsUserLocation:YES];
    [self.map setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [[self.saveButton layer] setCornerRadius:10]; // THIS IS THE RELEVANT LINE
    [self.saveButton.layer setMasksToBounds:YES]; ///missing in your code
    [self.saveButton setTitle:@"储存" forState:UIControlStateNormal];
    
    [self warningShow];
    
    MainObj = sender;
    [(MainClass *)MainObj Send_MapUserImei];//get phone data
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self.map setRegion:region animated:YES];
    
    CLLocation *location = [locations objectAtIndex:0];
//    NSLog(@"%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    [self findAddressUseLat:location.coordinate.latitude andLon:location.coordinate.longitude];
    g_gps_latlng = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
}

//hide keyboard
-(void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
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

- (void)findAddressUseLat:(double)lat andLon:(double)lon{
    NSLog(@"%@,findAddressUseLat ",self);
    
    BMKGeoCodeSearch *_searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, lon};
    
    pt = [self convertCoordinateToBaiDuWithLongitude:pt.longitude latitude:pt.latitude];
    
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    //    [reverseGeoCodeSearchOption release];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"正常结果 = %@",result.address);
        self.AddressTextField.text = result.address;
        [self.locationManager stopUpdatingLocation];
//        [currentAnn setTitle:result.address];
    }
    else {
        NSLog(@"抱歉，未找到结果");
        NSString *noRes = @"抱歉，未找到结果，请稍候重试";
//        [currentAnn setTitle:noRes];
        
    }
}


- (IBAction)ibaSave:(id)sender {
    if (self.WiFiMac.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"尚未取得的Wi-Fi mac，请稍等......" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
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

- (void)warningShow{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"需要发送简讯，以取得手表最后Wi-Fi资讯，此部分会有额外费用产生。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 1001;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1001) {
        //call api
        if (buttonIndex == 1) {
            [self sendMsg];
        }
        else{
            [self startCallAPI];
        }
    }
}
#pragma mark - SMS發送簡訊
- (void)sendMsg{
    //簡訊驗證碼
    
    
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
            
        }else{
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

- (void)startCallAPI{
    NSLog(@"startCallAPI 10s");
    myTimer = [NSTimer scheduledTimerWithTimeInterval:s_time target:self selector:@selector(callAPI) userInfo:nil repeats:YES];
}

- (void)callAPI{
    NSLog(@"callAPI");
    [(MainClass*)MainObj  getWiFi];
}

-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone
{
    imei = getimei;
    phone = _phone;
    
    
}

- (void)stopTimer{
    [myTimer invalidate];
    myTimer = nil;
}


@end
