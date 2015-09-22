//
//  MyMapView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "BMapKit.h"
#import <MessageUI/MessageUI.h>
#import "define.h"

@interface MyMapView : UIView<MKMapViewDelegate, BMKMapViewDelegate,UITextFieldDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate,BMKGeoCodeSearchDelegate>
{
    IBOutlet MKMapView *map_view;
    
    IBOutlet MKMapView *googleMapView;
    IBOutlet  UITextView   *ShowText;   
    IBOutlet  UIButton *Bu_Left;
    IBOutlet  UIButton *Bu_Right;
    IBOutlet BMKMapView *baiduMapView;
    
    //parent View
    id      MainObj;
    
    CGRect textFieldFrame;
    NSURLConnection *Date_Connect;
    NSMutableData *Date_tempData;
    NSString *imei;
    NSString *phone;
    int NowUser;
    IBOutlet UIButton *backgroundBtn;
    IBOutlet UILabel *privacyTitleLbl;
    IBOutlet UILabel *privacyContentLbl;
    IBOutlet UILabel *privacyCode;
    IBOutlet UIButton *privacySubmitBtn;
    IBOutlet UIButton *privacyCancelBtn;
    IBOutlet UILabel *smsSendLbl;
    
    int isGPS_GSM_WIFI;
}

@property (nonatomic,strong) BMKMapView *baiduMapView;

//設定地圖模式
-(void)MapMoushDown:(int)type;

//  初始化view上的設定
-(void)Do_Init:(id)sender;

//設定下方顯示欄位
-(void)Set_Text:(NSString *)location andE:(NSString *)event andN:(NSString *)name andST:(NSString *)server_time andWT:(NSString *)watch_time;

//設定範圍顯示圈
-(void)Set_Circle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius;

//設定大頭針
-(void)Set_Point:(NSString *)longitude :(NSString *)latitude;

//設定大頭針（會改變中心點）
-(void)Set_Point_ForAdd:(NSString *)longitude :(NSString *)latitude;

//清除大頭針
- (void)ClearPoint : (id)sender;

//Ｇoogle Map 衛星模式按鈕Mousedown觸發
-(IBAction)Right_MouseDown:(id)sender;
//Google一般模式按鈕Mousedown觸發
-(IBAction)Left_MouseDown:(id)sender;

//轉換百度座標
- (CLLocationCoordinate2D) convertCoordinateWithLongitude:(CLLocationDegrees) lng latitude:(CLLocationDegrees)lat;

//隱私權宣告View
@property(nonatomic,strong)IBOutlet UIView *privacyView;
@property(nonatomic,strong)IBOutlet UITextField *verificationText;

@property (nonatomic) BOOL GpsLocation;

-(void)setGpsLocation:(BOOL)gpsLocation;

-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)phoneStr;

//20130312 add by Bill sms簡訊啟動GPS Button
-(IBAction)smsBtnClick:(id)sender;
//20130312 add by Bill privacyBtn_submit
-(IBAction)privacyBtn_submit:(id)sender;
//20130312 add by Bill privacyBtn_submit
-(IBAction)privacyBtn_cancel:(id)sender;
//20130312 add by Bill 按下背景Btn將privacyView與KeyBoard隱藏
-(IBAction)backgroundBtn:(id)sender;
//20130315 add by Bill 更新Map地圖
-(IBAction)refreshBtnClick:(id)sender;
-(void)readLocalData;

- (void)setGPS_GSM_WIFI:(int)_GPS_GSM_WIFI;

@end
