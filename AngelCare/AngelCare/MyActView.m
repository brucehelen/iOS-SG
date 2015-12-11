//
//  MyActView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/10/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyActView.h"
#import "MainClass.h"
#import "Base64.h"
#import "KMLocationManager.h"

@interface MyActView()

@property (nonatomic, copy) NSString *globalLocation;

@end


@implementation MyActView
{
    MyAnnotation *currentAnn;
}

@synthesize swipeBar,barView,listDic;

NSMutableArray  *Array_timeDate;
NSMutableArray  *Array_locationDate;
NSMutableArray  *Array_longitudeDate;
NSMutableArray  *Array_latitudeDate;

NSMutableArray  *Array_electricityDate;
NSMutableArray  *Array_radiusDate;
NSMutableArray  *Array_Type;

int isGPS_GSM_WIFI;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y < 0)
    {
        [scrollView setContentOffset:CGPointZero
                            animated:NO];
    }
    else
    {
        if( scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height ) )
        {
            [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height - scrollView.frame.size.height)
                                animated:NO];   
        }  
    }
}

// ==== IOS MAP 基本設定
- (CLLocationCoordinate2D) convertCoordinateWithLongitude:(CLLocationDegrees)lng
                                                 latitude:(CLLocationDegrees)lat
{
    // bruce@20151127
    return CLLocationCoordinate2DMake(lat, lng);

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
    } else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"ISOCode"];
        isoCode = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",isoCode);

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

// for overlay
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay] ;
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

    if (mapType == 1) {
        circleView = [[BMKCircleView alloc] initWithOverlay:overlay] ;
    }

    if ((MKCircle *)overlay == leaveCircle)
    {
        NSLog(@"orange circle");
        circleView.strokeColor = [UIColor orangeColor];
        circleView.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
    } else {
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
    }

    circleView.lineWidth = 2;
    return circleView;
}

#pragma mark - 点击地图上图标显示出地址
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    int MyNum = 0;

    if ([view.annotation isKindOfClass:[MyAnnotation class]])
    {
        HaveAction_Sw = false;
        ShowCnt = 0;
        MyNum = [(MyAnnotation *)view.annotation  Get_ImageNum];
        [self ClearClricRemoveOrange:self];
        MyNum--;

        [self Set_Text:[Array_locationDate objectAtIndex:MyNum]
                      :[Array_electricityDate objectAtIndex:MyNum]
                      :SaveName
                      :[Array_timeDate objectAtIndex:MyNum]
                      :[Array_latitudeDate objectAtIndex:MyNum]
                      :[Array_longitudeDate objectAtIndex:MyNum]
                      :MyNum+1
                      :[Array_timeDate objectAtIndex:MyNum]];

        [self Set_Circle:[Array_longitudeDate objectAtIndex:MyNum]
                        :[Array_latitudeDate objectAtIndex:MyNum]
                        :[Array_radiusDate objectAtIndex:MyNum]];

        ShowWord = false;
        MyAnnotation *tmp = (MyAnnotation*)view.annotation;
        
        currentAnn.title = [Array_locationDate objectAtIndex:MyNum];
        NSLog(@"currentAnn.title = %@", currentAnn.title);
        if (tmp) {
            currentAnn = tmp;
        }
//        [self findAddressUseLat:[[Array_latitudeDate objectAtIndex:MyNum]doubleValue]
//                         andLon:[[Array_longitudeDate objectAtIndex:MyNum]doubleValue]
//                         andAnn:tmp];
    }
}

- (CLLocationCoordinate2D) convertCoordinateToBaiDuWithLongitude:(CLLocationDegrees)lng latitude:(CLLocationDegrees)lat
{
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

- (void)findAddressUseLat:(double)lat
                   andLon:(double)lon
                   andAnn:(MyAnnotation*)ann
{
    BMKGeoCodeSearch *_searcher = [[BMKGeoCodeSearch alloc] init];
    _searcher.delegate = self;

    __weak MyAnnotation *weakAnn = currentAnn;
    KMLocationManager *manger = [KMLocationManager locationManager];
    [manger startLocationWithLocation:[[CLLocation alloc] initWithLatitude:lat
                                                                 longitude:lon]
                          resultBlock:^(NSString *address) {
                              weakAnn.title = address;
                          }];

    if (ann) currentAnn = ann;
}

// 接收反向地理编码结果
- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                            result:(BMKReverseGeoCodeResult *)result
                         errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        currentAnn.title = result.address;
    }
}

