//
//  UserDateView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/10/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "PersonInfoCell.h"
#import "Format1Cell.h"
#import "Format2Cell.h"
#import "EditFormat1Cell.h"
#import "EditPersonView.h"
#import "EditPersonInfoCell.h"
#import "RegexKitLite.h"
@protocol UserDateDelegate <NSObject>

@required
-(void)PersonImgClick;
-(void)SavePersonInfo:(NSDictionary *)dic;
-(void)SaveSoSInfo:(NSDictionary *)dic;
-(void)familyImgClick:(int)type;
@end


@interface UserDateView : UIView<UITextFieldDelegate>
{
    NSDictionary *personDic;    //個人資訊
    NSDictionary *phoneDic;     //緊急電話與親情電話
    NSDictionary *medDic;       //吃藥提醒
    NSDictionary *hosDic;       //回診提醒
    
    IBOutlet UITableView *listTable;
    
    //配戴者圖片
     IBOutlet  UIImageView *UserImage;
    
    UIImage *tempImg;
    
    UITextField *nowTxt;
    
    //parent View
     id  MainObj;
    
    NSString *nameStr;          //暫存姓名
    NSString *addrStr;          //暫存地址
    NSString *phoneStr;         //暫存電話
    
    NSString *sosName1;
    NSString *sosName2;
    NSString *sosName3;
    NSString *sosPhone1;
    NSString *sosPhone2;
    NSString *sosPhone3;
    
    NSString *familyName1;      
    NSString *familyName2;
    NSString *familyName3;
    NSString *familyPhone1;
    NSString *familyPhone2;
    NSString *familyPhone3;
    
    int sexType;
    
    int nowEdit;
    
}


@property (strong) NSObject <UserDateDelegate> *delegate;
@property (nonatomic,strong) UIImageView *UserImage;

//設定佩戴者資訊
-(void)setAccountData:(NSDictionary *)dic;

//設定緊急聯絡電話與親情聯絡電話
-(void)setSoSandFamilyPhone:(NSDictionary *)dic;

//設定吃藥提醒
-(void)setMedRemind:(NSDictionary *)dic;

//設定回診提醒
-(void)setHosRemind:(NSDictionary *)dic;

//  設定此Ｖiew 
-(void)Set_Init:(id)sender;


@end
