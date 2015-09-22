//
//  ViewController.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MainClass.h"
#import "ECSlidingViewController.h"
#import "UnderRightViewController.h"

#import "FPPopoverController.h"
#import "PersonTableViewController.h"
#import "SafeViewController.h"
#import "SystemViewController.h"

#import "CheckErrorCode.h"
#import "AlbumViewController.h"
#import "LoginViewController.h"

//#import <ZXingWidgetController.h>


#import "GeoFenceShow.h"
#import <AVFoundation/AVFoundation.h>
//@interface ViewController : UIViewController<FPPopoverControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MainClassDelegate,ZXingDelegate,UIAlertViewDelegate>
@interface ViewController : UIViewController<FPPopoverControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MainClassDelegate,UIAlertViewDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    NSString *userAccount;
    NSString *userHash;
    id Btnsender;
    
    SafeViewController *safeViewController;
    SystemViewController *systemViewController;
    PersonTableViewController *personViewController;

    int isQRcode;
    int safecount;
    int systemcount;
    int personcount;
    
    UIImageView *safeCountImg;
    UIImageView *systemCountImg;
    UIImageView *personCountImg;
    
    IBOutlet UIImageView *img_bar;
    
    int upload_number;//親情照片上傳
    
    int upload_type;//展示照片上傳
}


@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) FPPopoverController *popover;



//設定ios推播token
-(void)Do_MySetValue:(NSString *)NewString;

//推播點選 ～ 依據內容後轉變顯示幕
-(void)Go_SelectState:(int )SelValue;
//目前無使用
-(void)Check_Mode;

-(void)changePushUser:(NSString *)name;

//Right更新View
-(void)UpdateSetting;


//右側功能列表
- (IBAction)composeList:(id)sender;
//個人訊息列表
- (IBAction)personList:(id)sender;
//安全訊息列表
- (IBAction)safeList:(id)sender;
//系統訊息列表
- (IBAction)systemList:(id)sender;
- (void)ShowSafe:(NSDictionary *)dic;

//點擊照片
-(IBAction)cameraBtnClick:(id)sender;

- (IBAction)scanButtonTapped;

@property (strong, nonatomic) IBOutlet GeoFenceShow *geoFS;

@end