//清除大頭針
- (void)ClearPoint : (id)sender
{
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray: map_view.annotations];
    //Remove the object userlocation
    [annotationsToRemove removeObject: map_view.userLocation];
    //Remove all annotations in the array from the mapView
    [map_view removeAnnotations: annotationsToRemove];
}


//清除範圍顯示圈
- (void)ClearClric:(id)sender
{
    NSMutableArray *overlaysToRemove = [[NSMutableArray alloc] initWithArray: map_view.overlays];

    NSLog(@"circle = %@",overlaysToRemove);

    [map_view removeOverlays:overlaysToRemove];
}

//清除範圍顯示圈
- (void)ClearClricRemoveOrange : (id)sender
{
    NSMutableArray *overlaysToRemove = [[NSMutableArray alloc] initWithArray: map_view.overlays];

    [overlaysToRemove removeObject:leaveCircle];

    NSLog(@"circle = %@",overlaysToRemove);

    [map_view removeOverlays:overlaysToRemove];
}

- (void)awakeFromNib
{
    TotalHei =0;
    
    Array_timeDate = [[NSMutableArray alloc] init];
    Array_timeDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_locationDate = [[NSMutableArray alloc] init];
    Array_locationDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_longitudeDate = [[NSMutableArray alloc] init];
    Array_longitudeDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_electricityDate = [[NSMutableArray alloc] init];
    Array_electricityDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_radiusDate = [[NSMutableArray alloc] init];
    Array_radiusDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_latitudeDate = [[NSMutableArray alloc] init];
    Array_latitudeDate = [NSMutableArray arrayWithCapacity:100];
    
    Array_Type = [[NSMutableArray alloc] init];
    Array_Type = [NSMutableArray arrayWithCapacity:100];

    tarNum = 0;

    MyTable.delegate = self;
    NeedInit = false;

    ShowWord = true;

    MyTable.delegate = self;
}

#pragma mark - 选择右边弹窗某一项
- (void)didselectCellNum:(int)number
{
    NSLog(@"didselectCellNum = %i", number);
    [self.swipeBar toggle];
    isList = NO;
    tarNum = number + 1;
    NeedInit = false;
    ShowWord = true;
    HaveAction_Sw = false;
    [self ClearPoint:self];
    [self ClearClricRemoveOrange:self];
    [self handleNewClickData];
}

//列表mousedown觸發
- (void)displayvalue:(id)sender
{
    UIButton *tmpBu = (UIButton *)sender;

    int DataNum = tmpBu.tag%100;

    NSLog(@"int dataNum = %i", DataNum);

    if( DataNum > 0)
    {
        isList = NO;
        tarNum = 0;
        NeedInit = false;
        ShowWord = true;
        HaveAction_Sw = true;

        [self ClearPoint:self];
        [self ClearClricRemoveOrange:self];

        StartNum = DataNum;

        ShowCnt = 4;

        [MyTable setHidden:YES];
        [map_view setHidden:NO];
              
        [MyTable setHidden:YES];
        [map_view setHidden:NO];

        [Bu_Map setEnabled:FALSE];
        [Bu_Map setBackgroundImage:[UIImage imageNamed:@"Act_Left_1.png"] forState:UIControlStateNormal];
        
        [Bu_List setEnabled:TRUE];
        [Bu_List setBackgroundImage:[UIImage imageNamed:@"Act_Right_2.png"] forState:UIControlStateNormal];
        
        [Bu_Right setHidden:NO];
        [Bu_Left setHidden:NO];
    }
}

