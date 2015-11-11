//
//  vcGeoFenceEdit.m
//  mCareWatch
//
//  Created by Roger on 2014/6/3.
//
//

#import "vcGeoFenceEdit.h"
#import "define.h"
#import "vcGeoInfo.h"


@interface vcGeoFenceEdit ()
{
    NSString *startStr;
    NSString *endStr;
    BOOL is1;
    BOOL is2;
    BOOL is3;
    BOOL is4;
    BOOL is5;
    BOOL is6;
    BOOL is7;
    NSMutableArray *pins;
    int pinIDX;
    MKPolygon *poly;
    NSString *name;
    
    NSMutableArray *pointA;
    
    MBProgressHUD *HUD;
    
    IBOutlet UIView *viewGeoInfo;
}

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation vcGeoFenceEdit

- (void)viewDidLoad
{
    [super viewDidLoad];

    UILongPressGestureRecognizer *longG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    longG.minimumPressDuration = 0.8;

    [_map addGestureRecognizer:longG];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    pinIDX = 0;
    pins = [NSMutableArray new];
    _barSearch.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    pointA = [NSMutableArray new];
}

- (IBAction)foundTap:(UILongPressGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)     {
        // handling code
        CGPoint point = [recognizer locationInView:_map];
        point.y = point.y + _map.frame.origin.y;
        CLLocationCoordinate2D tapPoint = [_map convertPoint:point toCoordinateFromView:self.view];
        
        MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
        
        [point1 setTitle:@"Click button to delete!"];
        
        point1.coordinate = tapPoint;
        
        [_map addAnnotation:point1];
        [pins addObject:point1];
        if ([pins count] >= 3) {
            [self drawPoly];
        }
    }
    else {

    }
}

- (void)drawPoly
{
    [_map removeOverlay:poly];
    //配置記憶體
    CLLocationCoordinate2D *commuterLotCoords = malloc([pins count] * sizeof(CLLocationCoordinate2D));
    for (int i = 0;  i < [pins count]; i ++) {
        MKPointAnnotation *view = [pins objectAtIndex:i];
        double lat = view.coordinate.latitude;
        double lon = view.coordinate.longitude;
        commuterLotCoords[i] = CLLocationCoordinate2DMake(lat , lon);
    }
    poly = [MKPolygon polygonWithCoordinates:commuterLotCoords count:[pins count]];
    [_map addOverlay:poly];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",[[[self.barSearch.subviews objectAtIndex:0] subviews] objectAtIndex:1]);
    UITextField *search = (UITextField *)[[[self.barSearch.subviews objectAtIndex:0] subviews] objectAtIndex:1];
    [search setBackgroundColor:[UIColor blackColor]];
    [search setTextColor:[UIColor whiteColor]];
    search.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor whiteColor]
                                                 }
     ];

    UIColor *BColor = [UIColor blackColor];
    UIColor *WColor = [UIColor whiteColor];
    [self.lblEndTime setTextColor:WColor];
    [self.lblName setTextColor:WColor];
    [self.lblStartTime setTextColor:WColor];
    [self.btn1 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn2 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn3 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn4 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn5 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn6 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btn7 setTitleColor:WColor forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:BColor forState:UIControlStateNormal];
    [self.btnSave setTitleColor:BColor forState:UIControlStateNormal];
    [self.btnReset setTitleColor:BColor forState:UIControlStateNormal];
    UIColor *bgColor = [UIColor colorWithRed:250/255.0 green:202/255.0 blue:37/255.0 alpha:1.0];
    [self.btnCancel setBackgroundColor:bgColor];
    [self.btnSave setBackgroundColor:bgColor];
    [self.btnReset setBackgroundColor:bgColor];
    

    is1 = NO;
    is2 = NO;
    is3 = NO;
    is4 = NO;
    is5 = NO;
    is6 = NO;
    is7 = NO;
    startStr = @"";
    endStr = @"";
    name = @"";
    [self setBgWithIs:is1 andSender:_btn1];
    [self setBgWithIs:is2 andSender:_btn2];
    [self setBgWithIs:is3 andSender:_btn3];
    [self setBgWithIs:is4 andSender:_btn4];
    [self setBgWithIs:is5 andSender:_btn5];
    [self setBgWithIs:is6 andSender:_btn6];
    [self setBgWithIs:is7 andSender:_btn7];

    CLLocationCoordinate2D coor;
    if ([pins count] == 0) {
        coor.latitude = 0;
        coor.longitude = 0;
        [_map setCenterCoordinate:coor];
    }
    else{
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        MKPointAnnotation *tmp = [pins firstObject];
        point.coordinate = tmp.coordinate;
        MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(coor, 1500, 1500)];
        [_map setRegion:adjustedRegion animated:YES];
    }

    if (self.dict) {
        NSLog(@"%@",self.dict);
        [self handleDict:self.dict];
        
    }
    else{
        
    }
    //設定網址
    NSURL *url = [NSURL URLWithString:@"http://210.242.50.122:9000/mcarewatch/Fence.html"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webInfo loadRequest:requestObj];
}

