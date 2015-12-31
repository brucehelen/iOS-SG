//
//  MainClass.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainClass.h"
#import <CoreGraphics/CoreGraphics.h>
#import "vcGeoFenceEdit.h"

@implementation MainClass
{
    int nextState;
    vcGeoFenceEdit *vcGFE;
    
    CustomIOS7AlertView *timeView;
    
    NSString *locatingEditIndex;
}


#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        myActSearchView.mainClass = self;
    }

    return self;
}

- (void)awakeFromNib
{
    NSLog(@"init: awakeFromNib");
    IF_State = IF_INDEX;
    NowMode = 0;
    
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    
    if (mapType == 1)
    {
        Is_Google_SW = FALSE;
    }
    else
    {
        Is_Google_SW = TRUE;
    }
    
    GoToSetting_Sw = false;
    HaveInsertLaw2_Sw = false;
    HaveInsertLaw_Sw = false;
    
    InkUrl = INK_Url_1;
    
    Is_UserGet_Sw = false;
    
    MyUUID = @"000000000000000";
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* arrayLanguages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [arrayLanguages objectAtIndex:0];
    
    if ([currentLanguage hasPrefix:@"zh-"]) {  // cn
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_cn" ofType:@"plist"];
        Array_show = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NowMode = 2;
    } else {        // en
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_en" ofType:@"plist"];
        Array_show = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NowMode = 1;
    }

    NSLog(@"tmpsave Token = %@", tmpSaveToken);
    tmpSaveToken = [NSString stringWithFormat:@"s"];
    ShowNum = 0;
    NeedQuit_Sw = false;
    HaveLoading_Sw = false;
    checkNetwork = [[CheckNetwork alloc] init];
    
    Bu1_lbl.text = NSLocalizedStringFromTable(@"Bu1_Str", INFOPLIST, nil);
    Bu2_lbl.text = NSLocalizedStringFromTable(@"Bu2_Str", INFOPLIST, nil);
    Bu3_lbl.text = NSLocalizedStringFromTable(@"Bu3_Str", INFOPLIST, nil);
    Bu4_lbl.text = NSLocalizedStringFromTable(@"Bu4_Str", INFOPLIST, nil);
    Bu5_lbl.text = NSLocalizedStringFromTable(@"Bu5_Str", INFOPLIST, nil);
    Bu6_lbl.text = NSLocalizedStringFromTable(@"Bu6_Str", INFOPLIST, nil);
    Bu7_lbl.text = NSLocalizedStringFromTable(@"Bu7_Str", INFOPLIST, nil);
    Bu8_lbl.text = NSLocalizedStringFromTable(@"Bu8_Str", INFOPLIST, nil);
    Bu9_lbl.text = NSLocalizedStringFromTable(@"Bu9_Str", INFOPLIST, nil);
    
    NSLog(@"%@", NSLocalizedStringFromTable(@"Bu10_Str", INFOPLIST, nil));
    Bu10_lbl.text = NSLocalizedStringFromTable(@"Bu10_Str", INFOPLIST, nil);
    
    [Bu1_lbl setTextColor:[UIColor blackColor]];
    [Bu2_lbl setTextColor:[UIColor blackColor]];
    [Bu3_lbl setTextColor:[UIColor blackColor]];
    [Bu4_lbl setTextColor:[UIColor blackColor]];
    [Bu5_lbl setTextColor:[UIColor blackColor]];
    [Bu6_lbl setTextColor:[UIColor blackColor]];
    [Bu7_lbl setTextColor:[UIColor blackColor]];
    [Bu8_lbl setTextColor:[UIColor blackColor]];
    [Bu9_lbl setTextColor:[UIColor blackColor]];
    
    [Bu_Set setTitle:[  Array_show objectForKey : INDEX_BU_SET  ] forState:UIControlStateNormal];
    
    UserData = [[NSMutableArray alloc] init];
    UserData = [NSMutableArray arrayWithCapacity:100];
    
    PhoneData= [[NSMutableArray alloc] init];
    PhoneData = [NSMutableArray arrayWithCapacity:100];
    
    AccData= [[NSMutableArray alloc] init];
    AccData = [NSMutableArray arrayWithCapacity:100];
    
    HashData= [[NSMutableArray alloc] init];
    HashData = [NSMutableArray arrayWithCapacity:100];
    
    [ShowName setText:@""];
    [self LoadUserData];
    NowUserNum =0;
    [self Check_Down_Bu];
    
    [TitleName setText:[Array_show objectForKey:TITLE_INDEX]];
}

- (void)setLocatingEditIndex:(NSString*)m_index
{
    locatingEditIndex = m_index;
}

#pragma mark - 网络连接事件
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{   //收到封包，將收到的資料塞進緩衝中並修改進度條
   
    if(connection == Add_Connect)
    {
        [Add_tempData appendData:incomingData];
    }
    else if(connection == UpDate_Token_Connect)
    {
        [UpDate_Token_tempData appendData:incomingData];
    }
    else if(connection == Get_connect)
    {
        [Get_tempData appendData:incomingData];
    }
    else if(connection == Loc_Connect)
    {
        [Loc_tempData appendData:incomingData];
    }
    else if(connection == Sms_Connect)
    {
        [Sms_tempData appendData:incomingData];
    }
    else if(connection == Act_Connect)
    {
        [Act_tempData appendData:incomingData];
    }
    else if (connection == Search_Connect) {
        [Search_tempData appendData:incomingData];
    }
    else if(connection == His_Connect)
    {
        [His_tempData appendData:incomingData];
        
    }
    else if(connection == WiFiList_Connect)
    {
        [WiFiList_tempData appendData:incomingData];
        
    }
    else if(connection == GetWiFi_Connect)
    {
        [GetWiFi_tempData appendData:incomingData];
        
    }
    else if(connection == SetWiFi_Connect)
    {
        [SetWiFi_tempData appendData:incomingData];
        
    }
    else if(connection == Save_Connect)
    {
        [Save_tempData appendData:incomingData];
        
    }
    else if (connection == Get_TWI_Connect)
    {
        [Get_TWI_tempData appendData:incomingData];
    }
    else if (connection == Get_AA_Connect)
    {
        [Get_AA_tempData appendData:incomingData];
    }
    else if (connection == Get_GEO_Connect)
    {
        [Get_GEO_tempData appendData:incomingData];
    }
    else if (connection == Get_Missing_Join_Stastus_Connect)
    {
        [Get_Missing_Join_Stastus_tempData appendData:incomingData];
    }
    else if (connection == Get_Missing_Join_Stastus_Link_Join_Action_Connect)
    {
        [Get_Missing_Join_Stastus_Link_Join_Action_tempData appendData:incomingData];
    }
    else if (connection == Set_Missing_Join_Stastus_Connect)
    {
        [Set_Missing_Join_Stastus_tempData appendData:incomingData];
    }
    else if (connection == Get_GEO_NORP_Connect)
    {
        [Get_GEO_NORP_tempData appendData:incomingData];
    }
    else if(connection == Get_Connect)
    {
        [Get_tempData appendData:incomingData];
        
    }
    else if(connection == Set_Connect)
    {
        [Set_tempData appendData:incomingData];
        
    }
    else if(connection == Date_Connect)
    {
        [Date_tempData appendData:incomingData];
        
    }
    else if(connection == Date_NewConnect)
    {
        [Date_NewtempData appendData:incomingData];
        
    }
    else if(connection == Del_Connect)
    {
        [Del_tempData appendData:incomingData];
        
    }
    else if(connection == Clear_Connect)
    {
        [Clear_tempData appendData:incomingData];
    }else if (connection == UploadPhoto_Connect)
    {
        [UploadPhoto_tempData appendData:incomingData];
    }else if (connection == UploadFamilyPhoto_Connect)
    {
        [UploadFamilyPhoto_tempData appendData:incomingData];
    }else if (connection == UploadShowPhoto_Connect)
    {
        [UploadShowPhoto_tempData appendData:incomingData];
    }
    else if (connection == SosAndFamilyPhone_Connect)
    {
        [SosAndFamilyPhone_tempData appendData:incomingData];
    }else if (connection == UpdateUser_Connect)
    {
        [UpdateUser_tempData appendData:incomingData ];
    }else if (connection == UpdatePhone_Connect)
    {
        [UpdatePhone_tempData appendData:incomingData];
    }else if (connection == MedRemind_Connect)
    {
        [MedRemind_tempData appendData:incomingData];
    }else if (connection == HosRemind_Connect)
    {
        [HosRemind_tempData appendData:incomingData];
    }else if (connection == UpdateMed_Connect)
    {
        [UpdateMed_tempData appendData:incomingData];
    }else if (connection == UpdateHos_Connect)
    {
        [UpdateHos_tempData appendData:incomingData];
    }else if (connection == MBP_Connect)
    {
        [MBP_tempData appendData:incomingData];
    }else if (connection == MBO_Connect)
    {
        [MBO_tempData appendData:incomingData];
    }else if (connection == MBS_Connect)
    {
        [MBS_tempData appendData:incomingData];
    }else if (connection == MS_Connect)
    {
        [MS_tempData appendData:incomingData];
    }else if (connection == MW_Connect)
    {
        [MW_tempData appendData:incomingData];
    }else if (connection == UpdateBP_Connect)
    {
        [UpdateBP_tempData appendData:incomingData];
    }else if (connection == UpdateBO_Connect)
    {
        [UpdateBO_tempData appendData:incomingData];
    }else if (connection == UpdateBS_Connect)
    {
        [UpdateBS_tempData appendData:incomingData];
    }else if (connection == UpdateSport_Connect)
    {
        [UpdateSport_tempData appendData:incomingData];
    }else if (connection == UpdateWeight_Connect)
    {
        [UpdateWeight_tempData appendData:incomingData];
    }else if (connection == Call_Connect)
    {
        [Call_tempData appendData:incomingData];
    }else if (connection == UpdateCall_Connect)
    {
        [UpdateCall_tempData appendData:incomingData];
    }else if (connection == Dev_Connect)
    {
        [Dev_tempData appendData:incomingData];
    }else if (connection == Remind_Connect)
    {
        [Remind_tempData appendData:incomingData];
    }else if (connection == Fall_Connect)
    {
        [Fall_tempData appendData:incomingData];
    }else if (connection == UpdateFall_Connect)
    {
        [UpdateFall_tempData appendData:incomingData];
    }else if (connection == UpdateDev_Connect)
    {
        [UpdateDev_tempData appendData:incomingData];
        
    }else if (connection == Update_Connect)
    {
        [Update_tempData appendData:incomingData];
        
    }else if (connection == LeaveRemind_Connect)
    {
        [LeaveRemind_tempData appendData:incomingData];
        
    }else if (connection == UpdateLeave_Connect)
    {
        [UpdateLeave_tempData appendData:incomingData];
    }else if (connection == News_Connect)
    {
        [News_tempData appendData:incomingData];
    }else if (connection == ActLeave_Connect)
    {
        [ActLeave_tempData appendData:incomingData];
    }else if (connection == MyAcc_Connect)
    {
        [MyAcc_tempData appendData:incomingData];
    }else if (connection == ChangePw_Connect)
    {
        [ChangePw_tempData appendData:incomingData];
    }else if (connection == ChangeUserInfo_Connect)
    {
        [ChangeUserInfo_tempData appendData:incomingData];
    }else if (connection == MapImei_Connect)
    {
        [MapImei_tempData appendData:incomingData];
    }else if (connection == LangInfo_Connect)
    {
        [LangInfo_tempData appendData:incomingData];
    }else if (connection == TimeZoneInfo_Connect)
    {
        [TimeZoneInfo_tempData appendData:incomingData];
    }else if (connection == Sync_Connect)
    {
        [Sync_tempData appendData:incomingData];
    }else if (connection == GpsSync_Connect)
    {
        [GpsSync_tempData appendData:incomingData];
    }else if (connection == ShowImage_Connect)
    {
        [ShowImage_tempData appendData:incomingData];
    }else if (connection == DeleteFamilyImage_Connect)
    {
        [DeleteFamilyImage_tempData appendData:incomingData];
    }else if (connection == DeleteShowImage_Connect)
    {
        [DeleteShowImage_tempData appendData:incomingData];
    }
    else if (connection == Save_TWI_Connect)
    {
        [Save_TWI_tempData appendData:incomingData];
    }
    else if (connection == Save_AA_Connect)
    {
        [Save_AA_tempData appendData:incomingData];
    }
    else if (connection == Save_GEO_Connect)
    {
        [Save_GEO_tempData appendData:incomingData];
    }
    else if (connection == Save_GEO_Enable_Connect)
    {
        [Save_GEO_Enable_tempData appendData:incomingData];
    }
    else if (connection == Delete_GEO_Connect)
    {
        [Delete_GEO_tempData appendData:incomingData];
    }
    else if (connection == GCareGetSOSTracking_Connect){
        [GCareGetSOSTracking_tempData appendData:incomingData];
    }
    else{
        NSLog(@"no define");
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑

    if(connection == Add_Connect)
    {
        [self Http_Process_AddUser];
    }
    else if(connection == UpDate_Token_Connect)
    {
        [self Http_UpDate_Token];
    }
    else if( connection == Get_connect )
    {
        switch (ShowNum)
        {
            case 1:
                NSLog(@"1 ok");
                [self Http_Process_GetData1];
                break;
            case 2:
                NSLog(@"2 ok");
                [self Http_Process_GetData2];
                break;
            case 3:
                NSLog(@"3 ok");
                [self Http_Process_GetData3];
                break;
            case 4:
                NSLog(@"4 ok");
                [self Http_Process_GetData4];
                break;
            case 5:
                NSLog(@"5 ok");
                [self Http_Process_GetData5];
                break;
        }
    }
    else if(connection == Loc_Connect)
    {
        [self Http_Process_GetLocMap];
    }
    else if( connection == Sms_Connect )//SMS簡訊發送解析
    {
        [self Http_Process_GetSMSMap];
    }
    else if( connection == Act_Connect )
    {
        [self Http_Process_GetLocAct];
    }
    else if (connection == Search_Connect) {
        [self httpProcessLocationActSearch];
    }
    else if( connection == His_Connect )
    {
        
        [self Http_Process_His];
        
    }
    else if( connection == Save_Connect )
    {
        [self Http_Process_Save];
    }
    else if( connection == WiFiList_Connect )
    {
        [self Http_WiFiList];
    }
    else if( connection == GetWiFi_Connect )
    {
        [self Http_WiFi];
    }
    else if( connection == SetWiFi_Connect )
    {
        [self Http_SetWiFi];
    }
    else if( connection == Set_Connect )
    {
        [self Http_Process_Set];
    }
    else if( connection == Date_Connect )
    {
        [self Http_Process_Date];
    }
    else if( connection == Date_NewConnect )
    {
        [self Http_Process_NewDate];
    }
    else if( connection == Del_Connect )
    {
        [self Http_Process_Del];
    }
    else if( connection == Clear_Connect )
    {
        [self Http_Process_Clear];
    }   
    else if (connection == UploadPhoto_Connect)//照片上傳
    {
        [self Http_UploadPhoto];
        
    }else if (connection == UploadFamilyPhoto_Connect)//親情照片上傳
    {
        [self Http_UploadFamilyPhoto];
    }
    else if (connection == UploadShowPhoto_Connect)//展示照片上傳
    {
        [self Http_UploadShowPhoto];
    }
    else if (connection == SosAndFamilyPhone_Connect)
    {
        [self Http_SoSandFamilyPhone];
        
    }else if (connection == UpdateUser_Connect)//使用者資訊上傳
    {
        [self Http_UpdateUserInfo];
        
    }else if (connection == UpdatePhone_Connect)//緊急電話與親情電話上傳
    {
        [self Http_UpdatePhoneInfo];
    }else if (connection == MedRemind_Connect)//取得吃藥提醒
    {
        [self Http_MedRemindInfo];
    }else if (connection == HosRemind_Connect)
    {
        [self Http_HosRemindInfo];//回診提醒
    }else if (connection == UpdateMed_Connect)
    {
        [self Http_UpdateMed];//吃藥提醒更新
    }else if (connection == UpdateHos_Connect)
    {
        [self Http_UpdateHos];//回診提醒更新
    }else if (connection == MBP_Connect)
    {
        [self Http_BPInfo];
    }else if (connection == MBO_Connect)
    {
        [self Http_BOInfo];
    }else if (connection == MBS_Connect)
    {
        [self Http_BSInfo];
    }else if (connection == MS_Connect)
    {
        [self HttP_SportInfo];
    }else if (connection == MW_Connect)
    {
        [self Http_WeightInfo];
    }else if (connection == UpdateBP_Connect)
    {
        [self Http_UpdateBP];
    }else if (connection == UpdateBO_Connect)
    {
        [self Http_UpdateBO];
    }else if (connection == UpdateBS_Connect)
    {
        [self Http_UpdateBS];
        
    }else if (connection == UpdateSport_Connect)
    {
        [self Http_UpdateSport];
        
    }else if (connection == UpdateWeight_Connect)
    {
        [self Http_UpdateWeight];
        
    }else if (connection == Call_Connect)
    {
        [self Http_CallInfo];
        
    }else if (connection == UpdateCall_Connect)
    {
        [self Http_UpdateCall];
    }else if (connection == Dev_Connect)
    {
        [self Http_DevSetInfo];
    }else if (connection == Remind_Connect)
    {
        [self Http_RemindInfo];
    }else if (connection == Fall_Connect)
    {
        [self Http_FallSetInfo];
    }else if (connection == UpdateFall_Connect)
    {
        [self Http_UpdateFall];
    }else if (connection == UpdateDev_Connect)
    {
        [self Http_UpdateDevice];
    }else if (connection == Update_Connect)
    {
        [self Http_Update];
    }else if (connection == LeaveRemind_Connect)
    {
        [self Http_LeaveRemindInfo];
    }else if (connection == UpdateLeave_Connect)
    {
        [self Http_UpdateLeave];
    }else if (connection == News_Connect)
    {
        [self Http_NewsInfo];
    }else if (connection == ActLeave_Connect)
    {
        [self Http_ActLeaveInfo];
        
    }else if (connection == MyAcc_Connect)
    {
        [self Http_MyAccInfo];
    }else if (connection == ChangePw_Connect)
    {
        [self Http_ChangePw];
    }else if (connection == ChangeUserInfo_Connect)
    {
        [self Http_ChangeUserInfo];
    }else if (connection == MapImei_Connect)
    {
        [self Http_MapImeiInfo];
    }else if (connection == LangInfo_Connect)
    {
        [self Http_LangInfo];
    }else if (connection == TimeZoneInfo_Connect)
    {
        [self Http_TimeZoneInfo];
    }else if (connection == Sync_Connect)
    {
        [self Http_SyncTimeInfo];
    }else if (connection == GpsSync_Connect)
    {
        [self Http_GpsTimeInfo];
    }else if (connection == Get_TWI_Connect)
    {
        [self Http_TWIInfo];
    }
    else if (connection == Get_AA_Connect)
    {
        [self Http_AAInfo];
    }
    else if (connection == Get_GEO_Connect)
    {
        [self Http_GEOInfo];
    }
    else if (connection == Get_Missing_Join_Stastus_Connect)
    {
        [self Http_Get_Missing_Join_StastusInfo];
    }
    else if (connection == Get_Missing_Join_Stastus_Link_Join_Action_Connect)
    {
        [self Http_Get_Missing_Join_Link_Join_Action];
    }
    else if (connection == Set_Missing_Join_Stastus_Connect)
    {
        [self Http_Set_Missing_Join_StastusInfo];
    }
    else if (connection == Get_GEO_NORP_Connect)
    {
        [self Http_GEO_NORPInfo];
    }
    else if (connection == ShowImage_Connect)
    {
        [self Http_ShowImageInfo];
    }
    else if (connection == DeleteFamilyImage_Connect)
    {
        [self Http_DeleteFamilyImageInfo];
    }
    else if (connection == DeleteShowImage_Connect)
    {
        [self Http_DeleteShowImageInfo];
    }
    else if (connection == Save_TWI_Connect)
    {
        [self Http_SaveTWIInfo];
    }
    else if (connection == Save_AA_Connect)
    {
        [self Http_SaveAAInfo];
    }
    else if (connection == Save_GEO_Connect)
    {
        [self Http_SaveGEOInfo];
    }
    else if (connection == Save_GEO_Enable_Connect)
    {
        [self Http_SaveGEO_EnableInfo];
    }
    else if (connection == Delete_GEO_Connect)
    {
        [self Http_DeleteGEOInfo];
    }
    else if (connection == GCareGetSOSTracking_Connect){
        [self Http_GcareGetSOSTracking];
    }
    else{
        NSLog(@"no define");
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    
    
    if(connection == Add_Connect)
    {
        [Add_tempData setLength:0];
        Add_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == UpDate_Token_Connect)
    {
        [UpDate_Token_tempData setLength:0];
        UpDate_Token_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == Get_connect)
    {
        [Get_tempData setLength:0];
        Get_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if(connection == Loc_Connect)
    {
        [Loc_tempData setLength:0];
        Loc_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if (connection == Sms_Connect)//簡訊定位
    {
        [Sms_tempData setLength:0];
        Sms_expectedLength = [aResponse expectedContentLength];
    }
    else if(connection == Act_Connect)
    {
        [Act_tempData setLength:0];
        Act_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    else if (connection == Search_Connect) {
        Search_tempData.length = 0;
        Search_expectedLength = [aResponse expectedContentLength];
    }
    else if(connection == His_Connect)
    {
        [His_tempData setLength:0];
        His_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Save_Connect)
    {
        [Save_tempData setLength:0];
        Save_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == WiFiList_Connect)
    {
        [WiFiList_tempData setLength:0];
        WiFiList_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == GetWiFi_Connect)
    {
        [GetWiFi_tempData setLength:0];
        GetWiFi_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == SetWiFi_Connect)
    {
        [SetWiFi_tempData setLength:0];
        SetWiFi_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Set_Connect)
    {
        [Set_tempData setLength:0];
        Set_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Date_Connect)
    {
        [Date_tempData setLength:0];
        Date_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Date_NewConnect)
    {
        [Date_NewtempData setLength:0];
        Date_NewexpectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Del_Connect)
    {
        [Del_tempData setLength:0];
        Del_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }
    else if(connection == Clear_Connect)
    {
        [Clear_tempData setLength:0];
        Clear_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
        
    }else if (connection == UploadPhoto_Connect) {
        [UploadPhoto_tempData setLength:0];
        UploadPhoto_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
    }else if (connection == UploadFamilyPhoto_Connect) {
        [UploadFamilyPhoto_tempData setLength:0];
        UploadFamilyPhoto_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
        
    }else if (connection == UploadShowPhoto_Connect)
    {
        [UploadShowPhoto_tempData setLength:0];
        UploadShowPhoto_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == UpdateUser_Connect)
    {
        [UpdateUser_tempData setLength:0];
        UpdateUser_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }else if (connection == UpdatePhone_Connect)
    {
        [UpdatePhone_tempData setLength:0];
        UpdatePhone_expectedLength = [aResponse expectedContentLength];
        
    }else if (connection == MedRemind_Connect)
    {
        [MedRemind_tempData setLength:0];
        MedRemind_expectedLength = [aResponse expectedContentLength];
    }else if (connection == HosRemind_Connect)
    {
        [HosRemind_tempData setLength:0];
        HosRemind_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateMed_Connect)
    {
        [UpdateMed_tempData setLength:0];
        UpdateMed_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateHos_Connect)
    {
        [UpdateHos_tempData setLength:0];
        UpdateHos_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MBP_Connect)
    {
        [MBP_tempData setLength:0];
        MBP_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MBO_Connect)
    {
        [MBO_tempData setLength:0];
        MBO_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MBS_Connect)
    {
        [MBS_tempData setLength:0];
        MBS_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MS_Connect)
    {
        [MS_tempData setLength:0];
        MS_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MW_Connect)
    {
        [MW_tempData setLength:0];
        MW_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Call_Connect)
    {
        [Call_tempData setLength:0];
        Call_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateCall_Connect)
    {
        [UpdateBS_tempData setLength:0];
        UpdateCall_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Dev_Connect)
    {
        [Dev_tempData setLength:0];
        Dev_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Remind_Connect)
    {
        [Remind_tempData setLength:0];
        Remind_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Fall_Connect)
    {
        [Fall_tempData setLength:0];
        Fall_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateFall_Connect)
    {
        [UpdateCall_tempData setLength:0];
        UpdateFall_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateDev_Connect)
    {
        [UpdateDev_tempData setLength:0];
        UpdateDev_expectedLength = [aResponse expectedContentLength];
    }else if (connection == Update_Connect)
    {
        [Update_tempData setLength:0];
        Update_expectedLength = [aResponse expectedContentLength];
    }else if (connection == LeaveRemind_Connect)
    {
        [LeaveRemind_tempData setLength:0];
        LeaveRemind_expectedLength = [aResponse expectedContentLength];
    }else if (connection == UpdateLeave_Connect)
    {
        [UpdateLeave_tempData setLength:0];
        UpdateLeave_expectedLength = [aResponse expectedContentLength];
    }else if (connection == News_Connect)
    {
        [News_tempData setLength:0];
        News_expectedLength = [aResponse expectedContentLength];
    }else if (connection == ActLeave_Connect)
    {
        [ActLeave_tempData setLength:0];
        ActLeave_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MyAcc_Connect)
    {
        [MyAcc_tempData setLength:0];
        MyAcc_expectedLength = [aResponse expectedContentLength];
    }else if (connection == ChangePw_Connect)
    {
        [ChangePw_tempData setLength:0];
        ChangePw_expectedLength = [aResponse expectedContentLength];
    }else if (connection == ChangeUserInfo_Connect)
    {
        [ChangeUserInfo_tempData setLength:0];
        ChangeUserInfo_expectedLength = [aResponse expectedContentLength];
    }else if (connection == MapImei_Connect)
    {
        [MapImei_tempData setLength:0];
        MapImei_expectedLength = [aResponse expectedContentLength];
    }else if (connection == LangInfo_Connect)
    {
        [LangInfo_tempData setLength:0];
        LangInfo_expectedLength = [aResponse expectedContentLength];
    }else if (connection == TimeZoneInfo_Connect)
    {
        [TimeZoneInfo_tempData setLength:0];
        TimeZoneInfo_expectedLength = [aResponse expectedContentLength];
    }else if (connection == ShowImage_Connect)
    {
        [ShowImage_tempData setLength:0];
        ShowImage_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == Save_TWI_Connect)
    {
        [Save_TWI_tempData setLength:0];
        Save_TWI_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == Save_AA_Connect)
    {
        [Save_AA_tempData setLength:0];
        Save_AA_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == Save_GEO_Connect)
    {
        [Save_GEO_tempData setLength:0];
        Save_GEO_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == Save_GEO_Enable_Connect)
    {
        [Save_GEO_tempData setLength:0];
        Save_GEO_Enable_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == Delete_GEO_Connect)
    {
        [Delete_GEO_tempData setLength:0];
        Delete_GEO_expectedLength = [aResponse expectedContentLength];
    }
    else if (connection == GCareGetSOSTracking_Connect){
        [GCareGetSOSTracking_tempData setLength:0];
        GCareGetSOSTracking_expectedLength = [aResponse expectedContentLength];
    }
    else{
        NSLog(@"no define");
    }
    //  NSLog(@"%d & len : %d ", status,expectedLength);
}


//顯示旋轉

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//================================================

int IF_State = IF_INDEX;

NSTimer *MyTimer = nil;

//切換使用者時 判斷是否需要重新取值
#pragma mark -
#pragma mark 切換使用者時 判斷是否需要重新取值
- (void)Check_Http
{
    //判斷是預設地圖還是百度地圖
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    if (mapType == 1) {
        NSLog(@"Baidu Map init");
        Is_Google_SW = FALSE;
    }else
    {
        NSLog(@"Google Map init");
        Is_Google_SW = TRUE;
    }

    switch (IF_State)
    {
        case IF_HealthSteps:
            [(HealthSteps *)healthStepsView Do_init:NowUserNum];
            break;
        case IF_USERDATE:
            [self Send_UserDate:userAccount andHash:userHash];
            break;
        case IF_USERSET:
            [self Send_UserSet:userAccount AndHash:userHash];
            break;
        case IF_EATSHOW:
            [self Send_MedRemind:userAccount andHash:userHash];
            break;
        case IF_DATESHOW:
            break;
        case IF_SETTING:
            [(MySetView *)MySetView  Set_Go:NowUserNum];
            break;
        case IF_HIS:
            [self Set_NewGetNum:GetNum];
            break;
        case IF_ACT:
            NSLog(@"isAct");
            [self Send_ActionLoc:userAccount andHash:userHash];
            break;
        case IF_MAP:
            NSLog(@"isMap");
            [self Send_LocMap:userAccount andHash:userHash];
            break;
        case IF_SHOWLIST:
            isMainBtn = YES;
            [self Send_UserRemind:userAccount andHash:userHash];
            break;
        case IF_HISMAP:
            [(MyHisMapView *)MyHisMapView ChangeMapType];
            break;
        case IF_BPREMIND:
            [self Send_UserBPRemind:userAccount andHash:userHash];
            break;
        case IF_BSREMIND:
            [self Send_UserBSRemind:userAccount andHash:userHash];
            break;
        case IF_BOREMIND:
            [self Send_UserBORemind:userAccount andHash:userHash];
            break;
        case IF_SPORTREMIND:
            [self Send_UserSportRemind:userAccount andHash:userHash];
            break;
        case IF_WEIGHTREMIND:
            [self Send_UserWeightRemind:userAccount andHash:userHash];
            break;
        case IF_CALL:
            [self Send_UserCallLimit:userAccount andHash:userHash];
            break;
        case IF_FALLSET:
            [self Send_UserFallSet:userAccount andHash:userHash];
            break;
        case IF_DEVSET:
            [self Send_UserDevSet:userAccount andHash:userHash];
            break;
        case IF_LEAVEREMIND:
            [self Send_UserLeaveSet:userAccount andHash:userHash];
            break;
        case IF_SHOWIMAGE:
            [self Send_ShowImage:userAccount andHash:userHash];
            break;
        case IF_CUSTOMCHART:
            isMainBtn = YES;
            [self Send_UserRemind:userAccount andHash:userHash];
            break;
        case IF_TWI:
            [self Get_TWI_Setting:userAccount andHash:userHash];
            break;
        case IF_ACTALERT:
            [self Get_AA_Setting:userAccount andHash:userHash];
            break;
        case IF_GeoFS:
            [self Get_GEO_Setting:userAccount andHash:userHash];
            break;
        case IF_AutoLocating:
            [self Get_WiFiList:userAccount andHash:userHash];
            break;
    }
}

#pragma mark -
//從RightView回到MainClass是否需重新取值
-(void)Right_Return
{
    //判斷是預設地圖還是百度地圖
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    if (mapType == 1) {
        NSLog(@"Baidu Map init");
        Is_Google_SW = FALSE;
    }else
    {
        NSLog(@"Google Map init");
        Is_Google_SW = TRUE;
    }

    switch (IF_State)
    {
        case IF_ACT:
            NSLog(@"isAct");
            [self Send_ActionLoc:userAccount andHash:userHash];
            break;
            
        case IF_MAP:
            NSLog(@"isMap");
            [self Send_LocMap:userAccount andHash:userHash];
            break;
            
        case IF_HISMAP:
            [(MyHisMapView *)MyHisMapView ChangeMapType];
            break;
    }
}

//Error Code字串判斷
-(void)Check_Error:(NSString *)ErrorData
{
    [HUD hide:YES];

    NSLog(@"Main class Check_Error: %@", ErrorData);
    return;

    int ErrorValue;
    ErrorValue = [ErrorData intValue];

    ErrorValue =  ErrorValue%100;

    UIAlertView *alert;
    
    switch (ErrorValue)
    {
        case 1:
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:NSLocalizedStringFromTable(@"ErrorCode_01",INFOPLIST,nil)
                                              delegate: self
                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE")
                                     otherButtonTitles: nil];
            [alert show];
            break;
        case 2:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_02",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 3:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_03",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
        
        case 4:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_04",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 5:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_05",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 6:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_06",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 7:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_07",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 8:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_08",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 9:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_09",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 10:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_10",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 11:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_11",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 12:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_12",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 90:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_90",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
        case 99:
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_99",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            break;
            
            
            
        default:
            
            alert = [[UIAlertView alloc] initWithTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                               message:
                     NSLocalizedStringFromTable(@"ErrorCode_999",INFOPLIST,nil)
                     delegate
                                                      : self cancelButtonTitle:
                     NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE",INFOPLIST,nil)
                                     otherButtonTitles: nil];
            
            [alert show];
            
            
            break;
    }
    
    
    
}

//無使用者時導入設定頁的alert提示
- (void)Show_GoToSet
{
    GoToSetting_Sw = true;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                    message:[self Get_DefineString:ALERT_MESSAGE_INPUT]
                                                   delegate:self
                                          cancelButtonTitle:[self Get_DefineString:ALERT_MESSAGE_OK]
                                          otherButtonTitles:nil];

    alert.delegate = self;

    [alert show];
}

- (void)handleRemoteMsgWithType:(NSInteger)type
{
    switch (type) {
        case 1:
            [self Send_LocMap:userAccount andHash:userHash];
            break;
        case 2:
            [self Change_State:IF_SHOWLSEL];
            break;
        default:
            break;
    }
}

#pragma mark - 首页按钮点击事件
- (IBAction)Main_MouseDown:(id)sender
{
    NSLog(@"--- Main_MouseDown = %@", sender);

    if( sender == Bu1 )
    {
        [self Send_UserDate:userAccount andHash:userHash];
    }
    else if (sender == Bu2)     // 设备状态
    {
        [self Send_UserSet:userAccount AndHash:userHash];
    }
    else if (sender == Bu3)     // 健康管理
    {
        [self Change_State:IF_SHOWLSEL];
    }
    else if (sender == Bu4)     // 定位救援
    {
        if([checkNetwork check] == false) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  [self Get_DefineString:NONET]
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                  otherButtonTitles: nil];
            
            [alert show];
        }
        else
        {
            [self Send_LocMap:userAccount andHash:userHash];
        }
    }
    else if (sender == Bu5)     // 活动区域
    {
        if ([checkNetwork check] == false)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  [self Get_DefineString:NONET]
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                  otherButtonTitles: nil];
            
            [alert show];
        }
        else
        {
            [self Send_ActionLoc:userAccount andHash:userHash];
        }
    }
    else if (sender == Bu6)     // 服务记录
    {
        //歷史紀錄
        [self Set_NewGetNum:1];
    }
    else if (sender == Bu7)     // 打电话
    {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];

        if ([[defaults objectForKey:@"quickCall"] integerValue] == 1) {
            NSString *phoneNumber = [@"tel://" stringByAppendingString:[PhoneData objectAtIndex:NowUserNum]];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }
        else
        {
            self.alert = [MLTableAlert tableAlertWithTitle:NSLocalizedStringFromTable(@"SelectNumber", INFOPLIST, nil) cancelButtonTitle:kLoadString(@"SelectNumberCancel") numberOfRows:^NSInteger (NSInteger section)
                          {
                              return [[defaults objectForKey:@"totalcount"] integerValue];
                          }
                                                  andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                          {
                              static NSString *CellIdentifier = @"CellIdentifier";
                              UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                              if (cell == nil)
                                  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

                              NSString *nameStr = [defaults objectForKey:[NSString stringWithFormat:@"Name%i",indexPath.row+1]];
                              NSString *phoneStr = [defaults objectForKey:[NSString stringWithFormat:@"Phone%i",indexPath.row+1]];
                              cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",nameStr,phoneStr];

                              return cell;
                          }];

            // Setting custom alert height
            self.alert.height = 350;

            [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
                int select = selectedIndex.row +1;
                NSString *phone = [NSString stringWithFormat:@"%@",[defaults objectForKey:[NSString stringWithFormat:@"Phone%i",select]]];
                
                NSString *phoneNumber = [@"tel://" stringByAppendingString:phone];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                
            } andCompletionBlock:^{
                
            }];

            // show the alert
            [self.alert show];
        }
    }
    else if (sender == Bu8)//吃藥回診提醒
    {
        [self Send_MedRemind:userAccount andHash:userHash];
    }
    else if (sender == Bu9)
    {
        //貼心設定
        [(MyDateShowView *)MyDateShowView Do_Init:self];
        [self Change_State:IF_DATESHOW];
    }
    else if (sender == Bu10) {      // 电子围栏
        // bruce@20150930 - 国内版本暂时改成自建定位
        //[self Get_WiFiList:userAccount andHash:userHash];

#ifdef PROGRAM_VER_ML
        [geoFS do_initWithSender:self];
        [self Get_GEO_Setting:userAccount andHash:userHash];
#else
        [self Get_WiFiList:userAccount andHash:userHash];
#endif
    }
    else if (sender == Bu_Index)    // 退格按钮
    {
        if (HaveInsertLaw_Sw)
        {
            [MyLawView removeFromSuperview];
            HaveInsertLaw_Sw = false;
        }
        else
        {
            if(HaveInsertLaw2_Sw)
            {
                [MyLawView22 removeFromSuperview];
                HaveInsertLaw2_Sw = false;
            }
            else if(IF_State == IF_SHOWLIST)
            {
                [self Change_State:IF_INDEX];
                [self Change_State:IF_SHOWLSEL];
            }
            else if(IF_State == IF_EATSEL)
            {
                [self Change_State:IF_INDEX];
                [self Change_State:IF_EATSHOW];
                
            }else if (IF_State == IF_MEASURERE || IF_State == IF_CALL || IF_State == IF_DEVSET || IF_State == IF_FALLSET || IF_State == IF_LEAVEREMIND || IF_State == IF_SHOWIMAGE || IF_State == IF_TWI || IF_State == IF_ACTALERT
#ifdef PROGRAM_VER_ML
                      || IF_State == IF_AutoLocating
#endif
                      )
            {
                [self Change_State:IF_DATESHOW];
            }else if (IF_State == IF_BPREMIND || IF_State == IF_BOREMIND || IF_State == IF_BSREMIND || IF_State == IF_SPORTREMIND || IF_State == IF_WEIGHTREMIND )
            {
                [self Change_State:IF_MEASURERE];
            }else if (IF_State == IF_HISMAP)
            {
                [self Change_State:IF_HIS];
            }else if (IF_State == IF_LEAVEMAP)
            {
                [self Change_State:IF_LEAVEREMIND];
            }else if (IF_State == IF_NEWSCONTENT)
            {
                [self Change_State:IF_NEWSINFO];
            }
            else if(IF_State == IF_CUSTOMCHART || IF_State == IF_HealthSteps)
            {
                [self Change_State:IF_INDEX];
                [self Change_State:IF_SHOWLSEL];
            }
            else if(IF_State == IF_LocatingEdit)
            {
                [self Get_WiFiList:userAccount andHash:userHash];
            }
            else if (IF_State == IF_FREQ_QUESTION_DETAIL) {
                [self Change_State:IF_FREQ_QUESTION];
            }
            else
            {
                [self Change_State:IF_INDEX];
            }
        }
    }
    else if (sender == Bu_Set)
    {
        [self Change_State:IF_SETTING];
    }
    else if (sender == Bu_Left)
    {
        if (NowUserNum > 0)
        {
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                                message:
                                      [self Get_DefineString:NONET]
                                      delegate
                                                                       : self cancelButtonTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                      otherButtonTitles: nil];
                
                
                
                [alert show];
            }
            else
            {
                NowUserNum--;
                [ShowName setText:[UserData objectAtIndex:NowUserNum]];
                [self Check_Http];
            }
            [self Check_Down_Bu];
        }
    }
    else if (sender == Bu_Right)
    {
        if ([UserData count] > (NowUserNum + 1))
        {
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                                message:
                                      [self Get_DefineString:NONET]
                                      delegate
                                                                       : self cancelButtonTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                      otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                NowUserNum++;
                [ShowName setText:[UserData objectAtIndex:NowUserNum]];
                
                [self Check_Http ];
            }

            [self Check_Down_Bu];
        }
    }
    else if (sender == Bu_News)
    {
        [self Send_News:userAccount andHash:userHash];
    }
}