// 新增列表顯示資料
- (void)Insert_Data :(NSString*)Value1
                    :(NSString*)Value2
                    :(NSString*)Value3
                    :(NSString*)Value4
                    :(NSString*)Value5
                    :(NSString*)Value6
                    :(NSString*)Value7
{
    [Array_timeDate addObject:Value1 ];
    [Array_locationDate addObject:Value2 ];
    [Array_longitudeDate addObject:Value3 ];
    [Array_electricityDate addObject:Value4 ];
    [Array_radiusDate addObject:Value5 ];
    [Array_latitudeDate addObject:Value6 ];
    [Array_Type addObject:Value7 ];

    NSString *deviceType = [UIDevice currentDevice].model;

    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {  
        UIImageView   *imageView =[ [UIImageView alloc] initWithFrame:CGRectMake(0, TotalHei, 307, 31) ];
        imageView.image = [UIImage imageNamed:@"actlist1.png"];
        imageView.tag = 7;
        [MyTable    addSubview:imageView];
        
        UILabel * label_1; //宣告一個UILabel ，命名為label_1
        
        label_1 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_1.frame = CGRectMake(5, TotalHei+7, 60/2, 30/2); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)

        NSString *AddText;

        int DataNum;

        DataNum = 1+ (TotalHei/31);

        AddText = [[NSString alloc] initWithFormat:@"%d.", DataNum];

        label_1.text = AddText; //設定label_1 的顯示文字
        //ios7 modify
        label_1.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_1 setBackgroundColor:[UIColor clearColor]];
        label_1.font = [UIFont systemFontOfSize:18];
        label_1.tag = 7;
        
        [MyTable addSubview:label_1]; //將label_1貼到self.view上
        
        
        UILabel * label_2; //宣告一個UILabel ，命名為label_1
        
        label_2 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_2.frame = CGRectMake(47, TotalHei+7, 250, 30/2); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)
        label_2.text = Value1; //設定label_1 的顯示文字
        //ios7 modify
        label_2.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_2 setBackgroundColor:[UIColor clearColor]];
        label_2.font = [UIFont systemFontOfSize:22];
        label_2.tag = 7;
        
        [MyTable addSubview:label_2]; //將label_1貼到self.view上
        
        
        UIButton *tmpButton;
        
        tmpButton = [[UIButton alloc ]init];
        tmpButton.frame = CGRectMake(0, TotalHei, 307, 31);
        tmpButton.backgroundColor = [UIColor clearColor];
        
        tmpButton.tag = 100+DataNum;

        [tmpButton addTarget:self  
                      action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside]; 

        [MyTable addSubview:tmpButton];

        TotalHei += 31;
    }
    else
    {
        UIImageView *imageView =[ [UIImageView alloc] initWithFrame:CGRectMake(0, TotalHei, 710, 68) ];
        imageView.image = [UIImage imageNamed:@"actlist1.png"];
        imageView.tag = 7;
        [MyTable    addSubview:imageView];
        
        UILabel * label_1; //宣告一個UILabel ，命名為label_1
        
        label_1 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_1.frame = CGRectMake(25, TotalHei+18, 60, 30); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)

        NSString *AddText;
        
        int DataNum;
        
        DataNum = 1+ (TotalHei/68);

        AddText = [[NSString alloc] initWithFormat:@"%d.",DataNum  ];

        label_1.text = AddText; //設定label_1 的顯示文字
        //ios7 modify
        label_1.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_1 setBackgroundColor:[UIColor clearColor]];
        label_1.font = [UIFont systemFontOfSize:24];
        label_1.tag = 7;

        [MyTable addSubview:label_1]; //將label_1貼到self.view上

        UILabel * label_2; //宣告一個UILabel ，命名為label_1

        label_2 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_2.frame = CGRectMake(96, TotalHei+18, 500, 30); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)
        label_2.text = Value1; //設定label_1 的顯示文字
        //ios7 modify
        label_2.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_2 setBackgroundColor:[UIColor clearColor]];
        label_2.font = [UIFont systemFontOfSize:28];
        label_2.tag = 7;
        
        [MyTable addSubview:label_2]; //將label_1貼到self.view上

        UIButton *tmpButton;

        tmpButton = [[UIButton alloc ]init];
        tmpButton.frame = CGRectMake(0, TotalHei, 710, 68);
        tmpButton.backgroundColor = [UIColor clearColor];

        tmpButton.tag = 100 + DataNum;

        [tmpButton addTarget:self
                      action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside]; 

        [MyTable addSubview:tmpButton];

        TotalHei += 68;
    }
}

