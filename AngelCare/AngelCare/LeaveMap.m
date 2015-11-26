//
//  LeaveMap.m
//  AngelCare
//
//  Created by macmini on 13/7/24.
//
//

#import "LeaveMap.h"
#import "MainClass.h"
@implementation LeaveMap

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
    
    [map_view removeFromSuperview];
    [addrTxt resignFirstResponder];
    [self ClearPoint:self];
    addrTxt.delegate = self;
    rangeArr = [self getRangeArr];
    if(MainObj!= nil)
    {
        if ( [(MainClass *) MainObj CheckGoogle] == false)
        {
//            baiduMapView = [[BMKMapView alloc] initWithFrame:map_view.frame];
//            //            map.delegate = (id<BMKMapViewDelegate>)self;
//            [self insertSubview:baiduMapView atIndex:2];
//            googleMapView.hidden = YES;
//            baiduMapView.hidden = NO;
//            map_view = baiduMapView;
//            NSLog(@"baiduMapXX:%@",map_view);
        }
        else{
//            baiduMapView.hidden = YES;
            googleMapView.hidden = NO;
            
            [self insertSubview:googleMapView atIndex:2];
            
            map_view = googleMapView;
            
            
            NSLog(@"googleMap:%@XX",map_view);
            
        }
    }
    else
    {
//        baiduMapView.hidden = YES;
        
        [self insertSubview:googleMapView atIndex:2];
        
        map_view = googleMapView;
        
        
        NSLog(@"googleMap:%@XX",map_view);
    }
}

-(void)Set_Init:(NSDictionary *)dic
{
    longitude = [dic objectForKey:@"longitude"];
    latitude = [dic objectForKey:@"latitude"];
    radius = [dic objectForKey:@"radius"];
    
    addressLbl.text = NSLocalizedStringFromTable(@"HS_Homeaddress", INFOPLIST, nil);
    
    rangeLbl.text = NSLocalizedStringFromTable(@"HS_Range", INFOPLIST, nil);
    
    [checkBtn setTitle:NSLocalizedStringFromTable(@"HS_Check", INFOPLIST, nil) forState:UIControlStateNormal];
    
    switch ([radius integerValue]) {
        case 50:
            selectNum = 0;
            break;
        case 100:
            selectNum = 1;
            break;
            
        case 150:
            selectNum = 2;
            break;
            
        case 200:
            selectNum = 3;
            break;
    }
    
    addr = [dic objectForKey:@"address"];
    [self Set_Circle:longitude:latitude:radius];
    addrTxt.text = [NSString stringWithFormat:@"%@",addr];
    //長按支援
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAct:)];
    longPress.minimumPressDuration = 1;
    [rangeBtn setTitle:[NSString stringWithFormat:@"%@M",radius] forState:UIControlStateNormal];
    [map_view addGestureRecognizer:longPress];
}




//長按加入座標
- (void)longPressAct:(UILongPressGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [recognizer locationInView:map_view];
        coordinate = [map_view convertPoint:touchPoint toCoordinateFromView:map_view];
        
        CLLocation *loaction = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        NSLog(@"long = %f lat = %f",coordinate.longitude,coordinate.latitude);
        
        longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        //經緯度座標轉地址
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:loaction completionHandler:^(NSArray *placemarks,NSError *error)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             /*
              for (CLPlacemark *placemark in placemarks) {
              
              NSLog(@"country %@",placemark.country);
              NSLog(@"administrativeArea %@",placemark.administrativeArea);
              NSLog(@"subAdministrativeArea %@",placemark.subAdministrativeArea);
              NSLog(@"locality %@",placemark.locality);
              NSLog(@"subLocality %@",placemark.subLocality);
              NSLog(@"addressDictionary %@",placemark.addressDictionary);
              NSLog(@"FormattedAddressLines %@",[placemark.addressDictionary objectForKey:@"FormattedAddressLines"]);
              NSLog(@"thoroughfare %@",placemark.thoroughfare);
              NSLog(@"subThoroughfare %@",placemark.subThoroughfare);
              NSLog(@"postalCode %@",placemark.postalCode);
              }
              */
             
             
             NSMutableArray *annotationsToRemove = [map_view.annotations mutableCopy];
             NSMutableArray *overlayToRemove = [map_view.overlays mutableCopy];
             [map_view removeAnnotations:annotationsToRemove];
             [map_view removeOverlays:overlayToRemove];
//             addrString = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] objectAtIndex:0];
             
             
             NSString *State = [placemark.addressDictionary objectForKey:@"State"];
             NSString *nameStr = [placemark.addressDictionary objectForKey:@"Name"];
             NSString *SubLocality = [placemark.addressDictionary objectForKey:@"SubLocality"];
    
             
             
             addrString = [NSString stringWithFormat:@"%@%@%@",State,SubLocality,nameStr];
             
             NSLog(@"addrstring = %@",placemark.addressDictionary);
//             [self addCoordinate:coordinate title:[NSString stringWithFormat:@"%@",[[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] objectAtIndex:0] ]radius:radius ToMap:map_view];
             
             [self Set_Circle:longitude :latitude :radius];
             addrTxt.text = [NSString stringWithFormat:@"%@",addrString];
         }];
        
        
    }
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


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay] ;
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    if (mapType == 1) {
//        circleView = [[BMKCircleView alloc] initWithOverlay:overlay] ;
    }
    
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    
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
        tmpimage = [UIImage imageNamed:@"mapred"];
        
        
        
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
-(void)Set_Point_ForAdd: (NSString *)longitudes :(NSString *)latitudes
{
    NSLog(@"here12345");
    CLLocationCoordinate2D NewPoint1;
    
    double v2= [latitudes doubleValue] ;
    double v1=[longitudes doubleValue] ;
    
    
    
    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);
    
    NSLog(@"test 2. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);
    
    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1 :TRUE  ];
    
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
    // NSLog(@"set %d",2);
    
    
    
}


