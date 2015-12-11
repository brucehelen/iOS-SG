//
//  MyHisMapView.m
//  AngelCare
//
//  Created by macmini on 13/7/15.
//
//

#import "MyHisMapView.h"
#import "MainClass.h"
#import "KMLocationManager.h"

@implementation MyHisMapView
{
    NSMutableArray *pointA;
}

- (CLLocationCoordinate2D)convertCoordinateWithLongitude:(CLLocationDegrees)lng
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
    } else {//高德 偏移校準
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

- (void)Do_Init:(id)sender
{
    MainObj = sender;
    [self ClearPoint];

    if(MainObj!= nil) {
        [map_view removeFromSuperview];
        NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

        if (mapType == 1)
        {
            baiduMapView = [[BMKMapView alloc] initWithFrame:map_view.frame];
            //map.delegate = (id<BMKMapViewDelegate>)self;
            [self insertSubview:baiduMapView atIndex:2];
            googleMapView.hidden = YES;
            baiduMapView.hidden = NO;
            map_view = baiduMapView;
            NSLog(@"baiduMapXX:%@",map_view);
        } else {
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

        [self insertSubview:map_view atIndex:2];

        map_view = googleMapView;
        NSLog(@"googleMap:%@XX",map_view);
    }
}


//清除大頭針
- (void)ClearPoint
{
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray: map_view.annotations];
    
    NSLog(@"anntation = %@",annotationsToRemove);
    
    [annotationsToRemove removeObject: map_view.userLocation];
    [map_view removeAnnotations: annotationsToRemove];
    
    NSMutableArray *overlaysToRemove = [[NSMutableArray alloc] initWithArray: map_view.overlays];
    
    NSLog(@"overlaysToRemove = %@",overlaysToRemove);
    
    [map_view removeOverlays:overlaysToRemove];
}

- (void)Set_Init:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);

    mapDic = dic;
    pointA = [NSMutableArray new];

    //確定是否是電子圍籬的資料形態
    if ([mapDic objectForKey:@"geoResultType"]) {
        [self doGeoDo];
    } else {
        [self Set_Point_ForAddLng:[mapDic objectForKey:@"longitude"]
                              Lat:[mapDic objectForKey:@"latitude"]];
        [self Set_CircleLng:[mapDic objectForKey:@"longitude"]
                        Lat:[mapDic objectForKey:@"latitude"]
                     Radius:@"1096"];

        NSString *textStr = [NSString stringWithFormat:@"%@:%@\r\n%@:%@",@"時間",[mapDic objectForKey:@"datatime"],@"地點",@""];

        [self Set_textView:textStr];
        double lat = [[mapDic objectForKey:@"latitude"] doubleValue];
        double lon = [[mapDic objectForKey:@"longitude"]doubleValue];
        
        [self findAddressUseLat:lat andLon:lon];
    }
}

- (void)doGeoDo
{
    NSLog(@"doGeoDo %@",[self class]);
    NSString * strLType;
    strLType = [mapDic objectForKey:@"location_type"];
    double lat = 0.0;
    double lon = 0.0;
    
    if ([strLType isEqualToString:@"gps"]) {
        [self Set_Point_ForAddLng:[mapDic objectForKey:@"gps_lng"] Lat:[mapDic objectForKey:@"gps_lat"]];
        lat = [[mapDic objectForKey:@"gps_lat"] doubleValue];
        lon = [[mapDic objectForKey:@"gps_lng"]doubleValue];
        [self Set_CircleLng:[mapDic objectForKey:@"gps_lng"] Lat:[mapDic objectForKey:@"gps_lat"] Radius:@"1096"];
    }
    else if ([strLType isEqualToString:@"wifi"]) {
        [self Set_Point_ForAddLng:[mapDic objectForKey:@"wifi_lng"] Lat:[mapDic objectForKey:@"wifi_lat"]];
        lat = [[mapDic objectForKey:@"wifi_lat"] doubleValue];
        lon = [[mapDic objectForKey:@"wifi_lng"]doubleValue];
        [self Set_CircleLng:[mapDic objectForKey:@"wifi_lng"] Lat:[mapDic objectForKey:@"wifi_lat"] Radius:@"1096"];
    }

    NSString *createTime = [[NSString stringWithFormat:@"%@",[mapDic objectForKey:@"updateTime"]]substringToIndex:19];
    NSString *textStr = [NSString stringWithFormat:@"%@:%@\r\n%@:%@",@"時間",createTime,@"地點",@""];

    //處理points
    [self handlePoints];
    //Geo插標
    [self makeData];
    //配置記憶體
    CLLocationCoordinate2D *commuterLotCoords = calloc([pointA count], sizeof(CLLocationCoordinate2D));
    
    for (int i = 0;  i < [pointA count]; i ++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        commuterLotCoords[i] = CLLocationCoordinate2DMake(lat , lon);
    }
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:commuterLotCoords count:[pointA count]];
    [map_view addOverlay:poly];

    //show all annotations
    [map_view showAnnotations:map_view.annotations animated:YES];

    [self Set_textView:textStr];
    [self findAddressUseLat:lat andLon:lon];
}