NSMutableData *Get_tempData;    //下載時暫存用的記憶體
NSURLConnection *Get_connect;
long long Get_expectedLength;        //檔案大小

NSURLConnection *Add_Connect;
NSMutableData *Add_tempData;    //下載時暫存用的記憶體
long long Add_expectedLength;        //檔案大小

NSURLConnection *Loc_Connect;
NSMutableData *Loc_tempData;    //下載時暫存用的記憶體
long long Loc_expectedLength;        //檔案大小

NSURLConnection *Sms_Connect;
NSMutableData *Sms_tempData;    //下載時暫存用的記憶體
long long Sms_expectedLength;        //檔案大小

NSURLConnection *Act_Connect;
NSMutableData *Act_tempData;    //下載時暫存用的記憶體
long long Act_expectedLength;        //檔案大小

NSURLConnection *Search_Connect;
NSMutableData *Search_tempData;    //下載時暫存用的記憶體
long long Search_expectedLength;        //檔案大小

NSString  *SaveAcc;
NSString  *SaveHash;

NSURLConnection *GetWiFi_Connect;
NSMutableData *GetWiFi_tempData;    //下載時暫存用的記憶體
long long GetWiFi_expectedLength;        //檔案大小

NSURLConnection *His_Connect;
NSMutableData *His_tempData;    //下載時暫存用的記憶體
long long His_expectedLength;        //檔案大小

NSURLConnection *WiFiList_Connect;
NSMutableData *WiFiList_tempData;    //下載時暫存用的記憶體
long long WiFiList_expectedLength;        //檔案大小

NSURLConnection *SetWiFi_Connect;
NSMutableData *SetWiFi_tempData;    //下載時暫存用的記憶體
long long SetWiFi_expectedLength;        //檔案大小

NSURLConnection *Save_Connect;
NSMutableData *Save_tempData;    //下載時暫存用的記憶體
long long Save_expectedLength;        //檔案大小


NSURLConnection *Set_Connect;
NSMutableData *Set_tempData;    //下載時暫存用的記憶體
long long Set_expectedLength;        //檔案大小



NSURLConnection *Date_Connect;
NSMutableData *Date_tempData;    //下載時暫存用的記憶體
long long Date_expectedLength;        //檔案大小

NSURLConnection *Del_Connect;
NSMutableData *Del_tempData;    //下載時暫存用的記憶體
long long Del_expectedLength;        //檔案大小

NSURLConnection *Clear_Connect;
NSMutableData *Clear_tempData;    //下載時暫存用的記憶體
long long Clear_expectedLength;        //檔案大小




NSURLConnection *Date_NewConnect;
NSMutableData *Date_NewtempData;    //下載時暫存用的記憶體
long long Date_NewexpectedLength;        //檔案大小


NSURLConnection *UploadPhoto_Connect;
NSMutableData *UploadPhoto_tempData;    //下載時暫存用的記憶體
long long UploadPhoto_expectedLength;        //檔案大小


NSURLConnection *UploadPhoto_Connect;
NSMutableData *UploadPhoto_tempData;    //下載時暫存用的記憶體
long long UploadPhoto_expectedLength;        //檔案大小

NSURLConnection *UploadFamilyPhoto_Connect;
NSMutableData *UploadFamilyPhoto_tempData;    //下載時暫存用的記憶體
long long UploadFamilyPhoto_expectedLength;        //檔案大小

NSURLConnection *UploadShowPhoto_Connect;
NSMutableData *UploadShowPhoto_tempData;    //下載時暫存用的記憶體
long long UploadShowPhoto_expectedLength;        //檔案大小

NSURLConnection *SosAndFamilyPhone_Connect;
NSMutableData *SosAndFamilyPhone_tempData;    //下載時暫存用的記憶體
long long SosAndFamilyPhone_expectedLength;        //檔案大小


NSURLConnection *UpdateUser_Connect;
NSMutableData *UpdateUser_tempData;    //下載時暫存用的記憶體
long long UpdateUser_expectedLength;        //檔案大小


NSURLConnection *UpdatePhone_Connect;
NSMutableData *UpdatePhone_tempData;    //下載時暫存用的記憶體
long long UpdatePhone_expectedLength;        //檔案大小

NSURLConnection *MedRemind_Connect;
NSMutableData *MedRemind_tempData;    //下載時暫存用的記憶體
long long MedRemind_expectedLength;        //檔案大小


NSURLConnection *HosRemind_Connect;
NSMutableData *HosRemind_tempData;    //下載時暫存用的記憶體
long long HosRemind_expectedLength;        //檔案大小

NSURLConnection *UpdateMed_Connect;
NSMutableData *UpdateMed_tempData;    //下載時暫存用的記憶體
long long UpdateMed_expectedLength;        //檔案大小

NSURLConnection *UpdateHos_Connect;
NSMutableData *UpdateHos_tempData;    //下載時暫存用的記憶體
long long UpdateHos_expectedLength;        //檔案大小


NSURLConnection *MBP_Connect;
NSMutableData *MBP_tempData;    //下載時暫存用的記憶體
long long MBP_expectedLength;        //檔案大小

NSURLConnection *MBO_Connect;
NSMutableData *MBO_tempData;    //下載時暫存用的記憶體
long long MBO_expectedLength;        //檔案大小

NSURLConnection *MBS_Connect;
NSMutableData *MBS_tempData;    //下載時暫存用的記憶體
long long MBS_expectedLength;        //檔案大小

NSURLConnection *MS_Connect;
NSMutableData *MS_tempData;    //下載時暫存用的記憶體
long long MS_expectedLength;        //檔案大小

NSURLConnection *MW_Connect;
NSMutableData *MW_tempData;    //下載時暫存用的記憶體
long long MW_expectedLength;        //檔案大小

NSURLConnection *UpdateBP_Connect;
NSMutableData *UpdateBP_tempData;    //下載時暫存用的記憶體
long long UpdateBP_expectedLength;        //檔案大小

NSURLConnection *UpdateBO_Connect;
NSMutableData *UpdateBO_tempData;    //下載時暫存用的記憶體
long long UpdateBO_expectedLength;        //檔案大小

NSURLConnection *UpdateBS_Connect;
NSMutableData *UpdateBS_tempData;    //下載時暫存用的記憶體
long long UpdateBS_expectedLength;        //檔案大小

NSURLConnection *UpdateSport_Connect;
NSMutableData *UpdateSport_tempData;    //下載時暫存用的記憶體
long long UpdateSport_expectedLength;        //檔案大小

NSURLConnection *UpdateWeight_Connect;
NSMutableData *UpdateWeight_tempData;    //下載時暫存用的記憶體
long long UpdateWeight_expectedLength;        //檔案大小

NSURLConnection *Call_Connect;
NSMutableData *Call_tempData;    //下載時暫存用的記憶體
long long Call_expectedLength;        //檔案大小

NSURLConnection *UpdateCall_Connect;
NSMutableData *UpdateCall_tempData;    //下載時暫存用的記憶體
long long UpdateCall_expectedLength;        //檔案大小

NSURLConnection *Dev_Connect;
NSMutableData *Dev_tempData;    //下載時暫存用的記憶體
long long Dev_expectedLength;        //檔案大小

NSURLConnection *Remind_Connect;
NSMutableData *Remind_tempData;    //下載時暫存用的記憶體
long long Remind_expectedLength;        //檔案大小


NSURLConnection *Fall_Connect;
NSMutableData *Fall_tempData;    //下載時暫存用的記憶體
long long Fall_expectedLength;        //檔案大小


NSURLConnection *UpdateFall_Connect;
NSMutableData *UpdateFall_tempData;    //下載時暫存用的記憶體
long long UpdateFall_expectedLength;        //檔案大小


NSURLConnection *UpdateDev_Connect;
NSMutableData *UpdateDev_tempData;    //下載時暫存用的記憶體
long long UpdateDev_expectedLength;        //檔案大小


NSURLConnection *Update_Connect;
NSMutableData *Update_tempData;    //下載時暫存用的記憶體
long long Update_expectedLength;        //檔案大小

NSURLConnection *LeaveRemind_Connect;
NSMutableData *LeaveRemind_tempData;    //下載時暫存用的記憶體
long long LeaveRemind_expectedLength;        //檔案大小

NSURLConnection *UpdateLeave_Connect;
NSMutableData *UpdateLeave_tempData;    //下載時暫存用的記憶體
long long UpdateLeave_expectedLength;        //檔案大小

NSURLConnection *News_Connect;
NSMutableData *News_tempData;    //下載時暫存用的記憶體
long long News_expectedLength;        //檔案大小

NSURLConnection *ActLeave_Connect;
NSMutableData *ActLeave_tempData;    //下載時暫存用的記憶體
long long ActLeave_expectedLength;        //檔案大小

NSURLConnection *MyAcc_Connect;
NSMutableData *MyAcc_tempData;    //下載時暫存用的記憶體
long long MyAcc_expectedLength;        //檔案大小

NSURLConnection *ChangePw_Connect;
NSMutableData *ChangePw_tempData;    //下載時暫存用的記憶體
long long ChangePw_expectedLength;        //檔案大小

NSURLConnection *ChangeUserInfo_Connect;
NSMutableData *ChangeUserInfo_tempData;    //下載時暫存用的記憶體
long long ChangeUserInfo_expectedLength;        //檔案大小


NSURLConnection *MapImei_Connect;
NSMutableData *MapImei_tempData;    //下載時暫存用的記憶體
long long MapImei_expectedLength;        //檔案大小

NSURLConnection *LangInfo_Connect;
NSMutableData *LangInfo_tempData;    //下載時暫存用的記憶體
long long LangInfo_expectedLength;        //檔案大小


NSURLConnection *TimeZoneInfo_Connect;
NSMutableData *TimeZoneInfo_tempData;    //下載時暫存用的記憶體
long long TimeZoneInfo_expectedLength;        //檔案大小


NSMutableData *Sync_tempData;    //下載時暫存用的記憶體
NSURLConnection *Sync_Connect;
long long Sync_expectedLength;        //檔案大小

NSMutableData *GpsSync_tempData;    //下載時暫存用的記憶體
NSURLConnection *GpsSync_Connect;
long long GpsSync_expectedLength;        //檔案大小


NSMutableData *ShowImage_tempData;    //下載時暫存用的記憶體
NSURLConnection *ShowImage_Connect;
long long ShowImage_expectedLength;        //檔案大小

//20140326 刪除親情照片
NSMutableData *DeleteFamilyImage_tempData;    //下載時暫存用的記憶體
NSURLConnection *DeleteFamilyImage_Connect;
long long DeleteFamilyImage_expectedLength;        //檔案大小

//20140326 刪除親情照片
NSMutableData *DeleteShowImage_tempData;    //下載時暫存用的記憶體
NSURLConnection *DeleteShowImage_Connect;
long long DeleteShowImage_expectedLength;        //檔案大小

//20140528 同步區間Get
NSURLConnection *Get_TWI_Connect;
NSMutableData *Get_TWI_tempData;    //下載時暫存用的記憶體
long long Get_TWI_expectedLength;        //檔案大小

//20140529 同步區間Save
NSURLConnection *Save_TWI_Connect;
NSMutableData *Save_TWI_tempData;    //下載時暫存用的記憶體
long long Save_TWI_expectedLength;        //檔案大小


//20140604 同步區間Get
NSURLConnection *Get_AA_Connect;
NSMutableData *Get_AA_tempData;    //下載時暫存用的記憶體
long long Get_AA_expectedLength;        //檔案大小

//201400604 同步區間Save
NSURLConnection *Save_AA_Connect;
NSMutableData *Save_AA_tempData;    //下載時暫存用的記憶體
long long Save_AA_expectedLength;        //檔案大小


//20140610 電子圍籬Get
NSURLConnection *Get_GEO_Connect;
NSMutableData *Get_GEO_tempData;    //下載時暫存用的記憶體
long long Get_GEO_expectedLength;        //檔案大小

//20150128 Missing program Jion Status
NSURLConnection *Get_Missing_Join_Stastus_Connect;
NSMutableData *Get_Missing_Join_Stastus_tempData;
long long Get_Missing_Join_Stastus_expectedLength;

//20150128 Missing program Jion Status _Link_Join_Action
NSURLConnection *Get_Missing_Join_Stastus_Link_Join_Action_Connect;
NSMutableData *Get_Missing_Join_Stastus_Link_Join_Action_tempData;
long long Get_Missing_Join_Stastus_Link_Join_Action_expectedLength;

//20150130 Missing program Jion Action
NSURLConnection *Set_Missing_Join_Stastus_Connect;
NSMutableData *Set_Missing_Join_Stastus_tempData;
long long Set_Missing_Join_Stastus_expectedLength;

//201400610 電子圍籬Save
NSURLConnection *Save_GEO_Connect;
NSMutableData *Save_GEO_tempData;    //下載時暫存用的記憶體
long long Save_GEO_expectedLength;        //檔案大小
//20140611 電子圍籬Get
NSURLConnection *Get_GEO_NORP_Connect;
NSMutableData *Get_GEO_NORP_tempData;    //下載時暫存用的記憶體
long long Get_GEO_NORP_expectedLength;        //檔案大小

//201400610 電子圍籬Save_Enable
NSURLConnection *Save_GEO_Enable_Connect;
NSMutableData *Save_GEO_Enable_tempData;    //下載時暫存用的記憶體
long long Save_GEO_Enable_expectedLength;

//201400613 電子圍籬 delete
NSURLConnection *Delete_GEO_Connect;
NSMutableData *Delete_GEO_tempData;    //下載時暫存用的記憶體
long long Delete_GEO_expectedLength;

//
NSURLConnection *UpDate_Token_Connect;
NSMutableData *UpDate_Token_tempData;    //下載時暫存用的記憶體
long long UpDate_Token_expectedLength;        //檔案大小

//
NSURLConnection *GCareGetSOSTracking_Connect;
NSMutableData *GCareGetSOSTracking_tempData;    //下載時暫存用的記憶體
long long GCareGetSOSTracking_expectedLength;        //檔案大小

//pick顯示資料暫存
-(void) SetPrData:(NSString *)SaveDate
{
    tmpSaveData = [NSString stringWithFormat:@"%@", SaveDate];
}

NSURLConnection *Get_Connect;
NSMutableData *Get_tempData;    //下載時暫存用的記憶體
long long Get_expectedLength;        //檔案大小
BOOL    Is_Get1_Sw = false;

#pragma mark - 历史记录
- (void)Set_NewGetNum:(int)SetNum
{
    GetNum = SetNum;
    [(MyHisView *)MyHisView setNowSelect:GetNum];
    switch (GetNum)
    {
        case 1:     //緊急求救
            [self Send_SOSAcc:userAccount andHash:userHash];
            
            break;
            
        case 2:     //跌倒
            [self Send_SOS2Acc:userAccount andHash:userHash];
            break;
            
        case 3:     //離家紀錄
            [self Send_SOS3Acc:userAccount andHash:userHash];
            break;
            
        case 4:     //通話
            [self Send_SOS4Acc:userAccount andHash:userHash];
            break;
        case 5:     //activity alert
            [self Send_SOS5Acc:userAccount andHash:userHash];
            break;
        case 6:     //geo fence
            [self Send_SOS6Acc:userAccount andHash:userHash];
            break;
        case 7:     //geo fence
            [self Send_SOS7Acc:userAccount andHash:userHash];
            break;
    }
}

// 折線圖範圍放大 mousedown觸發
- (IBAction)Big_MouseDown:(id)sender
{
    NSLog(@"is 1");
}

// 折線圖範圍縮小觸發
- (IBAction)Small_MouseDown:(id)sender
{
     NSLog(@"is 2");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (error.code == ErrorTimeOut) {
        NSLog(@"Time out!");
        [self showMsg:NSLocalizedStringFromTable(@"ErrorTimeOut", INFOPLIST, nil) andTag:1001];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                              [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                        message:
                              [ self Get_DefineString:NONET]
                              delegate
                                                               : self cancelButtonTitle:
                              [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                              otherButtonTitles: nil];
        
        [alert show];
    }
    
    NeedQuit_Sw = true;
}

- (void)showMsg:(NSString*) strMsg andTag:(int) tag{
    NSLog(@"%@",strMsg);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                          message:NSLocalizedStringFromTable(strMsg, INFOPLIST, nil)
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    alert.tag = tag;
    [alert show];
}



-(void)Ctl_LoadingView:(BOOL)Enable_Sw
{
    
    if(Enable_Sw)
    {
        if( HaveLoading_Sw )
        {
            
        }
        else
        {
            [self addSubview:LoadingView];
            HaveLoading_Sw = true;
            
        }
    }
    else
    {
        if(HaveLoading_Sw)
        {
            [LoadingView removeFromSuperview];
            HaveLoading_Sw = false;
            
        }
        
    }
    
}

- (void)addloadingView
{
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
    }

    [HUD show:YES];
}

#pragma mark - 活动区域展示定时器
- (void)procTime:(NSTimer*)timer
{
    switch (IF_State)
    {
        case IF_ACT:
            TickCount++;
            if ( TickCount > 9)
            {
                TickCount = 0;
                [(MyActView *)MyActView TimeProc];
            }
            break;
        default:
            break;
    }
}

// main  時間計數器控制
- (void)Ctl_MyTimer:(BOOL)Enable_Sw
{
    if (Enable_Sw == NO) return;

    if (MyTimer == nil) {
        MyTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                   target:self
                                                 selector:@selector(procTime:)
                                                 userInfo:nil
                                                  repeats:YES];
    }
}

#pragma mark - 其他view按钮点击事件
- (void)Other_MouseDown:(int)DownNum
{
    [Bu_Save removeTarget:nil
                   action:NULL
         forControlEvents:UIControlEventAllEvents];

    NSLog(@"Other_MouseDown = %i", DownNum);

    switch (DownNum)
    {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            if([checkNetwork check] == false)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_TITLE]
                                                                message:
                                      [self Get_DefineString:NONET]
                                      delegate
                                                                       : self cancelButtonTitle:
                                      [self Get_DefineString:ALERT_MESSAGE_CLOSE]
                                                      otherButtonTitles: nil];
                
                [alert show];
            }
            else
            {
                ShowNum = DownNum;
                NSDate *originalDate = [NSDate date];
                NSTimeInterval interval;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:DEFAULTDATE];
                NSDate * futureDate;
                
                interval = - 24*60*60;
                futureDate = [originalDate dateByAddingTimeInterval:interval];
                
//                searchStart = [formatter stringFromDate:futureDate];
//                searchEnd = [formatter stringFromDate:originalDate];
                
                isMainBtn = YES;
                
                [self Send_UserRemind:userAccount andHash:userHash];
                
//                [self MyTest:userAccount AndHash:userHash StartTime:searchStart andEndTime:searchEnd];
            }
            
//            [self Change_State:IF_SHOWLIST];
            break;
        case 6:
            [self Change_State:IF_HealthSteps];
            break;
        case 41:
        case 42:
            [(MyDatePickerView *)MyDatePickerView Set_Label:DownNum-40:tmpSaveData:TRUE];
            [self Change_State:IF_DATESEL];
            break;
            
        case 81:
        case 82:
            [(MyDatePickerView *)MyDatePickerView Set_Label:DownNum-80:tmpSaveData:FALSE];
            [self Change_State:IF_DATESEL];
            break;
            
            
        case 51:
        case 52:
        case 53:
        case 54:
        case 55:
            [self Change_State:IF_EATSEL];
            break;

        case 91:
            NSLog(@"Click first 91");
            [self Change_State:IF_MEASURERE];
            break;

        case 92://通話限制
            [Bu_Save addTarget:self action:@selector(saveSetCall:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            nextState = 92;
            [self Send_GetGpsSync:userAccount andHash:userHash];
            break;

        case 93://硬體設定
            [Bu_Save addTarget:self
                        action:@selector(saveDevSet:)
              forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"]
                               forState:UIControlStateNormal];
            nextState = 93;
            [self Send_LangInfo:userAccount andHash:userHash];
            break;

        case 94://跌倒設定
            [Bu_Save addTarget:self action:@selector(saveFallSet:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserFallSet:userAccount andHash:userHash];
               
            break;
        
        case 95://離家提醒
            [Bu_Save addTarget:self action:@selector(saveLeaveSet:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            
            [self Send_UserLeaveSet:userAccount andHash:userHash];

            break;
            
        case 96://展示照片
            [self Send_ShowImage:userAccount andHash:userHash];
            break;
        case 97://活動量提醒
            NSLog(@"97活動量提醒");
//            [self Send_ShowImage:userAccount andHash:userHash];
//            [Bu_Save setHidden:NO];
//            [Bu_Save addTarget:self action:@selector(saveActAlertSet:) forControlEvents:UIControlEventTouchUpInside];
//            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
//            //            [self Send_ShowImage:userAccount andHash:userHash];
//            nextState = 97;
//            //call api 無動做
//            [self Get_AA_Setting:userAccount andHash:userHash];
//            [self Send_GetGpsSync:userAccount andHash:userHash];
//            [self Change_State:IF_ACTALERT];
            break;
        case 98://同步時段
            NSLog(@"98同步時段");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveTWISet:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
//            [self Send_ShowImage:userAccount andHash:userHash];
            nextState = 98;
            [self Send_GetGpsSync:userAccount andHash:userHash];
//            [self Change_State:IF_TWI];
            break;
        case 99:    // 自建定位
            nextState = 99;
            [self Get_WiFiList:userAccount andHash:userHash];
            break;

        case 100://電子圍籬
            NSLog(@"100 Missing");
            [self Get_Missing_Join_Stastus_Link_Join_ActionWithAcc:userAccount];
//            [self Get_GEO_Setting:userAccount andHash:userHash];
            break;

        case 951://離家提醒地圖
            [Bu_Save addTarget:self action:@selector(saveAddr:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Change_State:IF_LEAVEMAP];
            break;

        case 952://離家提醒完成地址編輯後不重新下載
            [Bu_Save addTarget:self action:@selector(saveLeaveSet:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Change_State:IF_LEAVEREMIND];
            break;

        case 101://血壓提醒
            NSLog(@"BPRemind");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveBPRemind:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserBPRemind:userAccount andHash:userHash];
            break;
            
        case 102://血糖提醒
            NSLog(@"BSRemind");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveBSRemind:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserBSRemind:userAccount andHash:userHash];
            
            
            break;
        
        case 103://血氧提醒
            NSLog(@"BORemind");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveBORemind:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserBORemind:userAccount andHash:userHash];
            
            break;
            
        case 104://體重資訊
            NSLog(@"WeRemind");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveWeightRemind:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserWeightRemind:userAccount andHash:userHash];
            
            break;
        
        case 105://運動資訊
            NSLog(@"SportRemind");
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(saveSportRemind:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
            [self Send_UserSportRemind:userAccount andHash:userHash];
            
            break;
        
        case 61://歷史紀錄 求救
            [self Set_NewGetNum:1];
            break;
        
        case 62://歷史紀錄 跌倒
            [self Set_NewGetNum:2];
            break;
            
        case 63://歷史紀錄 離家
            [self Set_NewGetNum:3];
            break;
            
        case 64://歷史紀錄 通話
            [self Set_NewGetNum:4];
            break;
        case 65://歷史紀錄 無動作 activity alert
            [self Set_NewGetNum:5];
            break;
        case 66://歷史紀錄 電子圍籬
            [self Set_NewGetNum:6];
            break;
        case 67://歷史紀錄 Timer alert
            [self Set_NewGetNum:7];
            break;
        case 611://歷史紀錄 求救 地圖
            break;

        case 71:
        case 72:
            [self Change_State:IF_DATESHOW];
            break;

        case 1001:      //我的帳號
            [self Send_MyUserAccount:userAccount andHash:userHash];
            break;

        case 1004:      //佩戴者管理
            [Bu_Save setHidden:NO];
            [Bu_Save addTarget:self action:@selector(addNewMember:) forControlEvents:UIControlEventTouchUpInside];
            [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_add.png"] forState:UIControlStateNormal];
            [(GroupMemberView *)GroupMemberView Do_Init:self];
            [(GroupMemberView *)GroupMemberView Set_Init:NowUserNum];
            [self Change_State:IF_GROUPMEMBER];
            break;

        case 1005:      //最新消息內容
            [self Change_State:IF_NEWSCONTENT];
            break;
        case 1100:      // 常见问题
            [freqQuestionView do_init:self];
            [self Change_State:IF_FREQ_QUESTION];
            break;
        case 2100:      // 免责声明
            [disclaimerView do_init:self];
            [self Change_State:IF_FREQ_DISCLAIMER];
            break;
        default:
            break;
    }
}

#pragma mark - 问题详情
- (void)pushFreqQuestionDetailViewWithModel:(KMFAQModel *)model
{
    [freqQuestionDetailView do_init:model];
    [self Change_State:IF_FREQ_QUESTION_DETAIL];
}

//新增使用者
-(IBAction)addNewMember:(id)sender
{
    [(GroupMemberView *)GroupMemberView addTypeSelect];
}

//新增帳號使用IMEI
-(void) addAccByImei:(NSString *)imei
{
    [self Send_AddUserByIMEI:userAccount AndHash:userHash AndImei:imei];
}

//最新消息內容顯示
-(void)NewsContent:(NSDictionary *)dic
{
    [(NewsContentView *)NewsContentView Do_Init:self];
    [(NewsContentView *)NewsContentView Set_Init:dic];
}



//切換畫面至吃藥提醒設定
-(void)setEatMedDic:(NSDictionary *)dic
{
    [Bu_Save setHidden:NO];
    [Bu_Save removeTarget:self action:@selector(saveHosRemind:) forControlEvents:UIControlEventTouchUpInside];
    [Bu_Save addTarget:self action:@selector(saveMedRemind:) forControlEvents:UIControlEventTouchUpInside];
    [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];

    [(MyEatPickView *)MyEatPickView Do_Init:self andType:1];
    [(MyEatPickView *)MyEatPickView SetMed_initWithDic:dic];
    [self Change_State:IF_EATSEL];
}

//切換畫面至回診提醒設定
-(void)setHosDic:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);
    [Bu_Save setHidden:NO];
    [Bu_Save removeTarget:self action:@selector(saveMedRemind:) forControlEvents:UIControlEventTouchUpInside];
    [Bu_Save addTarget:self action:@selector(saveHosRemind:) forControlEvents:UIControlEventTouchUpInside];
    [Bu_Save setBackgroundImage:[UIImage imageNamed:@"icon_btn_save_w.png"] forState:UIControlStateNormal];
    //    (MyEatPickView *)MyEatPickView;
    [(MyEatPickView *)MyEatPickView Do_Init:self andType:2];
    [(MyEatPickView *)MyEatPickView SetHos_initWithDic:dic];
    [self Change_State:IF_EATSEL];
}


//儲存吃藥或回診提醒
-(IBAction)saveMedRemind:(id)sender
{
    [(MyEatPickView *)MyEatPickView SaveMed];
}

//儲存吃藥或回診提醒
-(IBAction)saveHosRemind:(id)sender
{
    [(MyEatPickView *)MyEatPickView SaveHos];
}

//儲存血壓資訊
-(IBAction)saveBPRemind:(id)sender
{
    NSLog(@"Save Bp Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTestAcc
    [(BPRemindView *)BPRemindView SaveBP];
}

//儲存血糖資訊
-(IBAction)saveBSRemind:(id)sender
{
    NSLog(@"Save BS Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    [(BSRemindView *)BSRemindView SaveBS];
}

//儲存血氧資訊
-(IBAction)saveBORemind:(id)sender
{
    NSLog(@"Save BO Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    //isTestAcc End
    [(BORemindView *)BORemindView SaveBO];
}

//儲存運動資訊
-(IBAction)saveSportRemind:(id)sender
{
    NSLog(@"Save Sport Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    [(SportRemindView *)SportRemindView SaveSport];
}

//儲存體重資訊
-(IBAction)saveWeightRemind:(id)sender
{
    NSLog(@"saveWeightRemind");

    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);

    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)
                                                       message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil)
                                                      delegate:self
                                             cancelButtonTitle:kLoadString(@"OK")
                                             otherButtonTitles: nil];
        [alert show];
        return;
    }

    [(WeightRemindView *)WeightRemindView SaveWeight];
}

