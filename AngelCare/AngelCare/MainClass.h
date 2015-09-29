//
//  MainClass.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "My_ShowView.h"
#import "MyMapView.h"
#import "MySetView.h"
#import "MySelView.h"
#import "HashSHA256.h"
#import <CommonCrypto/CommonDigest.h>
#import "SBJson.h"
#import "MyDatePickerView.h"
#import "MyDateShowView.h"
#import "MyEatShowView.h"
#import "MyEatPickView.h"
#import "MyActView.h"
#import "MyActSearchView.h"     // 活动区域搜索View

#import "CheckNetwork.h"
#import "MyHisView.h"
#import "MyHisMapView.h"

#import "UserSetView.h"
#import "UserDateView.h"
#import "MyLawTextView.h"
#import "MyLawView2.h"
#import "MBProgressHUD.h"
#import "define.h"
#import "MLTableAlert.h"

#import "MeasureRemind.h"
#import "BPRemindView.h"
#import "BORemindView.h"
#import "BSRemindView.h"
#import "SportRemindView.h"
#import "WeightRemindView.h"

#import "CallLimit.h"
#import "FallSet.h"
#import "DeviceSet.h"
#import "GroupMemberView.h"
#import "LeaveRemind.h"
#import "LeaveMap.h"

#import "NewsView.h"
#import "NewsContentView.h"
#import "MyAccountView.h"
#import "MarqueeLabel.h"

#import "SosMapView.h"
#import "CustomIOS7AlertView.h"
#import "ShowImage.h"
#import "CustomChart.h"
#import "trackingWithInterval.h"
#import "ActivityAlert.h"
#import "GeoFenceShow.h"
#import "HealthSteps.h"
#import "AutoLocating.h"
#import "LocatingEdit.h"

@protocol MainClassDelegate <NSObject>

@optional
-(void)OpenCamera;//UserDateView點選照片後開啓相簿
-(void)OpenPersonCamera:(int)number;//UserDateView點選親情照片後開啓相簿
-(void)OpenShowImageCamera:(int)number;//貼心設定-展示照片

@end

@class MLTableAlert;

