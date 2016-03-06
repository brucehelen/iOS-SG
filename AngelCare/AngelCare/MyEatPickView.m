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

//確定與取消mousedown觸發
- (IBAction)Main_MouseDown:(id)sender
{
    
}

-(void)SetDate:(NSString *)DateStr
{
    
}

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender andType:(int)type
{
    MainObj = sender;
    MyPick.minuteInterval = 5;
    NSLog(@"---> MyPick.minuteInterval = %d", MyPick.minuteInterval);
    
    if (type==1) {
        MyPick.frame = CGRectMake(60, 110, 200, 216);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            MyPick.frame = CGRectMake(278, 383, 213, 216);
        }
        
        //吃藥提醒
        MyPick.datePickerMode = UIDatePickerModeTime;
        NSDate *nowdate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *maxDayStr = [NSString stringWithFormat:@"%@ 21:00",[dateFormatter stringFromDate:nowdate]];
        NSString *minDayStr = [NSString stringWithFormat:@"%@ 06:00",[dateFormatter stringFromDate:nowdate]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *maxDate = [dateFormatter dateFromString:maxDayStr];
        NSDate *minDate = [dateFormatter dateFromString:minDayStr];
        
//        MyPick.maximumDate = maxDate;
//        MyPick.minimumDate = minDate;
        
        [self Btn_init];
        
    }else
    {
        NSLog(@"type =2");
        MyPick.frame = CGRectMake(0, 110, 320, 216);
        MyPick.datePickerMode = UIDatePickerModeDateAndTime;
//        MyPick.maximumDate = [NSDate dateWithTimeIntervalSinceNow:DBL_MAX];//最大時間
//        MyPick.minimumDate = [NSDate date];
        [self set_BtnHidden];
    }
//    [UIView appearanceWhenContainedIn:[UITableView class], [UIDatePicker class], nil].backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
//    [UILabel appearanceWhenContainedIn:[UITableView class], [UIDatePicker class],[UIView class], nil].textColor = [UIColor whiteColor];
    
//    NSMutableArray *tmp = [NSMutableArray new];
    for (UIView * subview in MyPick.subviews) {

//        if ([subview isKindOfClass:NSClassFromString(@"_UISomePrivateLabelSubclass")])
//        {
//            [subview setColor:...
             //do interesting stuff here
        NSLog(@"subview %@",[subview class]);
//         }
        [subview setBackgroundColor:[ColorHex colorWithHexString:@"b4b4b4"]];
        [subview.layer setCornerRadius:8];
        [subview.layer setMasksToBounds:YES];
//        for (UIView * view in subview.subviews){
//            NSLog(@"view %@",[view class]);
//            for (UIView * view1 in view.subviews){
//                NSLog(@"view111111 %@",[view1 class]);
//                for (UIView * view2 in view1.subviews){
//                    NSLog(@"view222222 %@",[view2 class]);
//                    for (UIView * view3 in view2.subviews){
//                        NSLog(@"view333333 %@",[view3 class]);
//                        for (UIView * view4 in view3.subviews){
//                            NSLog(@"view444444 %@",[view4 class]);
//                            for (UIView * view5 in view4.subviews){
//                                NSLog(@"view555555 %@",[view5 class]);
//                                for (UIView * view6 in view5.subviews){
//                                    NSLog(@"view666666 %@",[view6 class]);
//                                    for (UIView * view7 in view6.subviews){
//                                        NSLog(@"view777777 %@",[view7 class]);
//                                        for (UIView * view8 in view7.subviews){
//                                            NSLog(@"view888888 %@",[view8 class]);
//
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
     }
//    NSLog(@"tmp %@",tmp);
//    for (int i = 0;  i < tmp.count; i++) {
//        UILabel *lbl = [tmp objectAtIndex:i];
//        [lbl setTextColor:[UIColor whiteColor]];
//    }
    
    MyPick.minuteInterval = 5;
    NSLog(@"###> MyPick.minuteInterval = %d", MyPick.minuteInterval);
}
- (void)setLbl:(UILabel*)lbl{
    [lbl setTextColor:[UIColor whiteColor]];
}
//-(void)viewDidLoad{
//    
////    [super viewDidLoad];
//    
//    [[self pickerViews].subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"%@ --- > %i",obj, idx);
//    }];
//}
//-(UIView *)pickerViews{
//    
//    return ([MyPick.subviews objectAtIndex:0]);
//}

-(void)awakeFromNib
{
    backgroundColor = [ColorHex colorWithHexString:@"b4b4b4"];
//    [UIColor colorWithRed:0.921f
//                                      green:0.921f
//                                       blue:0.921f
//                                      alpha:1];
    
//    titleColor =   [UIColor colorWithRed:0.0f
//                                   green:0.0f
//                                    blue:0.0f
//                                   alpha:1];

    titleColor =   [UIColor colorWithRed:0.0f
                                   green:0.0f
                                    blue:0.0f
                                   alpha:1];
    
    selbackgroundColor = [UIColor colorWithRed:254/255.0 green:204/255.0 blue:70/255.0 alpha:1.0];
//    [UIColor colorWithRed:0.443f
//                                         green:0.443f
//                                          blue:0.443f
//                                         alpha:1];
//    
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