//Ｇoogle Map 衛星模式按鈕Mousedown觸發
- (IBAction)Right_MouseDown:(id)sender
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    map_view.mapType = MKMapTypeSatellite;
    
    if (mapType == 1) {
        map_view.mapType = BMKMapTypeSatellite;
    }

    [Bu_Right setEnabled:false];
    [Bu_Left setEnabled:true];
}

// Google一般模式按鈕Mousedown觸發
- (IBAction)Left_MouseDown:(id)sender
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

    map_view.mapType = MKMapTypeStandard;

    if (mapType == 1) {
        map_view.mapType = BMKMapTypeStandard;
    }

    [Bu_Right setEnabled:true];
    [Bu_Left setEnabled:false];
}

// 設定地圖模式
- (void)MapMoushDown:(int)type
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

// 列表按鈕Mousedown觸發
- (IBAction)List_MouseDown:(id)sender
{
    isList = YES;

    [MyTable setHidden:NO];
    [map_view setHidden:YES];

    [Bu_Map setEnabled:TRUE];
    [Bu_Map setBackgroundImage:[UIImage imageNamed:@"Act_Left_2.png"] forState:UIControlStateNormal];
    [Bu_List setEnabled:FALSE];
    [Bu_List setBackgroundImage:[UIImage imageNamed:@"Act_Right_1.png"] forState:UIControlStateNormal];

    [Bu_Right setHidden:YES];
    [Bu_Left setHidden:YES];
}

//地圖按鈕Mousedown觸發
-(IBAction)Map_MouseDown:(id)sender
{
    isList = NO;
    
    [MyTable setHidden:YES];
    [map_view setHidden:NO];
    
    
    [Bu_Map setEnabled:FALSE];
    [Bu_Map setBackgroundImage:[UIImage imageNamed:@"Act_Left_1.png"] forState:UIControlStateNormal];
    [Bu_List setEnabled:TRUE];
    [Bu_List setBackgroundImage:[UIImage imageNamed:@"Act_Right_2.png"] forState:UIControlStateNormal];
    
    [Bu_Right setHidden:NO];
    [Bu_Left setHidden:NO];
}

- (void)Set_Init:(id)sender
{
    NSLog(@"list dic = %@",listDic);
     MainObj = sender;
    
    NeedInit = true;
    ShowWord = true;
    HaveAction_Sw = false;
    StartNum =0;
    ShowCnt =0;
    //
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    map_view.mapType = MKMapTypeStandard;
    
    if (mapType == 1) {
        map_view.mapType = BMKMapTypeStandard;
    }
    
     [Bu_Right setEnabled:true];
     [Bu_Left setEnabled:false];
    
    [Array_timeDate removeAllObjects ];
    [Array_locationDate removeAllObjects ];
    [Array_longitudeDate removeAllObjects ];
    [Array_electricityDate removeAllObjects ];
    [Array_radiusDate removeAllObjects ];
    [Array_latitudeDate removeAllObjects ];
     tarNum = 0;
    TotalHei =0;
    
    [self ClearPoint:self];
    [self ClearClric:self];
    
    
    for (UIView *subview in [MyTable subviews])
    {
        if (subview.tag == 7)
        {
            //         NSLog(@"get is %d", 1 );
            [subview removeFromSuperview];
        }
    }
    
    [barView removeFromSuperview];
    //側邊 List
    [self addRouteListView];
    //
    [MyTable setHidden:YES];
    [map_view setHidden:NO];
    
    [Bu_Map setEnabled:FALSE];
    [Bu_Map setBackgroundImage:[UIImage imageNamed:@"Act_Left_1.png"] forState:UIControlStateNormal];
    [Bu_List setEnabled:TRUE];
    [Bu_List setBackgroundImage:[UIImage imageNamed:@"Act_Right_2.png"] forState:UIControlStateNormal];

    [Bu_Map setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU1] forState:UIControlStateNormal];

    [Bu_List setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU2] forState:UIControlStateNormal];

    [Bu_Left setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU3] forState:UIControlStateNormal];

    [Bu_Right setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU4] forState:UIControlStateNormal];

    [Bu_Map setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU1] forState:UIControlStateDisabled];

    [Bu_List setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU2] forState:UIControlStateDisabled];

    [Bu_Left setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU3] forState:UIControlStateDisabled];

    [Bu_Right setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_MAP_BU4] forState:UIControlStateDisabled];

    [Bu_Right setHidden:NO];
    [Bu_Left setHidden:NO];

    self.tfEnd.delegate = self;
    self.tfStart.delegate = self;
}