@interface MainClass : UIView<UIActionSheetDelegate,MBProgressHUDDelegate,UserDateDelegate,CustomIOS7AlertViewDelegate,ShowImageDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    CheckNetwork *checkNetwork;

    IBOutlet UIButton *Bu1;
    IBOutlet UIButton *Bu2;
    IBOutlet UIButton *Bu3;
    IBOutlet UIButton *Bu4;
    IBOutlet UIButton *Bu5;
    IBOutlet UIButton *Bu6;
    IBOutlet UIButton *Bu7;
    IBOutlet UIButton *Bu8;
    IBOutlet UIButton *Bu9;
    IBOutlet UIButton *Bu10;        // 电子围栏

    IBOutlet UIView *bgView1;
    IBOutlet UIView *bgView2;
    IBOutlet UIView *bgView3;
    IBOutlet UIView *bgView4;
    IBOutlet UIView *bgView5;
    IBOutlet UIView *bgView6;
    IBOutlet UIView *bgView7;
    IBOutlet UIView *bgView8;
    IBOutlet UIView *bgView9;
    IBOutlet UIView *bgView10;      // 电子围栏

    IBOutlet UILabel *Bu1_lbl;
    IBOutlet UILabel *Bu2_lbl;
    IBOutlet UILabel *Bu3_lbl;
    IBOutlet UILabel *Bu4_lbl;
    IBOutlet UILabel *Bu5_lbl;
    IBOutlet UILabel *Bu6_lbl;
    IBOutlet UILabel *Bu7_lbl;
    IBOutlet UILabel *Bu8_lbl;
    IBOutlet UILabel *Bu9_lbl;
    IBOutlet UILabel *Bu10_lbl;     // 电子围栏

    IBOutlet UIButton *Bu_Index;
    IBOutlet UIButton *Bu_Set;

    IBOutlet UIButton *Bu_News;

    IBOutlet UIButton *Bu_Left;
    IBOutlet UIButton *Bu_Right;
    
    IBOutlet UIButton *Bu_MapSet;

    IBOutlet UIButton *Bu_Save;
    
    // 活动区域搜索按钮
    __weak IBOutlet UIButton *Bu_search;
    

    IBOutlet MyEatShowView  *MyEatShowView;
    IBOutlet MyEatPickView  *MyEatPickView;
    
    IBOutlet MyDateShowView *MyDateShowView;
    
    IBOutlet My_ShowView    *ListView;
    
    IBOutlet MySetView   *MySetView;
    IBOutlet MyMapView   *MyMapView;
    
    IBOutlet MyActView   *MyActView;
    IBOutlet MyActSearchView *myActSearchView;
    
    IBOutlet MySelView   *MySelView;
    IBOutlet MyHisView   *MyHisView;
    
    IBOutlet MyHisMapView *MyHisMapView;
    
    IBOutlet UserSetView *UserSetView;
    
    IBOutlet UserDateView *UserDateView;
    
    IBOutlet MyLawTextView *MyLawView; 
    
    IBOutlet MyLawView2 *MyLawView22;
    
    IBOutlet MeasureRemind *MeasureRemind;
    
    IBOutlet BPRemindView *BPRemindView;
    IBOutlet BORemindView *BORemindView;
    IBOutlet BSRemindView *BSRemindView;
    IBOutlet SportRemindView *SportRemindView;
    IBOutlet WeightRemindView *WeightRemindView;
    
    IBOutlet CallLimit *CallLimit;
    IBOutlet FallSet *FallSet;
    IBOutlet DeviceSet *DeviceSet;
    IBOutlet LeaveRemind *LeaveRemind;
    IBOutlet LeaveMap *LeaveMap;
    
    IBOutlet NewsView *NewsView;
    IBOutlet NewsContentView *NewsContentView;
    
    IBOutlet GroupMemberView *GroupMemberView;
    IBOutlet MyAccountView *MyAccountView;
    
    IBOutlet UILabel *ShowName;
    IBOutlet UILabel *TitleName;

    IBOutlet trackingWithInterval *tWI;
    
    
    IBOutlet MyDatePickerView *MyDatePickerView;
    
    IBOutlet ShowImage *ShowImageView;
    
    IBOutlet SosMapView *SosMapView;
    
    IBOutlet ActivityAlert *ActAlert;
    IBOutlet UIView   *LoadingView;
    
    
    //本地端儲存資料
    NSMutableArray  *UserData;   //佩帶者姓名
    NSMutableArray  *PhoneData;  //佩帶者電話
    NSMutableArray  *AccData;    //佩帶者帳號
    NSMutableArray  *HashData;   //佩帶者密碼
    NSString *userAccount;
    NSString *userHash;

    bool   Is_Google_SW;

    //目前顯示的佩帶者編號
    int    NowUserNum;

    BOOL  HaveInsertLaw_Sw;

    BOOL HaveInsertLaw2_Sw;

    BOOL HaveLoading_Sw;

    BOOL  NeedQuit_Sw;

    BOOL  Is_UserGet_Sw;

    BOOL isMainBtn;

    int ShowNum;

    int GetNum;
    //時間計數器
    int TickCount;
    NSString * tmpSaveData;

    //Device token
    NSString * tmpSaveToken;

    //plist 國際化字典檔
    NSMutableDictionary *  Array_show;

    //與Server的Ｕrl開頭
    NSString * InkUrl;

    //此裝置的UUID
    NSString * MyUUID;
    
    //即將刪除的佩帶者姓名
    NSString * DelName;

    BOOL GoToSetting_Sw;

    int NowMode;

    NSString *mapServerTime;
    NSString *smsServerTime;
    NSDictionary *sosMap;

    UIButton *SearchstartBtn;
    UIButton *SearchendBtn;
    UIDatePicker *datePicker;

    NSString *searchStart;
    NSString *searchEnd;

    NSArray *timeZoneArr;

    NSString *newPw;

    IBOutlet UILabel *NewsLbl;
    IBOutlet UIView *animateView;

    //for new custom chart
    IBOutlet CustomChart *chartCustom;
    //
    IBOutlet UIButton *btnInter;
    IBOutlet UIButton *btnMonth;
    IBOutlet UIButton *btnWeek;
    IBOutlet UIButton *btnDay;

    IBOutlet GeoFenceShow *geoFS;
    IBOutlet HealthSteps *healthStepsView;

    IBOutlet AutoLocating *AutoLocatingView;
    IBOutlet LocatingEdit *LocatingEditView;
}

