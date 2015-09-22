//
//  SosMapView.m
//  AngelCare
//
//  Created by macmini on 13/8/28.
//
//

#import "SosMapView.h"
#import "MainClass.h"
@implementation SosMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
    dataDic = [[NSDictionary alloc] init];
    self.layer.borderWidth = 5.0f;
    self.layer.cornerRadius = 8.0f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = titleBg.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:166.0/255.0 green:164.0/255.0 blue:160.0/255.0 alpha:1] CGColor],(id)[[UIColor whiteColor] CGColor],  nil]; // 由上到下的漸層顏色
    [titleBg.layer insertSublayer:gradient atIndex:0];
    titleBg.layer.cornerRadius = 8.0f;
    titleBg.layer.masksToBounds = YES;
    
    titleLbl.text = NSLocalizedStringFromTable(@"SOS_MAPTITLE", INFOPLIST, nil);
    [self ClearPoint];
    
    if(MainObj!= nil)
    {
        if ( [(MainClass *) MainObj CheckGoogle] == false)
        {
            baiduMapView = [[BMKMapView alloc] initWithFrame:map_view.frame];
            //            map.delegate = (id<BMKMapViewDelegate>)self;
            
            map_view = baiduMapView;
            [self addSubview:baiduMapView];
            [googleMapView removeFromSuperview];
            NSLog(@"baiduMapXX:%@",map_view);
        }
        else{
            googleMapView = [[MKMapView alloc] initWithFrame:map_view.frame];
            map_view = googleMapView;
            [baiduMapView removeFromSuperview];
            [self addSubview:googleMapView];
            NSLog(@"googleMap:%@XX",map_view);
            
        }
    }
    else
    {
        baiduMapView.hidden = YES;
        
        map_view = googleMapView;
        
        
        NSLog(@"googleMap:%@XX",map_view);
    }
    
    
    [self bringSubviewToFront:lblGPS];
    [self bringSubviewToFront:lblWifi];
    [self bringSubviewToFront:lblGSM];

}

-(void)Set_Init:(NSDictionary *)dic
{
    dataDic = dic;
    isGPS_GSM_WIFI = [[dataDic objectForKey:@"location_type"]intValue];
    
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         self.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
    
}

- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         self.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}


- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         self.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
}

- (void)animationStoped
{
    NSString *latitudeStr = [dataDic objectForKey:@"latitude"];
    NSString *longitudeStr = [dataDic objectForKey:@"longitude"];
    NSString *placeStr = [dataDic objectForKey:@"place"];
    NSString *serverTime = [dataDic objectForKey:@"server_time"];
//    NSString *sourceAcc = [dataDic objectForKey:@"source_account"];
    NSString *titleStr = [dataDic objectForKey:@"title"];
//    NSString *radius = [dataDic objectForKey:@"station_radius"];
    NSString *radius = [NSString stringWithFormat:@"%d",[[dataDic objectForKey:@"station_radius"]intValue]];
//    int radius = [[dataDic objectForKey:@"station_radius"]intValue];
    [self Set_Point_ForAddLong:longitudeStr Lat:latitudeStr];
    
    if (radius.length >0) {
        [self Set_CircleLong:longitudeStr Lat:latitudeStr rad:radius];
    }
    
    //修正日期格式
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDateFormatter *dateFormatNew = [[NSDateFormatter alloc]init];
    [dateFormatNew setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *tmp = [dateFormat dateFromString:serverTime];
    serverTime = [dateFormatNew stringFromDate:tmp];
    infoTxt.text = [NSString stringWithFormat:@"回報時間:%@\r接近地點:%@\r",[dataDic objectForKey:@"server_time"],@""];
    [self findAddressUseLat:[latitudeStr doubleValue] andLon:[longitudeStr doubleValue]];
}


//關閉
-(IBAction)closeChangePwView:(id)sender
{
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];

    
    [self removeFromSuperview];
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
- (CLLocationCoordinate2D) convertCoordinateWithLongitude:(CLLocationDegrees) lng latitude:(CLLocationDegrees)lat{
    
    //    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
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
        //        isoGetter = [GetISOCountryCode new];
        //        [isoGetter startSignificantChangeUpdates];
        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"ISOCode"]; //Add the file name
        isoCode = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",isoCode);
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
        }
        else{
            NSLog(@"isoCode = %@",isoCode);
        }
        
    }
    return CLLocationCoordinate2DMake(lat, lng);
}