#pragma mark - text
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    if (textField == self.tfStart) {
        datePicker.datePickerMode = UIDatePickerModeDate;
        [self.tfStart setInputView:datePicker];
        [self.tfStart setInputAccessoryView:self.accessoryView];
    }
    else if (textField == self.tfEnd){
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [self.tfEnd setInputView:datePicker];
        [self.tfEnd setInputAccessoryView:self.accessoryView];
    }
}

- (IBAction)doneEditing:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    if (self.tfStart.editing) {
        UIDatePicker *picker = (UIDatePicker*)self.tfStart.inputView;
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        self.tfStart.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:picker.date]];
        [self.tfStart resignFirstResponder];
    }

    if (self.tfEnd.editing) {
        UIDatePicker *picker = (UIDatePicker*)self.tfEnd.inputView;
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        self.tfEnd.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:picker.date]];
        [self.tfEnd resignFirstResponder];
    }
}


//設定下方顯示欄位
- (void)Set_Text:(NSString *)location
                :(NSString *)electricity
                :(NSString *)name
                :(NSString *)server_time
                :(NSString *)latitudeDate
                :(NSString *)longitudeDate
                :(int)DataNum
                :(NSString *)TimeData
{
    NSString *AddText;

    if (location.length != 0) {
        AddText = [[NSString alloc] initWithFormat:@"%d)%@\n%@ : %@%%\n%@ : %@\n ",
                   DataNum,
                   TimeData,
                   [(MainClass *) MainObj Get_DefineString:STR_ACT_ELECTRIC],
                   electricity,
                   [(MainClass *) MainObj Get_DefineString:STR_ACT_LOCATION],
                   location];
        [ShowText setText:AddText];
        
    } else {
        __weak MyActView *weakSelf = self;

        NSLog(@"--- Set_Text: [%f, %f]", [latitudeDate doubleValue], [longitudeDate doubleValue]);
        KMLocationManager *manger = [KMLocationManager locationManager];
        [manger startLocationWithLocation:[[CLLocation alloc] initWithLatitude:[latitudeDate doubleValue]
                                                                     longitude:[longitudeDate doubleValue]]
                              resultBlock:^(NSString *address) {
                                  [weakSelf updateShowTextContentWithAddress:address
                                                                     dataNum:DataNum
                                                                    TimeData:TimeData
                                                                 electricity:electricity];
                              }];

    }

    [ShowText setFont:[UIFont systemFontOfSize:16]];
    [ShowText setTextColor:[UIColor blackColor]];
}