- (void)handleDict:(NSDictionary*)tmpD
{
    startStr = [tmpD objectForKey:@"fromtime"];
    [_btnStart setTitle:startStr forState:UIControlStateNormal];
    endStr = [tmpD objectForKey:@"totime"];
    [_btnEnd setTitle:endStr forState:UIControlStateNormal];
    name = [tmpD objectForKey:@"title"];
    _txtName.text = name;
    //set week
    NSString *week = [tmpD objectForKey:@"week"];
    week = [week stringByReplacingOccurrencesOfString:@"," withString:@""];
    for (int i = 0; i < week.length; i++) {
        int tmp = [[week substringWithRange:NSMakeRange(i, 1)]intValue];
        [self setWeek:tmp];
    }
    
    NSString *strPoints = [tmpD objectForKey:@"points"];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@"(" withString:@""];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *tmp = [strPoints componentsSeparatedByString:@","];
    for (int i = 0; i < [tmp count]/2; i++) {
        NSDictionary *tmpD = @{@"lat": [tmp objectAtIndex:i*2],@"lon": [tmp objectAtIndex:i*2+1]};
        [pointA addObject:tmpD];
    }
    if ([pointA count]>=3) {
        [self do_init];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setWeek:(int)which
{
    switch (which) {
        case 1:
            is1 = YES;
            [self setBgWithIs:is1 andSender:_btn1];
            break;
        case 2:
            is2 = YES;
            [self setBgWithIs:is2 andSender:_btn2];
            break;
        case 3:
            is3 = YES;
            [self setBgWithIs:is3 andSender:_btn3];
            break;
        case 4:
            is4 = YES;
            [self setBgWithIs:is4 andSender:_btn4];
            break;
        case 5:
            is5 = YES;
            [self setBgWithIs:is5 andSender:_btn5];
            break;
        case 6:
            is6 = YES;
            [self setBgWithIs:is6 andSender:_btn6];
            break;
        case 7:
            is7 = YES;
            [self setBgWithIs:is7 andSender:_btn7];
            break;
            
        default:
            break;
    }
}


- (IBAction)ibaSelectTime:(id)sender
{
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    } else {
        // use UIAlertView
        [self addActionSheetInView:sender];
    }
}

- (void)useAlerController:(id)sender
{
    // use UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil)
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
                                   [pickdate setDateFormat:@"HH:mm"];
                                   
                                   NSLog(@"pick[%d] = %@", (int)[(UIView *)sender tag], [pickdate stringFromDate:self.datePicker.date]);
                                   switch ([(UIView*)sender tag]) {
                                       case 301:
                                           startStr = [NSString stringWithFormat:@"%@:00",
                                                       [pickdate stringFromDate:self.datePicker.date]];
                                           [_btnStart setTitle:[pickdate stringFromDate:self.datePicker.date]
                                                      forState:UIControlStateNormal];
                                           break;
                                       case 302:
                                           endStr = [NSString stringWithFormat:@"%@:00",
                                                     [pickdate stringFromDate:self.datePicker.date]];
                                           [_btnEnd setTitle:[pickdate stringFromDate:self.datePicker.date] forState:UIControlStateNormal];
                                           break;
                                           
                                       default:
                                           break;
                                   }
                               }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];

    [alert.view addSubview:self.datePicker];

    [alert addAction:cancelAction];
    [alert addAction:okAction];

    [self presentViewController:alert animated:YES completion:nil];
}

-(void)addActionSheetInView:(id)sender
{
    //update by Bill 增加\r\n讓action sheet 時間不會被蓋掉
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Safezone time\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r" delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) , nil];
    sheet.tag = [(UIView*)sender tag];
    
    NSLog(@"start %@",[[(UIButton*)sender titleLabel] text]);
    
    [sheet addSubview:self.datePicker];
    [sheet showInView:self.view];
}

- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 300, 250)];
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }

    return _datePicker;
}