@property (strong, nonatomic) MLTableAlert *alert;
@property (strong) NSObject<MainClassDelegate> *delegate;


- (void)searchResultButtonDidClicked:(int)index date:(NSDate *)date;

- (void)Send_UpdateUserName;
- (void)Send_NewUserDate:(NSString *)Acc2 :(NSString *)Hash2;

- (void)Check_Mode;

- (void) Set_Go:(int)NowSetNum;

// 儲存Device token
- (void)Set_DToekn:(NSString *)Mytoken;
//推播點擊後 跳流程判斷
- (void)Go_State:(int )NewState;

//折線圖範圍放大 mousedown觸發
- (IBAction)Big_MouseDown:(id)sender;

//折線圖範圍縮小觸發
- (IBAction)Small_MouseDown:(id)sender;

//首頁按鈕mousedown觸發
- (IBAction)Main_MouseDown:(id)sender;

//其他顯示幕mousedown 回傳區
-(void) Other_MouseDown:(int)DownNum;


//最新消息內容顯示
-(void)NewsContent:(NSDictionary *)dic;


//切換畫面至吃藥提醒設定
-(void)setEatMedDic:(NSDictionary *)dic;

//切換畫面至回診提醒設定
-(void)setHosDic:(NSDictionary *)dic;

//設定頁隱私權mousedown 回傳
-(void)InsertLaw;

//設定頁服務條款mousedown 回傳
-(void)InsertLaw2;

//Error Code字串判斷
-(void)Check_Error:(NSString *)ErrorData;

//變更設定頁佩帶者顯示
-(void)Set_SetView;

//判斷是否有佩帶者資料
-(bool)CheckGoogle;

//判斷是否有佩帶者資料
-(BOOL)CheckTotal;

-(void)Show_GoToSet;

//切換使用者時 判斷是否需要重新取值
-(void)Check_Http;

//從RightView回到MainClass是否需重新取值
-(void)Right_Return;

//刪除佩帶者
-(void)Del_User:(NSString *)UserName;


-(void)Set_Google:(int)SetNum;


//設定目前 歷史紀錄為哪一種形態 1.緊急  2.跌倒  3.通話
-(void)Set_NewGetNum:(int)SetNum;


//pick顯示資料暫存
-(void) SetPrData:(NSString *)SaveDate;


//取得plist設定字串
-(NSString *)Get_DefineString:(NSString *)SetStr;


//=========================


//新增佩帶者資料傳輸
-(void) Add_User:(NSString *)Acc :(NSString *)Pwd;
//回診提醒更新（傳輸）
-(void) Send_SaveData:(int)SaveNum : (NSString *)SaveDate :(BOOL)On;
//吃藥提醒傳輸
-(void) Send_SaveSmallData:(int)SaveNum :(NSString *)SaveDate :(BOOL)On;

-(void) Send_Sos2:(NSString *)Acc2 :(NSString *)Hash2;
-(void) Send_Sos3:(NSString *)Acc2 :(NSString *)Hash2;


-(int)returnNowUser;
-(int)countAllUser;

-(void)push_changeUser: (NSString *)name;


//改變搜尋區間用於血壓血糖體重的顯示
-(IBAction)changeSearch:(id)sender;


-(void)uploadPNGImage:(UIImage *)image;

-(void) uploadJPEGImage:(UIImage *) image;

//上傳親情照片
-(void) uploadFamilyJPEGImage:(UIImage *) image andType:(int)type;

//上傳展示照片
-(void) uploadShowImage:(UIImage *) image andType:(int)type;

//新增帳號使用IMEI
-(void) addAccByImei:(NSString *)imei;


//切換衛星地圖或一般地圖
-(IBAction)changeMapType:(id)sender;

//儲存吃藥提醒
-(IBAction)saveMedRemind:(id)sender;

//電量轉換
-(NSString *)changeElectricityValue:(NSString *)electricity;

//上傳吃藥提醒設定
-(void)Send_MedRemindUpdateWith:(NSDictionary *)dic;

//上傳吃藥提醒設定
-(void)Send_HosRemindUpdateWith:(NSDictionary *)dic;

//上傳血壓上下限
-(void)Send_BPdata:(NSDictionary *)dic;