- (void)updateShowTextContentWithAddress:(NSString *)address
                                 dataNum:(int)DataNum
                                TimeData:(NSString *)TimeData
                             electricity:(NSString *)electricity
{
    NSString *AddText;

    NSString *dealedAddress = address ? address : @"";

    AddText = [[NSString alloc] initWithFormat:@"%d)%@\n%@ : %@%%\n%@ : %@\n ",
               DataNum,
               TimeData,
               [(MainClass *) MainObj Get_DefineString:STR_ACT_ELECTRIC],
               electricity,
               [(MainClass *) MainObj Get_DefineString:STR_ACT_LOCATION],
               dealedAddress];

    [ShowText setText:AddText];
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

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

    int MyNum = 0;

    if([annotation isKindOfClass:[MyAnnotation class]]) {
        UIImage *tmpimage;
        
        MyNum = [(MyAnnotation *)annotation  Get_ImageNum ];
        
        NSString  *tmpfile;// =[NSString stringWithFormat:@"mapp%d", MyNum ];
        NSLog(@"%@",[Array_Type objectAtIndex:MyNum-1]);
        int tmpType = [[Array_Type objectAtIndex:MyNum-1] intValue];
        isGPS_GSM_WIFI = tmpType;
        if( tmpType == 0)
        {
            tmpfile =[NSString stringWithFormat:@"g-%d", MyNum ];
            tmpimage = [UIImage imageNamed:tmpfile ];
            if (!tmpimage) {
                tmpimage = [UIImage imageNamed:@"mapgreen"];
            }
        }
        else if( tmpType == 1)
        {
            tmpfile =[NSString stringWithFormat:@"b%d", MyNum ];
            tmpimage = [UIImage imageNamed:tmpfile ];
            if (!tmpimage) {
                tmpimage = [UIImage imageNamed:@"mapblue"];
            }
        }
        else if( tmpType == 2 || tmpType == 3)
        {
            tmpfile =[NSString stringWithFormat:@"mapp%d", MyNum ];
            tmpimage = [UIImage imageNamed:tmpfile ];
            if (!tmpimage) {
                tmpimage = [UIImage imageNamed:@"mapred"];
            }
        }

        CGImageRef imgRef = tmpimage.CGImage;
        CGFloat width = CGImageGetWidth(imgRef);
        CGFloat height = CGImageGetHeight(imgRef);

        CGSize bounds = CGSizeMake(width/2, height/2);    

        UIImage *tmpimage2 = [self reSizeImage:tmpimage toSize:bounds] ;   

        [pin setImage:tmpimage2];
        [(MyAnnotation *)annotation setTitle:@" "];
        pin.canShowCallout = YES;
    } else if ([annotation isKindOfClass:[LeaveAnno class]]) {
        UIImage *tmpimage = [UIImage imageNamed:@"pin_orange.png"];
        CGImageRef imgRef = tmpimage.CGImage;
        CGFloat width = CGImageGetWidth(imgRef);
        CGFloat height = CGImageGetHeight(imgRef);

        CGSize bounds = CGSizeMake(width/2, height/2);
        
        UIImage *tmpimage2 = [self reSizeImage:tmpimage toSize:bounds] ;

        [pin setImage:tmpimage2];
    }

    return pin;
}

- (void) mapView:(MKMapView *)aMapView didAddAnnotationViews:(NSArray *)views 
{
    for (MKAnnotationView *view in views) 
    {
         [[view superview] bringSubviewToFront:view];
    }
}

// 設定大頭針
- (void)Set_Point: (NSString *)longitude : (NSString *)latitude : (int)ImageNum
{
    CLLocationCoordinate2D NewPoint1;

    double v2= [latitude doubleValue];
    double v1= [longitude doubleValue];

    NSLog(@"in. lat:%@, lng:%@", latitude, longitude);

    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];
    NSLog(@"out. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);

    v1 = NewPoint1.longitude;
    v2 = NewPoint1.latitude;

    MyAnnotation * aaas3;
    aaas3 = [[MyAnnotation alloc] initWithCoordinate:NewPoint1:TRUE  ];
    [aaas3 Set_ImageNum:ImageNum];

    [map_view addAnnotation:aaas3];

    MKCoordinateRegion LastRo = map_view.region;

    if( fabs((LastRo.center.latitude-v2)) > LastRo.span.latitudeDelta/2 ) {
        MKCoordinateRegion kaos_digital;

        // 設定經緯度
        kaos_digital.center.longitude =v1 ;
        kaos_digital.center.latitude = v2;

        // 設定縮放比例
        kaos_digital.span.latitudeDelta = 0.020717;
        kaos_digital.span.longitudeDelta = 0.034793;

        // 把region設定給MapView
        [map_view setRegion:kaos_digital];
        map_view.delegate = self;
    }
    else
    {
        if( fabs( (LastRo.center.longitude-v1) ) > LastRo.span.longitudeDelta/2 )
        {
            MKCoordinateRegion kaos_digital;
            
            // 設定經緯度
            kaos_digital.center.longitude =v1 ;
            kaos_digital.center.latitude = v2;

            // 設定縮放比例
            kaos_digital.span.latitudeDelta = 0.020717;
            kaos_digital.span.longitudeDelta = 0.034793;

            // 把region設定給MapView
            [map_view setRegion:kaos_digital];
            map_view.delegate = self;
        }
    }
}