//儲存血壓資訊
-(IBAction)saveSetCall:(id)sender
{
    NSLog(@"Save CallLimit Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    [(CallLimit *)CallLimit SaveCall];
}

#pragma mark - 儲存TWI
-(IBAction)saveTWISet:(id)sender{
    NSLog(@"儲存TWI");
    [(trackingWithInterval *)tWI SaveSetting];
    
}

#pragma mark - 儲存 act alert
-(IBAction)saveActAlertSet:(id)sender{
    NSLog(@"儲存Act alert");//無動作
    [(ActivityAlert *)ActAlert SaveSetting];
    
}


#pragma mark - 儲存硬體設定
-(IBAction)saveDevSet:(id)sender
{
    NSLog(@"Save DeviceSet Remind");
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
        [alert show];
        return;
    }
    [(DeviceSet *)DeviceSet SaveDevSet];
}
#pragma mark -

//儲存跌倒設定
-(IBAction)saveFallSet:(id)sender
{
    NSLog(@"Save FallSet Remind");
    [(FallSet *)FallSet SaveFallSet];
}

//儲存跌倒設定
-(IBAction)saveLeaveSet:(id)sender
{
    NSLog(@"Save Leave Remind");
    [(LeaveRemind *)LeaveRemind SaveLeaveSet];
}


-(IBAction)saveAddr:(id)sender
{
    NSDictionary *dic = [(LeaveMap *)LeaveMap saveAddr];
    
    [(LeaveRemind *)LeaveRemind ChangeAddr:dic];
    [self Other_MouseDown:952];
    
}

// 儲存Device token
-(void)Set_DToekn:(NSString *)Mytoken
{
    NSLog(@"tmpsave token1 = %@",Mytoken);
    tmpSaveToken = Mytoken;
    
}

//設定頁隱私權mousedown 回傳
- (void)InsertLaw
{
    HaveInsertLaw_Sw = true;

    NSString *deviceType = [UIDevice currentDevice].model;

    if ([deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        MyLawView.frame =  CGRectMake(0, 90, 320, 390);
        [self addSubview:MyLawView ];
    }
    else
    {
        MyLawView.frame = CGRectMake(0, 194, 768 , 830);
        [self addSubview:MyLawView];
    }
}

//設定頁服務條款mousedown 回傳
- (void)InsertLaw2
{
    HaveInsertLaw2_Sw = true;

    NSString *deviceType = [UIDevice currentDevice].model;

    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        MyLawView22.frame = CGRectMake(0, 90, 320, 390);
        [self addSubview:MyLawView22 ];
    }
    else
    {
        MyLawView22.frame = CGRectMake(0, 194, 768 , 830);
        [self addSubview:MyLawView22];
    }
}

//推播點擊後 跳流程判斷
- (void)Go_State:(int)NewState
{
    NSLog(@"nowuser = %i", NowUserNum);

    switch (NewState)
    {
        case 1:
            [self Send_UserSet:userAccount AndHash:userHash];
            break;
        case 3:     // SOS
            [self GcareGetSOSTrackingWithAcc:[AccData objectAtIndex:NowUserNum]];
            break;
        case 205://無動作
            [self Set_NewGetNum:5];
            break;
        case 206://無動作
            [self Set_NewGetNum:6];
            break;
        case 207://無動作
            [self Set_NewGetNum:7];
            break;
        case 4:
            ShowNum = 1;
//            [self MyTest:[AccData objectAtIndex:NowUserNum] :[HashData objectAtIndex:NowUserNum]StartTime:@"2013/06/17 00:00:00" andEndTime:@"2013/06/24 23:59:59"];
            
            //123456789
            
//            [self MyTest:userAccount AndHash:userHash StartTime:searchStart andEndTime:searchEnd];
            
//            [self Send_UserRemind:userAccount andHash:userHash];
//            
//            [self Change_State:IF_SHOWLSEL];
//            [self Change_State:IF_SHOWLIST];
            [self Other_MouseDown:ShowNum];
            break;
    }
}

//判斷目前語系
- (void)Check_Mode
{
    if( NowMode < 1)
    {
        return;
    }

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* arrayLanguages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [arrayLanguages objectAtIndex:0];

    if ([currentLanguage hasPrefix:@"zh-"]) {  // cn
        if( NowMode != 2) {
            if(Array_show.count > 0)
            {
                [Array_show removeAllObjects];
            }
            
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_cn" ofType:@"plist"];
            Array_show =   [[NSMutableDictionary  alloc] initWithContentsOfFile:plistPath];
            
            NowMode  = 2;
        }
    } else {        // en
        if (NowMode != 1) {
            if(Array_show.count > 0) {
                [Array_show removeAllObjects];
            }

            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"show_en" ofType:@"plist"];
            Array_show =   [[NSMutableDictionary  alloc] initWithContentsOfFile:plistPath];

            NowMode = 1;
        }
    }
}

//判斷佩帶者切換按鈕的顯示狀態 第一筆只能有向右 最後一筆只能有向左
- (void)Check_Down_Bu
{
    int NowCount = [UserData count];

    if( NowCount <= 1 )
    {
        [Bu_Left setHidden:YES];
        [Bu_Right setHidden:YES];

        return;
    }
    
    if(NowUserNum == 0)
    {
        [Bu_Left setHidden:YES];
        [Bu_Right setHidden:NO];
    }
    else
    {
        if( NowUserNum == (NowCount - 1))
        {
            [Bu_Left setHidden:NO];
            [Bu_Right setHidden:YES];
        }
        else
        {
            [Bu_Left setHidden:NO];
            [Bu_Right setHidden:NO];
        }
    }
}

- (void)Set_Google:(int)SetNum
{
    if (SetNum == 1)
    {
        Is_Google_SW = false;
    }
    else
    {
        Is_Google_SW = true;
    }
}

//判斷是否有佩帶者資料
- (bool)CheckGoogle
{
    if (Is_Google_SW) {
        NSLog(@"is google sw");
    }
    else
    {
        NSLog(@"is baidu sw");
    }

    return  Is_Google_SW;
}


//設定每個icon的背景顏色
- (void)SetBgView:(UIView *)bgView AndColor:(UIColor *)changeColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[changeColor CGColor],(id)[[UIColor whiteColor] CGColor],  nil]; // 由上到下的漸層顏色
    [bgView.layer insertSublayer:gradient atIndex:0];
    bgView.layer.cornerRadius = 8.0f;
    bgView.layer.masksToBounds = YES;

//    暫時先移除  因為會造成畫面停頓的問題
//    bgView.layer.shadowColor = [[UIColor whiteColor] CGColor];
//    bgView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
//    bgView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
//    bgView.layer.shadowRadius = 10.0f; // 陰影發散的程度
}

// 重新讀取佩戴者資料與下方切換使用者同步更新
- (void)ReloadUserData
{
    [self getUserAndUpdateAcc:userAccount andPwd:userHash andToken:tmpSaveToken];
}

//取得使用者並更新
-(void)getUserAndUpdateAcc:(NSString *)acc andPwd:(NSString *)hash andToken:(NSString *)token
{
    NSLog(@"log = account = %@",AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);
    NSString *httpBodyString;

    if(token.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&token=012345&device=0&appid=%i",acc, hash,dateString,APPID];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&device=iOS&token=%@&appid=%i",acc, hash,dateString,token,APPID];
    }

    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];

    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogin.html",INK_Url_1];

    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];

    Update_tempData = [NSMutableData alloc];
    Update_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//讀取本機端儲存的佩帶者資料
