//
//  MyEatPickView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEatPickView : UIView
{    
    IBOutlet UIDatePicker *MyPick;
    
    IBOutlet UIButton *MonBtn;
    IBOutlet UIButton *TueBtn;
    IBOutlet UIButton *WedBtn;
    IBOutlet UIButton *TheBtn;
    IBOutlet UIButton *FriBtn;
    IBOutlet UIButton *SatBtn;
    IBOutlet UIButton *SunBtn;
    
    BOOL isMon;
    BOOL isTue;
    BOOL isWed;
    BOOL isThe;
    BOOL isFri;
    BOOL isSat;
    BOOL isSun;
    
    NSString *s_team;   //第幾組
    
    //parent View
    id  MainObj;
    
    int SaveNum;
    
    BOOL IsOn;
    
    NSString *SaveMessage;
    
    UIColor *backgroundColor;
    UIColor *titleColor;
    UIColor *selbackgroundColor;
    UIColor *seltitleColor;
}

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender andType:(int)type;

//吃藥提醒初始化
-(void)SetMed_initWithDic:(NSDictionary *)dic;

//回診提醒初始化
-(void)SetHos_initWithDic:(NSDictionary *)dic;


-(IBAction)selectWeek:(id)sender;


-(void)SetDate:(NSString *)DateStr;

//儲存吃藥提醒
-(void)SaveMed;

//儲存回診提醒
-(void)SaveHos;

@end
