//
//  MySelView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MySelView : UIView
{
    IBOutlet UILabel *Bu1_lbl;
    IBOutlet UILabel *Bu2_lbl;
    IBOutlet UILabel *Bu3_lbl;
    IBOutlet UILabel *Bu4_lbl;
    IBOutlet UILabel *Bu5_lbl;
    IBOutlet UILabel *Bu6_lbl;
    
    
     IBOutlet UIButton *Bu1;
     IBOutlet UIButton *Bu2;
     IBOutlet UIButton *Bu3;
     IBOutlet UIButton *Bu4;
     IBOutlet UIButton *Bu5;
     IBOutlet UIButton *Bu6;
    
    IBOutlet UIView *bg1;
    IBOutlet UIView *bg2;
    IBOutlet UIView *bg3;
    IBOutlet UIView *bg4;
    IBOutlet UIView *bg5;
    IBOutlet UIView *bg6;


    
     //parent View
     id  MainObj;
}

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender;

//量測按鈕MouseDown觸發
- (IBAction)Main_MouseDown:(id)sender;
@end