-(void)LoadUserData
{
    NSLog(@"load user data");
    
    
    [UserData removeAllObjects];
    [PhoneData removeAllObjects];
    [AccData removeAllObjects];
    [HashData removeAllObjects];
    
    
    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"totalcount"];
    
    userAccount = [defaults stringForKey:@"userAccount"];
    userHash = [defaults stringForKey:@"userHash"];
    
    ////
    NSArray *tmpArr = [defaults objectForKey:@"accList"];
    //擋住使用者
    NSMutableArray *tmpList = [NSMutableArray new];
    int accNum = 0;
    
    for (int i=0; i<[tmpArr count]; i++) {
        //擋住使用者
        //        if ([[[tmpArr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
        if ([[NSString stringWithFormat:@"%@",[[tmpArr objectAtIndex:i] objectForKey:@"type"] ] isEqualToString:UserDeviceType1] ||
            [[NSString stringWithFormat:@"%@",[[tmpArr objectAtIndex:i] objectForKey:@"type"] ] isEqualToString:UserDeviceType2]
            )
        {
            //擋住使用者
            [tmpList addObject:[tmpArr objectAtIndex:i]];
            //accdata
            [defaults setObject:[[tmpArr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
            [AccData addObject:[defaults objectForKey:[NSString stringWithFormat:@"Acc%i",accNum+1]]];
            
            //userdata
            [defaults setObject:[[tmpArr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
            [UserData addObject:[defaults objectForKey:[NSString stringWithFormat:@"Name%i",accNum+1]]];
            if(accNum==0)//第一位使用者
            {
                [ShowName setText:[defaults objectForKey:[NSString stringWithFormat:@"Name%i",accNum+1]]];
            }
            
            //phonedata
            [defaults setObject:[[tmpArr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
            [PhoneData addObject:[defaults objectForKey:[NSString stringWithFormat:@"Phone%i",accNum+1]]];
            
            
            [defaults setObject:[[tmpArr objectAtIndex:i] objectForKey:@"type"] forKey:[NSString stringWithFormat:@"Type%i",accNum+1]];
            
            NSLog(@"account Acc %@ Key %@",[[tmpArr objectAtIndex:i] objectForKey:@"account"],[NSString stringWithFormat:@"Acc%i",accNum+1]);
            NSLog(@"Name %@ Key %@",[[tmpArr objectAtIndex:i] objectForKey:@"name"],[NSString stringWithFormat:@"Name%i",accNum+1]);
            
            accNum++;
        }
    }
    
    //檔住使用者
    //save accList
    //    NSLog(@"<#string#>")
    [defaults setObject:tmpList forKey:@"accList"];
    //save totalcount
    [defaults setObject:@([tmpList count]) forKey:@"totalcount"];
    ///
    //    for(int i=0;i<Value1;i++)
    //    {
    //        NSString *str1 = [NSString stringWithFormat:@"Name%d", i+1];
    //        NSString *savedValue = [defaults   stringForKey:str1];
    //        [UserData addObject:savedValue];
    //
    //        if(i==0)
    //        {
    //            [ShowName setText:savedValue];
    //        }
    //
    //
    //        NSString *str2 = [NSString stringWithFormat:@"Phone%d", i+1];
    //        NSString *savedValue2 = [defaults   stringForKey:str2];
    //        [PhoneData addObject:savedValue2];
    //
    //
    //        NSString *str3 = [NSString stringWithFormat:@"Acc%d", i+1];
    //        NSString *savedValue3 = [defaults   stringForKey:str3];
    //        [AccData addObject:savedValue3];
    //    }
    //
    NowUserNum =0;
    
    [(MySetView *)MySetView  Set_Go:NowUserNum];
    
    //檢查是否有輸入設備電話
    NSLog(@"isQRcodeLogin = %@",[defaults objectForKey:@"isQRcodeLogin"]);
    NSArray *accList = [defaults objectForKey:@"accList"];
    //是否經由QRcode登入
    if ([[defaults objectForKey:@"isQRcodeLogin"] isEqualToString:@"YES"] ) {
        if (accList.count == 0) { //沒有設備
            //        return;
        }
        else{//有設備，只抓第一個
            NSString *phone = [[accList objectAtIndex:0] objectForKey:@"phone"];
            if ([phone length] == 0) {//電話長度=0,無設備電話
                [self Main_MouseDown:Bu1];//到配戴者資訊
                [defaults setObject:@"YES" forKey:@"NeedPhoneRemind"];
                //                UIAlertView *alert;
                //                alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SetDevicePhoneNumber", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
                //                [alert show];
                [defaults removeObjectForKey:@"isQRcodeLogin"];
            }
        }
    }
    //檢查是否有輸入設備電話 end
}

//更新使用者
-(void)reloadAcc
{
    [UserData removeAllObjects];
    [PhoneData removeAllObjects];
    [AccData removeAllObjects];
    [HashData removeAllObjects];

    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"totalcount"];

    userAccount = [defaults stringForKey:@"userAccount"];
    userHash = [defaults stringForKey:@"userHash"];

    for(int i=0;i<Value1;i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"Name%d", i+1];
        NSString *savedValue = [defaults   stringForKey:str1];
        [UserData addObject:savedValue];

        if(i==NowUserNum)
        {
            [ShowName setText:savedValue];
        }

        NSString *str2 = [NSString stringWithFormat:@"Phone%d", i+1];
        NSString *savedValue2 = [defaults   stringForKey:str2];
        [PhoneData addObject:savedValue2];

        NSString *str3 = [NSString stringWithFormat:@"Acc%d", i+1];
        NSString *savedValue3 = [defaults   stringForKey:str3];
        [AccData addObject:savedValue3];
    }
}

//設定設定頁的勾選使用者
-(void) Set_Go:(int)NowSetNum
{
    NowUserNum = NowSetNum;
    NSLog(@"show name = %i",NowSetNum);
    
    [ShowName setText:[UserData objectAtIndex:NowUserNum]];
    [(MySetView *)MySetView  Set_Go:NowUserNum];
    [self Check_Down_Bu];
}

//儲存佩帶者資料於本機
-(void)SaveNewData2:(NSString*)Name :(NSString*)Phone :(NSString*)Acc :(NSString*)Hash
{
    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];

    Value1 = [defaults integerForKey:@"totalcount"];

    Value1++;

    NSString *str1 = [NSString stringWithFormat:@"Name%d", Value1];
    [defaults setObject:Name forKey:str1];

    NSString *str2 = [NSString stringWithFormat:@"Phone%d", Value1];
    [defaults setObject:Phone forKey:str2];
    [defaults setInteger:Value1 forKey:@"totalcount"];

    NSString *str3 = [NSString stringWithFormat:@"Acc%d", Value1];
    [defaults setObject:Acc forKey:str3];

    NSString *str4 = [NSString stringWithFormat:@"Hash%d", Value1];
    [defaults setObject:Hash forKey:str4];

    [defaults synchronize];
}

//儲存佩帶者資料於本機(檢查是否存在)
-(void)SaveNewData:(NSString*)Name :(NSString*)Phone :(NSString*)Acc :(NSString*)Hash
{
    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    Value1 = [defaults integerForKey:@"totalcount"];
    
    int Szlen = [UserData count];

    for(int j =0;j<Szlen;j++)
    {
        NSString *tmpstr = [UserData objectAtIndex:j];
        
        if( [tmpstr isEqualToString:Name]  )
        {
            NSLog(@"Have data");
            return;
        }
    }

    Value1++;

    NSString *str1 = [NSString stringWithFormat:@"Name%d", Value1];
    [defaults setObject:Name forKey:str1];

    NSString *str2 = [NSString stringWithFormat:@"Phone%d", Value1];
    [defaults setObject:Phone forKey:str2];
    [defaults setInteger:Value1 forKey:@"totalcount"];

    NSString *str3 = [NSString stringWithFormat:@"Acc%d", Value1];
    [defaults setObject:Acc forKey:str3];

    NSString *str4 = [NSString stringWithFormat:@"Hash%d", Value1];
    [defaults setObject:Hash forKey:str4];

    [defaults synchronize];
}

#pragma mark - 移除state
- (void) Remove_State:(int)NewState
{
    NSLog(@"Remove_State -> %d", NewState);
    switch (NewState)
    {
        case IF_HealthSteps:
            [(UIView *)healthStepsView removeFromSuperview];
            break;

        case IF_USERDATE:
            [ (UIView *)UserDateView removeFromSuperview];
            break;

        case IF_HIS:
            [(UIView *)MyHisView removeFromSuperview];
            break;

        case IF_ACT:            // 活动区域
            [(UIView *)MyActView removeFromSuperview];
            break;

        case IF_ACT_SEARCH:     // 活动区域搜索
            [myActSearchView removeFromSuperview];
            break;

        case IF_EATSEL:
            [(UIView *)MyEatPickView removeFromSuperview];
            break;

        case IF_EATSHOW:
            [(UIView *)MyEatShowView removeFromSuperview];
            break;

        case IF_DATESHOW:
            [(UIView *)MyDateShowView removeFromSuperview];
            break;

        case IF_DATESEL:
            [(UIView *)MyDatePickerView removeFromSuperview];
            break;

        case IF_SHOWLSEL:
            [(UIView *)MySelView removeFromSuperview];
            break;
            
        case IF_USERSET:
            [(UIView *)UserSetView removeFromSuperview];
            break;

        case IF_SETTING:
            [(UIView *)MySetView removeFromSuperview];
            break;
            
        case IF_MAP:
            [(UIView *)MyMapView removeFromSuperview];
            break;

        case IF_SHOWLIST:
            [(UIView *)ListView removeFromSuperview];
            break;

        case IF_MEASURERE:
            [(UIView *)MeasureRemind removeFromSuperview];
            break;

        case IF_BPREMIND:
            [(UIView *)BPRemindView removeFromSuperview];
            break;

        case IF_BOREMIND:
            [(UIView *)BORemindView removeFromSuperview];
            break;

        case IF_BSREMIND:
            [(UIView *)BSRemindView removeFromSuperview];
            break;

        case IF_SPORTREMIND:
            [(UIView *)SportRemindView removeFromSuperview];
            break;

        case IF_WEIGHTREMIND:
            [(UIView *)WeightRemindView removeFromSuperview];
            break;

        case IF_CALL:
            [(UIView *)CallLimit removeFromSuperview];
            break;

        case IF_DEVSET:
            [(UIView *)DeviceSet removeFromSuperview];
            break;

        case IF_FALLSET:
            [(UIView *)FallSet removeFromSuperview];
            break;

        case IF_HISMAP:
            [(UIView *)MyHisMapView removeFromSuperview];
            break;

        case IF_GROUPMEMBER:
            [(UIView *)GroupMemberView removeFromSuperview];
            break;
        
        case IF_MYACCOUNT:
            [(UIView *)MyAccountView removeFromSuperview];
            break;

        case IF_LEAVEREMIND:
            [(UIView *)LeaveRemind removeFromSuperview];
            break;

        case IF_LEAVEMAP:
            [(UIView *)LeaveMap removeFromSuperview];
            break;

        case IF_NEWSINFO:
            [(UIView *)NewsView removeFromSuperview];
            break;

        case IF_NEWSCONTENT:
            [(UIView *)NewsContentView removeFromSuperview];
            break;
            
        case IF_SHOWIMAGE:
            [(UIView *)ShowImageView removeFromSuperview];
            break;
        case IF_CUSTOMCHART:
            [(UIView*)chartCustom removeFromSuperview];
            break;
        case IF_TWI:
            [(UIView*)tWI removeFromSuperview];
            break;
        case IF_ACTALERT:
            [(UIView*)ActAlert removeFromSuperview];
            break;
        case IF_GeoFS:
            [(UIView*)geoFS removeFromSuperview];
            break;
        case IF_AutoLocating:
            [(UIView*)AutoLocatingView removeFromSuperview];
            break;
        case IF_LocatingEdit:
            [(UIView*)LocatingEditView removeFromSuperview];
            break;
        case IF_FREQ_QUESTION:
            [freqQuestionView removeFromSuperview];
            break;
        case IF_FREQ_QUESTION_DETAIL:
            [freqQuestionDetailView removeFromSuperview];
            break;
        case IF_FREQ_DISCLAIMER:
            [disclaimerView removeFromSuperview];
            break;
        default:
            break;
    }
}

#pragma mark -

// 判斷是否有佩帶者資料
- (BOOL)CheckTotal
{
    if ([UserData count] <1)
    {
        return  true;
    }

    return false;
}

//取得plist設定字串
- (NSString *)Get_DefineString:(NSString *)SetStr
{
    NSString *string = [Array_show objectForKey:SetStr];
    if (string.length == 0) {
        string = @"OK";
    }

    return string;
}

//變更設定頁佩帶者顯示
-(void)Set_SetView
{
    NSLog(@"set view ");
    
    NSLog(@"tmp token3 = %@",tmpSaveToken);
    
    
    [(MySetView *)MySetView Do_Init:self];
    
    for(int j =0;j<[UserData count];j++)
    {
        
        [(MySetView *)MySetView Insert_Data:[UserData objectAtIndex:j] ];
    }
     
}

#pragma mark - 变更状态

- (void)Change_State:(int)NewState
{
    NSLog(@"Change_State: [%d -> %d]", IF_State, NewState);

    if (IF_State != NewState)
    {
        [Bu_MapSet setHidden:YES];
        [Bu_Save setHidden:YES];

        [self Remove_State:IF_State];

        TickCount = 0;

        //設備電話判斷
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *strT = [defaults objectForKey:@"NeedPhoneRemind"];
        //設備電話判斷 end

        if (NewState == 1) {
            Bu_Index.hidden = YES; //works
            Bu_search.hidden = YES;
        } else {
            Bu_Index.hidden = NO; //works
        }

        // 确定当前view插入的位置
        // 12345在storyboard中定义，为显示最顶层的图片view，这个view下面的view都能够被显示
        UIView *insertView = [self viewWithTag:12345];
        if (insertView == nil) {
            NSLog(@"*** Please check view with tag = 12345");
            return;
        }

        switch (NewState)
        {
            case IF_HealthSteps:
                TitleName.text = NSLocalizedStringFromTable(@"Bu3_06_Str", INFOPLIST, nil);
                [self insertSubview:healthStepsView belowSubview:insertView];
                [(HealthSteps *)healthStepsView Do_init:NowUserNum];
                break;
            case IF_USERDATE:       // 配戴者資訊
                TitleName.text = NSLocalizedStringFromTable(@"Bu1_Str", INFOPLIST, nil);

                [self insertSubview:UserDateView
                       belowSubview:insertView];

                //設備電話判斷
                if ([strT isEqualToString:@"YES"]) {
                    UIAlertView *alert;
                    alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SetDevicePhoneNumber", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles: nil];
                    [alert show];
                    [defaults removeObjectForKey:@"NeedPhoneRemind"];
                }
                //設備電話判斷 end
                break;

            case IF_USERSET:        // 設備狀態
                TitleName.text = NSLocalizedStringFromTable(@"Bu2_Str", INFOPLIST, nil);
                [self insertSubview:UserSetView belowSubview:insertView];
                break;
            case IF_HIS:            // 歷史記錄
                TitleName.text = NSLocalizedStringFromTable(@"Bu6_Str", INFOPLIST, nil);
                [self insertSubview:MyHisView
                       belowSubview:insertView];
                break;
            case IF_AutoLocating:   // 歷史記錄
                TitleName.text = NSLocalizedStringFromTable(@"HS_Position", INFOPLIST, nil);
                [LocatingEditView stopTimer];
                [self insertSubview:AutoLocatingView
                       belowSubview:insertView];
                break;
            case IF_ACT:            // 活动区域
                Bu_search.hidden = NO;
                [self Ctl_MyTimer:true];
                [Bu_MapSet setHidden:NO];
                [Bu_MapSet setBackgroundImage:[UIImage imageNamed:@"icon_map.png"]
                                     forState:UIControlStateNormal];

                TitleName.text = NSLocalizedStringFromTable(@"Bu5_Str", INFOPLIST, nil);
                [self insertSubview:MyActView
                       belowSubview:insertView];
                break;

            case IF_ACT_SEARCH:     // 活动区域搜索
                [self insertSubview:myActSearchView
                       belowSubview:insertView];
                break;

            case IF_EATSEL:         // 事件提醒
                [Bu_Save setHidden:NO];
                [self insertSubview:MyEatPickView
                       belowSubview:insertView];
                break;
            case IF_EATSHOW:
                [TitleName setText:NSLocalizedStringFromTable(@"Bu8_Str", INFOPLIST, nil)];
                [self insertSubview:MyEatShowView
                       belowSubview:insertView];
                break;
            case IF_DATESHOW:
                [TitleName setText:NSLocalizedStringFromTable(@"Bu9_Str", INFOPLIST, nil)];
                [self insertSubview:MyDateShowView belowSubview:insertView];
                break;
            case IF_DATESEL:
                [self insertSubview:MyDatePickerView
                       belowSubview:insertView];
                break;
            case IF_SHOWLSEL:
                [TitleName setText:NSLocalizedStringFromTable(@"Bu3_Str", INFOPLIST, nil)];
                [(MySelView *)MySelView Do_Init:self];
                [self insertSubview:MySelView belowSubview:insertView];
                break;
            case IF_SHOWLIST:
                switch (ShowNum)
                {
                    case 1:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW1  ] ];
                        break;
                        
                    case 2:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW2  ] ];
                        break;
                        
                    case 3:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW3  ]];
                        break;
                        
                    case 4:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW4  ]];
                        break;
                        
                    case 5:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW5  ]];
                        break;
                }

                NSLog(@"list view = %i", ShowNum);
                [self insertSubview:ListView
                       belowSubview:insertView];
                break;

            case IF_INDEX:
                Is_UserGet_Sw = false;
                [TitleName setText:[Array_show objectForKey:TITLE_INDEX]];
                if ([self CheckTotal] == true) {
                    [self Show_GoToSet];
                }
                break;

            case IF_SETTING:
                [TitleName setText: [Array_show objectForKey:INDEX_BU_SET]];
                [(MySetView *)MySetView Set_Go:NowUserNum];
                [self Set_SetView];

                [self insertSubview:MySetView belowSubview:insertView];
                break;

            case IF_MAP:
                //顯示地圖/衛星 切換Btn顯示
                [Bu_MapSet setHidden:NO];
                [Bu_MapSet setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
                [TitleName setText:[Array_show objectForKey:TITLE_MAP]];
                [self insertSubview:MyMapView belowSubview:insertView];
                break;

            case IF_MEASURERE://量測提醒
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Measure", INFOPLIST, nil)];
                [(MeasureRemind *)MeasureRemind Do_Init:self];
                [self insertSubview:MeasureRemind
                       belowSubview:insertView];
                break;

            case IF_BPREMIND://血壓提醒
                NSLog(@"Change to BPRemind");
                [TitleName setText:NSLocalizedStringFromTable(@"HS_BPRemind", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:BPRemindView
                       belowSubview:insertView];
                break;
            
            case IF_BOREMIND://血氧提醒
                NSLog(@"Change to BORemind");
                [TitleName setText:NSLocalizedStringFromTable(@"HS_BORemind", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:BORemindView
                       belowSubview:insertView];
                break;

            case IF_BSREMIND://血糖提醒
                NSLog(@"Change to BSRemind");
                [TitleName setText:NSLocalizedStringFromTable(@"HS_BSRemind", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:BSRemindView
                       belowSubview:insertView];
                break;

            case IF_SPORTREMIND://運動資訊
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Sport", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:SportRemindView belowSubview:insertView];
                break;

            case IF_WEIGHTREMIND://體重資訊
                NSLog(@"IF_WEIGHTREMIND");
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Weight", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:WeightRemindView belowSubview:insertView];
                break;

            case IF_CALL:   //通話限制
                [Bu_Save setHidden:NO];
                [TitleName setText:NSLocalizedStringFromTable(@"HS_CALL", INFOPLIST, nil)];
                [self insertSubview:CallLimit belowSubview:insertView];
                break;

            case IF_DEVSET://硬體設定
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Setting", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:DeviceSet belowSubview:insertView];
                break;

            case IF_FALLSET://跌倒設定
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Fall", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:FallSet belowSubview:insertView];
                break;

            case IF_ACTALERT://無動作
                [TitleName setText:@"Activity alert"];
                [Bu_Save setHidden:NO];
                [self insertSubview:ActAlert belowSubview:insertView];
                break;

            case IF_GeoFS://無動作
                [Bu_MapSet setHidden:NO];
                [Bu_MapSet setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
                [TitleName setText:NSLocalizedStringFromTable(@"GeoFence", INFOPLIST, nil)];
                [Bu_Save setHidden:YES];
                [self insertSubview:geoFS belowSubview:insertView];
                break;

            case IF_SHOWIMAGE://跌倒設定
                [TitleName setText:NSLocalizedStringFromTable(@"HS_ShowImage", INFOPLIST, nil)];
                [self insertSubview:ShowImageView belowSubview:insertView];
                break;

            case IF_HISMAP://歷史紀錄 地圖
                [Bu_MapSet setHidden:NO];
                [self insertSubview:MyHisMapView belowSubview:insertView];
                break;

            case IF_GROUPMEMBER:
                [TitleName setText:NSLocalizedStringFromTable(@"Personal_WatcherManager", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                [self insertSubview:GroupMemberView belowSubview:insertView];
                break;

            case IF_MYACCOUNT://我的帳號
                [TitleName setText:NSLocalizedStringFromTable(@"Personal_MyAccount", INFOPLIST, nil)];
                [self insertSubview:MyAccountView belowSubview:insertView];
                break;
                
            case IF_LEAVEREMIND:
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Leave", INFOPLIST, nil)];
                [Bu_Save setHidden:NO];
                //[self insertSubview:LeaveRemind atIndex:23];
                [self insertSubview:LeaveRemind belowSubview:insertView];
                break;

            case IF_LEAVEMAP:
                [Bu_Save setHidden:NO];
                [TitleName setText:NSLocalizedStringFromTable(@"HS_Leave", INFOPLIST, nil)];
                //[self insertSubview:LeaveMap atIndex:23];
                [self insertSubview:LeaveMap belowSubview:insertView];
                break;

            case IF_NEWSINFO:
                [TitleName setText:NSLocalizedStringFromTable(@"NEWS", INFOPLIST, nil)];
                //[self insertSubview:NewsView atIndex:23];
                [self insertSubview:NewsView belowSubview:insertView];
                break;

            case IF_NEWSCONTENT:
                [TitleName setText:NSLocalizedStringFromTable(@"NEWS", INFOPLIST, nil)];
                //[self insertSubview:NewsContentView atIndex:23];
                [self insertSubview:NewsContentView belowSubview:insertView];
                break;
            case IF_CUSTOMCHART:
                switch (ShowNum)
                {
                    case 1:
                        [TitleName setText:[Array_show objectForKey:TITLE_SHOW1]];
                        break;

                    case 2:
                        [TitleName setText:[Array_show objectForKey:TITLE_SHOW2]];
                        break;

                    case 3:
                        [TitleName setText:[Array_show objectForKey:TITLE_SHOW3]];
                        break;

                    case 4:
                        [TitleName setText:[Array_show objectForKey:TITLE_SHOW4]];
                        break;

                    case 5:
                        [TitleName setText: [  Array_show objectForKey : TITLE_SHOW5  ]];
                        break;
                }

                [self insertSubview:chartCustom belowSubview:insertView];
                break;

            case IF_TWI:
                TitleName.text = NSLocalizedStringFromTable(@"HS_Tracking", INFOPLIST, nil);
                [Bu_Save setHidden:NO];
                [self insertSubview:tWI belowSubview:insertView];
                break;

            case IF_LocatingEdit:
                TitleName.text = NSLocalizedStringFromTable(@"Auto_location_create",
                                                            INFOPLIST,
                                                            nil);
                [Bu_Save setHidden:YES];
                NSLog(@"IF_LocatingEdit %@",self.autoLocatingName);
                LocatingEditView.nameString = self.autoLocatingName;
                [LocatingEditView Do_init:self];
                LocatingEditView.g_no = locatingEditIndex;
                [self insertSubview:LocatingEditView
                       belowSubview:insertView];
                break;

            case IF_FREQ_QUESTION:
                NSLog(@"IF_FREQ_QUESTION");
                TitleName.text = NSLocalizedStringFromTable(@"FreqQuestionTitle", INFOPLIST, nil);
                Bu_Save.hidden = YES;
                [self insertSubview:freqQuestionView belowSubview:insertView];
                break;
            case IF_FREQ_QUESTION_DETAIL:
                NSLog(@"IF_FREQ_QUESTION_DETAIL");
                TitleName.text = NSLocalizedStringFromTable(@"FreqQuestionDetailTitle", INFOPLIST, nil);
                Bu_Save.hidden = YES;
                [self insertSubview:freqQuestionDetailView belowSubview:insertView];
                break;
            case IF_FREQ_DISCLAIMER:
                NSLog(@"IF_FREQ_DISCLAIMER");
                TitleName.text = NSLocalizedStringFromTable(@"DisclaimerTitle", INFOPLIST, nil);
                Bu_Save.hidden = YES;
                [self insertSubview:disclaimerView belowSubview:insertView];
                break;
            default:
                NSLog(@"*** Change_State NewState unhandle: %d", NewState);
                break;
        }

        IF_State = NewState;
    }
}

#pragma mark -

// 歷史記錄-跌倒紀錄(傳輸)
- (void)Send_SOS2Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@", AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHistoryFall.html",INK_Url_1];
    
    NSLog(@"跌倒記錄Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//歷史記錄-緊急(傳輸)
- (void)Send_SOSAcc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@", AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHistorySos.html",INK_Url_1];
    
    NSLog(@"歷史紀錄緊急Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//歷史記錄-離家紀錄(傳輸)
-(void) Send_SOS3Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHistoryLeaveHome.html",INK_Url_1];
    
    NSLog(@"離家紀錄Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//歷史記錄-通話紀錄(傳輸)
-(void) Send_SOS4Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHistoryCall.html",INK_Url_1];
    
    NSLog(@"通話紀錄Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

-(void) Send_SOS5Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/GcareGetHistoryNonmovement.html",INK_Url_1];
    
    NSLog(@"無動作 activity alert Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

-(void) Send_SOS6Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHistoryGeoFence.html",INK_Url_1];
    
    NSLog(@"電子圍籬 Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

-(void) Send_SOS7Acc:(NSString *)acc andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&role=1&AppDataJson={\"maxResults\":10}",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetAlarmLocation.html",INK_Url_1];
    
    NSLog(@"Amber_Alert Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

/*
-(void) Send_Sos:(NSString *)Acc2 :(NSString *)Hash2
{
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
 //   NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
 //   NSLog(@"Hash : %@", hash);
    
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appSOS.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    NSLog(@"tmpstr = %@",tmpstr2);
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}

//歷史記錄-跌倒(傳輸)
-(void) Send_Sos2:(NSString *)Acc2:(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
 //   NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
 //   NSLog(@"Hash : %@", hash);
    
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appFALL.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
    
    
}

//歷史記錄-通話(傳輸)
-(void) Send_Sos3:(NSString *)Acc2: (NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
//   NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
 //   NSLog(@"Hash : %@", hash);
    
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/appCALL.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
//    NSLog(@"phone string = %@",tmpstr2);
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    His_tempData = [NSMutableData alloc];
    His_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self Ctl_LoadingView:true];
    
    
}
*/
/*
//取得回診提醒設定資料(傳輸)
-(void) Send_Get1:(NSString *)Acc2:(NSString *)Hash2
{
    
    Is_Get1_Sw = true;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
//    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
 //   NSLog(@"Hash : %@", hash);
    
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/apphospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Get_tempData = [NSMutableData alloc];
    Get_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
    
    
}
*/

/*
//刪除佩帶者(傳輸)
- (void)Send_DeleteUser:(NSString *)Acc2 :(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSString *tmpstr2;
    
    NSLog(@"send del");
    
    
    if(tmpSaveToken.length <10)
    {
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delaccount.do?account=%@&UUID=%@&device=iOS&token=012345",InkUrl,Acc2,MyUUID];
    }
    else
    {
        
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delaccount.do?account=%@&UUID=%@&device=iOS&token=%@",InkUrl,Acc2,MyUUID,tmpSaveToken];
    }
    
    NSLog(@"delaccount = %@",tmpstr2);
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Del_tempData = [NSMutableData alloc];
    Del_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
}
*/

/*
//活動區域(傳輸)
- (void)Send_ActionLoc:(NSString *)Acc2 :(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSString *tmpstr2;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
  //  NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
//    NSLog(@"Hash : %@", hash);
    
    
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/apptrace.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    NSLog(@"tmpstr = %@",tmpstr2);
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Act_tempData = [NSMutableData alloc];
    Act_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
//    [self Ctl_LoadingView:true];
}
*/

//活動區域(傳輸)
- (void) Send_ActionLoc:(NSString *)acc andHash:(NSString *)hash
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    
    NSLog(@"httpBodyString = %@", httpBodyString);
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetActiveRegion.html",INK_Url_1];

    [request setURL:[NSURL URLWithString:getUserApi]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Act_tempData = [NSMutableData alloc];
    Act_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

#pragma mark - 定位救援网络请求
- (void)Send_LocMap:(NSString *)acc andHash:(NSString *)hash
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&language=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,NSLocalizedStringFromTable(@"LANGUAGE", INFOPLIST, nil)];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSOSLocation.html",INK_Url_1];

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Loc_tempData = [[NSMutableData alloc] init];
    Loc_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//刪除佩帶者傳輸
- (void)Clear_User
{
    NSLog(@"send clear");
    
    int Value1 = 0;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"HaveSendClear"];
    
    NSLog(@"value1 = %i",Value1);
    
    /*
    if(Value1 == 3)
        return;
    */
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *tmpstr2;
    
    NSLog(@"send clear");
    
    
    if(tmpSaveToken.length <10)
    {
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delallaccount.do?UUID=%@&device=iOS&token=012345",InkUrl,MyUUID];
    }
    else
    {
        
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/delallaccount.do?UUID=%@&device=iOS&token=%@",InkUrl,MyUUID,tmpSaveToken];
    }
    
    NSLog(@"delallaccount = %@",tmpstr2);
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Clear_tempData = [NSMutableData alloc];
    Clear_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    
}



//刪除佩帶者傳輸
-(void)Del_User:(NSString *)UserName
{
    [self Ctl_LoadingView:true];
    
    int Szlen = [UserData count];
    NSLog(@"Del data");
    
    
    for(int j =0;j<Szlen;j++)
    {
        
        NSString *tmpstr = [UserData objectAtIndex:j];
        
        if( [tmpstr isEqualToString:UserName]  )
        {
            NSLog(@"Have data");
            
            DelName = [NSString stringWithFormat:@"%@", UserName];
            
            
//            [self Send_DeleteUser:[AccData objectAtIndex:j]:[HashData objectAtIndex:j] ];
            
            
            
            return;
        }
        
    }
    
    [self Ctl_LoadingView:false];
    
}

/*
//量測紀錄查詢(傳輸)
- (void)MyTest:(NSString *)Acc2 :(NSString *)Hash2
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSString *tmpstr2;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc]init];
    [dateFormat2 setDateFormat:@"yyyy/MM/dd"];
    
    NSTimeInterval secondsPerDay = 24*60*60*7;
    NSDate *startdate = [NSDate dateWithTimeIntervalSinceNow:-secondsPerDay];
    
//    NSLog(@"now %@",[dateFormat2 stringFromDate:startdate]);
    
    NSString *dateString2 = [dateFormat2 stringFromDate:[NSDate date]];
//    NSString *dateString3 = [dateString2 substringWithRange:NSMakeRange(0, 8)];
    
    NSString *startString = [dateFormat2 stringFromDate:startdate];
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
//    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
//    NSLog(@"Hash : %@", hash);
    
    
    switch (ShowNum)
    {
        case 1:
            
            tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalbp.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            NSLog(@"tmpstr = %@",tmpstr2);
            break;
            
        case 2:
            
            tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalbs.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            NSLog(@"tmpstr血糖 = %@",tmpstr2);
            break;
            
        case 3:
            NSLog(@"tmpstr = %@",tmpstr2);
            tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitalwt.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;
            
        case 4:
            NSLog(@"tmpstr = %@",tmpstr2);
            tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/vitaloxy.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
            break;
        
        //add by Bill 計步器
        case 5:
            tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/pedometer.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&start_time=%@%@&end_time=%@%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID,startString,@"%2000:00:00",dateString2,@"%2023:59:59"];
            NSLog(@"tmpstr = %@",tmpstr2);
//                tmpstr2 = @"http://angel.guidercare.com:18087/OSGiRMS/pedometer.do?account=paulsu1&data=21da28299ddea35475205881e8bad7d4066915d214d01c5442013a8ef186e4a5&timeStamp=2011/2/14%2014:00:00&token=012345&device=iOS&UUID=0123456789ABCDEF&start_time=2013/02/24%2010:00:00&end_time=2013/02/27%2016:00:00";
            
            break;
        
        default:
            
            return;
            
            break;
    }
    
    
    
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Get_tempData = [NSMutableData alloc];
    Get_connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self Ctl_LoadingView:true];
}
*/


//量測記錄－血壓提醒資訊
-(void) Send_UserRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi;
    
    switch (ShowNum)
    {
        case 1://血壓
            
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBp.html",INK_Url_1];
            break;
            
        case 2://血糖
            
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBg.html",INK_Url_1];
            break;
            
        case 3://血氧
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBo.html",INK_Url_1];
            break;
            
        case 4://體重
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingWeight.html",INK_Url_1];
            break;
            
            //add by Bill 計步器
        case 5:
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingPedometer.html",INK_Url_1];
            break;
        case 6:
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingPedometer.html",INK_Url_1];
            break;
        default:
            
            return;
            
            break;
    }
    
    
    NSLog(@"API = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Remind_tempData = [NSMutableData alloc];
    Remind_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}



//量測紀錄查詢(傳輸)
- (void)MyTest:(NSString *)acc AndHash:(NSString *)hash StartTime:(NSString *)start andEndTime:(NSString *)end
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSString *httpBodyString;
    NSLog(@"Hash : %@", hash);
    
    if (isMainBtn) {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&Start=&End=",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    }else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&Start=%@&End=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,start,end];
    }
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi;
    
    
    switch (ShowNum)
    {
        case 1://血壓
            
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetBPData.html",INK_Url_1];
            break;
            
        case 2://血糖
            
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetBSData.html",INK_Url_1];
            break;
            
        case 3://血氧
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetBloodOxyData.html",INK_Url_1];
            break;
            
        case 4://體重
           getUserApi = [NSString stringWithFormat:@"%@/API/AppGetWeightData.html",INK_Url_1];
            break;
            
            //add by Bill 計步器
        case 5:
            getUserApi = [NSString stringWithFormat:@"%@/API/AppGetStepData.html",INK_Url_1];
            break;
            
        default:
            
            return;
            
            break;
    }
    
    
    NSLog(@"量測Api = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Get_tempData = [NSMutableData alloc];
    Get_connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}





//回診提醒更新（傳輸）
/*
-(void) Send_SaveData:(int)SaveNum :(NSString *)SaveDate :(BOOL)On
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSArray *arr = [SaveDate componentsSeparatedByString:@" "];
    
    NSString *tmpstr2;
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", [AccData objectAtIndex:NowUserNum],[HashData objectAtIndex:NowUserNum],dateString];
    
    NSArray *arr2 = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    
    
    
    if( On )
    {
        
        
        
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatehospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=on&datetime=%@%%20%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatehospital.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=off&datetime=%@%%20%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    
    
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Save_tempData = [NSMutableData alloc];
    Save_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self Ctl_LoadingView:true];
}
*/
/*
//吃藥提醒傳輸
-(void) Send_SaveSmallData:(int)SaveNum :(NSString *)SaveDate :(BOOL)On
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", [AccData objectAtIndex:NowUserNum],[HashData objectAtIndex:NowUserNum],dateString];
    
    NSArray *arr2 = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *tmpstr2;
    
    if( On )
    {
        
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatemedicine.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=on&datetime=%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,SaveDate];
    }
    else
    {
        
        tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/updatemedicine.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@&number=%d&action=off&datetime=%@",InkUrl,[AccData objectAtIndex:NowUserNum],hash,[arr2 objectAtIndex:0],[arr2 objectAtIndex:1],MyUUID,SaveNum,SaveDate];
        
    }
    
    
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Save_tempData = [NSMutableData alloc];
    Save_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self Ctl_LoadingView:true];
}
*/

-(void)Send_UpdateUserName
{
    NSLog(@"send update name");
     [self Send_NewUserDate:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum]];
}

-(void) Send_NewUserDate:(NSString *)Acc2 :(NSString *)Hash2
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", Acc2, Hash2,dateString];
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    
    NSString *tmpstr2;
    
    tmpstr2=[NSString stringWithFormat:@"%@/OSGiRMS/getinfo.do?account=%@&data=%@&timeStamp=%@%%20%@&UUID=%@",InkUrl,Acc2,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],MyUUID];
    
    [request setURL:[NSURL URLWithString:tmpstr2]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Date_NewtempData = [NSMutableData alloc];
    Date_NewConnect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    
    [self Ctl_LoadingView:true];
    
    
}


//取得佩帶者資料(傳輸)
-(void) Send_UserDate:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
//    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMember.html",INK_Url_1];
    
    NSLog(@"佩戴者Api = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Date_tempData = [NSMutableData alloc];
    Date_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}



//地圖取得佩帶者imei資料(傳輸)
-(void) Send_MapUserImei
{
    NSString *acc = userAccount;
    NSString *hash = userHash;
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMember.html",INK_Url_1];
    
    NSLog(@"佩戴者Api = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MapImei_tempData = [NSMutableData alloc];
    MapImei_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}



//取得親情電話與緊急電話(傳輸)
-(void) Send_SoSandFamilyPhone:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMemberPhone.html",INK_Url_1];
    
    NSLog(@"電話資訊Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    SosAndFamilyPhone_tempData = [NSMutableData alloc];
    SosAndFamilyPhone_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
//    [self addloadingView];
    
    
}

//取得吃藥提醒(傳輸)
-(void) Send_MedRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=01",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMedData.html",INK_Url_1];
    
    NSLog(@"吃藥 ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MedRemind_tempData = [[NSMutableData alloc] init];
    MedRemind_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}

//儲存吃藥提醒(傳輸)
-(void) Send_MedRemind:(NSString *)acc andHash: (NSString *)hash andDic :(NSDictionary *)dic
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&s_hour=%@&s_min=%@&t1_hex=%@&t2_hex=%@&t3_hex=%@&t4_hex=%@&t5_hex=%@&t6_hex=%@&t7_hex=%@&isvalid=%@&s_team=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"hour"],[dic objectForKey:@"min"],[dic objectForKey:@"week1"],[dic objectForKey:@"week2"],[dic objectForKey:@"week3"],[dic objectForKey:@"week4"],[dic objectForKey:@"week5"],[dic objectForKey:@"week6"],[dic objectForKey:@"week7"],[dic objectForKey:@"on_off"],[dic objectForKey:@"s_team"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppEditMedData.html",INK_Url_1];
    
    NSLog(@"吃藥 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateMed_tempData = [NSMutableData alloc];
    UpdateMed_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//儲存吃藥提醒(傳輸)
-(void) Send_HosRemind:(NSString *)acc andHash: (NSString *)hash andDic :(NSDictionary *)dic
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&s_year=%@&s_mon=%@&s_day=%@&s_hour=%@&s_min=%@&t1_hex=%@&t2_hex=%@&t3_hex=%@&t4_hex=%@&t5_hex=%@&t6_hex=%@&t7_hex=%@&isvalid=%@&s_team=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"year"],[dic objectForKey:@"mon"],[dic objectForKey:@"day"],[dic objectForKey:@"hour"],[dic objectForKey:@"min"],[dic objectForKey:@"week1"],[dic objectForKey:@"week2"],[dic objectForKey:@"week3"],[dic objectForKey:@"week4"],[dic objectForKey:@"week5"],[dic objectForKey:@"week6"],[dic objectForKey:@"week7"],[dic objectForKey:@"on_off"],[dic objectForKey:@"s_team"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppEditHosData.html",INK_Url_1];
    
    NSLog(@"回診 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateHos_tempData = [NSMutableData alloc];
    UpdateHos_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//取得吃藥提醒(傳輸)
-(void) Send_News:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/getAllNews.html",INK_Url_1];
    
    NSLog(@"最新消息列表 ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    News_tempData = [NSMutableData alloc];
    News_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}


//上傳吃藥提醒設定
-(void)Send_MedRemindUpdateWith:(NSDictionary *)dic
{
    NSLog(@"dic =%@",dic);
    [self Send_MedRemind:userAccount andHash:userHash andDic:dic];
}

//從設定頁上傳吃藥提醒設定
-(void)Send_HosRemindUpdateWith:(NSDictionary *)dic
{
    [self Send_HosRemind:userAccount andHash:userHash andDic:dic];
}

//上傳血壓上下限
-(void)Send_BPdata:(NSDictionary *)dic
{
    [self Send_UserBPData:userAccount andHash:userHash andDic:dic];
}

//上傳血糖資料
-(void)Send_BSdata:(NSDictionary *)dic
{
    [self Send_UserBSData:userAccount andHash:userHash andDic:dic];
}

//上傳血氧資料
-(void)Send_BOdata:(NSDictionary *)dic
{
    [self Send_UserBOData:userAccount andHash:userHash andDic:dic];
}

//上傳體重資訊
-(void)Send_Weightdata:(NSDictionary *)dic
{
    [self Send_UserWeightData:userAccount andHash:userHash andDic:dic];
}


//上傳運動資訊
-(void)Send_Sportdata:(NSDictionary *)dic
{
    [self Send_UserSportData:userAccount andHash:userHash andDic:dic];
}

//上傳通話限制資訊
-(void)Send_Calldata:(NSDictionary *)dic
{
    [self Send_UserCallData:userAccount andHash:userHash andDic:dic];
}
//上傳同步時段
-(void)Send_tWI:(NSDictionary *)dic
{
    [self Send_UserCallData:userAccount andHash:userHash andDic:dic];
}

//上傳完後重新讀取通話限制
-(void)Send_CallReload
{
    [self Send_UserCallLimit:userAccount andHash:userHash];
}

//上傳跌倒資訊
-(void)Send_Falldata:(NSDictionary *)dic
{
    [self Send_Falldata:userAccount andHash:userHash andDic:dic];
}



//上傳設備資訊
-(void)Send_Devicedata:(NSDictionary *)dic
{
    [self Send_DeviceData:userAccount andHash:userHash andDic:dic];
}
//上傳同步區間
-(void)Save_TWISetting:(NSDictionary *)dict
{
    [self Save_TWI_Setting:userAccount andHash:userHash andDict:dict];
}
//上傳無動作
-(void)Save_AASetting:(NSDictionary *)dict
{
    [self Save_AA_Setting:userAccount andHash:userHash andDict:dict];
}

//上傳完後重新讀取通話限制
-(void)Send_DevReload
{
    [self Send_UserDevSet:userAccount andHash:userHash];
}

//上傳離家警示
-(void)Send_Leavedata:(NSDictionary *)dic
{
    [self Send_LeaveData:userAccount andHash:userHash andDic:dic];
}

//查看離家設定地圖
-(void)Show_LeaveMapdata:(NSDictionary *)dic
{
    [(LeaveMap *)LeaveMap Do_Init:self];
    [(LeaveMap *)LeaveMap Set_Init:dic];
}

//歷史紀錄－地圖
-(void)Send_HisMapdata:(NSDictionary *)dic
{
    [(MyHisMapView *)MyHisMapView Do_Init:self];
    [(MyHisMapView *)MyHisMapView Set_Init:dic];
    [self Change_State:IF_HISMAP];
}

//新增使用者
-(void)Send_AddMemberdata:(NSDictionary *)dic
{
    [self Send_AddUserData:userAccount andHash:userHash andDic:dic];
}

//刪除佩戴者資料
-(void)Send_DelMemberdata:(NSString *)acc
{
    [self Send_DelUserData:userAccount andHash:userHash andDelAccount:acc];
}


//修改密碼儲存
-(void)Send_OldPw:(NSString *)oldpw AndNewPw:(NSString *)newpw
{
    newPw = newpw;
    [self Send_ChangePw:userAccount andHash:userHash andOldpw:oldpw andNewpw:newpw];
}

//修改帳號資訊
-(void)Send_AccInfo:(NSDictionary *)dic
{
    [self Send_AccInfomation:userAccount andHash:userHash andDic:dic];
}

//上傳血壓(傳輸)
-(void) Send_UserBPData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
//    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&bpsUplimit=%@&bpsDownlimit=%@&bpdUplimit=%@&bpdDownlimit=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"bpsUplimit"],[dic objectForKey:@"bpsDownlimit"],[dic objectForKey:@"bpdUplimit"],[dic objectForKey:@"bpdDownlimit"]];
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&bpsUplimit=%@&bpsDownlimit=%d&bpdUplimit=%@&bpdDownlimit=%d",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"bpsUplimit"],0,[dic objectForKey:@"bpdUplimit"],0];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingBp.html",INK_Url_1];
    
    NSLog(@"血壓上下限設定 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateBP_tempData = [NSMutableData alloc];
    UpdateBP_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//上傳血糖(傳輸)
-(void) Send_UserBSData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&beforeMealUp=%@&beforeMealDown=%d&afterMealUp=%@&afterMealDown=%d&bedTimeUp=%d&bedTimeDown=%d&breakfastStart=%@&breakfastEnd=%@&lunchStart=%@&lunchEnd=%@&dinnerStart=%@&dinnerEnd=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"beforeMealUp"],0,[dic objectForKey:@"afterMealUp"],0,0,0,[dic objectForKey:@"breakfastStart"],[dic objectForKey:@"breakfastEnd"],[dic objectForKey:@"lunchStart"],[dic objectForKey:@"lunchEnd"],[dic objectForKey:@"dinnerStart"],[dic objectForKey:@"dinnerEnd"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingBg.html",INK_Url_1];
    
    NSLog(@"血糖上下限設定 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateBS_tempData = [NSMutableData alloc];
    UpdateBS_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//上傳血氧(傳輸)
-(void) Send_UserBOData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&uplimit=%d&downlimit=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,0,[dic objectForKey:@"downlimit"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingBo.html",INK_Url_1];
    
    NSLog(@"血氧上下限設定 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateBO_tempData = [NSMutableData alloc];
    UpdateBO_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//上傳體重(傳輸)
-(void) Send_UserWeightData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"account = %@",AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, (unsigned int)dataIn.length, digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&sex=%@&bodyfat=%@&weight=%@&height=%@&years=%@&weightT=%@&bodyfatT=%@",
                                acc,
                                [AccData objectAtIndex:NowUserNum],
                                hash,
                                dateString,
                                [dic objectForKey:@"sex"],
                                [dic objectForKey:@"bodyfat"],
                                [dic objectForKey:@"weight"],
                                [dic objectForKey:@"height"],
                                [dic objectForKey:@"years"],
                                [dic objectForKey:@"weightT"],
                                [dic objectForKey:@"bodyfatT"]
                                ];

    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingWeight.html",INK_Url_1];

    NSLog(@"體重上下限設定 ＝ %@",httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    UpdateWeight_tempData = [NSMutableData alloc];
    UpdateWeight_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

//上傳運動(傳輸)
-(void) Send_UserSportData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&StepRange=%@&Distance=%@&StepCount=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"StepRange"],[dic objectForKey:@"Distance"],[dic objectForKey:@"StepCount"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingPedometer.html",INK_Url_1];
    
    NSLog(@"運動設定 ＝ %@%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateSport_tempData = [NSMutableData alloc];
    UpdateSport_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}





//通話限制(傳輸)
-(void) Send_UserCallData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&number=%@&value=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"number"],[dic objectForKey:@"value"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingCall.html",INK_Url_1];
    
    NSLog(@"通話限制 ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateCall_tempData = [NSMutableData alloc];
    UpdateCall_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//跌倒設定(傳輸)
-(void) Send_Falldata:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
//    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&FallSwitch=%@&Level=%@&Phone1=%@&Phone2=%@&Phone3=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"FallSwitch"],[dic objectForKey:@"Level"],[dic objectForKey:@"Phone1"],[dic objectForKey:@"Phone2"],[dic objectForKey:@"Phone3"]];
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&FallSwitch=%@&Level=%@&Phone1=%@&Phone2=%@&Phone3=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"FallSwitch"],[dic objectForKey:@"Level"],[dic objectForKey:@"Phone1"],[dic objectForKey:@"Phone2"],[dic objectForKey:@"Phone3"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingFall.html",INK_Url_1];
    
    NSLog(@"跌倒設定 ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateFall_tempData = [NSMutableData alloc];
    UpdateFall_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}




//硬體設定(傳輸)
-(void) Send_DeviceData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&number1=1&value1=%@&number2=2&value2=%@&number3=3&value3=%@&number4=4&value4=%@&number5=5&value5=%@&number6=6&value6=%@&number7=7&value7=%@&voiceMail=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"value1"],[dic objectForKey:@"value2"],[dic objectForKey:@"value3"],[dic objectForKey:@"value4"],[dic objectForKey:@"value5"],[dic objectForKey:@"value6"],[dic objectForKey:@"value7"],[dic objectForKey:@"voiceMail"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingHardwareMuti.html",INK_Url_1];
    
    NSLog(@"硬體設定Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateDev_tempData = [NSMutableData alloc];
    UpdateDev_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}





//硬體設定(傳輸)
-(void) Send_LeaveData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&number=%@&start=%@&end=%@&longitude=%@&latitude=%@&radius=%@&t1=%@&t2=%@&t3=%@&t4=%@&t5=%@&t6=%@&t7=%@&address=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"number"],[dic objectForKey:@"start"],[dic objectForKey:@"end"],[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"],[dic objectForKey:@"radius"],[dic objectForKey:@"t1"],[dic objectForKey:@"t2"],[dic objectForKey:@"t3"],[dic objectForKey:@"t4"],[dic objectForKey:@"t5"],[dic objectForKey:@"t6"],[dic objectForKey:@"t7"],[dic objectForKey:@"address"]];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingLeaveHome.html",INK_Url_1];
    
    NSLog(@"離家警示設定Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdateLeave_tempData = [NSMutableData alloc];
    UpdateLeave_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}



//新增使用者(傳輸)
-(void) Send_AddUserData:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString;
    
    
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@&token=012345&device=iOS",acc,[dic objectForKey:@"account"],[dic objectForKey:@"pwd"],hash,dateString];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@&token=%@&device=iOS",acc,[dic objectForKey:@"account"],[dic objectForKey:@"pwd"],hash,dateString,tmpSaveToken];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppAddGroupMember.html",INK_Url_1];
    
    NSLog(@"新增使用者Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Add_tempData = [NSMutableData alloc];
    Add_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}




//新增使用者(傳輸)
-(void) Send_AddUserByIMEI:(NSString *)acc AndHash: (NSString *)hash AndImei:(NSString *)imei
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString;
    
    
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gIemi=%@&data=%@&timeStamp=%@&token=012345&device=iOS",acc,imei,hash,dateString];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gIemi=%@&data=%@&timeStamp=%@&token=%@&device=iOS",acc,imei,hash,dateString,tmpSaveToken];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppAddGroupMemberByImei.html",INK_Url_1];
    
    NSLog(@"新增QRcode使用者Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Add_tempData = [NSMutableData alloc];
    Add_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//刪除使用者(傳輸)
-(void) Send_DelUserData:(NSString *)acc andHash: (NSString *)hash andDelAccount:(NSString *)delcount
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString;
    
    
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&data=%@&timeStamp=%@&token=012345&device=iOS",acc,delcount,hash,dateString];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&data=%@&timeStamp=%@&token=%@&device=iOS",acc,delcount,hash,dateString,tmpSaveToken];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppDelGroupMember.html",INK_Url_1];
    
    NSLog(@"刪除使用者Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Del_tempData = [NSMutableData alloc];
    Del_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//修改密碼傳輸
-(void) Send_ChangePw:(NSString *)acc andHash: (NSString *)hash andOldpw:(NSString *)oldpw andNewpw:(NSString *)newpw
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString;
    

    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&pwOld=%@&pwNew=%@",acc,acc,hash,dateString,oldpw,newpw];
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetMyPw.html",INK_Url_1];
    
    NSLog(@"修改密碼Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    ChangePw_tempData = [[NSMutableData alloc] init];
    ChangePw_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}



//修改密碼傳輸
-(void) Send_AccInfomation:(NSString *)acc andHash: (NSString *)hash andDic:(NSDictionary *)dic
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString;
    
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&name=%@&email=%@&phone=%@",acc,acc,hash,dateString,[dic objectForKey:@"name"],[dic objectForKey:@"email"],[dic objectForKey:@"phone"]];
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetMyAccount.html",INK_Url_1];
    
    NSLog(@"修改帳號資料Api ＝ %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    ChangeUserInfo_tempData = [NSMutableData alloc];
    ChangeUserInfo_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}


//取得回診提醒(傳輸)
-(void) Send_HosRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=02",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetHosData.html",INK_Url_1];
    
    NSLog(@"吃藥 ＝ %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    HosRemind_tempData = [[NSMutableData alloc] init];
    HosRemind_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

//取得血壓提醒資訊
-(void) Send_UserBPRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBp.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MBP_tempData = [NSMutableData alloc];
    MBP_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}


//取得血氧提醒資訊
-(void) Send_UserBORemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBo.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MBO_tempData = [NSMutableData alloc];
    MBO_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}


//取得血糖提醒資訊
-(void) Send_UserBSRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingBg.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MBS_tempData = [NSMutableData alloc];
    MBS_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}


//取得運動提醒資訊
-(void) Send_UserSportRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingPedometer.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MS_tempData = [NSMutableData alloc];
    MS_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}





//取得我的帳號資料
-(void) Send_MyUserAccount:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,acc, hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMyAccount.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    MyAcc_tempData = [NSMutableData alloc];
    MyAcc_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}




//取得體重資訊
-(void) Send_UserWeightRemind:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingWeight.html",INK_Url_1];

    NSLog(@"httpbody = %@",httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    MW_tempData = [NSMutableData alloc];
    MW_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

//取得同步時間選項
- (void) Send_GetSync:(NSString *)acc andHash: (NSString *)hash
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=sys&name=returnTime",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSysParameter.html",INK_Url_1];

    NSLog(@"同步時間 = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    Sync_tempData = [[NSMutableData alloc] init];
    Sync_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

//    [self addloadingView];
}



//取得同步時間選項
-(void) Send_GetGpsSync:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    //    AppGetSupportLanguage.html?userAccount=andywang&account=test&data=7ee2ac770561c311e666b49953a71eaa42264161dce51f51dc8ab33741a86adc&timeStamp=2013/08/01%2013:52:34
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=sys&name=gpsSync",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSysParameter.html",INK_Url_1];
    
    NSLog(@"GPS同步時間 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    GpsSync_tempData = [[NSMutableData alloc] init];
    GpsSync_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}

//取得WiFI List
- (void)Get_WiFiList:(NSString *)acc
             andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

// http://210.242.50.122:9000/mcarewatch/API/
//    AppGetMemberWifi.html?
//    userAccount=testforen&
//    account=352151022022078&
//    timeStamp=2015/03/31%2017:07:07&
//    data=D3E15D9234BE2397970E0F3F5EB4E88695F92054D469FD5EE7370559587E541C

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetMemberWifi.html",INK_Url_1];

    NSLog(@"get WiFi List = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    WiFiList_tempData = [[NSMutableData alloc] init];
    WiFiList_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

//取得WiFI List
- (void)Get_WiFi:(NSString *)acc
         andHash:(NSString *)hash
{
    NSLog(@"*** 取得WiFI List = %@", AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

    //http://210.242.50.122:9000/mcarewatch/API/
    //    AppGetMemberWifi.html?
    //    userAccount=testforen&
    //    account=352151022022078&
    //    timeStamp=2015/03/31%2017:07:07&
    //    data=D3E15D9234BE2397970E0F3F5EB4E88695F92054D469FD5EE7370559587E541C

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetActiveRegionWifiList.html",INK_Url_1];

    NSLog(@"get WiFi List = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    GetWiFi_tempData = [[NSMutableData alloc] init];
    GetWiFi_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - 获取到手表WiFi地址，开始保存
- (void) Set_WiFiList:(NSString *)acc
              andHash:(NSString *)hash
              andDict:(NSDictionary*)m_dict
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, (CC_LONG)dataIn.length,  digest);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    //http://210.242.50.122:9000/mcarewatch/API/
    //    AppGetMemberWifi.html?
    //    userAccount=testforen&
    //    account=352151022022078&
    //    timeStamp=2015/03/31%2017:07:07&
    //    data=D3E15D9234BE2397970E0F3F5EB4E88695F92054D469FD5EE7370559587E541C
    //    no
    //    name
    //    mac
    //    gps_latlng
    //    address

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&no=%@&name=%@&mac=%@&gps_latlng=%@&address=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[m_dict objectForKey:@"no"]
                                ,[m_dict objectForKey:@"name"]
                                ,[m_dict objectForKey:@"mac"]
                                ,[m_dict objectForKey:@"gps_latlng"]
                                ,[m_dict objectForKey:@"address"]];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetMemberWifi.html",INK_Url_1];
    
    NSLog(@"*** Set_WiFiList = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    SetWiFi_tempData = [[NSMutableData alloc] init];
    SetWiFi_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

// 取得同步區間選項
- (void)Get_TWI_Setting:(NSString *)acc
                andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

//    http://210.242.50.122:9000
//    /angelcare/API/AppGetSettingAutochange.html?
//    userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type1=pr&type2=gps",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingAutochange.html",INK_Url_1];

    NSLog(@"get twi 同步時段 = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    Get_TWI_tempData = [[NSMutableData alloc] init];
    Get_TWI_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

//取得同步時間選項 Save
-(void) Save_TWI_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
//http://210.242.50.122:9000/angelcare/API/
//    AppSetSettingAutochange.html?userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps&statusPr=1&statusGps=0&valuePr=177&startTimePr=08:00:00&endTimePr=19:00:00&valueGps=0&startTimeGp=00:00:00&endTimeGps=00:00:00
    
    NSString *keyGV = @"gpsV";
    NSString *keyGS = @"startG";
    NSString *keyGE = @"endG";
    NSString *keyGO = @"gpsOn";
    NSString *keyWV = @"wifiV";
    NSString *keyWS = @"start";
    NSString *keyWE= @"end";
    NSString *keyWO = @"wifiOn";
    NSMutableArray *keyWW = [NSMutableArray new];
    NSMutableArray *keyGW = [NSMutableArray new];
    NSString *resWW = @"[";
    NSString *resGW = @"[";
    for (int i = 1; i < 8; i ++) {
        NSString *tmpWW = [NSString stringWithFormat:@"w%i",i];
        NSString *tmpGW = [NSString stringWithFormat:@"gw%i",i];
        [keyWW addObject:tmpWW];
        [keyGW addObject:tmpGW];
        if ([[dict objectForKey:tmpWW] isEqualToString:@"YES"]) {
            resWW =[resWW stringByAppendingString:[NSString stringWithFormat:@"%i,",i]];
        }
        if ([[dict objectForKey:tmpGW] isEqualToString:@"YES"]) {
            resGW = [resGW stringByAppendingString:[NSString stringWithFormat:@"%i,",i]];
        }
    }
    if (resWW.length >1) {
        resWW = [resWW substringToIndex:resWW.length-1];
    }
    if (resGW.length >1) {
        resGW = [resGW substringToIndex:resGW.length-1];
    }

    resWW = [resWW stringByAppendingString:@"]"];
    resGW = [resGW stringByAppendingString:@"]"];

    NSLog(@"resWW = %@",resWW);
    NSLog(@"resGW = %@",resGW);
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type1=pr&type2=gps&statusPr=%@&statusGps=%@&valuePr=%@&startTimePr=%@&endTimePr=%@&valueGps=%@&startTimeGps=%@&endTimeGps=%@&weeklyPr=%@&weeklyGps=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dict objectForKey:keyWO],[dict objectForKey:keyGO],[dict objectForKey:keyWV],[dict objectForKey:keyWS],[dict objectForKey:keyWE],[dict objectForKey:keyGV],[dict objectForKey:keyGS],[dict objectForKey:keyGE],resWW,resGW];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingAutochange.html",INK_Url_1];
    
    NSLog(@"save twi 同步時段 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Save_TWI_tempData = [[NSMutableData alloc] init];
    Save_TWI_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//取得無動作選項
- (void)Get_AA_Setting:(NSString *)acc
               andHash:(NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    //    http://210.242.50.122:9000
    //    /angelcare/API/AppGetSettingAutochange.html?
    //    userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingNonmovement.html",INK_Url_1];
    
    NSLog(@"get 無動作 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Get_AA_tempData = [[NSMutableData alloc] init];
    Get_AA_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}

//取得電子圍籬
- (void) Get_GEO_Setting:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);

    //    http://210.242.50.122:9000
    //    /angelcare/API/AppGetSettingAutochange.html?
    //    userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetGeoFence.html",INK_Url_1];

    NSLog(@"get GEO = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    Get_GEO_tempData = [[NSMutableData alloc] init];
    Get_GEO_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
}

//取得報名狀態
-(void) Get_Missing_Join_StastusWithAcc:(NSString *)acc
{
    
//    Missing_Join_Stastus
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:DEFAULTDATE];
//    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDictionary *apiData = @{@"account" : acc};
    
    
    NSString *httpBodyString = [HttpHelper returnHttpBody:apiData];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/APP/GcareGetJoiningPersonJoinStatus.html",INK_Url_1];
    
    NSLog(@"get Missing_Join_Stastus = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Get_Missing_Join_Stastus_tempData = [[NSMutableData alloc] init];
    Get_Missing_Join_Stastus_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//取得報名狀態
-(void) Get_Missing_Join_Stastus_Link_Join_ActionWithAcc:(NSString *)acc
{
    
    //    Missing_Join_Stastus
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    //    [dateFormat setDateFormat:DEFAULTDATE];
    //    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDictionary *apiData = @{@"account" : acc};
    
    
    NSString *httpBodyString = [HttpHelper returnHttpBody:apiData];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/APP/GcareGetJoiningPersonJoinStatus.html",INK_Url_1];
    
    NSLog(@"get Missing_Join_Stastus = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Get_Missing_Join_Stastus_Link_Join_Action_tempData = [[NSMutableData alloc] init];
    Get_Missing_Join_Stastus_Link_Join_Action_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

//Set 報名狀態
-(void) Set_Missing_Join_Stastus_Acc:(NSString *)acc withStatus:(NSString*) status
{
    
    //    Missing_Join_Stastus
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    //    [dateFormat setDateFormat:DEFAULTDATE];
    //    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDictionary *apiData = @{@"account" : acc,@"JoinStatus" : status};
    
    
    NSString *httpBodyString = [HttpHelper returnHttpBody:apiData];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/APP/GcareSetJoiningPersonJoinStatus.html",INK_Url_1];
    
    NSLog(@"get Missing_Join_Stastus = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Set_Missing_Join_Stastus_tempData = [[NSMutableData alloc] init];
    Set_Missing_Join_Stastus_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}

//取得電子圍籬
-(void) Get_GEO_NORP_Setting:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    //    http://210.242.50.122:9000
    //    /angelcare/API/AppGetSettingAutochange.html?
    //    userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetGeoFence.html",INK_Url_1];
    
    NSLog(@"get GEONORP = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Get_GEO_NORP_tempData = [[NSMutableData alloc] init];
    Get_GEO_NORP_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}
// 無動作 Save
-(void) Save_AA_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    //http://210.242.50.122:9000/angelcare/API/
    //    AppSetSettingAutochange.html?userAccount=testforen&account=testforen&timeStamp=2014/05/28%2017:56:08&data=D3FDA0226ED3C9620D542DF14C6DC428D4EFBF99618A8B3DDE7C0A04E63208C4&type1=pr&type2=gps&statusPr=1&statusGps=0&valuePr=177&startTimePr=08:00:00&endTimePr=19:00:00&valueGps=0&startTimeGp=00:00:00&endTimeGps=00:00:00
    

    NSString *keyGS = @"S";
    NSString *keyGE = @"E";
    NSString *keyGO = @"O";
    

    NSMutableArray *keyGW = [NSMutableArray new];

    NSString *resGW = @"[";
    for (int i = 1; i < 8; i ++) {
        
        NSString *tmpGW = [NSString stringWithFormat:@"gw%i",i];
        
        [keyGW addObject:tmpGW];
        
        if ([[dict objectForKey:tmpGW] isEqualToString:@"YES"]) {
            resGW = [resGW stringByAppendingString:[NSString stringWithFormat:@"%i,",i]];
        }
    }
    
    if (resGW.length >1) {
        resGW = [resGW substringToIndex:resGW.length-1];
    }
    
    
    
    resGW = [resGW stringByAppendingString:@"]"];
    
    
    NSLog(@"resGW = %@",resGW);
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&startTime=%@&endTime=%@&status=%@&weekly=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dict objectForKey:keyGS],[dict objectForKey:keyGE],[dict objectForKey:keyGO],resGW];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetSettingNonmovement.html",INK_Url_1];
    
    NSLog(@"save 無動作 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Save_AA_tempData = [[NSMutableData alloc] init];
    Save_AA_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}
// 電子圍籬 Save
-(void) Save_GEO_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
//    http://192.168.1.146:8080/angelcare/API/AppSetGeoFence.html?userAccount=test&account=IBC-01&timeStamp=05-26%2010:40:07&data=BED0FC95F5116130794A19C9E199202CE53DC9D0442615148DAD81E100AC10D7&
//    no=1
//    &title=test1
//    &fromtime=13:50
//    &totime=15:30
//    &week=1,5,7
//    &points=(25.049486,121.519022),(25.049486,121.519023),(25.049486,121.519021)
//    &enable=0
    NSString *no = [dict objectForKey:@"no"];
    NSString *title = [dict objectForKey:@"title"];
    NSString *fromtime = [dict objectForKey:@"fromtime"];
    NSString *totime = [dict objectForKey:@"totime"];
    NSString *week = [dict objectForKey:@"week"];
    week = [week stringByReplacingOccurrencesOfString:@"[" withString:@""];
    week = [week stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSString *points = [dict objectForKey:@"points"];
//    NSString *enable = [dict objectForKey:@"enable"];
    
    
//    NSLog(@"resGW = %@",resGW);
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&no=%@&title=%@&fromtime=%@&totime=%@&week=%@&points=%@&enable=1",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,no,title,fromtime,totime,week,points];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetGeoFence.html",INK_Url_1];
    
    NSLog(@"save 電子圍籬 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Save_GEO_tempData = [[NSMutableData alloc] init];
    Save_GEO_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}
// 電子圍籬 delete
-(void) Delete_GEO_Setting:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    //    http://192.168.1.146:8080/angelcare/API/AppSetGeoFence.html?userAccount=test&account=IBC-01&timeStamp=05-26%2010:40:07&data=BED0FC95F5116130794A19C9E199202CE53DC9D0442615148DAD81E100AC10D7&
    //    no=1
    //    &title=test1
    //    &fromtime=13:50
    //    &totime=15:30
    //    &week=1,5,7
    //    &points=(25.049486,121.519022),(25.049486,121.519023),(25.049486,121.519021)
    //    &enable=0
    NSString *no = [dict objectForKey:@"no"];
//    NSString *title = [dict objectForKey:@"title"];
//    NSString *fromtime = [dict objectForKey:@"fromtime"];
//    NSString *totime = [dict objectForKey:@"totime"];
//    NSString *week = [dict objectForKey:@"week"];
//    week = [week stringByReplacingOccurrencesOfString:@"[" withString:@""];
//    week = [week stringByReplacingOccurrencesOfString:@"]" withString:@""];
//    NSString *points = [dict objectForKey:@"points"];
    //    NSString *enable = [dict objectForKey:@"enable"];
    
    
    //    NSLog(@"resGW = %@",resGW);
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&no=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,no];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppDelGeoFence.html",INK_Url_1];
    
    NSLog(@"delete 電子圍籬 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Delete_GEO_tempData = [[NSMutableData alloc] init];
    Delete_GEO_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}
// 電子圍籬 Save
-(void) Save_GEO_Setting_fromSwitch:(NSString *)acc andHash: (NSString *)hash andDict:(NSDictionary*)dict
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    
    //    http://192.168.1.146:8080/angelcare/API/AppSetGeoFence.html?userAccount=test&account=IBC-01&timeStamp=05-26%2010:40:07&data=BED0FC95F5116130794A19C9E199202CE53DC9D0442615148DAD81E100AC10D7&
    //    no=1
    //    &title=test1
    //    &fromtime=13:50
    //    &totime=15:30
    //    &week=1,5,7
    //    &points=(25.049486,121.519022),(25.049486,121.519023),(25.049486,121.519021)
    //    &enable=0
    NSString *no = [dict objectForKey:@"no"];
    NSString *title = [dict objectForKey:@"title"];
    NSString *fromtime = [dict objectForKey:@"fromtime"];
    NSString *totime = [dict objectForKey:@"totime"];
    NSString *week = [dict objectForKey:@"week"];
    week = [week stringByReplacingOccurrencesOfString:@"[" withString:@""];
    week = [week stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSString *points = [dict objectForKey:@"points"];
    NSString *enable = [dict objectForKey:@"enable"];
    
    
    //    NSLog(@"resGW = %@",resGW);
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&no=%@&title=%@&fromtime=%@&totime=%@&week=%@&points=%@&enable=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,no,title,fromtime,totime,week,points,enable];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppSetGeoFence.html",INK_Url_1];
    
    NSLog(@"save 電子圍籬 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Save_GEO_Enable_tempData = [[NSMutableData alloc] init];
    Save_GEO_Enable_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}
-(void)Save_GEO_WithDict:(NSDictionary*)dict withSender:(id)Sender{
    vcGFE = Sender;
    [self Save_GEO_Setting:userAccount andHash:userHash andDict:dict];
}
-(void)Delete_GEO_WithDict:(NSDictionary*)dict withSender:(id)Sender{
    vcGFE = Sender;
    [self Delete_GEO_Setting:userAccount andHash:userHash andDict:dict];
}

-(void)Save_GEO_WithDict_fromSwitch:(NSDictionary*)dict{
    [self Save_GEO_Setting_fromSwitch:userAccount andHash:userHash andDict:dict];
}

- (void)SetWiFiWithDict:(NSDictionary*)dict
{
    [self Set_WiFiList:userAccount andHash:userHash andDict:dict];
}

//取得通話限制
-(void) Send_UserCallLimit:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingCall.html",INK_Url_1];
    
    NSLog(@"通話限制 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Call_tempData = [NSMutableData alloc];
    Call_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
//    [self addloadingView];
    
    
}

//取得硬體設定－語言設定
- (void) Send_LangInfo:(NSString *)acc andHash: (NSString *)hash
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=sys&name=language",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSysParameter.html",INK_Url_1];
    
    NSLog(@"語言設定 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    LangInfo_tempData = [[NSMutableData alloc] init];
    LangInfo_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}



//取得硬體設定－時區設定
-(void) Send_TimeZoneInfo:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    //    AppGetSupportLanguage.html?userAccount=andywang&account=test&data=7ee2ac770561c311e666b49953a71eaa42264161dce51f51dc8ab33741a86adc&timeStamp=2013/08/01%2013:52:34
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&type=sys&name=timeZoneString",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSysParameter.html",INK_Url_1];
    
    NSLog(@"時區設定 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    TimeZoneInfo_tempData = [NSMutableData alloc];
    TimeZoneInfo_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
//    [self addloadingView];
    
    
}



//取得硬體設定
-(void) Send_UserDevSet:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingHardware.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Dev_tempData = [NSMutableData alloc];
    Dev_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
//    [self addloadingView];
    
    
}



//取得跌倒設定
-(void) Send_UserFallSet:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingFall.html",INK_Url_1];
    
    NSLog(@"httpbody = %@",httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Fall_tempData = [NSMutableData alloc];
    Fall_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}



//取得離家提醒設定
-(void) Send_UserLeaveSet:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingLeaveHome.html",INK_Url_1];
    
    NSLog(@"離家提醒設定 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    LeaveRemind_tempData = [NSMutableData alloc];
    LeaveRemind_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}


//取得展示照片
-(void) Send_ShowImage:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingOtherPic.html",INK_Url_1];
    
    NSLog(@"取得展示照片 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    ShowImage_tempData = [[NSMutableData alloc] init];
    ShowImage_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}



//活動區域取得離家提醒設定
-(void) Send_ActLeaveSet:(NSString *)acc andHash: (NSString *)hash
{
    NSLog(@"log = account = %@",AccData);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSettingLeaveHome.html",INK_Url_1];
    
    NSLog(@"活動區域離家提醒設定 = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    ActLeave_tempData = [NSMutableData alloc];
    ActLeave_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
    
    
}


//取得佩帶者狀態(傳輸)
-(void) Send_UserSet:(NSString *)acc AndHash:(NSString *)hash
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetStatus.html",INK_Url_1];
    
    NSLog(@"設備資訊 Api  = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    Set_tempData = [NSMutableData alloc];
    Set_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self addloadingView];

}

////刪除親情照片
//-(void) DeleteFamilyImage:(NSString *)acc AndHash:(NSString *)hash AndIdx:(NSNumber*)idx
//{
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:DEFAULTDATE];
//    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
//    
//    
//    NSString *tmpstr;
//    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
//    
//    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
//
//    
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
//    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
//    
//    NSLog(@"dataIn: %@", dataIn);
//    
//    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//    hash = [out2 description];
//    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
//    
//    NSLog(@"Hash : %@", hash);
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
//    request.timeoutInterval = TimeOutLimit;
//    
//    NSString *deleteAPI = [NSString stringWithFormat:@"%@/DeleteFamilyPhoto",INK_Url_1];
//    
//    NSLog(@"DeleteFamilyPhoto = %@",deleteAPI);
//    
//    [request setURL:[NSURL URLWithString:deleteAPI]];
//    [request setHTTPMethod:@"POST"];
//    
//    //設定Header
//    
//    NSString *boundary = [NSString stringWithFormat:@"---------%ld",random()];
//    
//    NSString *boundaryString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    
//    NSNumber *type = @(1);
//    
//    [request addValue:boundaryString forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
//    
//    NSLog(@"userAcc = %@ account = %@,timestamp = %@ data = %@ type = %@",acc,[AccData objectAtIndex:NowUserNum],dateString,hash,type);
//    
//    //設定Body
//    NSLog(@"body init");
//    
//    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:acc,@"userAccount",[AccData objectAtIndex:NowUserNum],@"account",dateString,@"timeStamp",hash,@"data", type,@"familyPicNum",nil];
//
//    
//    /********測試********/
//    
//    
//    // Add HTTP Body
//    NSMutableData *POSTBody = [NSMutableData data];
//    [POSTBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Add Key/Values to the Body
//    NSEnumerator *enumerator = [dic keyEnumerator];
//    NSString *key;
//    
//    while ((key = [enumerator nextObject])) {
//        [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
//        [POSTBody appendData:[[NSString stringWithFormat:@"%@", [dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
//        [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    // Add the closing -- to the POST Form
//    [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:POSTBody];
//    
//    
//    
//    DeleteFamilyImage_tempData = [NSMutableData alloc];
//    DeleteFamilyImage_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    
//    [self addloadingView];
//}

//刪除親情照片
-(void) DeleteFamilyImage:(NSString *)acc AndHash:(NSString *)hash AndIdx:(NSNumber*)idx
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&familyPicNum=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,idx];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppDelFamilyPhoto.html",INK_Url_1];
    
    NSLog(@"刪除親情照片 Api  = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    DeleteFamilyImage_tempData = [NSMutableData alloc];
    DeleteFamilyImage_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
    
}

//刪除展示照片
-(void) DeleteShowImage:(NSString *)acc AndHash:(NSString *)hash AndIdx:(NSNumber*)idx
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&otherPicNum=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,idx];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppDelSettingOtherPic.html",INK_Url_1];
    
    NSLog(@"刪除展示照片 Api  = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    DeleteShowImage_tempData = [NSMutableData alloc];
    DeleteShowImage_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self addloadingView];
    
}






//更新使用者資訊
-(void)Update_UserDate:(NSString *)acc andHash: (NSString *)hash InfoDic:(NSDictionary *)dic
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&realName=%@&Sex=%@&Address=%@&Phone=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"realName"],[dic objectForKey:@"Sex"],[dic objectForKey:@"Address"],[dic objectForKey:@"Phone"]];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppEditMember.html",INK_Url_1];
    
    NSLog(@"修改配戴者資訊 : %@?%@", getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
//    NSLog(@"儲存佩戴者資訊%@?%@",getUserApi,httpBodyString);
    
    UpdateUser_tempData = [[NSMutableData alloc] init];
    UpdateUser_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    [self addloadingView];
}

