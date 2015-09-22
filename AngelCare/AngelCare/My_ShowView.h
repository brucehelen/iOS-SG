//
//  My_ShowView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"
#import "Measure1Cell.h"
#import "Measure2Cell.h"
#import "Measure3Cell.h"
#import "Measure4Cell.h"
#import "Measure5Cell.h"
#import "MeasureNoCell.h"
#import "GraphView.h"

@interface My_ShowView : UIView<UIScrollViewDelegate>
{
    
    //parent View
    id  MainObj;
    
    //血壓，血糖，血氧類別
    int type;

    
    //是否為圖表
    BOOL isChart;
    
    NSArray *dataArr;
    NSDictionary *remindDic;
    
    IBOutlet UITextView *remindView;
    IBOutlet UIButton *changeViewBtn;
    
    IBOutlet UIButton *dayBtn;
    IBOutlet UIButton *weekBtn;
    IBOutlet UIButton *monthBtn;
    IBOutlet UIButton *IntervalBtn;
}

@property (nonatomic) BOOL isChart;
@property (nonatomic,strong) IBOutlet UITableView *listView;
@property (nonatomic,strong) IBOutlet GraphView *graphView;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;





//  設定此Ｖiew
-(void)Set_Init:(NSArray *)arr;

//  初始化Ｖiew 上的設定
-(void)Do_Init:(int)nowtype :(id)SetObj;


//設定小提醒
-(void)Set_RemindInit:(NSDictionary *)dic;

//圖表列表切換
-(IBAction)changeChart:(id)sender;

//重新讀取資料
-(void)reloadData;


@end
