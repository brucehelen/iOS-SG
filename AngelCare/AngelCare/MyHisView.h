//
//  MyHisView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/10/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHisCell.h"
#import "MyHisCell2.h"

@interface MyHisView : UIView
{

    //parent View
    id    MainObj;
    
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;
    IBOutlet UIButton *btn3;
    IBOutlet UIButton *btn4;
    IBOutlet UIButton *btn5;
    IBOutlet UIButton *btn6;
    IBOutlet UIButton *btn7;
    
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    IBOutlet UILabel *lbl4;
    
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *img3;
    IBOutlet UIImageView *img4;
    IBOutlet UIImageView *img5;
    IBOutlet UIImageView *img6;
    IBOutlet UIImageView *img7;
    
    int nowSelect;
    
    NSArray *listArr;
    IBOutlet UIScrollView *scrTitle;
    
    
}

@property (nonatomic) int nowSelect;
@property (nonatomic,strong) IBOutlet UITableView *list;


//三個類別按鈕mousedown觸發
- (IBAction)His_MouseDown:(id)sender;

//  設定此Ｖiew 
-(void)Set_Init:(NSArray *)arr;

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender;
//
@property (nonatomic,strong) NSDictionary *dict;
@end