//更新SOS電話資訊
-(void)Update_SOS:(NSString *)acc andHash: (NSString *)hash InfoDic:(NSDictionary *)dic
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    /*
    NSString *personName1 = [dic objectForKey:@"personName1"];
    NSString *personPhone1 = [dic objectForKey:@"personPhone1"];
    NSString *personName2 = [dic objectForKey:@"personName2"];
    NSString *personPhone2 = [dic objectForKey:@"personPhone2"];
    NSString *personName3 = [dic objectForKey:@"personName3"];
    NSString *personPhone3 = [dic objectForKey:@"personPhone3"];
    NSString *familyName1 = [dic objectForKey:@"familyName1"];
    NSString *familyPhone1 = [dic objectForKey:@"familyPhone1"];
    NSString *familyName2 = [dic objectForKey:@"familyName2"];
    NSString *familyPhone2 = [dic objectForKey:@"familyPhone2"];
    NSString *familyName3 = [dic objectForKey:@"familyName3"];
    NSString *familyPhone3 = [dic objectForKey:@"familyPhone3"];
    */
    NSString *httpBodyString;
    /*
    NSMutableString *bodyString = [NSMutableString string];
    
    if (personName1.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personName1=%@",personName1]];
    }
    
    if (personPhone1.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personPhone1=%@",personPhone1]];
    }
    
    if (personName2.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personName2=%@",personName2]];
    }
    
    if (personPhone2.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personPhone2=%@",personPhone2]];
    }
    
    if (personName3.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personName3=%@",personName3]];
    }
    
    if (personPhone3.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&personPhone3=%@",personPhone3]];
    }
    if (familyName1.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyName1=%@",familyName1]];
    }
    
    if (familyPhone1.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyPhone1=%@",familyPhone1]];
    }
    
    if (familyName2.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyName2=%@",familyName2]];
    }
    if (familyPhone2.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyPhone2=%@",familyPhone2]];
    }
    
    if (familyName3.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyName3=%@",familyName3]];
    }
    if (familyPhone3.length>0) {
        [bodyString appendString:[NSString stringWithFormat:@"&familyPhone3=%@",familyPhone3]];
    }
    */
    NSString *personPhone1 = [dic objectForKey:@"personPhone1" ];

    if (personPhone1.length >0 && [[personPhone1 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        personPhone1 = [personPhone1 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"personPhone1 = %@",personPhone1);
    }
    
    NSString *personPhone2 = [dic objectForKey:@"personPhone2" ];
    
    if (personPhone2.length >0 && [[personPhone2 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        personPhone2 = [personPhone2 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"personPhone2 = %@",personPhone2);
    }
    
    NSString *personPhone3 = [dic objectForKey:@"personPhone3" ];
    
    if (personPhone3.length >0 && [[personPhone3 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        personPhone3 = [personPhone3 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"personPhone3 = %@",personPhone3);
    }
    
    NSString *familyPhone1 = [dic objectForKey:@"familyPhone1" ];
    if (familyPhone1.length >0 && [[familyPhone1 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        familyPhone1 = [familyPhone1 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"familyPhone1 = %@",familyPhone1);
    }
    
    NSString *familyPhone2 = [dic objectForKey:@"familyPhone2" ];
    if (familyPhone2.length >0 && [[familyPhone2 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        familyPhone2 = [familyPhone2 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"familyPhone2 = %@",familyPhone2);
    }
    
    NSString *familyPhone3 = [dic objectForKey:@"familyPhone3" ];
    if (familyPhone3.length >0 && [[familyPhone3 substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"])
    {
        
        familyPhone3 = [familyPhone3 stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
        
        NSLog(@"familyPhone3 = %@",familyPhone3);
    }
    
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&personName1=%@&personPhone1=%@&personName2=%@&personPhone2=%@&personName3=%@&personPhone3=%@&familyName1=%@&familyPhone1=%@&familyName2=%@&familyPhone2=%@&familyName3=%@&familyPhone3=%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,[dic objectForKey:@"personName1"],personPhone1,[dic objectForKey:@"personName2"],personPhone2,[dic objectForKey:@"personName3"],personPhone3,[dic objectForKey:@"familyName1"],familyPhone1,[dic objectForKey:@"familyName2"],familyPhone2,[dic objectForKey:@"familyName3"],familyPhone3];

    
//    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@%@",acc,[AccData objectAtIndex:NowUserNum], hash,dateString,bodyString];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppEditMemberPhone.html",INK_Url_1];
    
    NSLog(@"上傳緊急電話 api = %@?%@",getUserApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    UpdatePhone_tempData = [[NSMutableData alloc] init];
    UpdatePhone_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    [self addloadingView];
     
}






/*
//新增佩帶者資料(傳輸)
-(void) Add_User:(NSString *)acc andHash:(NSString *)hash
{
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    tmpSaveToken = [defaults objectForKey:@"token"];

    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    
    
    
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    NSString *httpBodyString;
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=iOS",userAccount,[u],pwd,hash,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@%%20%@&token=%@&device=iOS",userAcc,acc,pwd,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],tmpSaveToken];
        
    }
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppAddGroupMember.html",INK_Url_1];
    NSLog(@"loginApi = %@?%@",loginApi,httpBodyString);
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [request setURL:[NSURL URLWithString:loginApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Add_tempData = [NSMutableData alloc];
    Add_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
    
}
*/

//編輯配戴者顯示圖片
-(void)Send_UploadPhoto:(NSString *)acc andHash:(NSString *)hash andImageData:(NSData *)imagedata
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSLog(tmpstr);
    
//    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash = [out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadPhoto",INK_Url_1];
//    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadPhoto",@"http://192.168.1.115:8081/angelcare"];
    
    NSLog(@"upload API = %@",uploadAPI);
    
    [request setURL:[NSURL URLWithString:uploadAPI]];
    [request setHTTPMethod:@"POST"];
    
    //設定Header
    
    NSString *boundary = [NSString stringWithFormat:@"---------%ld",random()];
    
    NSString *boundaryString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:boundaryString forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    NSLog(@"userAcc = %@,timestamp = %@ data = %@",acc,dateString,hash);
    
    //設定Body
//    NSMutableData *body = [[NSMutableData alloc] init];
    NSLog(@"body init");
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:acc,@"userAccount",[AccData objectAtIndex:NowUserNum],@"account",dateString,@"timeStamp",hash,@"data", nil];
    
    /*
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"andywang",@"userAccount",@"rebecca",@"account",@"2011/2/14%2014:00:00",@"timeStamp",@"D29A722D87B81A0EC6D1616A3F299844429C5F6973AB4D5A9413959C305DD5DD",@"data", nil];
     */
    
    /********測試********/
    
    
    // Add HTTP Body
    NSMutableData *POSTBody = [NSMutableData data];
    [POSTBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add Key/Values to the Body
    NSEnumerator *enumerator = [dic keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"%@", [dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"angelbaby.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [POSTBody appendData:imagedata];
    
    // Add the closing -- to the POST Form
    [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:POSTBody];
    
    /*******************/
    /*
    //使用者帳號
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userAccount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n",acc] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"useracc init");
    //佩戴者帳號
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"account\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",[AccData objectAtIndex:NowUserNum]] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"acc init");
    //TimeStamp
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"timeStamp\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@%%20%@",[arr objectAtIndex:0],[arr objectAtIndex:1]] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"timestamp init");
    //Data
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",hash] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"data init");
    //Image
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"angelbaby.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:imagedata];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"image init");
    
    [request setHTTPBody:body];
     */
    /*
    UploadPhoto_tempData = [NSMutableData alloc];
    UploadPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    */
    
    UploadPhoto_tempData = [NSMutableData alloc];
    UploadPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
    /*
    NSError *error;
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSLog(@"%@",error);
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"return String = %@",returnString);
    */
//    [self addloadingView];
}







//編輯配戴者顯示圖片
-(void)Send_UploadFamilyPhoto:(NSString *)acc andHash:(NSString *)hash andImageData:(NSData *)imagedata andType:(NSString *)type
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSLog(tmpstr);
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash = [out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadFamilyPhoto",INK_Url_1];
    //    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadPhoto",@"http://192.168.1.115:8081/angelcare"];
    
    NSLog(@"upload Family API = %@",uploadAPI);
    
    [request setURL:[NSURL URLWithString:uploadAPI]];
    [request setHTTPMethod:@"POST"];
    
    //設定Header
    
    NSString *boundary = [NSString stringWithFormat:@"---------%ld",random()];
    
    NSString *boundaryString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:boundaryString forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    NSLog(@"userAcc = %@ account = %@,timestamp = %@ data = %@ type = %@",acc,[AccData objectAtIndex:NowUserNum],dateString,hash,type);
    
    //設定Body
    //    NSMutableData *body = [[NSMutableData alloc] init];
    NSLog(@"body init");
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:acc,@"userAccount",[AccData objectAtIndex:NowUserNum],@"account",dateString,@"timeStamp",hash,@"data", type,@"familyPicNum",nil];
    
    /*
     NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"andywang",@"userAccount",@"rebecca",@"account",@"2011/2/14%2014:00:00",@"timeStamp",@"D29A722D87B81A0EC6D1616A3F299844429C5F6973AB4D5A9413959C305DD5DD",@"data", nil];
     */
    
    /********測試********/
    
    
    // Add HTTP Body
    NSMutableData *POSTBody = [NSMutableData data];
    [POSTBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add Key/Values to the Body
    NSEnumerator *enumerator = [dic keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"%@", [dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"family.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [POSTBody appendData:imagedata];
    
    // Add the closing -- to the POST Form
    [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:POSTBody];
    
    /*******************/
    /*
     //使用者帳號
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userAccount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@\r\n",acc] dataUsingEncoding:NSUTF8StringEncoding]];
     
     NSLog(@"useracc init");
     //佩戴者帳號
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"account\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[AccData objectAtIndex:NowUserNum]] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"acc init");
     //TimeStamp
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"timeStamp\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@%%20%@",[arr objectAtIndex:0],[arr objectAtIndex:1]] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"timestamp init");
     //Data
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",hash] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"data init");
     //Image
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"angelbaby.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:imagedata];
     
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"image init");
     
     [request setHTTPBody:body];
     */
    /*
     UploadPhoto_tempData = [NSMutableData alloc];
     UploadPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
     */
    
    UploadFamilyPhoto_tempData = [[NSMutableData alloc] init];
    UploadFamilyPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
    /*
     NSError *error;
     
     NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
     
     NSLog(@"%@",error);
     
     NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
     NSLog(@"return String = %@",returnString);
     */
    //    [self addloadingView];
}


////========


//上傳展示照片
-(void)Send_UploadShowPhoto:(NSString *)acc andHash:(NSString *)hash andImageData:(NSData *)imagedata andType:(NSString *)type
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    //    NSLog(tmpstr);
    
    //    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash = [out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadOtherPic",INK_Url_1];
    //    NSString *uploadAPI = [NSString stringWithFormat:@"%@/UploadPhoto",@"http://192.168.1.115:8081/angelcare"];
    
    NSLog(@"UploadOtherPic API = %@",uploadAPI);
    
    [request setURL:[NSURL URLWithString:uploadAPI]];
    [request setHTTPMethod:@"POST"];
    
    //設定Header
    
    NSString *boundary = [NSString stringWithFormat:@"---------%ld",random()];
    
    NSString *boundaryString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:boundaryString forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    NSLog(@"userAcc = %@ account = %@,timestamp = %@ data = %@ type = %@",acc,[AccData objectAtIndex:NowUserNum],dateString,hash,type);
    
    //設定Body
    //    NSMutableData *body = [[NSMutableData alloc] init];
    NSLog(@"body init");
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:acc,@"userAccount",[AccData objectAtIndex:NowUserNum],@"account",dateString,@"timeStamp",hash,@"data", type,@"otherPicNum",nil];
    
    /*
     NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"andywang",@"userAccount",@"rebecca",@"account",@"2011/2/14%2014:00:00",@"timeStamp",@"D29A722D87B81A0EC6D1616A3F299844429C5F6973AB4D5A9413959C305DD5DD",@"data", nil];
     */
    
    /********測試********/
    
    
    // Add HTTP Body
    NSMutableData *POSTBody = [NSMutableData data];
    [POSTBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add Key/Values to the Body
    NSEnumerator *enumerator = [dic keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"%@", [dic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"family.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [POSTBody appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [POSTBody appendData:imagedata];
    
    // Add the closing -- to the POST Form
    [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:POSTBody];
    
    /*******************/
    /*
     //使用者帳號
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userAccount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@\r\n",acc] dataUsingEncoding:NSUTF8StringEncoding]];
     
     NSLog(@"useracc init");
     //佩戴者帳號
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"account\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",[AccData objectAtIndex:NowUserNum]] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"acc init");
     //TimeStamp
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"timeStamp\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@%%20%@",[arr objectAtIndex:0],[arr objectAtIndex:1]] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"timestamp init");
     //Data
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@",hash] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"data init");
     //Image
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"fileName\"; filename=\"angelbaby.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     [body appendData:imagedata];
     
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     NSLog(@"image init");
     
     [request setHTTPBody:body];
     */
    /*
     UploadPhoto_tempData = [NSMutableData alloc];
     UploadPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
     */
    
    UploadShowPhoto_tempData = [[NSMutableData alloc] init];
    UploadShowPhoto_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
    /*
     NSError *error;
     
     NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
     
     NSLog(@"%@",error);
     
     NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
     NSLog(@"return String = %@",returnString);
     */
    //    [self addloadingView];
}

-(void)Http_Process_NewDate
{
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Date_NewtempData encoding:NSUTF8StringEncoding];
    
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        if( [status isEqualToString:str1]  )
        {
            
            NSLog(@"back name is %@",[usersOne objectForKey:@"name"]);
            
            /*
            NSString *TValue1 = [usersOne objectForKey:@"name"];
            [(UserDateView *) UserDateView Set_Value:1:TValue1];
            
            NSString *TValue2 = [usersOne objectForKey:@"sex"];
            [(UserDateView *) UserDateView Set_Value:2:TValue2];
            
            NSString *TValue3 = [usersOne objectForKey:@"address"];
            [(UserDateView *) UserDateView Set_Value:3:TValue3];
            
            NSString *TValue4 = [usersOne objectForKey:@"imei"];
            [(UserDateView *) UserDateView Set_Value:4:TValue4];
            
            
            NSString *TValue5 = [usersOne objectForKey:@"phone"];
            [(UserDateView *) UserDateView Set_Value:5:TValue5];
            
            
            NSString *TValue6 = [usersOne objectForKey:@"service"];
            [(UserDateView *) UserDateView Set_Value:6:TValue6];
            
            NSString *TValue7 = [usersOne objectForKey:@"img_url"];
            [(UserDateView *) UserDateView Set_Value:7:TValue7];
            */
            
            
            [UserData replaceObjectAtIndex:NowUserNum withObject:[usersOne objectForKey:@"name"]];
            [PhoneData replaceObjectAtIndex:NowUserNum withObject:[usersOne objectForKey:@"phone"]];
            
            

            NSUserDefaults* defaults;
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setInteger:0 forKey:@"totalcount"];
            [defaults synchronize];
                    
            for (int z=0;z<[UserData count]; z++)
            {
                NSLog(@"add one");
                [self SaveNewData2:[UserData objectAtIndex:z]: [PhoneData objectAtIndex:z]: [AccData objectAtIndex:z]: [HashData objectAtIndex:z]];
            }
            
            
            [self Set_Go:NowUserNum];
            
            [self Change_State:IF_INDEX];
            [self Change_State:IF_SETTING];
            
        }
        else
        {
            
            
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
        
    }
    
    [self Ctl_LoadingView:FALSE];
    
}


//解析使用者資料
-(void)Http_Process_Date
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Date_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [(UserDateView *)UserDateView Set_Init:self];
    if( [status isEqualToString:str1]  )
    {
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[usersOne objectForKey:@"name"],@"name",[usersOne objectForKey:@"address"],@"address",[usersOne objectForKey:@"imei"],@"imei",[usersOne objectForKey:@"img_url"],@"img_url",[usersOne objectForKey:@"phone"],@"phone",[usersOne objectForKey:@"service"],@"service",[usersOne objectForKey:@"sex"],@"sex", nil];
        
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[usersOne objectForKey:@"name"],@"name",[usersOne objectForKey:@"address"],@"address",[usersOne objectForKey:@"imei"],@"imei",@"",@"img_url",[usersOne objectForKey:@"phone"],@"phone",[usersOne objectForKey:@"service"],@"service",[usersOne objectForKey:@"sex"],@"sex", nil];
        
        [(UserDateView *)UserDateView setAccountData:dic];
        [(UserDateView *)UserDateView setDelegate:self];
        
        //取得緊急電話與親情電話
        [self Send_SoSandFamilyPhone:userAccount andHash:userHash];
        [self Change_State:IF_USERDATE];
//        [HUD hide:YES];
        
    } else
    {
        [(UserDateView *)UserDateView Set_Init:self];
        NSLog(@"佩戴者異常");
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
    
    
    
}

// 解析地圖使用者IMEI
- (void)Http_MapImeiInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MapImei_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if([status isEqualToString:str1])
    {
        [HUD hide:YES];
        if(IF_State == 3){
            [(MyMapView *)MyMapView SetIMEI:[usersOne objectForKey:@"imei"]  AndPhone:[usersOne objectForKey:@"phone"]];
        }
        else if(IF_State == 15){
            [(CallLimit *)CallLimit SetIMEI:[usersOne objectForKey:@"imei"]  AndPhone:[usersOne objectForKey:@"phone"]];
        }
        else if(IF_State == 16){
            [(DeviceSet *)DeviceSet SetIMEI:[usersOne objectForKey:@"imei"]  AndPhone:[usersOne objectForKey:@"phone"]];
        }
        else if(IF_State == IF_LocatingEdit){
            NSLog(@"*** Postion phone number: %@", [usersOne objectForKey:@"phone"]);
            [(LocatingEdit *)LocatingEditView SetIMEI:[usersOne objectForKey:@"imei"]
                                             AndPhone:[usersOne objectForKey:@"phone"]];
        }
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

#pragma mark - 设备状态
- (void)Http_Process_Set
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Set_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSLog(@"设备状态 = %@", usersOne);

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if([status isEqualToString:str1]) {
        [(UserSetView *)UserSetView Set_Init:self SetDic:usersOne];
        [self Change_State:IF_USERSET];
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }

    [HUD hide:YES];
}


- (void)Http_Process_Clear
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Clear_tempData encoding:NSUTF8StringEncoding];
    
    
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    NSLog(@" clear back ");
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@" clear ok ");
            
            NSUserDefaults* defaults;
            defaults = [NSUserDefaults standardUserDefaults];
                      
            NSString *str4 = [NSString stringWithFormat:@"HaveSendClear"];
            [defaults setInteger:3 forKey:str4];
           
            [defaults synchronize];
            
  
        }
        else
        {

        }
    }
    
    
    
    
}


-(void)Http_Process_Del
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Del_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSArray *arr = [usersOne objectForKey:@"list"];
    NSLog(@"arr = %@",arr);
    [HUD hide:YES];
    
    if( [status isEqualToString:str1]  )
    {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        int accNum = 0;
        NSMutableArray *tmpA = [NSMutableArray new];//0313 bug 新增使用者消失事件！
        for (int i =0; i<[arr count]; i++) {
            
            //            if ([[[arr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
            //擋住使用者
            if ([[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType1] ||
                [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType2]
                )
            {
                
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"type"] forKey:[NSString stringWithFormat:@"Type%i",accNum+1]];
                accNum ++ ;
                [tmpA addObject:[arr objectAtIndex:i]];//0313 bug 新增使用者消失事件！
            }
        }
        [defaults setInteger:accNum forKey:@"totalcount"];
        [defaults setObject:tmpA forKey:@"accList"];//0313 bug 新增使用者消失事件！
        [defaults synchronize];
        
        [self UpdateNameLbl];
        [self Check_Down_Bu];
        
        [(GroupMemberView *)GroupMemberView Do_Init:self];
        [(GroupMemberView *)GroupMemberView Set_Init:NowUserNum];
        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        NSLog(@"error happen");
    }
}

- (void)Http_Process_Save
{
    [self Ctl_LoadingView:false];

    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:Save_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];

    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0];
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d", 0];

        if([status isEqualToString:str1])
        {
            NSLog(@" save ok ");
            
            if(IF_State == IF_EATSEL)
            {

            }
            else if( IF_State == IF_DATESEL)
            {
            }
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
        }
    }

    [self Ctl_LoadingView:false];
}

//歷史記錄-緊急(回傳解析)

- (void)Http_Process_His
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:His_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    NSArray *data = [usersOne objectForKey:@"Data"];
    
    [(MyHisView *)MyHisView Do_Init:self];
    
    NSLog(@"data = %@",data);
    
    if( [status isEqualToString:str1]  )
    {
        [(MyHisView *)MyHisView Set_Init:data];
        [(MyHisView *)MyHisView setDict:usersOne];
        [self Change_State:IF_HIS];
        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

- (void)Http_WiFiList
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:WiFiList_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    NSArray *data = [usersOne objectForKey:@"data"];
    NSMutableArray *m_data = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        [m_data addObject:[NSNull null]];
    }

    for (int i = 0; i < data.count; i++) {
        NSDictionary *m_dict = [data objectAtIndex:i];
        int m_index =  [[m_dict objectForKey:@"no"] intValue] - 1;
        [m_data replaceObjectAtIndex:m_index withObject:m_dict];
    }

    if([status isEqualToString:str1])
    {
        [(AutoLocating*)AutoLocatingView setData:m_data];
        [(AutoLocating*)AutoLocatingView Do_init:self];
        [HUD hide:YES];
        [self Change_State:IF_AutoLocating];
    }
    else
    {
        NSLog(@"WiFiList_Connect = %@", data);
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

- (void)Http_WiFi
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:GetWiFi_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    NSLog(@"%@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    NSArray *data = [usersOne objectForKey:@"data"];
    if([status isEqualToString:str1])
    {
        if (data.count != 0) {
            NSDictionary *m_dict = [data objectAtIndex:0];
            NSString *mac = [m_dict objectForKey:@"mac"];
            NSString *rssi = [m_dict objectForKey:@"rssi"];
            NSString *m_string = [NSString stringWithFormat:@"%@,%@",mac,rssi];
            LocatingEditView.WIFIMACLabel.text = m_string;
            LocatingEditView.WiFiMac = mac;
        }

        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

- (void)Http_SetWiFi
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:SetWiFi_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if([status isEqualToString:str1]) {
        [self Change_State:IF_AutoLocating];
//        [(AutoLocating*)AutoLocatingView Do_init:self];
//        [(AutoLocating*)AutoLocatingView setData:m_data];
        [HUD hide:YES];
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//歷史記錄-跌倒(回傳解析)
- (void) Http_Process_His2
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString* json_string = [[NSString alloc] initWithData:His_tempData encoding:NSUTF8StringEncoding];
    id jsonObject = [parser objectWithString:json_string error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        
    }
    // treat as a dictionary, or reassign to a dictionary ivar
    else if ([jsonObject isKindOfClass:[NSArray class]])
    {
        
        NSDictionary *usersOne = [jsonObject  objectAtIndex:0] ;
        
        
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        
        if( [status isEqualToString:str1]  )
        {
            NSLog(@"ok la ");
            
            [self Ctl_LoadingView:true];
            
            id station = [usersOne objectForKey:@"Data"];

            if ([station isKindOfClass:[NSArray class]])
            {
                NSArray *tmpb1 = station;

                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"datatime"];
                    NSString * tmpValue2 =[buf1 objectForKey:@"place"];
                    
                    
                    if(tmpValue1 == NULL)
                    {
                        tmpValue1 = @"";
                    }
                    
                    if(tmpValue2 == NULL)
                    {
                        tmpValue2 = @"";
                    }
                }
            }

            [self Ctl_LoadingView:false];
            [self Change_State:IF_HIS];
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            [self Ctl_LoadingView:false];
        }
    }
}

//歷史記錄-通話(回傳解析)
- (void)Http_Process_His3
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:His_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

        if( [status isEqualToString:str1]  )
        {
            [self Ctl_LoadingView:true];
            
            id station = [usersOne objectForKey:@"Data"];
    
            if ([station isKindOfClass:[NSArray class]])
            {
                NSArray *tmpb1 = station;

                for(int j =0;j< tmpb1.count;j++ )
                {
                    id buf1 = [tmpb1 objectAtIndex:j];
                    
                    NSString * tmpValue1 =[buf1 objectForKey:@"start_time"];
                    NSString * tmpValue2 =[buf1 objectForKey:@"end_time"];
                    NSString * tmpValue3 =[buf1 objectForKey:@"duration"];
                    
                    if(tmpValue1 == NULL)
                    {
                        tmpValue1 = @"";
                    }
                    
                    if(tmpValue2 == NULL)
                    {
                        tmpValue2 = @"";
                    }
                    
                    if(tmpValue3 == NULL)
                    {
                        tmpValue3 = @"";
                    }
                }
            }

            [self Ctl_LoadingView:false];
            [self Change_State:IF_HIS];
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            [self Ctl_LoadingView:false];
        }
}

//新增佩帶者(回傳解析)
- (void)Http_Process_AddUser
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Add_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];

    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    NSArray *arr = [usersOne objectForKey:@"list"];
    NSLog(@"arr = %@",arr);

    if([status isEqualToString:str1])
    {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        int accNum = 0;
        NSMutableArray *tmpA = [NSMutableArray new];//0313 bug 新增使用者消失事件！
        for (int i =0; i<[arr count]; i++) {
            
            //            if ([[[arr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
            //擋住使用者
            if ([[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType1] ||
                [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType2]
                )
            {
                
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"type"] forKey:[NSString stringWithFormat:@"Type%i",accNum+1]];
                accNum ++;
                [tmpA addObject:[arr objectAtIndex:i]];//0313 bug 新增使用者消失事件！
            }
        }
        [defaults setInteger:accNum forKey:@"totalcount"];
        [defaults setObject:tmpA forKey:@"accList"];//0313 bug 新增使用者消失事件！
        [defaults synchronize];
        
        [self UpdateNameLbl];
        [self Check_Down_Bu];
        
        [(GroupMemberView *)GroupMemberView Do_Init:self];
        [(GroupMemberView *)GroupMemberView Set_Init:NowUserNum];
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        NSLog(@"error happen");
        [HUD hide:YES];
    }
}


