//
//  MyDateShowView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyDateShowView : UIView
{
    IBOutlet UIButton *Bu_1;
    IBOutlet UIButton *Bu_2;
    IBOutlet UIButton *Bu_3;
    IBOutlet UIButton *Bu_4;
    IBOutlet UIButton *Bu_5;
    IBOutlet UIButton *Bu_6;
    IBOutlet UIButton *Bu_7;
    IBOutlet UIButton *Bu_8;

    /*
     bu_9和bu_10添加与15.7.24  Keven

    IBOutlet UIButton *Bu_10;
    */
    IBOutlet UIButton *Bu_9;

    IBOutlet UIView *bgView1;
    IBOutlet UIView *bgView2;
    IBOutlet UIView *bgView3;
    IBOutlet UIView *bgView4;
    IBOutlet UIView *bgView5;
    IBOutlet UIView *bgView6;
    IBOutlet UIView *bgView7;
    IBOutlet UIView *bgView8;
    IBOutlet UIView *bgView9;
    IBOutlet UIView *bgView10;

    IBOutlet UILabel *title1;
    IBOutlet UILabel *title2;
    IBOutlet UILabel *title3;
    IBOutlet UILabel *title4;
    IBOutlet UILabel *title5;
    IBOutlet UILabel *title6;
    IBOutlet UILabel *title7;
    IBOutlet UILabel *title8;
    IBOutlet UILabel *title9;
    IBOutlet UILabel *title10;
    
    NSString *SaveStr1;
    NSString *SaveStr2;

    //parent View
    id  MainObj;
}


//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender;


//功能按鈕
-(IBAction)funcionBtn:(id)sender;

@end