- (void)handlePoints
{
    NSString *strPoints = [mapDic objectForKey:@"points"];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@"(" withString:@""];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray* foo = [strPoints componentsSeparatedByString: @","];
    int numOfPoints = [foo count]/2;
    if (numOfPoints) {
        for (int i = 0; i < numOfPoints; i++) {
            NSDictionary * dict = @{@"lat": [foo objectAtIndex:i*2],@"lon": [foo objectAtIndex:i*2+1]};
            [pointA addObject:dict];
        }
    }
    if (pointA) {
        NSLog(@"pointA %@",pointA);
    }
}

- (void)makeData
{
    for (int i = 0;  i < pointA.count; i++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        NSLog(@"%f,%f",lat,lon);
        [self doAddPinWithLat:lat andLon:lon ];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonRenderer *view = [[MKPolygonRenderer alloc] initWithOverlay:overlay] ;
        view.lineWidth=1;
        view.strokeColor=[UIColor blueColor];
        view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
        return view;
    }
    return nil;
}

- (void)doAddPinWithLat:(double)lat andLon:(double)lon
{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lon;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coor;
    [map_view addAnnotation:point];
}



//設定大頭針（會改變中心點）
- (void)Set_Point_ForAddLng: (NSString *)longitude Lat:(NSString *)latitude
{
    CLLocationCoordinate2D NewPoint1;

    double v2= [latitude doubleValue];
    double v1=[longitude doubleValue];

    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);
    
    NSLog(@"test 2. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);
    
    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1 :TRUE ];
    
    [map_view addAnnotation:aaas3];
    
    MKCoordinateRegion kaos_digital;
    
    //   // 設定經緯度
    kaos_digital.center.longitude = NewPoint1.longitude; //[longitude doubleValue];
    kaos_digital.center.latitude = NewPoint1.latitude;//[latitude doubleValue];

    // 設定縮放比例
    kaos_digital.span.latitudeDelta =map_view.region.span.latitudeDelta;
    kaos_digital.span.longitudeDelta = map_view.region.span.longitudeDelta;

    //  // 把region設定給MapView

    [map_view setRegion:kaos_digital];
}

//設定範圍顯示圈
- (void)Set_CircleLng:(NSString *)longitude
                  Lat:(NSString *)latitude
               Radius:(NSString *)radius
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

    [map_view setRegion:kaos_digital];
    map_view.delegate = self;

    CLLocationCoordinate2D NewPoint1 = newCoordinate;

    NSLog(@"set %f",[radius doubleValue]);

    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

    MKCircle *circle = [MKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];

    if (mapType == 1) {
        NSLog(@"BMKCircle");
        circle = [BMKCircle circleWithCenterCoordinate:NewPoint1
                                                radius:[radius doubleValue]];
    }

    [map_view addOverlay:circle];

    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1
                                                    :FALSE];
    [map_view addAnnotation:aaas3];
}

-(void)Set_textView:(NSString *)text
{
    noteTxt.text = text;
}