//設定大頭針

-(void)Set_Point:(NSString *)longitudes :(NSString *)latitudes
{
    
    
    CLLocationCoordinate2D NewPoint1;
    
    double v2= [latitudes doubleValue] ;
    double v1=[longitudes doubleValue] ;
    
    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);
    
    
    
    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1:TRUE  ];
    
    [map_view addAnnotation:aaas3];
    
    
    
    
}


//設定範圍顯示圈
- (void)Set_Circle:(NSString *)longitudes :(NSString *)latitudes :(NSString *)aradius
{
    MKCoordinateRegion kaos_digital;

    NSLog(@"in. lat:%@, lng:%@", latitudes, longitudes);

    //設定經緯度
    CLLocationCoordinate2D newCoordinate = [self convertCoordinateWithLongitude:[longitudes doubleValue] latitude:[latitudes doubleValue]];
    
    NSLog(@"out. lat:%f, lng:%f", newCoordinate.latitude, newCoordinate.longitude);
    
    kaos_digital.center = newCoordinate;
    
    // 設定縮放比例
    kaos_digital.span.latitudeDelta = (0.018* [aradius doubleValue])/1118.00f ;
    kaos_digital.span.longitudeDelta =(0.018* [aradius doubleValue])/1118.00f ;

    // 把region設定給MapView
    [map_view setRegion:kaos_digital];
    map_view.delegate = self;

    CLLocationCoordinate2D NewPoint1 = newCoordinate;

    NSLog(@"set %f",[aradius doubleValue]);

    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:NewPoint1 radius:[aradius doubleValue] ];
    
    if (mapType == 1) {
        NSLog(@"BMKCircle");
    }
    
    [map_view addOverlay:circle];
    
    
    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1:FALSE  ];
    [map_view addAnnotation:aaas3];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frames = textField.frame;
    int offset = frames.origin.y + 32 - (self.frame.size.height - 300.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return = %@",textField);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (NSDictionary *)saveAddr
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude",radius,@"radius",addrString,@"address", nil];

    return dic;
}

- (IBAction)checkAddrString:(id)sender
{
    addrString = addrTxt.text;
    //地址轉經緯度座標
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addrString completionHandler:^(NSArray *placemarks,NSError *error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         NSLog(@"place = %f",placemark.location.coordinate.longitude);
         latitude = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
         longitude = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
     }];

    [self ClearPoint:self];
    [self Set_Circle:longitude :latitude :radius];
}


- (IBAction)changeRange:(id)sender
{
    NSLog(@"changeRange Click");

    UIActionSheet *changeRange = [[UIActionSheet alloc] initWithTitle:@"\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"確定", nil];

    UIPickerView *rangePicker = [[UIPickerView alloc] init];
    rangePicker.delegate = self;
    rangePicker.dataSource = self;
    rangePicker.showsSelectionIndicator = YES;
    [rangePicker selectRow:selectNum inComponent:0 animated:YES];

    [changeRange addSubview:rangePicker];

    [changeRange showInView:self];
}


#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@M",[rangeArr objectAtIndex:row]];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [rangeArr count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    selectNum = row;
    NSLog(@"selectNum %i",selectNum);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"select %i",buttonIndex);
        radius = [rangeArr objectAtIndex:selectNum];
        NSLog(@"button Index = %i",selectNum);
        [rangeBtn setTitle:[NSString stringWithFormat:@"%@M",radius] forState:UIControlStateNormal];
        [self ClearPoint:self];
        [self Set_Circle:longitude :latitude :radius ];
    }
}

- (NSArray *)getRangeArr
{
    NSArray *range = [[NSArray alloc] initWithObjects:@"50",@"100",@"150",@"200", nil];
    
    return range;
}


@end
