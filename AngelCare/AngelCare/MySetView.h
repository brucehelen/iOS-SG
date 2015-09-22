//
//  MySetView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySetView : UIView<UIScrollViewDelegate>
{
    IBOutlet UIImageView  *MyGo;
    IBOutlet UIScrollView *myScrollView;
    
    
     IBOutlet UIScrollView *myListScrollView;
    
    IBOutlet  UIButton *AddButton;
    
    IBOutlet  UIButton *Bu1;
    IBOutlet  UIButton *Bu2;
    IBOutlet  UIButton *Bu3;
    IBOutlet  UIButton *Bu4;
    
    
    IBOutlet UILabel  *Title1;
    IBOutlet UILabel  *Title2;
    
    
    IBOutlet UILabel  *Text1;
    IBOutlet UILabel  *Text2;
    IBOutlet UILabel  *Text3;
    
    IBOutlet  UIButton *Bu_Google;
    IBOutlet  UIButton *Bu_Ba;
    
    
    UIAlertView *MyalertView;
    
    //parent View
    id      MainObj;
    
    int TotalHei;
    
    int TotalUser;
    
    //預計刪除的使用者
    int DelNum;
    
    NSMutableArray  *Array_UserDate;
}

//  設定此Ｖiew 
-(void)Do_Init:(id)sender;

//設定佩帶者Input Alert 提示
-(IBAction)Set_MouseDown:(id)sender;

//新增資料
-(void)Insert_Data:(NSString*)TimeDate;

//新增佩帶者提示
-(void)Show_Alert;

//設定提示目前在哪位使用者的勾選提示在哪個位置
-(void)Set_Go:(int)SetNum;

//版本檢查  MouseDown𧣈發
- (IBAction)B1_MouseDown:(id)sender;

//隱私權政策 MouseDown𧣈發
- (IBAction)B2_MouseDown:(id)sender;

//服務條款 MouseDown𧣈發
- (IBAction)B3_MouseDown:(id)sender;

//版本   MouseDown𧣈發
- (IBAction)B4_MouseDown:(id)sender;

//使用者 mousedown觸發
-(void)displayvalue:(id)sender;

-(IBAction)Set_Google:(id)sender;
-(IBAction)Set_Baduio:(id)sender;


@end