//設定離家警示大頭針
- (void)Set_LeavePointLng:(NSString *)longitude
                      Lat:(NSString *)latitude
                   ImgNum:(int)ImageNum
{
    CLLocationCoordinate2D NewPoint1;

    double v2= [latitude doubleValue] ;
    double v1= [longitude doubleValue] ;

    NSLog(@"in. lat:%@, lng:%@", latitude, longitude);

    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);
    
    NSLog(@"out. lat:%f, lng:%f", NewPoint1.latitude, NewPoint1.longitude);

    v1 = NewPoint1.longitude;
    v2 = NewPoint1.latitude;

    LeaveAnno * aaas3;
    aaas3 = [[LeaveAnno alloc] initWithCoordinate:NewPoint1:TRUE  ];
    [aaas3 Set_ImageNum:ImageNum];
    [map_view addAnnotation:aaas3];

    MKCoordinateRegion LastRo = map_view.region;

    if( fabs((LastRo.center.latitude-v2)) > LastRo.span.latitudeDelta/2 ) {
        MKCoordinateRegion kaos_digital;

        // 設定經緯度
        kaos_digital.center.longitude =v1 ;
        kaos_digital.center.latitude = v2;

        // 設定縮放比例
        kaos_digital.span.latitudeDelta = 0.020717;
        kaos_digital.span.longitudeDelta = 0.034793;

        // 把region設定給MapView
        [map_view setRegion:kaos_digital];
        map_view.delegate = self;
    }
    else
    {
        if( fabs( (LastRo.center.longitude-v1) ) > LastRo.span.longitudeDelta/2 )
        {
            MKCoordinateRegion kaos_digital;

            kaos_digital.center.longitude =v1 ;
            kaos_digital.center.latitude = v2;

            // 設定縮放比例
            kaos_digital.span.latitudeDelta = 0.020717;
            kaos_digital.span.longitudeDelta = 0.034793;

            //  // 把region設定給MapView
            [map_view setRegion:kaos_digital];
            map_view.delegate = self;
        }
    }
}

// 設定範圍顯示圈
- (void)Set_Circle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius
{
    CLLocationCoordinate2D NewPoint1;

    double v2= [latitude doubleValue] ;

    double v1=[longitude doubleValue] ;

    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];//CLLocationCoordinate2DMake(v2,v1);


    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

    MKCircle *circle = [MKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];

    if (mapType == 1) {
        circle = [BMKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];
    }

    [map_view addOverlay:circle];
}

// 設定離家範圍顯示圈
- (void)Set_LeaveCircle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius
{
    CLLocationCoordinate2D NewPoint1;
    
    double v2= [latitude doubleValue] ;
    
    double v1=[longitude doubleValue] ;

    NewPoint1= [self convertCoordinateWithLongitude:v1 latitude:v2];
    
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    leaveCircle = [MKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];

    if (mapType == 1) {
        leaveCircle = [BMKCircle circleWithCenterCoordinate:NewPoint1 radius:[radius doubleValue] ];
    }

    NSLog(@"add orange cicle %@",leaveCircle);
    
    [map_view addOverlay:leaveCircle];
}

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360
//size the mapView region to fit its annotations

- (void)MyzoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    return;
}

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    return;

    NSArray *annotations = mapView.annotations;
    int count = [mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations

    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);

    [mapView setRegion:region animated:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self zoomMapViewToFitAnnotations:map_view animated:animated];
}

- (void)Do_Init:(NSString*)Name
{
    if (isList) {
        [self List_MouseDown:self];
    } else {
        if(MainObj!= nil)
        {
            _stop = NO;
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
            [self insertSubview:googleMapView atIndex:2];
            map_view = googleMapView;
        }

        NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];

        map_view.mapType = MKMapTypeStandard;
        
        if (mapType == 1) {
            map_view.mapType = BMKMapTypeStandard;
        }

        SaveName = [NSString stringWithFormat:@"%@",Name];
        
        if (Array_timeDate.count > 0) {
            MKCoordinateRegion kaos_digital;

            // 設定經緯度
            kaos_digital.center.longitude =[[Array_longitudeDate objectAtIndex:Array_timeDate.count -1] doubleValue];
            kaos_digital.center.latitude = [ [Array_latitudeDate objectAtIndex:Array_timeDate.count -1] doubleValue];

            // 設定縮放比例
            kaos_digital.span.latitudeDelta = 0.020717;
            kaos_digital.span.longitudeDelta = 0.034793;
            
            // 把region設定給MapView
            [map_view setRegion:kaos_digital];    
            map_view.delegate = self;
        }

        CGRect  NewRect =  CGRectMake(0, 0, 307, TotalHei);

        MyTable.contentSize = NewRect.size;

        [self TimeProc];
    }

    [self insertSubview:lblGPS aboveSubview:map_view];
    [self insertSubview:lblWifi aboveSubview:map_view];
    [self insertSubview:lblGSM aboveSubview:map_view];
}

