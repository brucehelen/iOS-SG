//
//  MyEatPickView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyEatPickView.h"
#import "MainClass.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyEatPickView

- (IBAction)Main_MouseDown:(id)sender
{
    
}


// 初始化Ｖiew 上的設定
- (void)Do_Init:(id)sender andType:(int)type
{
    MainObj = sender;
    MyPick.minuteInterval = 1;

    if (type == 1) {
        MyPick.frame = CGRectMake(60, 110, 200, 216);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            MyPick.frame = CGRectMake(278, 383, 213, 216);
        }

        //吃藥提醒
        MyPick.datePickerMode = UIDatePickerModeTime;

        [self Btn_init];
    }else
    {
        MyPick.frame = CGRectMake(0, 110, 320, 216);
        MyPick.datePickerMode = UIDatePickerModeDateAndTime;
        [self set_BtnHidden];
    }

    for (UIView * subview in MyPick.subviews) {
        [subview setBackgroundColor:[ColorHex colorWithHexString:@"b4b4b4"]];
        [subview.layer setCornerRadius:8];
        [subview.layer setMasksToBounds:YES];
    }

    MyPick.minuteInterval = 1;
}
- (void)setLbl:(UILabel*)lbl{
    [lbl setTextColor:[UIColor whiteColor]];
}

-(void)awakeFromNib
{
    backgroundColor = [ColorHex colorWithHexString:@"b4b4b4"];
    titleColor =   [UIColor colorWithRed:0.0f
                                   green:0.0f
                                    blue:0.0f
                                   alpha:1];

    selbackgroundColor = [UIColor colorWithRed:254/255.0 green:204/255.0 blue:70/255.0 alpha:1.0];

    seltitleColor = [UIColor colorWithRed:0.0f
                                    green:0.0f
                                     blue:0.0f
                                    alpha:1];
}

