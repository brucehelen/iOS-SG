//
//  MyEatShowView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EatRemindCell.h"
#import "DateRemindCell.h"

@interface MyEatShowView : UIView
{
    NSArray *medRemindArr; //吃藥提醒
    NSArray *hosRemindArr; //回診提醒
    
    NSMutableArray *weekArr;
    
    //parent View
    id  MainObj;
    NSArray *dataArr;
    int medcount;   //吃藥已設定幾組
    int hoscount;   //回診已設定幾組
}

@property (nonatomic,strong) IBOutlet UITableView *listView;

//update
-(void)UpdateData;

//吃藥提醒
-(void)setMedRemind:(NSArray *)arr;

//回診提醒
-(void)setHosRemind:(NSArray *)arr;

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender;


@end