//上傳血糖資料
-(void)Send_BSdata:(NSDictionary *)dic;

//上傳血氧資料
-(void)Send_BOdata:(NSDictionary *)dic;

//上傳體重資訊
-(void)Send_Weightdata:(NSDictionary *)dic;

//上傳運動資訊
-(void)Send_Sportdata:(NSDictionary *)dic;

//上傳通話限制資訊
-(void)Send_Calldata:(NSDictionary *)dic;

//上傳跌倒資訊
-(void)Send_Falldata:(NSDictionary *)dic;

//上傳完後重新讀取通話限制
-(void)Send_CallReload;

//上傳設備資訊
-(void)Send_Devicedata:(NSDictionary *)dic;

//上傳完設備資訊重新讀取
-(void)Send_DevReload;

//上傳離家警示
-(void)Send_Leavedata:(NSDictionary *)dic;

//查看地圖
-(void)Show_LeaveMapdata:(NSDictionary *)dic;

//歷史紀錄－地圖
-(void)Send_HisMapdata:(NSDictionary *)dic;

//新增佩帶者資料(傳輸)
-(void)Send_AddMemberdata:(NSDictionary *)dic;

//刪除佩戴者資料
-(void)Send_DelMemberdata:(NSString *)acc;

//修改密碼儲存
-(void)Send_OldPw:(NSString *)oldpw AndNewPw:(NSString *)newpw;

//修改帳號資訊
-(void)Send_AccInfo:(NSDictionary *)dic;


//改變敏感度
-(void)changeFallLevel;

//改變時區
-(void)changeTimeZone;

//改變設備語言
-(void)changeDevLanguage;

//解析區域及語言
-(NSDictionary *)getArea:(NSString *)area AndLanguage:(NSString *)lang;

//佩戴者管理  點擊後  更新
-(void)ChangeMemberList:(int)number;

-(void)NewsAnimate:(NSString *)newsStr;

//登出
-(void)LogOut;

//地圖取得佩帶者imei資料(傳輸)
-(void) Send_MapUserImei;
 
//提醒儲存後回傳成功訊息
-(void)AlertTitleShow:(NSString *)alertTitle andMessage:(NSString *)message;

//點及安全列表
-(void)Show_SafeMap:(NSDictionary *)dic;

//更新使用者
-(void)reloadAcc;

//刪除親情照片
-(void) DeleteFamilyImage:(NSString *)acc AndHash:(NSString *)hash AndIdx:(NSNumber*)idx;
//刪除親情照片
-(void) DeleteShowImage:(NSString *)acc AndHash:(NSString *)hash AndIdx:(NSNumber*)idx;
//上傳同步時段
-(void)Send_tWI:(NSDictionary *)dic;
//api 同步時段
-(void)Get_TWI_Setting:(NSString *)acc andHash: (NSString *)hash;
//
//-(void) Save_TWI_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict;
-(void) Save_TWISetting:(NSDictionary*)dict;
//上傳無動作
-(void)Save_AASetting:(NSDictionary *)dict;
//上傳電子圍籬
-(void) Save_GEO_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict;
//
-(void)Save_GEO_WithDict:(NSDictionary*)dict withSender:(id)Sender;
//
-(void)Save_GEO_WithDict_fromSwitch:(NSDictionary*)dict;
//
-(void)Delete_GEO_WithDict:(NSDictionary*)dict withSender:(id)Sender;
//-(void) Delete_GEO_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict;

//update token
- (void) UpdateToken:(NSString *)acc andHash: (NSString *)hash andToken:(NSString *)token;

//
- (void)LetHUDHide;
- (void)AddLoadingView;
- (void)setHiddenBack:(BOOL)hidden;
//
- (void)Send_SOS7Acc:(NSString *)acc andHash:(NSString *)hash;
//Missing program
- (void)Get_Missing_Join_StastusWithAcc:(NSString *)acc;
- (int)returnIF_State;

//
- (void)Change_State:(int)NewState;

@property (nonatomic, strong) NSString *autoLocatingName;

- (void)SetWiFiWithDict:(NSDictionary*)dict;

- (void)setLocatingEditIndex:(NSString*)m_index;

- (void)getWiFi;

- (void)displayTimerStop;

@end
