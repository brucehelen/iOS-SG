//
//  MyDatePickerView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDatePickerView : UIView
{
    IBOutlet UIButton *MyOk;
    IBOutlet UIButton *MyCancel;
    
    IBOutlet UIDatePicker *MyPick;
        
    IBOutlet UILabel     *MyLabel;
    
    //parent View
    id  MainObj;
    int SaveNum;
    
    BOOL IsOn;
    
      NSString *SaveMessage;
}


-(void)SetDate:(NSString *)DateStr;

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender;

//確定與取消mousedown觸發
- (IBAction)Main_MouseDown:(id)sender;

//設定提示欄內容
-(void)Set_Label:(int)SetNum : (NSString *)DateStr : (BOOL)On;


@end
