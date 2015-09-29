//
//  MySelView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MySelView.h"
#import "MainClass.h"

@implementation MySelView


//量測按鈕MouseDown觸發
- (IBAction)Main_MouseDown:(id)sender
{
    [(MainClass *)MainObj Other_MouseDown:[(UIView*)sender tag]];
}


//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender
{

    MainObj = sender;
    
    Bu1_lbl.text = NSLocalizedStringFromTable(@"Bu3_01_Str", INFOPLIST, nil);
    Bu2_lbl.text = NSLocalizedStringFromTable(@"Bu3_02_Str", INFOPLIST, nil);
    Bu3_lbl.text = NSLocalizedStringFromTable(@"Bu3_03_Str", INFOPLIST, nil);
    Bu4_lbl.text = NSLocalizedStringFromTable(@"Bu3_04_Str", INFOPLIST, nil);
    Bu5_lbl.text = NSLocalizedStringFromTable(@"Bu3_05_Str", INFOPLIST, nil);
    Bu6_lbl.text = NSLocalizedStringFromTable(@"Bu3_06_Str", INFOPLIST, nil);
    
    
    [Bu1_lbl setTextColor:[UIColor blackColor]];
    [Bu2_lbl setTextColor:[UIColor blackColor]];
    [Bu3_lbl setTextColor:[UIColor blackColor]];
    [Bu4_lbl setTextColor:[UIColor blackColor]];
    [Bu5_lbl setTextColor:[UIColor blackColor]];
    [Bu6_lbl setTextColor:[UIColor blackColor]];
    //change to ntt
//    [self SetBgView:bg1 AndColor:[UIColor colorWithRed:0.509 green:0.803 blue:0.99 alpha:1]];
//    [self SetBgView:bg2 AndColor:[UIColor colorWithRed:0.294 green:0.737 blue:0.247 alpha:1]];
//    [self SetBgView:bg3 AndColor:[UIColor colorWithRed:0.486 green:0.925 blue:1 alpha:1]];
//    [self SetBgView:bg4 AndColor:[UIColor colorWithRed:0.788 green:0.643 blue:0.56 alpha:1]];
//    [self SetBgView:bg5 AndColor:[UIColor colorWithRed:0.925 green:0.901 blue:0.286 alpha:1]];
    /*
    [Bu1 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW1]] forState:UIControlStateNormal];
    
    [Bu2 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW2]] forState:UIControlStateNormal];    
    
   
    [Bu3 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW3]] forState:UIControlStateNormal];
    
    
    [Bu4 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW4]] forState:UIControlStateNormal];
    
    [Bu5 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW5]] forState:UIControlStateNormal];
    
    
    [Bu6 setImage:[UIImage imageNamed: [(MainClass *) MainObj Get_DefineString:IMAGE_SHOW6]] forState:UIControlStateNormal]; 
     */
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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



@end
