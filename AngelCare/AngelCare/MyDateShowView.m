//
//  MyDateShowView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyDateShowView.h"
#import "MainClass.h"
#import <QuartzCore/QuartzCore.h>

#define HS_Measure NSLocalizedStringFromTable(@"HS_Measure", INFOPLIST, nil)
#define HS_Weight NSLocalizedStringFromTable(@"HS_Weight", INFOPLIST, nil)
#define HS_Sport NSLocalizedStringFromTable(@"HS_Sport", INFOPLIST, nil)
#define HS_CALL NSLocalizedStringFromTable(@"HS_CALL", INFOPLIST, nil)
#define HS_Setting NSLocalizedStringFromTable(@"HS_Setting", INFOPLIST, nil)
#define HS_Fall NSLocalizedStringFromTable(@"HS_Fall", INFOPLIST, nil)

@implementation MyDateShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


//功能按鈕
-(IBAction)funcionBtn:(UIButton *)sender
{
    NSLog(@"funcionBtn sender tag = %d", (int)sender.tag);

    switch (sender.tag) {
        case 101:   // 量測提醒
            [(MainClass *)MainObj Other_MouseDown:91];
            break;
        case 102:   // 通話限制
            [(MainClass *)MainObj Other_MouseDown:92];
            break;
        case 103:   // 硬體設定
            [(MainClass *)MainObj Other_MouseDown:93];
            break;
        case 104:   // 跌倒設定
            [(MainClass *)MainObj Other_MouseDown:94];
            NSLog(@"Fall");
            break;
        case 105:   // 離家警示設定
            [(MainClass *)MainObj Other_MouseDown:95];
            NSLog(@"LeaveRemind");
            break;
        case 106:   // 取得展示照片
            [(MainClass *)MainObj Other_MouseDown:96];
            NSLog(@"取得展示照片");
            break;
        case 107:   // 活動量提醒 無動作
            [(MainClass *)MainObj Other_MouseDown:97];
            NSLog(@"活動量提醒");
            break;
        case 108:   // 同步時段
            [(MainClass *)MainObj Other_MouseDown:98];
            NSLog(@"同步時段");
            break;
        case 109:   // 電子圍籬
            [(MainClass *)MainObj Other_MouseDown:99];
            NSLog(@"電子圍籬");
            break;
        case 110:   // 自建定位
            //[(MainClass *)MainObj Other_MouseDown:100];
            //NSLog(@"Missing program");
            [(MainClass *)MainObj Other_MouseDown:99];
            NSLog(@"電子圍籬");
            break;
        default:
            break;
    }
}

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender
{
    NSLog(@"set it");
    MainObj = sender;
    //ntt modify
//    [self SetBgView:bgView1 AndColor:[UIColor colorWithRed:0.541 green:0.803 blue:1 alpha:1]];
//    
//    [self SetBgView:bgView2 AndColor:[UIColor colorWithRed:0.454 green:0.674 blue:1 alpha:1]];
//    
//    [self SetBgView:bgView3 AndColor:[UIColor colorWithRed:0.505 green:0.933 blue:0.99 alpha:1]];
//    
//    [self SetBgView:bgView4 AndColor:[UIColor colorWithRed:0.921 green:0.909 blue:0.262 alpha:1]];
//    
//    [self SetBgView:bgView5 AndColor:[UIColor colorWithRed:1 green:0.729 blue:0.207 alpha:1]];
//    
//    [self SetBgView:bgView6 AndColor:[UIColor colorWithRed:1 green:0.729 blue:0.207 alpha:1]];

    title1.text = NSLocalizedStringFromTable(@"HS_Measure", INFOPLIST, nil);
    title2.text = NSLocalizedStringFromTable(@"HS_CALL", INFOPLIST, nil);
    title3.text = NSLocalizedStringFromTable(@"HS_Setting", INFOPLIST, nil);
    title4.text = NSLocalizedStringFromTable(@"HS_Fall", INFOPLIST, nil);
    title5.text = NSLocalizedStringFromTable(@"HS_Leave", INFOPLIST, nil);
    title6.text = NSLocalizedStringFromTable(@"HS_ShowImage", INFOPLIST, nil);
    title8.text = NSLocalizedStringFromTable(@"HS_Tracking", INFOPLIST, nil);
    title9.text = NSLocalizedStringFromTable(@"HS_GeoFence", INFOPLIST, nil);
    title10.text = NSLocalizedStringFromTable(@"HS_Position", INFOPLIST, nil);

    [title1 setTextColor:[UIColor blackColor]];
    [title2 setTextColor:[UIColor blackColor]];
    [title3 setTextColor:[UIColor blackColor]];
    [title4 setTextColor:[UIColor blackColor]];
    [title5 setTextColor:[UIColor blackColor]];
    [title6 setTextColor:[UIColor blackColor]];
    [title8 setTextColor:[UIColor blackColor]];
    [title9 setTextColor:[UIColor blackColor]];
    [title10 setTextColor:[UIColor blackColor]];
}


//設定每個icon的背景顏色
-(void)SetBgView:(UIView *)bgView AndColor:(UIColor *)changeColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[changeColor CGColor],(id)[[UIColor whiteColor] CGColor],  nil]; // 由上到下的漸層顏色
    [bgView.layer insertSublayer:gradient atIndex:0];
    bgView.layer.cornerRadius = 8.0f;
    bgView.layer.masksToBounds = YES;
}


@end