-(void)Btn_init
{
    [MonBtn setTitle:NSLocalizedStringFromTable(@"HS_W1", INFOPLIST, nil) forState:UIControlStateNormal];
    [TueBtn setTitle:NSLocalizedStringFromTable(@"HS_W2", INFOPLIST, nil) forState:UIControlStateNormal];
    [WedBtn setTitle:NSLocalizedStringFromTable(@"HS_W3", INFOPLIST, nil) forState:UIControlStateNormal];
    [TheBtn setTitle:NSLocalizedStringFromTable(@"HS_W4", INFOPLIST, nil) forState:UIControlStateNormal];
    [FriBtn setTitle:NSLocalizedStringFromTable(@"HS_W5", INFOPLIST, nil) forState:UIControlStateNormal];
    [SatBtn setTitle:NSLocalizedStringFromTable(@"HS_W6", INFOPLIST, nil) forState:UIControlStateNormal];
    [SunBtn setTitle:NSLocalizedStringFromTable(@"HS_W7", INFOPLIST, nil) forState:UIControlStateNormal];
    
    
//    UIColor *color = [ColorHex colorWithHexString:@"717171"];
    
    [[MonBtn layer] setCornerRadius:8.0f];
    [[MonBtn layer] setMasksToBounds:YES];
    [[MonBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [MonBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [MonBtn setHidden:NO];
    
    [[TueBtn layer] setCornerRadius:8.0f];
    [[TueBtn layer] setMasksToBounds:YES];
    [[TueBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [TueBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [TueBtn setHidden:NO];
    
    [[WedBtn layer] setCornerRadius:8.0f];
    [[WedBtn layer] setMasksToBounds:YES];
    [[WedBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [WedBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [WedBtn setHidden:NO];
    
    [[TheBtn layer] setCornerRadius:8.0f];
    [[TheBtn layer] setMasksToBounds:YES];
    [[TheBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [TheBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [TheBtn setHidden:NO];
    
    [[FriBtn layer] setCornerRadius:8.0f];
    [[FriBtn layer] setMasksToBounds:YES];
    [[FriBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [FriBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [FriBtn setHidden:NO];
    
    [[SatBtn layer] setCornerRadius:8.0f];
    [[SatBtn layer] setMasksToBounds:YES];
    [[SatBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [SatBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [SatBtn setHidden:NO];
    
    [[SunBtn layer] setCornerRadius:8.0f];
    [[SunBtn layer] setMasksToBounds:YES];
    [[SunBtn layer] setBackgroundColor:backgroundColor.CGColor];
    [SunBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [SunBtn setHidden:NO];
    
    isMon = NO;
    isTue = NO;
    isWed = NO;
    isThe = NO;
    isFri = NO;
    isSat = NO;
    isSun = NO;
}

//回診提醒隱藏星期按鈕
-(void)set_BtnHidden
{
    [MonBtn setHidden:YES];
    [TueBtn setHidden:YES];
    [WedBtn setHidden:YES];
    [TheBtn setHidden:YES];
    [FriBtn setHidden:YES];
    [SatBtn setHidden:YES];
    [SunBtn setHidden:YES];
}

//吃藥提醒初始化
-(void)SetMed_initWithDic:(NSDictionary *)dic
{
    s_team = [dic objectForKey:@"team"];
    if (![[dic objectForKey:@"day"] isEqualToString:@"--"])
    {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *nowDate = [NSDate date];
    
    NSString *nowDateStr = [formatter stringFromDate:nowDate];
    
    NSString *medTime = [NSString stringWithFormat:@"%@ %@:%@",nowDateStr,[dic objectForKey:@"hour"],[dic objectForKey:@"min"]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSLog(@"med time = %@",medTime);
    
        if ([formatter dateFromString:medTime]) {
            NSDate *medDate = [formatter dateFromString:medTime];
            
            [MyPick setDate:medDate animated:YES];
        }
        
    

        
        if ([[dic objectForKey:@"week1"] isEqualToString:@"1"]) {
            [[MonBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            
            [MonBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isMon = YES;
        }
        if ([[dic objectForKey:@"week2"] isEqualToString:@"1"]) {
            [[TueBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [TueBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isTue = YES;
        }
        
        if ([[dic objectForKey:@"week3"] isEqualToString:@"1"]) {
            [[WedBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [WedBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isWed = YES;
        }
       
        if ([[dic objectForKey:@"week4"] isEqualToString:@"1"]) {
            [[TheBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [TheBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isThe = YES;
        }
        
        if ([[dic objectForKey:@"week5"] isEqualToString:@"1"]) {
            [[FriBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [FriBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isFri = YES;
        }
        
        if ([[dic objectForKey:@"week6"] isEqualToString:@"1"]) {
            [[SatBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [SatBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isSat = YES;
        }
        
        if ([[dic objectForKey:@"week7"] isEqualToString:@"1"]) {
            [[SunBtn layer] setBackgroundColor:selbackgroundColor.CGColor];
            [SunBtn setTitleColor:seltitleColor forState:UIControlStateNormal];
            isSun = YES;
        }
    }
}


//回診提醒初始化
-(void)SetHos_initWithDic:(NSDictionary *)dic
{
    s_team = [dic objectForKey:@"team"];
    if (![[dic objectForKey:@"day"] isEqualToString:@"--"])
    {
        
        NSString *selDateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",[dic objectForKey:@"year"],[dic objectForKey:@"mon"],[dic objectForKey:@"day"],[dic objectForKey:@"hour"],[dic objectForKey:@"min"]];
        
        NSLog(@"sel date = %@",selDateStr);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSDate *HosDate;
        
        if([formatter dateFromString:selDateStr])
        {
            HosDate = [formatter dateFromString:selDateStr];
        }else
        {
            HosDate = [NSDate date];
        }
        
        
        [MyPick setDate:HosDate animated:YES];
        
    }
    NSLog(@"s_team = %@",s_team);
}




-(IBAction)selectWeek:(id)sender
{
    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    switch ([(UIView*)sender tag]) {
        case 101:
            if (isMon) {
                NSLog(@"test is isMon");
                isMon = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isMon = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 102:
            if (isTue) {
                NSLog(@"test is isTue");
                isTue = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isTue = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 103:
            if (isWed) {
                NSLog(@"test is isWed");
                isWed = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isWed = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 104:
            if (isThe) {
                NSLog(@"test is isThe");
                isThe = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isThe = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 105:
            if (isFri) {
                NSLog(@"test is isFri");
                isFri = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isFri = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 106:
            if (isSat) {
                NSLog(@"test is isSat");
                isSat = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isSat = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 107:
            if (isSun) {
                NSLog(@"test is isSun");
                isSun = NO;
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                isSun = YES;
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
    }
}

//儲存吃藥提醒設定
-(void)SaveMed
{
    NSLog(@"SaveMed");
    
    NSDateFormatter *dateFotmatter = [[NSDateFormatter alloc] init];
    [dateFotmatter setDateFormat:@"HH"];
    NSString *hourStr = [dateFotmatter stringFromDate:MyPick.date];
    
    [dateFotmatter setDateFormat:@"mm"];
    NSString *minStr = [dateFotmatter stringFromDate:MyPick.date];

    NSLog(@"hourStr = %@",hourStr);
    NSLog(@"minStr = %@",minStr);
    
    NSString *isMonStr = @"0";
    NSString *isTueStr = @"0";
    NSString *isWedStr = @"0";
    NSString *isTheStr = @"0";
    NSString *isFriStr = @"0";
    NSString *isSatStr = @"0";
    NSString *isSunStr = @"0";
    
    if (isMon) {
        isMonStr = @"1";
    }
    
    if (isTue) {
        isTueStr = @"1";
    }
    
    if (isWed) {
        isWedStr = @"1";
    }
    
    if (isThe) {
        isTheStr = @"1";
    }
    
    if (isFri) {
        isFriStr = @"1";
    }
    
    if (isSat) {
        isSatStr = @"1";
    }
    
    if (isSun) {
        isSunStr = @"1";
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:hourStr,@"hour",minStr,@"min",isMonStr ,@"week1",isTueStr ,@"week2",isWedStr ,@"week3",isTheStr ,@"week4",isFriStr ,@"week5",isSatStr ,@"week6",isSunStr ,@"week7",s_team ,@"s_team",@"Y" ,@"on_off", nil];

    NSLog(@"dic = %@",dic);

    [(MainClass *)MainObj Send_MedRemindUpdateWith:dic];
}


//儲存回診提醒
-(void)SaveHos
{
    NSDateFormatter *dateFotmatter = [[NSDateFormatter alloc] init];

    [dateFotmatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFotmatter stringFromDate:MyPick.date];

    [dateFotmatter setDateFormat:@"MM"];
    NSString *monthStr = [dateFotmatter stringFromDate:MyPick.date];
    
    [dateFotmatter setDateFormat:@"dd"];
    NSString *dayStr = [dateFotmatter stringFromDate:MyPick.date];

    [dateFotmatter setDateFormat:@"HH"];
    NSString *hourStr = [dateFotmatter stringFromDate:MyPick.date];

    [dateFotmatter setDateFormat:@"mm"];
    NSString *minStr = [dateFotmatter stringFromDate:MyPick.date];

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:yearStr,@"year",monthStr,@"mon",dayStr,@"day",hourStr,@"hour",minStr,@"min",@"0" ,@"week1",@"0" ,@"week2",@"0" ,@"week3",@"0" ,@"week4",@"0" ,@"week5",@"0" ,@"week6",@"0" ,@"week7",s_team ,@"s_team",@"Y" ,@"on_off", nil];

    [(MainClass *)MainObj Send_HosRemindUpdateWith:dic];
}

@end