//時間timer 播放插針動畫
- (void)TimeProc
{
    if ( NeedInit == true) {
        NeedInit = false;
        tarNum = (int)[Array_latitudeDate count];

        if(tarNum > 22)
            tarNum = 22;
    }

    if (_stop) {
        [(MainClass *) MainObj displayTimerStop];
        return;
    }

    if( tarNum > 0 ) {
        int M_Cnt = tarNum - 1;

        [self ClearClricRemoveOrange:self];

        [self Set_Point:[Array_longitudeDate objectAtIndex:M_Cnt]
                       :[Array_latitudeDate objectAtIndex:M_Cnt]
                       :tarNum];

        if (ShowWord) {
            [self Set_Text:[Array_locationDate objectAtIndex:M_Cnt]
                          :[Array_electricityDate objectAtIndex:M_Cnt]
                          :SaveName
                          :[Array_timeDate objectAtIndex:M_Cnt]
                          :[Array_latitudeDate objectAtIndex:M_Cnt]
                          :[Array_longitudeDate objectAtIndex:M_Cnt]
                          :tarNum
                          :[Array_timeDate objectAtIndex:M_Cnt]];
        }

        [self Set_Circle:[Array_longitudeDate objectAtIndex:M_Cnt]
                        :[Array_latitudeDate objectAtIndex:M_Cnt]
                        :[Array_radiusDate objectAtIndex:M_Cnt]];

        tarNum --;
        [self viewWillAppear:false];
    } else {
        _stop = YES;
    }
}

- (void)handleNewClickData
{
    int M_Cnt = tarNum - 1;

    [self ClearClricRemoveOrange:self];

    [self Set_Point:[Array_longitudeDate objectAtIndex:M_Cnt]
                   :[Array_latitudeDate objectAtIndex:M_Cnt]
                   :tarNum];

    if (ShowWord) {
        [self Set_Text:[Array_locationDate objectAtIndex:M_Cnt]
                      :[Array_electricityDate objectAtIndex:M_Cnt]
                      :SaveName
                      :[Array_timeDate objectAtIndex:M_Cnt]
                      :[Array_latitudeDate objectAtIndex:M_Cnt]
                      :[Array_longitudeDate objectAtIndex:M_Cnt]
                      :tarNum
                      :[Array_timeDate objectAtIndex:M_Cnt]];
    }

    [self Set_Circle:[Array_longitudeDate objectAtIndex:M_Cnt]
                    :[Array_latitudeDate objectAtIndex:M_Cnt]
                    :[Array_radiusDate objectAtIndex:M_Cnt]];
}


#pragma mark 侧滑View
- (void)addRouteListView
{
    swipeBar = [[SwipeBar alloc] initWithMainView:self];

    [swipeBar setPadding:20.0f];
    [swipeBar setDelegate:self];

    NSLog(@"Frame %f %f %f %f",swipeBar.frame.origin.x,swipeBar.frame.origin.y,swipeBar.frame.size.width,swipeBar.frame.size.height);

    [self addSubview:[self swipeBar]];

    barView = [[[NSBundle mainBundle] loadNibNamed:@"RouteList" owner:self options:nil] lastObject];

    barView.routeListArr = [listDic objectForKey:@"time"];
    [barView setDelegate:self];
    [swipeBar setBarView:barView];
}

- (void)reloadRouteListView
{
    barView.routeListArr = [listDic objectForKey:@"time"];
    [barView.routeTable reloadData];
}

- (void)mainButtonWasPressed:(id)sender
{
    [self.swipeBar toggle];
}

- (IBAction)ibaOK:(id)sender
{

}

- (void)startEditTextView
{
    [self.tfStart becomeFirstResponder];
}

@end