- (MKAnnotationView *) mapView:(MKMapView *) mapView
             viewForAnnotation:(id<MKAnnotation>) annotation
{
    MKAnnotationView *pin = (MKAnnotationView *) [map_view dequeueReusableAnnotationViewWithIdentifier: @"VoteSpotPin"];
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        return nil;
    }

    if (pin == nil) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                           reuseIdentifier:@"VoteSpotPin"] ;
    } else {
        pin.annotation = annotation;
    }

    if([annotation isKindOfClass:[MyAnnotation class]]) {
        UIImage *tmpimage;
        NSString *Ltype = [mapDic objectForKey:@"location_type"];
        if ([Ltype isEqualToString:@"0"]) {
            tmpimage = [UIImage imageNamed:@"mapgreen"];
        } else if ([Ltype isEqualToString:@"1"]){
            tmpimage = [UIImage imageNamed:@"mapblue"];
        } else {
            tmpimage = [UIImage imageNamed:@"mapred"];
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

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay] ;
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    if (mapType == 1) {
        circleView = [[BMKCircleView alloc] initWithOverlay:overlay] ;
    }
    
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    
    circleView.lineWidth = 2;
    return circleView;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (void)ChangeMapType
{
    [map_view removeFromSuperview];
    [self ClearPoint];

    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    if (mapType == 1)
    {
        baiduMapView = [[BMKMapView alloc] initWithFrame:map_view.frame];
        //map.delegate = (id<BMKMapViewDelegate>)self;
        [self insertSubview:baiduMapView atIndex:2];
        googleMapView.hidden = YES;
        baiduMapView.hidden = NO;
        map_view = baiduMapView;
        NSLog(@"baiduMapXX:%@",map_view);
    } else {
        baiduMapView.hidden = YES;
        googleMapView.hidden = NO;
        [self insertSubview:googleMapView atIndex:2];
        map_view = googleMapView;
        NSLog(@"googleMap:%@XX",map_view);
    }

    [self Set_Point_ForAddLng:[mapDic objectForKey:@"longitude"] Lat:[mapDic objectForKey:@"latitude"]];

    [self Set_CircleLng:[mapDic objectForKey:@"longitude"] Lat:[mapDic objectForKey:@"latitude"] Radius:@"1096"];
}

//設定地圖模式
- (void)MapMoushDown:(int)type
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    //判斷百度地圖或是GoogleMap
    if (mapType == 1) {
        //百度地圖
        //再判斷type類型為一般地圖或是衛星地圖
        if (type == 1) {//一般地圖
            map_view.mapType = BMKMapTypeStandard;
        }else
        {
            map_view.mapType = BMKMapTypeSatellite;//衛星地圖
        }
    }else
    {
        //Google Map
        //再判斷type類型為一般地圖或是衛星地圖
        if (type == 1) {
            map_view.mapType = MKMapTypeStandard;
        }else
        {
            map_view.mapType = MKMapTypeSatellite;
        }
    }
}

- (CLLocationCoordinate2D) convertCoordinateToBaiDuWithLongitude:(CLLocationDegrees)lng
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

    __weak MyHisMapView *weakSelf = self;

    KMLocationManager *manger = [KMLocationManager locationManager];
    [manger startLocationWithLocation:[[CLLocation alloc] initWithLatitude:lat
                                                                 longitude:lon]
                          resultBlock:^(NSString *address) {
                              if (address == nil) {
                                  NSLog(@"*** MyHisMapView address[%f, %f] == nil", lat, lon);
                              }

                              [weakSelf updateAddressLabelWithAddress:address];
                          }];
}

- (void)updateAddressLabelWithAddress:(NSString *)address
{
    NSString *dealedAddress = address ? address : @"";

    NSString *textStr = [NSString stringWithFormat:@"%@:%@\r\n%@:%@",
                         NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil),
                         [mapDic objectForKey:@"datatime"],
                         NSLocalizedStringFromTable(@"His_ADDR", INFOPLIST, nil),
                         dealedAddress];

    [self Set_textView:textStr];
}

//接收反向地理编码结果
- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                            result:(BMKReverseGeoCodeResult *)result
                         errorCode:(BMKSearchErrorCode)error
{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      NSLog(@"正常结果 = %@",result.address);
      NSString *textStr = [NSString stringWithFormat:@"%@:%@\r\n%@:%@",NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil),[mapDic objectForKey:@"datatime"],NSLocalizedStringFromTable(@"His_ADDR", INFOPLIST, nil),result.address];
      [self Set_textView:textStr];
  }
  else {
      NSLog(@"抱歉，未找到结果");
      NSString *noRes = @"抱歉，未找到结果，请稍候重试";
      NSString *textStr = [NSString stringWithFormat:@"%@:%@\r\n%@:%@",NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil),[mapDic objectForKey:@"datatime"],NSLocalizedStringFromTable(@"His_ADDR", INFOPLIST, nil),noRes];
      [self Set_textView:textStr];
  }
}

@end