//設定大頭針（會改變中心點）
-(void)Set_Point_ForAddLong: (NSString *)longitude Lat:(NSString *)latitude
{
    NSLog(@"here12345");
    CLLocationCoordinate2D NewPoint1;
    
    double v2= [latitude doubleValue] ;
    double v1=[longitude doubleValue] ;
    
    
    
    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);
    
    NSLog(@"test 2. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);
    
    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1 :TRUE  ];
    
//    [map_view addAnnotation:aaas3];
    
    MKCoordinateRegion kaos_digital;
    
    //   // 設定經緯度
    kaos_digital.center.longitude = NewPoint1.longitude; //[longitude doubleValue];
    kaos_digital.center.latitude = NewPoint1.latitude;//[latitude doubleValue];
    
    
    
    
    // 設定縮放比例
    kaos_digital.span.latitudeDelta =map_view.region.span.latitudeDelta;
    kaos_digital.span.longitudeDelta = map_view.region.span.longitudeDelta;
    
    //  // 把region設定給MapView
    
    [map_view setRegion:kaos_digital];
    // NSLog(@"set %d",2);
    
}


//for overlay
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
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
    else if(isGPS_GSM_WIFI == 2 || isGPS_GSM_WIFI == 3){
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
    //   NSLog(@"viewForAnnotation");
    MKAnnotationView *pin = (MKAnnotationView *) [map_view dequeueReusableAnnotationViewWithIdentifier: @"VoteSpotPin"];
    if (pin == nil)
    {
        
        pin = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"mapred"] ;
    }
    else
    {
        pin.annotation = annotation;
    }
    
    
    if([annotation isKindOfClass:[MyAnnotation class]] )
    {
        UIImage *tmpimage ;
        
        //如果是ＧＰＳ就是綠色大頭針,不是就是紅色
        
        if( isGPS_GSM_WIFI == 0)
        {
            //            if (GpsLocation) {
            //                tmpimage = [UIImage imageNamed:@"mappurple"];
            //            }
            //            else
            //            {
            tmpimage = [UIImage imageNamed:@"mappurple"];
            //            }
        }
        else if( isGPS_GSM_WIFI == 1)
        {
            //                tmpimage = [UIImage imageNamed:@"mapred"];
            tmpimage = [UIImage imageNamed:@"mappurple"];
        }
        else if( isGPS_GSM_WIFI == 2 || isGPS_GSM_WIFI == 3)
        {
            tmpimage = [UIImage imageNamed:@"mappurple"];
        }
        else{
            
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
- (void)ClearPoint
{
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray: map_view.annotations];
    //Remove the object userlocation
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


//設定範圍顯示圈
-(void)Set_CircleLong:(NSString *)longitude Lat:(NSString *)latitude rad:(NSString *)radius
{
    
    MKCoordinateRegion kaos_digital;
    
    NSLog(@"in. lat:%@, lng:%@", latitude, longitude);
    
    //設定經緯度
    CLLocationCoordinate2D newCoordinate = [self convertCoordinateWithLongitude:[longitude doubleValue] latitude:[latitude doubleValue]];
    
    NSLog(@"out. lat:%f, lng:%f", newCoordinate.latitude, newCoordinate.longitude);
    
    kaos_digital.center = newCoordinate;
    
    // 設定縮放比例
    kaos_digital.span.latitudeDelta = (0.018* [radius doubleValue])/1118.00f ;
    kaos_digital.span.longitudeDelta =(0.018* [radius doubleValue])/1118.00f ;
    
    //  // 把region設定給MapView
    [map_view setRegion:kaos_digital];
    map_view.delegate = self;
    
    
    CLLocationCoordinate2D NewPoint1 = newCoordinate;
    
    //    double v2= [latitude doubleValue] ;
    //
    //    double v1=[longitude doubleValue] ;
    //
    //    NewPoint1=CLLocationCoordinate2DMake(v2,v1);
    //
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)findAddressUseLat:(double)lat andLon:(double)lon{
    NSLog(@"%@,findAddressUseLat ",self);
    
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
//        "His_TIME" = "时间";
//        "His_ADDR" = "约略地址";
        infoTxt.text = [NSString stringWithFormat:@"%@:\r%@\r%@:\r%@\r"
                        ,NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil),
                        [dataDic objectForKey:@"server_time"],
                        NSLocalizedStringFromTable(@"His_ADDR", INFOPLIST, nil),
                        result.address];
    }
    else {
        NSLog(@"抱歉，未找到结果");
        infoTxt.text = [NSString stringWithFormat:@"%@:\r%@\rNearest location:\r%@\r",@"Time reported",[dataDic objectForKey:@"server_time"],@"抱歉，未找到结果，请稍候重试"];
    }
}

@end