//量測紀錄-血糖量測(回傳解析)
- (void)Http_Process_GetData2
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    [inStream close];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        NSLog(@"user one = %@",usersOne);

        NSArray *datearr = [[NSArray alloc] init];
        NSMutableArray *newdateArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[usersOne objectForKey:@"Data"] count]; i++)
        {
            if ([[[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"bloodglucose"] integerValue] != 0)
            {
                [newdateArr addObject:[[usersOne objectForKey:@"Data"] objectAtIndex:i]];
            }
        }

        if (isMainBtn) {
            datearr = newdateArr;
        }
        else
        {
            datearr = [self searchData:searchStart AndEnd:searchEnd withArray:newdateArr];
        }

        isMainBtn = NO;
        //for CustomChart
        [(CustomChart *)chartCustom doInit];
        [(CustomChart *)chartCustom setIsChart:NO];
        [self Change_State:IF_CUSTOMCHART];
        datearr = [self handleData:datearr andKey:@"bloodglucose"];
        [(CustomChart*)chartCustom Set_Init:datearr withType:2];
        [(CustomChart*)chartCustom reloadData];
        [(CustomChart*)chartCustom drawChart];

        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        
        [HUD hide:YES];
    }
}

// 量測紀錄-體重量測(回傳解析)
- (void)Http_Process_GetData4
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    [inStream close];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if ([status isEqualToString:str1])
    {
        NSArray *datearr = [[NSArray alloc] init];
        
        NSMutableArray *newdateArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[usersOne objectForKey:@"Data"] count]; i++)
        {
            if ([[[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"weight"] integerValue] != 0)
            {
                [newdateArr addObject:[[usersOne objectForKey:@"Data"] objectAtIndex:i]];
            }
        }

        if (isMainBtn) {
            datearr = newdateArr;
        }
        else
        {
            datearr = [self searchData:searchStart AndEnd:searchEnd withArray:newdateArr];
        }

        isMainBtn = NO;
        //修改體重start
        //for CustomChart
        [(CustomChart *)chartCustom doInit];
        [(CustomChart *)chartCustom setIsChart:NO];
        [self Change_State:IF_CUSTOMCHART];
        datearr = [self handleData:datearr andKey:@"weight"];
        [(CustomChart*)chartCustom Set_Init:datearr withType:4];
        [(CustomChart*)chartCustom reloadData];
        [(CustomChart*)chartCustom drawChart];
        
        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        
        [HUD hide:YES];
    }
}

- (NSArray *)searchData:(NSString *)startStr
                 AndEnd:(NSString *)endStr
              withArray:(NSArray *)arr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"dd-MM-yyyy"];
    
    NSDate *startDate = [formatter dateFromString:[startStr substringWithRange:NSMakeRange(0, 10)]];
    
    NSDate *endDate = [formatter dateFromString:[endStr substringWithRange:NSMakeRange(0, 10)]];
    
    int startTime = [startDate timeIntervalSince1970]*1;
    int endTime = [endDate timeIntervalSince1970]*1;
    
    int dayNum = (endTime - startTime)/60/60/24;
    
    NSMutableArray *datearr = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<dayNum; i++) {
        
        startTime = startTime + (60*60*24);
        
        NSDate *nowdate = [NSDate dateWithTimeIntervalSince1970:startTime];
        
        NSLog(@"now date = %@ ",[formatter2 stringFromDate:nowdate]);
        
        BOOL isAdd = NO;
        
        
        for (int j=0; j<[arr count]; j++)
        {
            
            if ([[arr objectAtIndex:j] objectForKey:@"time"])
            {
                NSString *tmp = [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:j] objectForKey:@"time"] ] substringFromIndex:6] ;
                NSString *strNowDate = [formatter2 stringFromDate:nowdate];
                NSLog(@"tmp=%@",tmp);
                NSLog(@"strNowDate=%@",strNowDate);
                if ([tmp isEqualToString:strNowDate])
                {
                    isAdd = YES;
                    
                    [datearr addObject:[arr objectAtIndex:j]];
                }
                
               
            }
            
            //計步
            if ([[arr objectAtIndex:j] objectForKey:@"start"])
            {
                if ([[[NSString stringWithFormat:@"%@",[[arr objectAtIndex:j] objectForKey:@"start"] ] substringWithRange:NSMakeRange(0, 10)] isEqualToString:[formatter stringFromDate:nowdate]])
                {
                        isAdd = YES;
                        
                        [datearr addObject:[arr objectAtIndex:j]];
                    
                    NSLog(@"start22222 = %@",[[NSString stringWithFormat:@"%@",[[arr objectAtIndex:j] objectForKey:@"start"] ] substringWithRange:NSMakeRange(0, 10)]);
                }
            }
        }

        if (!isAdd)
        {
            NSDictionary *dateDic = [[NSDictionary alloc] initWithObjectsAndKeys:[formatter2 stringFromDate:nowdate],@"time", nil];

            [datearr addObject:dateDic];
        }
    }

    NSLog(@"is arr %@ ",arr);
    return arr;
}

#pragma mark - 血氧记录
- (void)Http_Process_GetData3
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    [inStream close];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSLog(@"Http_Process_GetData3[血氧记录] = %@", usersOne);

    NSString *status = [usersOne objectForKey:@"status"];

    if ([status isEqualToString:@"0"]) {
        NSArray *datearr = [[NSArray alloc] init];
        NSMutableArray *newdateArr = [[NSMutableArray alloc] init];

        NSString *dateStr;
        float oxy;
        float heartbeat;
        NSMutableArray *listArr = [[NSMutableArray alloc] init];

        NSArray *data = [usersOne objectForKey:@"Data"];

        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *tempDate;
        
        BOOL recordFlag = NO;

        for (int i = 0; i < data.count; i++) {

            dateStr = [data[i] objectForKey:@"time"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *date = [dateFormatter dateFromString:dateStr];
            if (i == 0) {
                tempDate = [date copy];
            }
            unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *comps = [cal components:unitFlags fromDate:date];
            NSDateComponents *tempComps = [cal components:unitFlags fromDate:tempDate];

            if (comps.minute == tempComps.minute) {
                if (recordFlag == NO) {
                    recordFlag = YES;

                    // save the first one
                    oxy = [[data[i] objectForKey:@"oxygen"] floatValue];
                    heartbeat = [[data[i] objectForKey:@"heartbeat"] floatValue];
                    
                    [listArr addObject:data[i]];
                    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [NSString stringWithFormat:@"%i",(int)(oxy + 0.5f)], @"oxygen",
                                         [NSString stringWithFormat:@"%i",(int)(heartbeat + 0.5f)], @"heartbeat",
                                         [dateStr substringWithRange:NSMakeRange(0, 16)], @"time",
                                         listArr, @"list",
                                         nil];
                    listArr = [[NSMutableArray alloc] init];
                    
                    [newdateArr addObject:dic];
                }
            } else {
                //recordFlag = NO;
                
                oxy = [[data[i] objectForKey:@"oxygen"] floatValue];
                heartbeat = [[data[i] objectForKey:@"heartbeat"] floatValue];
                
                [listArr addObject:data[i]];
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%i",(int)(oxy + 0.5f)], @"oxygen",
                                     [NSString stringWithFormat:@"%i",(int)(heartbeat + 0.5f)], @"heartbeat",
                                     [dateStr substringWithRange:NSMakeRange(0, 16)], @"time",
                                     listArr, @"list",
                                     nil];
                listArr = [[NSMutableArray alloc] init];
                
                [newdateArr addObject:dic];
            }

            tempDate = [date copy];
        }

        //血氧修改start
        NSLog(@"newdateArr = %@", newdateArr);

        if (isMainBtn) {
            NSLog(@"isMainBtn = YES");
            datearr = newdateArr;
        } else {
            NSLog(@"isMainBtn = NO");
            datearr = [self searchData:searchStart
                                AndEnd:searchEnd
                             withArray:newdateArr];
        }

        isMainBtn = NO;
        //for CustomChart
        [(CustomChart *)chartCustom doInit];
        [(CustomChart *)chartCustom setIsChart:NO];
        [self Change_State:IF_CUSTOMCHART];
        datearr = [self handleData:datearr andKey:@"oxygen"];
        [(CustomChart*)chartCustom Set_Init:datearr withType:3];
        [(CustomChart*)chartCustom reloadData];
        [(CustomChart*)chartCustom drawChart];
        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];

        [HUD hide:YES];
    }
}

//量測記錄－計步器
-(void)Http_Process_GetData5
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    [inStream close];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if( [status isEqualToString:str1])
    {
        NSLog(@"user one = %@",usersOne);

        //old
//        [(My_ShowView *)ListView Do_Init:5:self];

        NSArray *datearr = [[NSArray alloc] init];
        NSMutableArray *newdateArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [[usersOne objectForKey:@"Data"] count]; i++)
        {
            if ([[[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"dist"] integerValue] != 0)
            {
                [newdateArr addObject:[[usersOne objectForKey:@"Data"] objectAtIndex:i]];
            }
        }

        if (isMainBtn)
        {
            datearr = newdateArr;
        }
        else
        {
            datearr = [self searchData:searchStart AndEnd:searchEnd withArray:newdateArr];
        }

        isMainBtn = NO;
        //修改計步start
        //for CustomChart
        [(CustomChart *)chartCustom doInit];
        [(CustomChart *)chartCustom setIsChart:NO];
        [self Change_State:IF_CUSTOMCHART];

        [(CustomChart*)chartCustom Set_Init:datearr withType:5];
        [(CustomChart*)chartCustom reloadData];
        [(CustomChart*)chartCustom drawChart];
        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        
        [HUD hide:YES];
    }
}

// 量測紀錄-小提醒
- (void)Http_RemindInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Remind_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    [inStream close];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [(CustomChart *)chartCustom  Set_RemindInit:usersOne withType:ShowNum];

        if (isMainBtn) {
            NSLog(@"testtest123");
            [self MyTest:userAccount AndHash:userHash StartTime:@"" andEndTime:@""];
        }else
        {
            [self MyTest:userAccount AndHash:userHash StartTime:searchStart andEndTime:searchEnd];
        }
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        
        [HUD hide:YES];
    }
}

//量測紀錄-血壓量測(回傳解析)
-(void)Http_Process_GetData1
{
        NSError *error;
        NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_tempData];
        [inStream open];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
        [inStream close];
        
        
        NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
        NSString *status = [usersOne objectForKey:@"status"];
        NSString *str1 = [NSString stringWithFormat:@"%d",0];
        
        if( [status isEqualToString:str1]  )
        {
            
            NSLog(@"user one = %@",usersOne);
            
            

            NSArray *datearr = [[NSArray alloc] init];
            NSMutableArray *newdateArr = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [[usersOne objectForKey:@"Data"] count]; i++)
            {
                if ([[[[usersOne objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"systolic"] integerValue] != 0)
                {
                    [newdateArr addObject:[[usersOne objectForKey:@"Data"] objectAtIndex:i]];
                }
            }

            if (isMainBtn) {
                datearr = newdateArr;
            }else
            {
                datearr = [self searchData:searchStart AndEnd:searchEnd withArray:newdateArr];

            }

            isMainBtn = NO;

            //for CustomChart
            [(CustomChart *)chartCustom doInit];
            [(CustomChart *)chartCustom setIsChart:NO];

            [self Change_State:IF_CUSTOMCHART];
            datearr = [self handleData:datearr];
            [(CustomChart*)chartCustom Set_Init:datearr withType:1];
            [(CustomChart*)chartCustom setLimitDict:@{@"up": [usersOne objectForKey:@"Systolic_Up"],@"down":[usersOne objectForKey:@"Diastolic_Up"]}];
            [(CustomChart*)chartCustom reloadData];
            [(CustomChart*)chartCustom drawChart];

            [HUD hide:YES];
        }
        else
        {
            NSString *str1 =[usersOne objectForKey:@"msg"];
            [self Check_Error:str1];
            
            [HUD hide:YES];
        }
        
}

- (NSArray*)handleData:(NSArray*)tmpArray
{
    NSMutableArray *newArray = [NSMutableArray new];
    for (int i = 0; i < tmpArray.count; i++) {
        NSDictionary *dict = [tmpArray objectAtIndex:i];
        if ([dict objectForKey:@"systolic"]) {
            [newArray addObject:dict];
        }
    }

    NSLog(@"newArray %@", newArray);
    return [NSArray arrayWithArray:newArray];
}

- (NSArray*)handleData:(NSArray*)tmpArray andKey:(NSString*)key
{
    NSLog(@"key = %@",key);
    NSMutableArray *newArray = [NSMutableArray new];
    for (int i = 0; i < tmpArray.count; i++) {
        NSDictionary *dict = [tmpArray objectAtIndex:i];
        if ([dict objectForKey:key]) {
            [newArray addObject:dict];
        }
    }
    NSLog(@"newArray %@",newArray);
    return [NSArray arrayWithArray:newArray];
}

#pragma mark - 活动区域
- (void)Http_Process_GetLocAct
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Act_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    NSLog(@">>> Http_Process_GetLocAct = %@", usersOne);

    [(MyActView *)MyActView setListDic:usersOne];

    if ([status isEqualToString:str1]) {
        [HUD hide:YES];

        // 在活动区域的界面显示搜索图标
        Bu_search.hidden = NO;
        Bu_search.enabled = [(MyActView *)MyActView stop];

        id station = [usersOne objectForKey:@"time"];
        id station2 = [usersOne objectForKey:@"location"];
        id station3 = [usersOne objectForKey:@"longitude"];
        id station4 = [usersOne objectForKey:@"latitude"];
        id station5 = [usersOne objectForKey:@"electricity"];
        id station6 = [usersOne objectForKey:@"radius"];
        id station7 = [usersOne objectForKey:@"type"];

        if ([station isKindOfClass:[NSArray class]]) {
            NSArray *tmpb1 = station;
            NSArray *tmpb2 = station2;
            NSArray *tmpb3 = station3;
            NSArray *tmpb4 = station4;
            NSArray *tmpb5 = station5;
            NSArray *tmpb6 = station6;
            NSArray *tmpb7 = station7;
            //#######
            [(MyActView *)MyActView Set_Init:self];
            
            for(int j = 0; j< tmpb1.count; j++ )
            {
                id buf1 = [tmpb1 objectAtIndex:j];
                id buf2 = [tmpb2 objectAtIndex:j];
                id buf3 = [tmpb3 objectAtIndex:j];
                id buf4 = [tmpb4 objectAtIndex:j];
                id buf5 = [tmpb5 objectAtIndex:j];
                id buf6 = [tmpb6 objectAtIndex:j];
                id buf7 = [tmpb7 objectAtIndex:j];
                
                NSString * tmpValue1 =[buf1 objectForKey:@"time"];
                NSString * tmpValue2 =[buf2 objectForKey:@"location"];
                NSString * tmpValue3 =[buf3 objectForKey:@"longitude"];
                NSString * tmpValue4 =[buf4 objectForKey:@"latitude"];
                NSString * tmpValue5 =[buf5 objectForKey:@"electricity"];
                NSString * tmpValue6 =[buf6 objectForKey:@"radius"];
                NSString * tmpValue7 =[buf7 objectForKey:@"location_type"];
                
                if (([tmpValue3 doubleValue] >180 )|| ([tmpValue3 doubleValue] < -180) || ([tmpValue4 doubleValue] >90) || ([tmpValue4 doubleValue] < -90)) {
                    tmpValue3 = @"";
                    tmpValue4 = @"";
                }

                NSLog( @"data %d is 時間%@ ,位置%@ 經度%@,緯度%@,電量%@,範圍%@,type%@  ",j+1,tmpValue1,tmpValue2,tmpValue3,tmpValue4,tmpValue5,tmpValue6,tmpValue7);

                [(MyActView *)MyActView Insert_Data:tmpValue1:tmpValue2:tmpValue3:tmpValue5:tmpValue6:tmpValue4:tmpValue7];
            }

            if (tmpb1.count == 0) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ALERT_ACT_Error1", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_OK") otherButtonTitles: nil];
                [alertView show];
            }
            else
            {
                [(MyActView *)MyActView Do_Init:[UserData objectAtIndex:NowUserNum]];
                [self Change_State:IF_ACT];
            }
        }
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

