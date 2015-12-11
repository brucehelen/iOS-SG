//
//  MyActView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/10/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "LeaveAnno.h"
#import "BMapKit.h"

//swipeBar
#import "SwipeBar.h"
#import "RouteList.h"

@interface MyActView : UIView <MKMapViewDelegate,UITableViewDelegate,UIScrollViewDelegate,RouteListDelegate,SwipeBarDelegate,UITextFieldDelegate,BMKGeoCodeSearchDelegate>
{
    MKCircle *leaveCircle;

    IBOutlet MKMapView *map_view;

    BMKMapView *baiduMapView;
    IBOutlet MKMapView *googleMapView;
    IBOutlet UITextView *ShowText;

    int tarNum;
    BOOL ShowWord;

    NSString *SaveName;

    IBOutlet  UIButton *Bu_Map;
    IBOutlet  UIButton *Bu_List;

    IBOutlet  UIButton *Bu_Left;
    IBOutlet  UIButton *Bu_Right;

    IBOutlet  UIScrollView  *MyTable;

    int TotalHei;

    int ShowCnt;
    int StartNum;

    BOOL    HaveAction_Sw;
    BOOL    NeedInit;

    //parent View
    id MainObj;

    BOOL isList;

    IBOutlet UILabel *lblGPS;
    IBOutlet UILabel *lblWifi;
    IBOutlet UILabel *lblGSM;
}

@property (nonatomic,strong) NSDictionary *listDic;

//RouteList
@property (strong) SwipeBar *swipeBar;
@property (nonatomic,strong) RouteList *barView;

//for search
@property (strong, nonatomic) IBOutlet UITextField *tfStart;
@property (strong, nonatomic) IBOutlet UITextField *tfEnd;
@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (strong, nonatomic) IBOutlet UIToolbar *accessoryView;

- (IBAction)ibaOK:(id)sender;

- (void)startEditTextView;

//設定地圖模式
-(void)MapMoushDown:(int)type;

//Ｇoogle Map 衛星模式按鈕Mousedown觸發
-(IBAction)Right_MouseDown:(id)sender;
//Google一般模式按鈕Mousedown觸發
-(IBAction)Left_MouseDown:(id)sender;

//列表按鈕Mousedown觸發
-(IBAction)List_MouseDown:(id)sender;
//地圖按鈕Mousedown觸發
-(IBAction)Map_MouseDown:(id)sender;

//設定大頭針
-(void)Set_Point:(NSString *)longitude :(NSString *)latitude :(int)ImageNum;


//時間timer 播放插針動畫
-(void)TimeProc;

//設定範圍顯示圈
-(void)Set_Circle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius;

//設定下方顯示欄位
-(void)Set_Text:(NSString *)location :(NSString *)electricity :(NSString *)name :(NSString *)server_time :(NSString *)latitudeDate :(NSString *)longitudeDate : (int)DataNum :(NSString *)TimeData;

//新增列表顯示資料
-(void)Insert_Data :(NSString*)Value1 :(NSString*)Value2 :(NSString*)Value3 :(NSString*)Value4 :(NSString*)Value5 :(NSString*)Value6 :(NSString*)Value7;

//  設定此Ｖiew 
-(void)Set_Init:(id)sender;

//  初始化Ｖiew 上的設定
-(void)Do_Init:(NSString*)Name;


//列表mousedown觸發
-(void)displayvalue:(id)sender;

//轉換百度座標
- (CLLocationCoordinate2D) convertCoordinateWithLongitude:(CLLocationDegrees) lng latitude:(CLLocationDegrees)lat;

//設定離家提醒
-(void)Set_LeavePointLng:(NSString *)longitude Lat:(NSString *)latitude ImgNum:(int)ImageNum;

//設定離家範圍顯示圈
-(void)Set_LeaveCircle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius;

// 重新加载侧滑数据
- (void)reloadRouteListView;
@property (nonatomic, assign) BOOL stop;

@end