- (IBAction)ibaSelectWeek:(id)sender
{
    BOOL isDefault = NO;
    BOOL isTmp;
    switch ([(UIView*)sender tag]) {
        case Mon:
            is1 = !is1;
            isTmp = is1;
            break;
        case Tue:
            is2 = !is2;
            isTmp = is2;
            break;
        case Wed:
            is3 = !is3;
            isTmp = is3;
            break;
        case The:
            is4 = !is4;
            isTmp = is4;
            break;
        case Fri:
            is5 = !is5;
            isTmp = is5;
            break;
        case Sat:
            is6 = !is6;
            isTmp = is6;
            break;
        case Sun:
            is7 = !is7;
            isTmp = is7;
            break;
            
        default:
            isDefault = YES;
            break;
    }
    if (!isDefault) {
        [self setBgWithIs:isTmp andSender:sender];
    }
}

- (void) setBgWithIs:(BOOL)is andSender:(id)sender
{
    if (is) {
        [(UIButton*)sender setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
    }
    else{
        [(UIButton*)sender setBackgroundColor:[UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:1.0]];
    }
}

- (IBAction)ibaCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)ibaSave:(id)sender
{
    startStr = _btnStart.titleLabel.text;
    endStr = _btnEnd.titleLabel.text;
    name = _txtName.text;
    NSString *str1 = @"";
    NSString *str2 = @"";
    NSString *str3 = @"";
    NSString *str4 = @"";
    NSString *str5 = @"";
    NSString *str6 = @"";
    NSString *str7 = @"";
    
    str1 = is1?@"YES":@"NO";
    str2 = is2?@"YES":@"NO";
    str3 = is3?@"YES":@"NO";
    str4 = is4?@"YES":@"NO";
    str5 = is5?@"YES":@"NO";
    str6 = is6?@"YES":@"NO";
    str7 = is7?@"YES":@"NO";
    NSArray *arr = @[str1,str2,str3,str4,str5,str6,str7];
    NSString *resW = @"[";
    for (int i = 0; i < [arr count]; i ++) {
        if ([[arr objectAtIndex:i] isEqualToString:@"YES"]) {
            resW =[resW stringByAppendingString:[NSString stringWithFormat:@"%i,",i+1]];
        }
    }
    if (resW.length >1) {
        resW = [resW substringToIndex:resW.length-1];
    }
    resW = [resW stringByAppendingString:@"]"];
    
    
//    NSLog(@"*********************");
//    NSLog(@"start = %@",startStr);
//    NSLog(@"end = %@",endStr);
//    NSLog(@"resW = %@",resW);
//    NSLog(@"name = %@",name);
//    NSLog(@"*********************");
    NSMutableArray *coordD = [NSMutableArray new];
    NSString *resP = @"";
    for (int i = 0;  i < [pins count]; i++) {
        MKPointAnnotation *tmp = [pins objectAtIndex:i];
        [coordD addObject:@{@"lat": @(tmp.coordinate.latitude),
                            @"lon": @(tmp.coordinate.longitude)}];
        if (i != [pins count]-1) {
            resP = [resP stringByAppendingString:[NSString stringWithFormat:@"(%f,%f),",tmp.coordinate.latitude,tmp.coordinate.longitude]];
        }
        else{
            resP = [resP stringByAppendingString:[NSString stringWithFormat:@"(%f,%f)",tmp.coordinate.latitude,tmp.coordinate.longitude]];
        }
        
    }
//    NSLog(@"resp = %@",resP);
    NSDictionary *dict = @{@"fromtime": startStr,
                           @"totime": endStr,
                           @"title": name,
                           @"week": resW,
                           @"points": resP,
                           @"no": @(self.no+1)};
    NSLog(@"dict = %@",dict);
    
    if (_txtName.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder" message:@"Please name the Safezone you wish to create" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if([pins count] <3){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder" message:@"Three points minimum need to be connected to complete a Safezone" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        [self addloadingView];
        [(MainClass*)_mainObj Save_GEO_WithDict:dict withSender:self];
    }
}

#pragma mark - map delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonRenderer *view = [[MKPolygonRenderer alloc] initWithOverlay:overlay] ;
        view.lineWidth=1;
        view.strokeColor=[UIColor blueColor];
        view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
        return view;
    }
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:@"PinView"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40.0);
    [btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    pinView.rightCalloutAccessoryView = btn;
    [pinView.rightCalloutAccessoryView setFrame:CGRectMake(-10, 0, pinView.rightCalloutAccessoryView.frame.size.width, pinView.rightCalloutAccessoryView.frame.size.width)];
//    UIView *tmpV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [tmpV addSubview:btn];
//    [pinView addSubview:tmpV];
    //設定顏色
    pinView.pinColor = MKPinAnnotationColorRed;
    //    UIImage *image = [UIImage imageNamed:@"MapPin.png"];
    //    UIImageView  *imageView = [[UIImageView alloc] initWithImage:image];
    
    
    //重設圖片大小與座標
    //    imageView.frame = CGRectMake(0, 0, 30, 30);
    
    //設定註解內的圖片
    //    pinView.rightCalloutAccessoryView = imageView;
    
    
    //點擊時是否出現註解
    pinView.canShowCallout = YES;
    
    
    pinView.animatesDrop = YES;
    //是否可以被拖曳
    pinView.draggable = YES;
    
    return pinView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    for (int i = 0;  i < [pins count]; i++) {
        if (view.annotation == [pins objectAtIndex:i]) {
            [pins removeObjectAtIndex:i];
//            NSLog(@"%d", [pins count]);
        
            break;
        }
    }
    NSLog(@"%f,%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    NSLog(@"%d", [pins count]);
    [mapView removeAnnotation:view.annotation];
    //redraw
    [self drawPoly];
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [self drawPoly];
    }
}