#pragma mark - 活动区域历史记录搜索网络请求API
- (void)Send_ActionSearch:(NSString *)acc andHash:(NSString *)hash searchDate:(NSString *)searchDate
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    NSString *tmpstr;
    tmpstr = [NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(dataIn.bytes, (unsigned int)dataIn.length,  digest);

    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    // searchDate=2015-09-28
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&account=%@&data=%@&timeStamp=%@&searchDate=%@",
                                acc,
                                [AccData objectAtIndex:NowUserNum],
                                hash,
                                dateString,
                                searchDate];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/API/AppGetSearchActiveRegionByDate.html", INK_Url_1];
    
    [request setURL:[NSURL URLWithString:getUserApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    Search_tempData = [[NSMutableData alloc] init];
    Search_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

#pragma mark 活动区域搜索网络请求成功
- (void)httpProcessLocationActSearch
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Search_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSLog(@">>> httpProcessLocationActSearch = %@", usersOne);

    NSString *status = [usersOne objectForKey:@"status"];
    if ([status isEqualToString:@"0"]) {
        [(MyActView *)MyActView setListDic:usersOne];
        [(MyActView *)MyActView Set_Init:self];
        [(MyActView *)MyActView reloadRouteListView];
        
        id station = [usersOne objectForKey:@"time"];
        id station2 = [usersOne objectForKey:@"location"];
        id station3 = [usersOne objectForKey:@"longitude"];
        id station4 = [usersOne objectForKey:@"latitude"];
        id station5 = [usersOne objectForKey:@"electricity"];
        id station6 = [usersOne objectForKey:@"radius"];
        id station7 = [usersOne objectForKey:@"type"];
        
        if ([station isKindOfClass:[NSArray class]]) {
            NSArray *tmpb1 = station;
            NSArray *tmpb2 = station2;
            NSArray *tmpb3 = station3;
            NSArray *tmpb4 = station4;
            NSArray *tmpb5 = station5;
            NSArray *tmpb6 = station6;
            NSArray *tmpb7 = station7;
            
            for(int j = 0; j< tmpb1.count; j++ ) {
                id buf1 = [tmpb1 objectAtIndex:j];
                id buf2 = [tmpb2 objectAtIndex:j];
                id buf3 = [tmpb3 objectAtIndex:j];
                id buf4 = [tmpb4 objectAtIndex:j];
                id buf5 = [tmpb5 objectAtIndex:j];
                id buf6 = [tmpb6 objectAtIndex:j];
                id buf7 = [tmpb7 objectAtIndex:j];
                
                NSString * tmpValue1 =[buf1 objectForKey:@"time"];
                NSString * tmpValue2 =[buf2 objectForKey:@"location"];
                NSString * tmpValue3 =[buf3 objectForKey:@"longitude"];
                NSString * tmpValue4 =[buf4 objectForKey:@"latitude"];
                NSString * tmpValue5 =[buf5 objectForKey:@"electricity"];
                NSString * tmpValue6 =[buf6 objectForKey:@"radius"];
                NSString * tmpValue7 =[buf7 objectForKey:@"location_type"];
                
                if (([tmpValue3 doubleValue] >180 )|| ([tmpValue3 doubleValue] < -180) || ([tmpValue4 doubleValue] >90) || ([tmpValue4 doubleValue] < -90)) {
                    tmpValue3 = @"";
                    tmpValue4 = @"";
                }

                [(MyActView *)MyActView Insert_Data:tmpValue1:tmpValue2:tmpValue3:tmpValue5:tmpValue6:tmpValue4:tmpValue7];
            }
        }

        [myActSearchView removeFromSuperview];
        Bu_search.hidden = NO;
        Bu_Index.hidden = NO;
        Bu_MapSet.hidden = NO;
    }

    [HUD hide:YES];
}

#pragma mark 搜索按钮点击事件
- (IBAction)searchButtonDidClicked:(UIButton *)sender
{
    myActSearchView.mainClass = self;

    UIView *insertView = [self viewWithTag:12345];
    if (insertView == nil) {
        NSLog(@"*** Please check view with tag = 12345");
        return;
    }

    [self insertSubview:myActSearchView
           belowSubview:insertView];

    Bu_MapSet.hidden = YES;
    Bu_search.hidden = YES;
    Bu_Index.hidden = YES;
}

#pragma mark 搜索页面取消确定按钮
- (void)searchResultButtonDidClicked:(int)index date:(NSDate *)date
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];

    switch (index) {
        case 0:
            [myActSearchView removeFromSuperview];
            Bu_search.hidden = NO;
            Bu_Index.hidden = NO;
            Bu_MapSet.hidden = NO;
            break;
        case 1:
        {
            NSString *dateString = [formater stringFromDate:date];
            [self Send_ActionSearch:userAccount
                            andHash:userHash
                         searchDate:dateString];
        } break;
        default:
            break;
    }
}

#pragma mark 展示定时器停止, 搜索按钮可用
- (void)displayTimerStop
{
    Bu_search.enabled = YES;
}

#pragma mark - 定位救援
- (void) Http_Process_GetLocMap
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Loc_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    [(MyMapView *)MyMapView ClearPoint:self];

    sosMap = usersOne;

    if([status isEqualToString:str1])
    {
        NSLog(@"userone = %@",usersOne);

        if ([[usersOne objectForKey:@"data"] count] > 0) {
            id idTmp = [usersOne objectForKey:@"data"];
            NSDictionary *dicTmp = [idTmp objectAtIndex:0];

            int isGPSGSMWIFI = [[dicTmp objectForKey:@"location_type"] intValue];
            [(MyMapView *)MyMapView setGPS_GSM_WIFI:isGPSGSMWIFI];

            [(MyMapView *)MyMapView Do_Init:self];

            NSString *strTmp = [NSString stringWithFormat:@"%@",[dicTmp objectForKey:@"type"]];
            if ([strTmp isEqualToString:@"28"]) {//type = 28 簡訊定位
                [(MyMapView *)MyMapView setGpsLocation:YES];
            }
            else{
                [(MyMapView *)MyMapView setGpsLocation:NO];
            }

            [self Change_State:IF_MAP ];

            id station = [usersOne objectForKey:@"station"];

            NSString *longitude;
            NSString *latitude;
            NSString *radius;
            
            
            NSString *location;
            NSString *event;
            NSString *name;
            NSString *server_time;
            NSString *watch_time;
            
            id station2 = [usersOne objectForKey:@"data"];
            
            if ([station2 isKindOfClass:[NSArray class]])
            {
                NSArray *tmpb2 = station2;
                
                NSDictionary *true1 = [tmpb2 objectAtIndex:0];
                
                location = [true1 objectForKey:@"location"];
                event = [true1 objectForKey:@"event"];
                name = [true1 objectForKey:@"name"];
                server_time = [true1 objectForKey:@"server_time"];
                watch_time = [true1 objectForKey:@"watch_time"];
                
                [(MyMapView *)MyMapView Set_Text:location andE:event andN:name andST:server_time andWT:watch_time];
            }

            id station3 = [usersOne objectForKey:@"mark"];

            if ([station3 isKindOfClass:[NSArray class]])
            {
                NSArray *tmpb3 = station3;

                if ([tmpb3 count] > 0) {
                    id buf1 = [tmpb3 objectAtIndex:0];
                    NSDictionary *true1 = buf1;
                    
                    longitude = [NSString stringWithFormat:@"%@",[true1 objectForKey:@"longitude"]] ;
                    latitude = [NSString stringWithFormat:@"%@",[true1 objectForKey:@"latitude"]];

                    if (([longitude doubleValue] >180 )|| ([longitude doubleValue] < -180) || ([latitude doubleValue] >90) || ([latitude doubleValue] < -90)) {
                        longitude = @"";
                        latitude = @"";
                    }

                    if( ![longitude isEqualToString:@""]  && ![latitude isEqualToString:@""] )
                    {
                        [(MyMapView *)MyMapView Set_Point_ForAdd:longitude :latitude];
                    }
                    else
                    {
                        NSArray *tmpb1 = station;
                        id buf1 = [tmpb1 objectAtIndex:0];
                        NSDictionary *true1 =    buf1;
                        longitude = [true1 objectForKey:@"longitude"];
                        latitude = [true1 objectForKey:@"latitude"];
                        radius = [true1 objectForKey:@"radius"];
                        //GSM circle
                        [(MyMapView *)MyMapView Set_Circle :longitude:latitude:radius];
                    }
                }
            }
        }else{
            [(MyMapView *)MyMapView Do_Init:self];
            [self Change_State:IF_MAP ];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"ALERT_MAP_Error1", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_OK") otherButtonTitles: nil];
            [alertView show];
        }

        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//簡訊定位(回傳解析)
- (void)Http_Process_GetSMSMap
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Sms_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if([status isEqualToString:str1]) {
        NSLog(@"map server time = %@",mapServerTime);
        NSLog(@"sms server time = %@",smsServerTime);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd H:m:s"];

        NSDate *serverDate = [formatter dateFromString:mapServerTime];
        NSDate *smsDate = [formatter dateFromString:smsServerTime];

        NSDate *newLoction = [serverDate laterDate:smsDate];

        NSLog(@"newLoction = %@",newLoction);

        BOOL isGps;

        if ([newLoction isEqualToDate:serverDate]) {
            usersOne = sosMap;
            isGps = YES;
            NSLog(@"server time");
        } else {
            NSLog(@"SMS time");
            isGps = NO;
        }

        [(MyMapView *)MyMapView Do_Init:self];
        [(MyMapView *)MyMapView setGpsLocation:isGps];

        [self Change_State:IF_MAP];

        id station = [usersOne objectForKey:@"station"];

        NSString *longitude;
        NSString *latitude;
        NSString *radius;
        NSString *location;
        NSString *event;
        NSString *name;
        NSString *server_time;
        NSString *watch_time;

        if ([station isKindOfClass:[NSArray class]])
        {
            NSArray *tmpb1 = station;

            for(int j =0;j< tmpb1.count;j++ )
            {
                id buf1 = [tmpb1 objectAtIndex:j];
                NSDictionary *true1 =    buf1;

                longitude = [true1 objectForKey:@"longitude"];
                latitude = [true1 objectForKey:@"latitude"];
                radius = [true1 objectForKey:@"radius"];

                [(MyMapView *)MyMapView Set_Circle:longitude:latitude:radius];
            }
        }

        id station2 = [usersOne objectForKey:@"data"];

        if ([station2 isKindOfClass:[NSArray class]]) {
            NSArray *tmpb2 = station2;
            for (int j =0;j< tmpb2.count;j++ ) {
                id buf1 = [tmpb2 objectAtIndex:j];

                NSDictionary *true1 = buf1;

                location = [true1 objectForKey:@"location"];
                event = [true1 objectForKey:@"event"];
                name = [true1 objectForKey:@"name"];
                server_time = [true1 objectForKey:@"server_time"];
                watch_time = [true1 objectForKey:@"watch_time"];

                [(MyMapView *)MyMapView Set_Text:location andE:event andN:name andST:server_time andWT:watch_time];
                break;
            }
        }

        id station3 = [usersOne objectForKey:@"mark"];

        if ([station3 isKindOfClass:[NSArray class]])
        {
            NSArray *tmpb3 = station3;

            for(int j =0; j< tmpb3.count; j++ )
            {
                id buf1 = [tmpb3 objectAtIndex:j];
 
                NSDictionary *true1 =    buf1;
                
                longitude = [true1 objectForKey:@"longitude"];
                latitude = [true1 objectForKey:@"latitude"];
            
                if( longitude!= NULL  && latitude != NULL )
                {
                    [(MyMapView *)MyMapView Set_Point_ForAdd:longitude:latitude];
                }
            }
        }

        [HUD hide:YES];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

// 使用者咨訊修改解析
- (void)Http_UpdateUserInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateUser_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [(UserDateView *)UserDateView Set_Init:self];
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self ReloadUserData];
        [self Send_UserDate:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//使用者緊急電話與親情電話修改
-(void)Http_UpdatePhoneInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdatePhone_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [(UserDateView *)UserDateView Set_Init:self];
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Send_UserDate:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


-(int)returnNowUser
{
    return NowUserNum;
}

-(int)countAllUser
{
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    int totalcount = [defaults integerForKey:@"totalcount"];
    return totalcount;
}


-(void)push_changeUser: (NSString *)name
{
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    int totalcount = [defaults integerForKey:@"totalcount"];
    for (int i=0; i<totalcount; i++)
    {
        NSString *username = [defaults objectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        
        if ([username isEqualToString:name])
        {
            if (NowUserNum != i) {
                NowUserNum = i;
                [ShowName setText:[UserData objectAtIndex:NowUserNum]];
                [self Check_Down_Bu];
            }
            
            break;
        }
    }
}

-(void)btnInitImage{
    [btnDay setBackgroundImage:[UIImage imageNamed:@"icon_record_up_day"] forState:UIControlStateNormal];
    [btnWeek setBackgroundImage:[UIImage imageNamed:@"icon_record_up_week"] forState:UIControlStateNormal];
    [btnMonth setBackgroundImage:[UIImage imageNamed:@"icon_record_up_month"] forState:UIControlStateNormal];
    [btnInter setBackgroundImage:[UIImage imageNamed:@"icon_record_up_interval"] forState:UIControlStateNormal];
}

//改變搜尋區間用於血壓血糖體重的顯示
- (IBAction)changeSearch:(id)sender
{
    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    
    NSDate * originalDate = [NSDate date];
    NSTimeInterval interval;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DEFAULTDATE];
    NSDate * futureDate;
    
    NSLog(@"originalDate date = %@",[formatter stringFromDate:originalDate]);
    NSLog(@"furture date = %@",[formatter stringFromDate:futureDate]);
    searchEnd = [formatter stringFromDate:originalDate];
    switch ([(UIView*)sender tag]) {
        case 101://日
//            [self MyTest:[AccData objectAtIndex:NowUserNum]:[HashData objectAtIndex:NowUserNum] StartTime:@"2013/06/24 00:00:00" andEndTime:@"2013/06/24 23:59:59"];
            interval = - 24*60*60;
            futureDate = [originalDate dateByAddingTimeInterval:interval];
            searchStart = [formatter stringFromDate:futureDate];
            [self btnInitImage];
            [btnDay setBackgroundImage:[UIImage imageNamed:@"icon_record_down_day"] forState:UIControlStateNormal];
            
            [self Send_UserRemind:userAccount andHash:userHash];
            break;
        
        case 102://週
            interval = - 24*60*60*7;
            futureDate = [originalDate dateByAddingTimeInterval:interval];
            searchStart = [formatter stringFromDate:futureDate];
            [self btnInitImage];
            [btnWeek setBackgroundImage:[UIImage imageNamed:@"icon_record_down_week"] forState:UIControlStateNormal];
            
            [self Send_UserRemind:userAccount andHash:userHash];
//            [self MyTest:userAccount AndHash:userHash StartTime:searchStart andEndTime:searchEnd];
            break;
            
        case 103://月
            interval = - 24*60*60*30;
            futureDate = [originalDate dateByAddingTimeInterval:interval];
            searchStart = [formatter stringFromDate:futureDate];
            [self btnInitImage];
            [btnMonth setBackgroundImage:[UIImage imageNamed:@"icon_record_down_month"] forState:UIControlStateNormal];
            
            [self Send_UserRemind:userAccount andHash:userHash];
//            [self MyTest:userAccount AndHash:userHash StartTime:searchStart andEndTime:searchEnd];
            break;
            
        case 104://週期 彈出視窗選擇時間
            [self btnInitImage];
            [btnInter setBackgroundImage:[UIImage imageNamed:@"icon_record_down_interval"] forState:UIControlStateNormal];
            [self searchRange];
            break;
            
        default:
            break;
    }
    
    
}

-(void)searchRange
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"SelectRange", INFOPLIST, nil) message:@"\n\n\n\n" delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
        [alertView setTag:101];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *nowDate = [NSDate date];
        NSString *nowString = [formatter stringFromDate:nowDate];
        
        UILabel *startLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 100, 20)];
        startLbl.text = NSLocalizedStringFromTable(@"StartTime", INFOPLIST, nil);
        startLbl.backgroundColor = [UIColor clearColor];
        startLbl.textColor = [UIColor whiteColor];
        
        SearchstartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SearchstartBtn.frame = CGRectMake(115, 70, 100, 20);
        [SearchstartBtn setTitle:nowString forState:UIControlStateNormal];
        SearchstartBtn.tag = 501;
        [SearchstartBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *endlbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 93, 100, 20)];
        endlbl.text = NSLocalizedStringFromTable(@"EndTime", INFOPLIST, nil);
        endlbl.backgroundColor = [UIColor clearColor];
        endlbl.textColor = [UIColor whiteColor];
        
        SearchendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SearchendBtn.frame = CGRectMake(115, 93, 100, 20);
        [SearchendBtn setTitle:nowString forState:UIControlStateNormal];
        SearchendBtn.tag = 502;
        [SearchendBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:startLbl];
        [alertView addSubview:SearchstartBtn];
        [alertView addSubview:SearchendBtn];
        [alertView addSubview:endlbl];
        [alertView show];
    }else
    {
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        timeView = alertView;
        [alertView setDelegate:self];
        [alertView setTag:101];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *nowDate = [NSDate date];
        NSString *nowString = [formatter stringFromDate:nowDate];
        
        UILabel *startLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 100, 20)];
        startLbl.text = NSLocalizedStringFromTable(@"StartTime", INFOPLIST, nil);
        startLbl.backgroundColor = [UIColor clearColor];
        startLbl.textColor = [UIColor blackColor];
        
        SearchstartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SearchstartBtn.frame = CGRectMake(115, 50, 100, 20);
        [SearchstartBtn setTitle:nowString forState:UIControlStateNormal];
        SearchstartBtn.tag = 501;
        [SearchstartBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *endlbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 93, 100, 20)];
        endlbl.text = NSLocalizedStringFromTable(@"EndTime", INFOPLIST, nil);
        endlbl.backgroundColor = [UIColor clearColor];
        endlbl.textColor = [UIColor blackColor];
        
        SearchendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SearchendBtn.frame = CGRectMake(115, 93, 100, 20);
        [SearchendBtn setTitle:nowString forState:UIControlStateNormal];
        SearchendBtn.tag = 502;
        [SearchendBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *showAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
        [showAlertView addSubview:startLbl];
        [showAlertView addSubview:SearchstartBtn];
        [showAlertView addSubview:SearchendBtn];
        [showAlertView addSubview:endlbl];
        [alertView setContainerView:showAlertView];

        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil),NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil]];
        [alertView show];
    }
}


- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"customIOS7dialogButtonTouchUpInside %li",(long)buttonIndex);
    [alertView close];
    
    if ([alertView tag] == 101) {
        
        if (buttonIndex == 1) {
            
            NSLog(@"alertView touch %@ %@",SearchstartBtn.titleLabel.text,SearchendBtn.titleLabel.text);
            
            searchStart = [NSString stringWithFormat:@"%@ 00:00",SearchstartBtn.titleLabel.text];
            searchEnd = [NSString stringWithFormat:@"%@ 23:59",SearchendBtn.titleLabel.text];
            
            NSLog(@"search Start = %@",searchStart);
            
            
            
            //            [self MyTest:userAccount AndHash:userHash StartTime:SearchstartBtn.titleLabel.text andEndTime:SearchendBtn.titleLabel.text];
            [self Send_UserRemind:userAccount andHash:userHash];
        }
    }
    else if ([alertView tag] == 8016051){
        if (buttonIndex == 1) {
            [self Set_Missing_Join_Stastus_Acc:userAccount withStatus:@"1"];
        }
    }
    else if ([alertView tag] == 8016052){
        if (buttonIndex == 1) {
            [self Set_Missing_Join_Stastus_Acc:userAccount withStatus:@"2"];
        }
    }
    else{
        
    }
}


-(IBAction)searchBtnClick:(id)sender
{
    
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    }
    else {
        // use UIAlertView
        [self useActionSheet:sender];
    }
}

- (void)useAlerController:(id)sender{
    [timeView setHidden:YES];
    // use UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   ////todo
                                   NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
                                   [pickdate setDateFormat:@"yyyy-MM-dd"];
                                   if ([(UIView*)sender tag] == 501) {
                                       [SearchstartBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                                   }else
                                   {
                                       [SearchendBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                                   }
                                   [timeView setHidden:NO];
                               }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                   {
                                       [timeView setHidden:NO];
                                   }];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    
    NSLog(@"start %@",SearchstartBtn.titleLabel.text);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:SearchstartBtn.titleLabel.text];
    
    if ([(UIView*)sender tag]==502) {
        datePicker.minimumDate = startDate;
        datePicker.maximumDate = [NSDate date];
    }
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[self nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}

- (void)useActionSheet:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) , nil];
    sheet.tag = [(UIView*)sender tag];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    
    NSLog(@"start %@",SearchstartBtn.titleLabel.text);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:SearchstartBtn.titleLabel.text];
    
    if ([(UIView*)sender tag]==502) {
        datePicker.minimumDate = startDate;
        datePicker.maximumDate = [NSDate date];
    }
    
    [sheet addSubview:datePicker];
    [self bringSubviewToFront:sheet];
    [sheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
        [pickdate setDateFormat:@"yyyy-MM-dd"];
        
        if ([actionSheet tag] == 501) {
            [SearchstartBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
        }else
        {
            [SearchendBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
        }
    }
    NSLog(@"action sheet index %i",buttonIndex);
}

//上傳設備照片
-(void) uploadJPEGImage:(UIImage *) image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1f);
    [self Send_UploadPhoto:userAccount andHash:userHash andImageData:imageData];
}

//上傳親情照片
-(void) uploadFamilyJPEGImage:(UIImage *) image andType:(int)type
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.0f);
    
//    NSLog(@"image data size %f",(float)imageData.length/1024.0f/1024.0f);
    
    NSLog(@"Byte = %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
    
    NSString *typeStr = [NSString stringWithFormat:@"%i",type];
    [self Send_UploadFamilyPhoto:userAccount andHash:userHash andImageData:imageData andType:typeStr];
}

//上傳展示照片
-(void) uploadShowImage:(UIImage *) image andType:(int)type
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.0f);
    
    //    NSLog(@"image data size %f",(float)imageData.length/1024.0f/1024.0f);
    
    NSLog(@"Byte = %@",[NSByteCountFormatter stringFromByteCount:imageData.length countStyle:NSByteCountFormatterCountStyleFile]);
    
    NSString *typeStr = [NSString stringWithFormat:@"%i",type];
    [self Send_UploadShowPhoto:userAccount andHash:userHash andImageData:imageData andType:typeStr];
}

//上傳拍照後的PNG圖片
-(void)uploadPNGImage:(UIImage *)image
{
    NSLog(@"YES");
    
    
    
    NSData *imageData  = UIImagePNGRepresentation(image);
    
    
    [self Send_UploadPhoto:[AccData objectAtIndex:NowUserNum] andHash:[HashData objectAtIndex:NowUserNum] andImageData:imageData];
    
}

//上傳圖片回傳解析
-(void)Http_UploadPhoto
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UploadPhoto_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Check_Http];//重新取值
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        
    }
    
}

//上傳親情照片
-(void)Http_UploadFamilyPhoto
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UploadFamilyPhoto_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Check_Http];//重新取值
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        
    }
}


//上傳親情照片
-(void)Http_UploadShowPhoto
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UploadShowPhoto_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Check_Http];//重新取值
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        
    }
}

//解析緊急電話與親情電話
-(void)Http_SoSandFamilyPhone
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:SosAndFamilyPhone_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [(UserDateView *)UserDateView setSoSandFamilyPhone:usersOne];
//        [self Send_MedRemind:userAccount andHash:userHash];
        [HUD hide:YES];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        
        if ([str1 isEqualToString:@"7610"]) {
            [HUD hide:YES];
        }else
        {
            [self Check_Error:str1];
            [HUD hide:YES];

        }
        
    }
}

#pragma mark - 解析吃药提醒
- (void)Http_MedRemindInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MedRemind_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSArray *medData = [usersOne objectForKey:@"Data"];
    
    NSLog(@"medData = %@",medData);
    
    if( [status isEqualToString:str1]  )
    {
        [(MyEatShowView *)MyEatShowView Do_Init:self];
        [(MyEatShowView *)MyEatShowView setMedRemind:medData];
        [self Send_HosRemind:userAccount andHash:userHash];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//解析回診提醒
-(void)Http_HosRemindInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:HosRemind_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSArray *hosdata = [usersOne objectForKey:@"Data"];
    NSLog(@"hosData = %@",hosdata);
    if( [status isEqualToString:str1]  )
    {
        [(MyEatShowView *)MyEatShowView setHosRemind:hosdata];
        [(MyEatShowView *)MyEatShowView UpdateData];
        [HUD hide:YES];
        [self Change_State:IF_EATSHOW];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//解析回診提醒
-(void)Http_UpdateMed
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateMed_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Send_MedRemind:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//解析回診提醒
-(void)Http_UpdateHos
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateHos_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self Send_MedRemind:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//解析血壓提醒
-(void)Http_BPInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MBP_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"user one = %@",usersOne);
    
    [(BPRemindView *)BPRemindView Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        //血壓提醒
        [self Change_State:IF_BPREMIND];
        [(BPRemindView *)BPRemindView Set_Init:usersOne];
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//解析血糖提醒
-(void)Http_BSInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MBS_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"jsonArr = %@",jsonArr);
    
    NSDictionary *usersOne = [jsonArr objectAtIndex:0];
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d", 0];
    
    NSLog(@"json dic = %@",usersOne);
    [(BSRemindView *)BSRemindView Do_Init:self];
    if ([status isEqualToString:str1])
    {
        //血糖提醒
        [self Change_State:IF_BSREMIND];
        [(BSRemindView *)BSRemindView Set_Init:usersOne];
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//解析血氧提醒
-(void)Http_BOInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MBO_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(BORemindView *)BORemindView Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        //血氧提醒
        [self Change_State:IF_BOREMIND];
        
        [(BORemindView *)BORemindView Set_Init:usersOne];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//解析運動提醒
-(void)HttP_SportInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MS_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(SportRemindView *)SportRemindView Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        //運動資訊
        [(SportRemindView *)SportRemindView Set_Init:usersOne];
//        [HUD hide:YES];
        [self Get_AA_Setting:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//解析體重提醒
-(void)Http_WeightInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MW_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(WeightRemindView *)WeightRemindView Do_Init:self];
    if( [status isEqualToString:str1]  )
    {
        //體重資訊
        [self Change_State:IF_WEIGHTREMIND];
        [(WeightRemindView *)WeightRemindView Set_Init:usersOne];
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}



//修改解析血壓提醒
-(void)Http_UpdateBP
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateBP_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_BPRemind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [self Send_UserBPRemind:userAccount andHash:userHash];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//修改解析血氧提醒
-(void)Http_UpdateBO
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateBO_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_BORemind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        
        [self Send_UserBORemind:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//修改解析血糖提醒
-(void)Http_UpdateBS
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateBS_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_BSRemind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        
        [self Send_UserBSRemind:userAccount andHash:userHash];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//修改解析運動提醒
-(void)Http_UpdateSport
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateSport_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
//        [HUD hide:YES];
//        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_Sport", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE", INFOPLIST, nil)];
//        [self Send_UserSportRemind:userAccount andHash:userHash];
        
        [(ActivityAlert*)ActAlert SaveSetting];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//修改解析運動提醒
- (void)Http_UpdateWeight
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateWeight_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr objectAtIndex:0];
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_Weight", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [self Send_UserWeightRemind:userAccount andHash:userHash];
       
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//解析通話限制
- (void)Http_CallInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Call_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    NSLog(@"Http_CallInfo json dic = %@",usersOne);

    if([status isEqualToString:str1]) {
        [(DeviceSet *)DeviceSet Set_Init_Call:usersOne];
        //通話限制
        [self Change_State:IF_DEVSET];
        [HUD hide:YES];
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//取得語言設定
- (void)Http_LangInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:LangInfo_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];

    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;

    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if([status isEqualToString:str1]) {
        [(DeviceSet *)DeviceSet setLangArr:[usersOne objectForKey:@"SysParameter"]];
        [self Send_TimeZoneInfo:userAccount andHash:userHash];
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

//取得語言設定
-(void)Http_TimeZoneInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:TimeZoneInfo_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
//        [HUD hide:YES];

        [(DeviceSet *)DeviceSet setTimezoneArr:[usersOne objectForKey:@"SysParameter"]];
        [self Send_UserDevSet:userAccount andHash:userHash]; //取得硬體設定
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
    
    
    
}


//取得同步時間解析
-(void)Http_SyncTimeInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Sync_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
//        [HUD hide:YES];
        if (nextState == 92) {
            [(CallLimit *)CallLimit setSynctimearr:[usersOne objectForKey:@"SysParameter"]];
            [self Send_UserCallLimit:userAccount andHash:userHash];
        }
        else if (nextState == 98){
            //init tWI
            [(trackingWithInterval *)tWI setSynctimearr:[usersOne objectForKey:@"SysParameter"]];

//            [(trackingWithInterval *)tWI do_init];

            [self Get_TWI_Setting:userAccount andHash:userHash];
//            [HUD hide:YES];
        }
        else if (nextState == 93){
            [(DeviceSet *)DeviceSet setSynctimearr:[usersOne objectForKey:@"SysParameter"]];
            [self Send_UserCallLimit:userAccount andHash:userHash];
        }
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

-(void)Http_GpsTimeInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:GpsSync_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        if (nextState == 92) {
            [(CallLimit *)CallLimit setGpstimearr:[usersOne objectForKey:@"SysParameter"]];
            [self Send_GetSync:userAccount andHash:userHash];
        }
        else if (nextState == 98){
            [(trackingWithInterval *)tWI setGpstimearr:[usersOne objectForKey:@"SysParameter"]];
            [self Send_GetSync:userAccount andHash:userHash];
        }
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}


//http 無動作
-(void)Http_AAInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_AA_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //[self call TWI api]

        NSString *keyS = @"startTime";
        NSString *keyE = @"endTime";
        NSString *keyO = @"nonmovementStatus";
        NSString *keyW = @"weekly";
    
        NSString *gpsStart = @"";
        NSString *gpsEnd = @"";
        NSString *gpsOn = @"";
        NSString *gpsW = @"";
        
        
        gpsStart = [usersOne  objectForKey:keyS];
        gpsEnd = [usersOne objectForKey:keyE];
        gpsOn = [usersOne objectForKey:keyO];
        gpsW = [usersOne objectForKey:keyW];
        NSDictionary *dict = @{
                               @"S": gpsStart,
                               @"E": gpsEnd,
                               @"O": gpsOn,
                               @"W": gpsW};
        NSLog(@"%@",dict);
        [(ActivityAlert*)ActAlert do_initWithDict:dict andSender:self];
//        [self Change_State:IF_ACTALERT];
        
        [self Change_State:IF_SPORTREMIND];
        
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}
-(void)Http_Get_Missing_Join_StastusInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_Missing_Join_Stastus_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"Http_Get_Missing_Join_StastusInfo = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {

        [HUD hide:YES];
        int joinStatus = [[usersOne objectForKey:@"JoinStatus"] intValue];
        NSLog(@"joinStatus = %@",@(joinStatus));
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:@"" delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles:nil];

        switch (joinStatus) {
            case 0:
                [alert setMessage:NSLocalizedStringFromTable(@"Not Join", INFOPLIST, nil)];
                [alert show];
                NSLog(@"未報名");
                break;
            case 1:
                [alert setMessage:NSLocalizedStringFromTable(@"Joined", INFOPLIST, nil)];
                [alert show];
                NSLog(@"報名");
                break;
            case 2:
                [alert setMessage:NSLocalizedStringFromTable(@"Quitted", INFOPLIST, nil)];
                [alert show];
                NSLog(@"已退出");
                break;
                
            default:
                break;
        }

    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