#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
        [pickdate setDateFormat:@"HH:mm"];
        
        NSLog(@"pick = %@", [pickdate stringFromDate:self.datePicker.date]);
        switch ([actionSheet tag]) {
            case 301:
                startStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:self.datePicker.date]];
                [_btnStart setTitle:[pickdate stringFromDate:self.datePicker.date] forState:UIControlStateNormal];
                break;
            case 302:
                endStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:self.datePicker.date]];
                [_btnEnd setTitle:[pickdate stringFromDate:self.datePicker.date]
                         forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
    }
    NSLog(@"action sheet index %i",buttonIndex);
}

#pragma mark - 搜尋地址
-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:theSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude,
                                                                 placemark.location.coordinate.longitude);

        MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(coor, 500, 500)];
        [_map setRegion:adjustedRegion animated:YES];
    }];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"%@",view);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void) dismissKeyboard
{
    // add self
    [_barSearch resignFirstResponder];
}

- (void)do_init
{
    _map.delegate = self;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    NSDictionary *tmpD = [pointA objectAtIndex:0];
    coor.latitude = [[tmpD objectForKey:@"lat"]doubleValue];//25.040875;
    coor.longitude = [[tmpD objectForKey:@"lon"]doubleValue];
    
    point.coordinate = coor;

    MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(coor, 1500, 1500)];
    [_map setRegion:adjustedRegion animated:YES];
    //  // 把region設定給MapView

    [self makeData];
    //配置記憶體
    //    CLLocationCoordinate2D *commuterLotCoords = malloc([pointA count] * sizeof(CLLocationCoordinate2D));
    CLLocationCoordinate2D *commuterLotCoords = calloc([pointA count], sizeof(CLLocationCoordinate2D));
    
    for (int i = 0;  i < [pointA count]; i ++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        commuterLotCoords[i] = CLLocationCoordinate2DMake(lat , lon);
    }
    poly = [MKPolygon polygonWithCoordinates:commuterLotCoords count:[pointA count]];
    [_map addOverlay:poly];
}

- (void)makeData
{
    for (int i = 0;  i < pointA.count; i++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        [self doAddPinWithLat:lat andLon:lon ];
    }
}

- (void)doAddPinWithLat:(double)lat
                 andLon:(double)lon
{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lon;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    [point setTitle:@"Click button to delete!"];
    point.coordinate = coor;
    
    [_map addAnnotation:point];
    [pins addObject:point];
}

- (IBAction)ibaReset:(id)sender
{
    [_map removeAnnotations:_map.annotations];
    [_map removeOverlays:_map.overlays];
    [pointA removeAllObjects];
    [pins removeAllObjects];
}

-(void)addloadingView
{
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
    }
    
    //    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HUD show:YES];
}

-(void)closeLoading
{
    [HUD hide:YES];
}

- (IBAction)ibaHideWeb:(id)sender
{
    [_viewWeb setHidden:YES];
}

- (IBAction)ibaShowWeb:(id)sender
{
    [self.view addSubview:viewGeoInfo];
    [viewGeoInfo setFrame:CGRectMake(0, self.view.frame.size.height, viewGeoInfo.frame.size.width, viewGeoInfo.frame.size.height)];
    [UIView animateWithDuration:1 animations:^{
        [viewGeoInfo setFrame:CGRectMake(0, 0, viewGeoInfo.frame.size.width, viewGeoInfo.frame.size.height)];
    }];
}

- (IBAction)ibaBack:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        [viewGeoInfo setFrame:CGRectMake(0, self.view.frame.size.height, viewGeoInfo.frame.size.width, viewGeoInfo.frame.size.height)];
    } completion:^(BOOL finished) {
        [viewGeoInfo removeFromSuperview];
    }];
}


@end