- (void)Http_Get_Missing_Join_Link_Join_Action
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_Missing_Join_Stastus_Link_Join_Action_tempData];
    [inStream open];
    NSString *string = [[NSString alloc] initWithData:Get_Missing_Join_Stastus_Link_Join_Action_tempData
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"inStream = %@", string);
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSLog(@"Http_Get_Missing_Join_Link_Join_Action = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if([status isEqualToString:str1])
    {
        [HUD hide:YES];
        int joinStatus = [[usersOne objectForKey:@"JoinStatus"] intValue];
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        alertView.delegate = self;
        CGRect webFrame = CGRectMake(0.0, 0.0, 310.0, 420.0);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
        
        //調整背景顏色
        [webView setBackgroundColor:[UIColor whiteColor]];
        
        //調整畫面比例，啟用之後同時也可以雙擊畫面放大與多點觸碰縮放畫面
        webView.scalesPageToFit = YES;
        
        //設定網址
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",INK_Url_1,@"/MissingProgramInfo.html"]];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webView loadRequest:requestObj];
        
        //將Web View顯示在畫面上
        [alertView setContainerView:webView];

        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel", INFOPLIST, nil) otherButtonTitles:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil), nil];
        
        switch (joinStatus) {
            case 0: //未報名
                //do 報名
//                [alert setMessage:@"Join?"];
                [alertView setButtonTitles:@[NSLocalizedStringFromTable(@"Cancel", INFOPLIST, nil),NSLocalizedStringFromTable(@"Join", INFOPLIST, nil)]];
                alertView.tag = 8016051;
                [alertView show];
                
                break;
            case 1: //報名
                //do 退出
//                [alert setMessage:@"Quit?"];
                [alertView setButtonTitles:@[NSLocalizedStringFromTable(@"Cancel", INFOPLIST, nil),NSLocalizedStringFromTable(@"Quit", INFOPLIST, nil)]];
                alertView.tag = 8016052;
                [alertView show];
                
                break;
            case 2: //退出
                //do 報名
//                [alert setMessage:@"Join?"];
                [alertView setButtonTitles:@[NSLocalizedStringFromTable(@"Cancel", INFOPLIST, nil),NSLocalizedStringFromTable(@"Join", INFOPLIST, nil)]];
                alertView.tag = 8016051;
                [alertView show];
                
                break;
                
            default:
                break;
        }
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

-(void)Http_Set_Missing_Join_StastusInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Set_Missing_Join_Stastus_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [self Get_Missing_Join_StastusWithAcc:userAccount];
        [HUD hide:YES];
        //增加說明
        
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

//http 電子圍籬
- (void)Http_GEOInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_GEO_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    if([status isEqualToString:str1])
    {
        [HUD hide:YES];

        [(GeoFenceShow*)geoFS do_initWithArray:[usersOne objectForKey:@"data"]];
        [self Change_State:IF_GeoFS];
    }
    else
    {
        NSLog(@"*** Http_GEOInfo error = %@", usersOne);
        NSString *str1 = [usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}

//http 電子圍籬
- (void)Http_GEO_NORPInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_GEO_NORP_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //[self call TWI api]
        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [(GeoFenceShow*)geoFS do_initWithArray:[usersOne objectForKey:@"data"]];
//        [self Change_State:IF_GeoFS];
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}
//http 同步區間
-(void)Http_TWIInfo
{
    
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Get_TWI_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //[self call TWI api]
        NSString *keyV = @"value";
        NSString *keyS = @"startTime";
        NSString *keyE = @"endTime";
        NSString *keyO = @"autochangeStatus";
        NSString *keyW = @"weekly";
        NSString *wifiVal = @"";
        NSString *wifiStart = @"";
        NSString *wifiEnd = @"";
        NSString *wifiOn = @"";
        NSString *wifiW = @"";
        NSString *gpsVal = @"";
        NSString *gpsStart = @"";
        NSString *gpsEnd = @"";
        NSString *gpsOn = @"";
        NSString *gpsW = @"";
        wifiVal = [[[usersOne objectForKey:@"pr"] firstObject] objectForKey:keyV];
        wifiStart = [[[usersOne objectForKey:@"pr"] firstObject ]objectForKey:keyS];
        wifiEnd = [[[usersOne objectForKey:@"pr"] firstObject ]objectForKey:keyE];
        wifiOn = [[[usersOne objectForKey:@"pr"] firstObject ]objectForKey:keyO];
        wifiW = [[[usersOne objectForKey:@"pr"] firstObject ]objectForKey:keyW];
        gpsVal = [[[usersOne objectForKey:@"gps"] firstObject ]objectForKey:keyV];
        gpsStart = [[[usersOne objectForKey:@"gps"] firstObject ]objectForKey:keyS];
        gpsEnd = [[[usersOne objectForKey:@"gps"] firstObject ]objectForKey:keyE];
        gpsOn = [[[usersOne objectForKey:@"gps"] firstObject ]objectForKey:keyO];
        gpsW = [[[usersOne objectForKey:@"gps"] firstObject ]objectForKey:keyW];
        NSDictionary *dict = @{@"wifiV": wifiVal,
                               @"wifiS": wifiStart,
                               @"wifiE": wifiEnd,
                               @"wifiO": wifiOn,
                               @"wifiW": wifiW,
                               @"gpsV": gpsVal,
                               @"gpsS": gpsStart,
                               @"gpsE": gpsEnd,
                               @"gpsO": gpsOn,
                               @"gpsW": gpsW};
        NSLog(@"%@",dict);
        [(trackingWithInterval*)tWI do_initWithDict:dict andSender:self];
        [self Change_State:IF_TWI];
//        if (nextState == 92) {
//            [(CallLimit *)CallLimit setGpstimearr:[usersOne objectForKey:@"SysParameter"]];
//            [self Send_GetSync:userAccount andHash:userHash];
//        }
//        else if (nextState == 98){
//            [(trackingWithInterval *)tWI setGpstimearr:[usersOne objectForKey:@"SysParameter"]];
//            [self Send_GetSync:userAccount andHash:userHash];
//        }
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
}
//展示照片
-(void)Http_ShowImageInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ShowImage_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        NSLog(@"Data = %@",usersOne);
        [(ShowImage *)ShowImageView Set_Init:usersOne];
        [(ShowImage *)ShowImageView setDelegate:self];
        //展示照片
        [self Change_State:IF_SHOWIMAGE];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
    
}


//解析硬體設定
-(void)Http_DevSetInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Dev_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(DeviceSet *)DeviceSet Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        //硬體設定
        [(DeviceSet *)DeviceSet Set_Init:usersOne];
        
//        -(void) Send_GetSync:(NSString *)acc andHash: (NSString *)hash
        [self Send_GetSync:userAccount andHash:userHash];
        //RogerWang
//        [HUD hide:YES];
//        [self Change_State:IF_DEVSET];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}



//解析跌倒設定
-(void)Http_FallSetInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Fall_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(FallSet *)FallSet Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        //跌倒設定
        [(FallSet *)FallSet Set_Init:usersOne];
        [self Change_State:IF_FALLSET];
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//解析跌倒設定
-(void)Http_UpdateFall
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateFall_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_Fall", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [self Send_UserFallSet:userAccount andHash:userHash];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}




//解析離家提醒設定
-(void)Http_LeaveRemindInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:LeaveRemind_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    [(LeaveRemind *)LeaveRemind Do_Init:self];
    
    if( [status isEqualToString:str1]  )
    {
        [self Change_State:IF_LEAVEREMIND];
        if ([[usersOne objectForKey:@"data"] count]>0) {
            //離家提醒
            
            [(LeaveRemind *)LeaveRemind Set_Init:[[usersOne objectForKey:@"data"] objectAtIndex:0]];
        }else
        {
            [(LeaveRemind *)LeaveRemind Set_Init:nil];
        }
        
        
        [HUD hide:YES];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}





//修改解析通話限制
-(void)Http_UpdateCall
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateCall_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [self AlertTitleShow:NSLocalizedStringFromTable(@"Reminder", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [HUD hide:YES];
//        [(CallLimit *)CallLimit sendNext];
        [self Send_DevReload];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//修改解析硬體設定
-(void)Http_UpdateDevice
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateDev_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
//        [(DeviceSet *)DeviceSet sendNext];
//        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_Setting", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [(DeviceSet *)DeviceSet SaveCall];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//修改圍籬設定
-(void)Http_UpdateLeave
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpdateLeave_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [self AlertTitleShow:NSLocalizedStringFromTable(@"HS_Leave", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [self Send_UserLeaveSet:userAccount andHash:userHash];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}



//最新消息列表
-(void)Http_NewsInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:News_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"json dic = %@",usersOne);
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        [(NewsView *)NewsView Do_Init:self];
        [(NewsView *)NewsView Set_Init:[usersOne objectForKey:@"Data"]];
        [self Change_State:IF_NEWSINFO];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}



//活動區域離家提醒
-(void)Http_ActLeaveInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ActLeave_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        [HUD hide:YES];
        
//        NSLog(@"long %@",[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"longitude"]);
        
        if ([[usersOne objectForKey:@"data"] count]>0)
        {
            
            [(MyActView *)MyActView Set_LeavePointLng:[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"longitude"] Lat:[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"latitude"] ImgNum:0];
            
            
            [(MyActView *)MyActView Set_LeaveCircle:[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"longitude"]:[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"latitude"]:[[[usersOne objectForKey:@"data"] objectAtIndex:0] objectForKey:@"radius"]];
        }
        
        
        
        

        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}



//我的帳號資訊
-(void)Http_MyAccInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:MyAcc_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        [(MyAccountView *)MyAccountView Do_Init:self];
        
        
        
        NSArray *datarr = [[NSArray alloc] initWithObjects:[usersOne objectForKey:@"name"],[usersOne objectForKey:@"email"],[usersOne objectForKey:@"phone"], nil];
        
        [(MyAccountView *)MyAccountView Set_Init:datarr];
        [self Change_State:IF_MYACCOUNT];
        [HUD hide:YES];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}


//密碼修改資訊
-(void)Http_ChangePw
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ChangePw_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        //成功後要修改plist 的密碼與userHash密碼
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:newPw forKey:@"userHash"];
        userHash = newPw;
        NSLog(@"userHash = %@",userHash);
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"Personal_PWChange_Sucess", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE") otherButtonTitles: nil];
        [alertView show];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//修改我的帳號資訊
-(void)Http_ChangeUserInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ChangeUserInfo_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        //成功後要修改plist 的密碼與userHash密碼
//        NSUserDefaults *defaults;
//        defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:newPw forKey:@"userHash"];
//        userHash = newPw;
        [HUD hide:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"Personal_MyAccount_Sucess", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CLOSE") otherButtonTitles: nil];
        [alertView show];
        [self Send_MyUserAccount:userAccount andHash:userHash];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

//重新讀取所有佩帶者資訊並更新
-(void)Http_Update
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Update_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
//    NSArray *json = [NSJSONSerialization JSONObjectWithData:Update_tempData options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
//    NSLog(@"%@",json);
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [self loadUserDic:[usersOne objectForKey:@"list"]];
        [HUD hide:YES];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        NSLog(@"error happen");
    }
}

//刪除親情照片
-(void)Http_DeleteFamilyImageInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:DeleteFamilyImage_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
//        [self loadUserDic:[usersOne objectForKey:@"list"]];
        [self Check_Http];//重新取值
        [HUD hide:YES];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        NSLog(@"error happen");
    }
}

//刪除展示照片
-(void)Http_DeleteShowImageInfo
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:DeleteShowImage_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    //    NSLog(@"%@",json);
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        [self Check_Http];//重新取值
        [HUD hide:YES];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
        NSLog(@"error happen");
    }
}
- (void)Http_SaveTWIInfo{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Save_TWI_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
//        NSLog(@"%@",usersOne);
        [HUD hide:YES];
//        add alert
        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
    
}
- (void)Http_SaveAAInfo{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Save_AA_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        //        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //        add alert
        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        
        [self Send_UserSportRemind:userAccount andHash:userHash];
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
    
}
- (void)Http_SaveGEOInfo{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Save_GEO_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        //        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //        add alert
//        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        //重新取一次data
        
        [self Get_GEO_NORP_Setting:userAccount andHash:userHash];
        [(vcGeoFenceEdit*)vcGFE closeLoading];
        [(vcGeoFenceEdit*)vcGFE dismissViewControllerAnimated:YES completion:nil];
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

- (void)Http_DeleteGEOInfo{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Delete_GEO_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        //        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //        add alert
        //        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        //重新取一次data
//        aaa
        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"Delete Ok", INFOPLIST, nil)];
        [self Get_GEO_Setting:userAccount andHash:userHash];
//        [(vcGeoFenceEdit*)vcGFE closeLoading];
//        [(vcGeoFenceEdit*)vcGFE dismissViewControllerAnimated:YES completion:nil];
        
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        [HUD hide:YES];
    }
}

- (void)Http_SaveGEO_EnableInfo{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Save_GEO_Enable_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        //        NSLog(@"%@",usersOne);
        [HUD hide:YES];
        //        add alert
        //        [self AlertTitleShow:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        //重新取一次data
//        [self Get_GEO_NORP_Setting:userAccount andHash:userHash];
    } else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
    }
    
}
- (NSString*)returnStringByKeyWithDIct:(NSDictionary*)m_dict andKey:(NSString*)m_key{
    NSString *m_str = @"";
    if ([m_dict objectForKey:m_key]) {
        m_str = [NSString stringWithFormat:@"%@",[m_dict objectForKey:m_key]];
    }
    NSLog(@"key:%@,str:%@",m_key,m_str);
    return m_str;
}

- (void)Http_GcareGetSOSTracking
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:GCareGetSOSTracking_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0];

    NSLog(@"Http_GcareGetSOSTracking = %@", usersOne);
    NSString *status = [usersOne objectForKey:@"status"];

    if ([status isEqualToString:@"0"]) {
        [(MyMapView *)MyMapView Do_Init:self];
        NSString *longitude = [self returnStringByKeyWithDIct:usersOne andKey:@"location_lng"];
        NSString *latitude = [self returnStringByKeyWithDIct:usersOne andKey:@"location_lat"];
        NSString *radius = [self returnStringByKeyWithDIct:usersOne andKey:@"radius"];
        NSString *location = [self returnStringByKeyWithDIct:usersOne andKey:@"address"];
        NSString *event = [self returnStringByKeyWithDIct:usersOne andKey:@"event"];
        NSString *name = [self returnStringByKeyWithDIct:usersOne andKey:@"name"];
        NSString *server_time = [self returnStringByKeyWithDIct:usersOne andKey:@"server_time"];
        NSString *watch_time = [self returnStringByKeyWithDIct:usersOne andKey:@"watch_time"];
        NSString *location_type = [self returnStringByKeyWithDIct:usersOne andKey:@"location_type"];
        //get data_type
        NSString *data_type = [NSString stringWithFormat:@"%@",[usersOne objectForKey:@"data_type"]];
        if ([data_type isEqualToString:@"28"]) {//type = 28 簡訊定位
            [(MyMapView *)MyMapView setGpsLocation:YES];
        }
        else{
            [(MyMapView *)MyMapView setGpsLocation:NO];
        }

        int isGPSGSMWIFI = [location_type intValue];
        NSLog(@"isGPSGSMWIFI %d",isGPSGSMWIFI);
        [(MyMapView *)MyMapView setGPS_GSM_WIFI:isGPSGSMWIFI];

        [self Change_State:IF_MAP];

        // nsstring 為空
        if ( (!longitude.length && !latitude.length) ) {
            NSLog(@"*** 经纬度为空");
        }
        else{
//            [(MyMapView *)MyMapView Set_Text:location:event:name:server_time:watch_time];
            //
            [(MyMapView *)MyMapView Set_Point_ForAdd:longitude :latitude];
            //
            if (![radius isEqualToString:@"0"]) {
                [(MyMapView *)MyMapView Set_Circle :longitude:latitude:radius];
            }
        }

        [HUD hide:YES];
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        NSString *msg = [self returnStringByKeyWithDIct:usersOne andKey:@"msg"];
        NSString *msgErr = [msg substringFromIndex:MAX((int)[msg length]-2, 0)]; //in case string is less than 2 characters long.
        if ([msgErr isEqualToString:@"28"]) {
            [HUD hide:YES];
            [(MyMapView *)MyMapView Do_Init:self];
//            [(MyMapView *)MyMapView  stopTimer];
            [self Change_State:IF_MAP ];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"NODATA", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_OK") otherButtonTitles: nil];
            [alertView show];
            
        }
        else if ([msgErr isEqualToString:@"99"]){
            [self Check_Error:str1];
        }
        else{
            [self Check_Error:str1];
        }
    }
}

//儲存所有佩戴者帳號
-(void)loadUserDic:(NSArray *)arr
{
    NSLog(@"%@",arr);
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    //清空所有佩戴者資料
    for (int i=0; i<[[defaults objectForKey:@"totalcount"] integerValue]; i++) {
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Acc%i",i+1]];
        [defaults removeObjectForKey:[NSString stringWithFormat:@"Phone%i",i+1]];
        
    }
    [defaults synchronize];
    
    int MAP_TYPE = [defaults integerForKey:@"MAP_TYPE"];
    int nowuser = [defaults integerForKey:@"nowuser"];
    NSString *useraccount = [defaults stringForKey:@"userAccount"];
    NSString *userhash = [defaults stringForKey:@"userHash"];
    
    if (nowuser > [arr count]) {
        nowuser = [arr count];
    }
    
    int tmpTotal = 0; // to count total 700 20140317
    for (int i=0; i<[arr count]; i++) {
        NSString *type = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]];
        //擋住使用者
        if ([type isEqualToString:UserDeviceType1]||
            [type isEqualToString:UserDeviceType2]) {
//            break;
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",tmpTotal+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",tmpTotal+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",tmpTotal+1]];
            tmpTotal++;
        }
    }
    
//    [defaults setInteger:[arr count] forKey:@"totalcount"];
    [defaults setInteger:tmpTotal forKey:@"totalcount"]; // set totalcount using tmpTotal 20140317
    
    [defaults setInteger:MAP_TYPE forKey:@"MAP_TYPE"];
    [defaults setInteger:nowuser forKey:@"nowuser"];
    [defaults setObject:useraccount forKey:@"userAccount"];
    [defaults setObject:userhash forKey:@"userHash"];
    [defaults synchronize];
    
    [self UpdateNameLbl];
    
    NSLog(@"default = %@",[defaults objectForKey:@"Name1"]);
}

//更新下方顯示名字
-(void)UpdateNameLbl
{
    [UserData removeAllObjects];
    [PhoneData removeAllObjects];
    [AccData removeAllObjects];
    [HashData removeAllObjects];
    
    int Value1 =1;
    NSUserDefaults* defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    Value1 = [defaults integerForKey:@"totalcount"];

    
    if (Value1 == NowUserNum)
    {
        NowUserNum --;
    }
    
    userAccount = [defaults stringForKey:@"userAccount"];
    userHash = [defaults stringForKey:@"userHash"];
    
    NSLog(@"Value1 %i",Value1);
    
    for(int i=0;i<Value1;i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"Name%d", i+1];
        NSString *savedValue = [defaults   stringForKey:str1];
        [UserData addObject:savedValue];
        
        if(i==NowUserNum)
        {
            [ShowName setText:savedValue];
        }
        
        
        NSString *str2 = [NSString stringWithFormat:@"Phone%d", i+1];
        NSString *savedValue2 = [defaults   stringForKey:str2];
        [PhoneData addObject:savedValue2];
        
        
        NSString *str3 = [NSString stringWithFormat:@"Acc%d", i+1];
        NSString *savedValue3 = [defaults   stringForKey:str3];
        [AccData addObject:savedValue3];
    }
    
}


//UserDateView Delegate
-(void)PersonImgClick
{
    NSLog(@"btnclick");
    if ([self.delegate respondsToSelector:@selector(OpenCamera)])
    {
        [self.delegate OpenCamera];
    }
}


-(void)familyImgClick:(int)type
{
    NSLog(@"familyImgClick");
    if ([self.delegate respondsToSelector:@selector(OpenPersonCamera:)])
    {
        [self.delegate OpenPersonCamera:type];
    }
}

//ShowImage Delegate
-(void)ShowImgClick:(int)type
{
    NSLog(@"ShowImgClick");
    if ([self.delegate respondsToSelector:@selector(OpenShowImageCamera:)])
    {
        [self.delegate OpenShowImageCamera:type];
    }
}

//更新使用者資訊
-(void)SavePersonInfo:(NSDictionary *)dic
{
    [self Update_UserDate:userAccount andHash:userHash InfoDic:dic];
}

//更新緊急聯絡人資訊與親情電話
-(void)SaveSoSInfo:(NSDictionary *)dic
{
    NSLog(@"Update SoSInfo");
    [self Update_SOS:userAccount andHash:userHash InfoDic:dic];
}

-(IBAction)changeMapType:(id)sender
{
    if (IF_State == IF_MAP) {
        if ([(UIView*)sender tag] == 101) {
            [(MyMapView *)MyMapView MapMoushDown:2];
            [(UIView*)sender setTag:102];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_ST", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_satelite.png"] forState:UIControlStateNormal];
        }else
        {
            [(MyMapView *)MyMapView MapMoushDown:1];
            [(UIView*)sender setTag:101];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_Map", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
        }
    }
    
    if (IF_State == IF_ACT) {
        if ([(UIView*)sender tag] == 101) {
            //改為衛星地圖
            [(MyActView *)MyActView MapMoushDown:2];
            [(UIView*)sender setTag:102];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_ST", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_satelite.png"] forState:UIControlStateNormal];
        }else
        {
            [(MyActView *)MyActView MapMoushDown:1];
            [(UIView*)sender setTag:101];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_Map", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
        }
    }
    
    if (IF_State == IF_HISMAP) {
        if ([(UIView*)sender tag] == 101) {
            //改為衛星地圖
            [(MyHisMapView *)MyHisMapView MapMoushDown:2];
            [(UIView*)sender setTag:102];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"His_ST", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_satelite.png"] forState:UIControlStateNormal];
        }else
        {
            [(MyHisMapView *)MyHisMapView MapMoushDown:1];
            [(UIView*)sender setTag:101];
//            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"His_Map", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
        }
    }
    
    if (IF_State == IF_GeoFS) {
        if ([(UIView*)sender tag] == 101) {
            [(GeoFenceShow *)geoFS MapMoushDown:2];
            [(UIView*)sender setTag:102];
            //            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_ST", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_satelite.png"] forState:UIControlStateNormal];
        }else
        {
            [(GeoFenceShow *)geoFS MapMoushDown:1];
            [(UIView*)sender setTag:101];
            //            [(UIButton *)sender setTitle:NSLocalizedStringFromTable(@"Act_Map", INFOPLIST, nil) forState:UIControlStateNormal];
            [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_map.png"] forState:UIControlStateNormal];
        }
    }
    
}


//電量轉換
/*
 電壓<3697時，百分比顯示固定為0%
 
 電壓3698~3876時，百分比顯示為(電壓-3698)/3
 
 電壓在3877~4200時，百分比顯示為((電壓-3876)/8)+59
 
 電壓>4200時，百分比顯示固定為100%
 */
-(NSString *)changeElectricityValue:(NSString *)electricity
{
    
    int electricValue = [electricity integerValue];
    NSString *eleStr;
    if (electricValue > 4200) {
        return eleStr = @"100%";
    }else if (3877 < electricValue < 4200)
    {
        return eleStr = [NSString stringWithFormat:@"%d%%",((electricValue-3876)/8)+59];
    }else if (3698< electricValue <3876)
    {
        return eleStr = [NSString stringWithFormat:@"%d%%",(electricValue-3698)/3];
    }else
    {
        return eleStr = @"0%";
    }
    
    return NULL;
}


//改變敏感度
-(void)changeFallLevel
{
//    NSArray *levelArr = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"HS_Fall_level0", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level1", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level2", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level3", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level4", INFOPLIST, nil), nil];
    NSArray *levelArr = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"HS_Fall_level0", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level1", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level2", INFOPLIST, nil),NSLocalizedStringFromTable(@"HS_Fall_level3", INFOPLIST, nil), nil];
    
    self.alert = [MLTableAlert tableAlertWithTitle:NSLocalizedStringFromTable(@"HS_Fall_SelecSence", INFOPLIST, nil) cancelButtonTitle:kLoadString(@"Cancel") numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      return [levelArr count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      //                      cell.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d", indexPath.section, indexPath.row];
                      
                      cell.textLabel.text = [levelArr objectAtIndex:indexPath.row];
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 350;
    
    // configure actions to perform
    
    
    
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        //		self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
        
        NSLog(@"set Btn title %i",selectedIndex.row);
        
        [(FallSet *)FallSet ChangeLevelBtnTitle:selectedIndex.row];
        
    } andCompletionBlock:^{
        //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
        
    }];
    
    [self.alert show];
}






-(NSDictionary *)getArea:(NSString *)area AndLanguage:(NSString *)lang
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"timezone" ofType:@"plist"];
    
    NSMutableDictionary *timeZone = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    timeZoneArr = [timeZone objectForKey:@"Zone"];
    NSString *langStr;
    switch ([lang intValue]) {
        case 0:
            langStr = @"其他";
            break;
        case 1:
            langStr = @"繁中";
            break;
            
        case 2:
            langStr = @"簡中";
            break;
            
        case 3:
            langStr = @"英文";
            break;
            
        case 4:
            langStr = @"西班牙文";
            break;
            
        case 5:
            langStr = @"日文";
            break;
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[timeZoneArr objectAtIndex:[area intValue]] objectForKey:@"name"],@"time",langStr,@"lang", nil];
    
    return dic;
}


//佩戴者管理  點擊後  更新
-(void)ChangeMemberList:(int)number
{
    NowUserNum = number;
    [self UpdateNameLbl];
    [self Check_Down_Bu];
//    [(GroupMemberView *)GroupMemberView reloadData:number];
}

//執行動畫
-(void)NewsAnimate:(NSString *)newsStr
{
    // Second continuous label example
    MarqueeLabel *continuousLabel2 = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, animateView.frame.size.width-30, 30) rate:100.0f andFadeLength:10.0f];
    continuousLabel2.tag = 101;
    continuousLabel2.marqueeType = MLContinuous;
    continuousLabel2.animationCurve = UIViewAnimationOptionCurveLinear;
    continuousLabel2.continuousMarqueeExtraBuffer = 50.0f;
    continuousLabel2.numberOfLines = 1;
    continuousLabel2.opaque = NO;
    continuousLabel2.enabled = YES;
    continuousLabel2.shadowOffset = CGSizeMake(0.0, -1.0);
    continuousLabel2.textAlignment = NSTextAlignmentLeft;
    continuousLabel2.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
    continuousLabel2.backgroundColor = [UIColor clearColor];
    continuousLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.000];
    continuousLabel2.text = newsStr;
    
    [animateView addSubview:continuousLabel2];
}


//提醒儲存後回傳成功訊息
-(void)AlertTitleShow:(NSString *)alertTitle andMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:message delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_OK") otherButtonTitles: nil];
    [alertView show];
}


//點及安全列表
-(void)Show_SafeMap:(NSDictionary *)dic
{
    NSLog(@"safe dic = %@",dic);
    [(SosMapView *)SosMapView Do_Init:self];
    [(SosMapView *)SosMapView Set_Init:dic];
    [self addSubview:SosMapView];
}

- (NSString*) chkNull:(NSString*) string{
    if (string == (id)[NSNull null] || string.length == 0 ){
        string = @" ";
    }
    return string;
//    if ([string isKindOfClass:[NSString class]]) {
//        if (string == (id)[NSNull null] || string.length == 0 ){
//            string = @"";
//        }
//    }
}

//
//新增使用者(傳輸)
- (void)UpdateToken:(NSString *)acc andHash: (NSString *)hash andToken:(NSString *)token
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:DEFAULTDATE];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, hash,dateString];

    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, (unsigned int)dataIn.length,  digest);

    NSLog(@"dataIn: %@", dataIn);

    NSData *out2 = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];

    NSLog(@"Hash : %@", hash);

    NSString *httpBodyString;
    httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&device=0&token=%@&appid=%i",acc, hash,dateString,token,APPID];

    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];

    NSString *updateTokenApi = [NSString stringWithFormat:@"%@/AppUpdateToken.html",INK_Url_1];
    NSLog(@"AppUpdateToken Api ＝ %@?%@",updateTokenApi,httpBodyString);
    [request setURL:[NSURL URLWithString:updateTokenApi]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    UpDate_Token_tempData = [NSMutableData alloc];
    UpDate_Token_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - 更新devicetoken
- (void)Http_UpDate_Token
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:UpDate_Token_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];

    NSDictionary *usersOne = [jsonArr objectAtIndex:0] ;

    NSLog(@"Http_UpDate_Token = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];

    NSArray *arr = [usersOne objectForKey:@"list"];
    NSLog(@"arr = %@",arr);

    if( [status isEqualToString:str1]  ) {
        NSLog(@"Update token success!");
    } else {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [self Check_Error:str1];
        NSLog(@"error happen");
        [HUD hide:YES];
    }
}

- (void)LetHUDHide{
    [HUD hide:YES];
}
- (void)AddLoadingView{
    [self addloadingView];
}
- (void)setHiddenBack:(BOOL)hidden{
    if (Bu_Index) {
        [Bu_Index setHidden:hidden];
    }
    else{
        NSLog(@"Bu_Index Nothing!!!");
    }
}


//跳出提醒alert 的 確定與取消mousedown觸發
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 101) {
        
        if (buttonIndex == 1) {
            
            NSLog(@"alertView touch %@ %@",SearchstartBtn.titleLabel.text,SearchendBtn.titleLabel.text);
            
            searchStart = [NSString stringWithFormat:@"%@ 00:00",SearchstartBtn.titleLabel.text];
            searchEnd = [NSString stringWithFormat:@"%@ 23:59",SearchendBtn.titleLabel.text];
            
            NSLog(@"search Start = %@",searchStart);
            
            
            
            //            [self MyTest:userAccount AndHash:userHash StartTime:SearchstartBtn.titleLabel.text andEndTime:SearchendBtn.titleLabel.text];
            [self Send_UserRemind:userAccount andHash:userHash];
        }
        
        
    }else
    {
        
        if(GoToSetting_Sw)
        {
            GoToSetting_Sw = false;
            [self Other_MouseDown:1004];
            
        }
        else
        {
            if(NeedQuit_Sw)
            {
                //            exit(0);
                [HUD hide:YES];
            }
        }
    }
}

//
- (void)GcareGetSOSTrackingWithAcc:(NSString *)acc
{
    //    Missing_Join_Stastus
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = TimeOutLimit;

    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    //    [dateFormat setDateFormat:DEFAULTDATE];
    //    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDictionary *apiData = @{@"account" : acc};

    NSString *httpBodyString = [HttpHelper returnHttpBody:apiData];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getUserApi = [NSString stringWithFormat:@"%@/APP/GcareGetSOSTracking.html",INK_Url_1];

    NSLog(@"get GcareGetSOSTracking = %@?%@",getUserApi,httpBodyString);

    [request setURL:[NSURL URLWithString:getUserApi]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];

    GCareGetSOSTracking_tempData = [[NSMutableData alloc] init];
    GCareGetSOSTracking_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [self addloadingView];
}

- (int)returnIF_State
{
    return IF_State;
}

- (void)getWiFi
{
    [self Get_WiFi:userAccount andHash:userHash];
}

@end
