//
//  LeaveRemind.m
//  AngelCare
//
//  Created by macmini on 13/7/24.
//
//

#import "LeaveRemind.h"
#import "MainClass.h"

@implementation LeaveRemind
@synthesize timeareaLbl,addressLbl,actRangeBtn,actRangeLbl,startBtn,endBtn,MapBtn,addrLbl,periodrLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib
{
    backgroundColor = [UIColor colorWithRed:0.921f
                                      green:0.921f
                                       blue:0.921f
                                      alpha:1];
    
    titleColor =   [UIColor colorWithRed:0.0f
                                   green:0.0f
                                    blue:0.0f
                                   alpha:1];
    
    selbackgroundColor = [UIColor colorWithRed:0.443f
                                         green:0.443f
                                          blue:0.443f
                                         alpha:1];
    
    seltitleColor = [UIColor colorWithRed:1.0f
                                    green:1.0f
                                     blue:1.0f
                                    alpha:1];
    
    [self Btn_init];
}


-(void)Do_Init:(id)sender
{
    MainObj = sender;
    rangeArr = [self getRangeArr];
    
    startStr = @"08:00";
    endStr = @"10:00";
    rangeStr = @"50";
    t1 = @"0";
    t2 = @"0";
    t3 = @"0";
    t4 = @"0";
    t5 = @"0";
    t6 = @"0";
    t7 = @"0";
    addrLbl.text = @"";
    addrStr = @"";
    [startBtn setTitle:startStr forState:UIControlStateNormal];
    [endBtn setTitle:endStr forState:UIControlStateNormal];
    [actRangeBtn setTitle:[NSString stringWithFormat:@"%@M",rangeStr] forState:UIControlStateNormal];
    
    timeareaLbl.text = NSLocalizedStringFromTable(@"HS_Timeinterval", INFOPLIST, nil);
    
    addressLbl.text = NSLocalizedStringFromTable(@"HS_Homeaddress", INFOPLIST, nil);
    
    [MapBtn setTitle:NSLocalizedStringFromTable(@"HS_MapEditor", INFOPLIST, nil) forState:UIControlStateNormal];
    
    actRangeLbl.text = NSLocalizedStringFromTable(@"HS_Range", INFOPLIST, nil);
    
    periodrLbl.text = NSLocalizedStringFromTable(@"HS_Repetitionperiod", INFOPLIST, nil);
    
    [week1 setTitle:NSLocalizedStringFromTable(@"HS_W1", INFOPLIST, nil) forState:UIControlStateNormal];
    [week2 setTitle:NSLocalizedStringFromTable(@"HS_W2", INFOPLIST, nil) forState:UIControlStateNormal];
    [week3 setTitle:NSLocalizedStringFromTable(@"HS_W3", INFOPLIST, nil) forState:UIControlStateNormal];
    [week4 setTitle:NSLocalizedStringFromTable(@"HS_W4", INFOPLIST, nil) forState:UIControlStateNormal];
    [week5 setTitle:NSLocalizedStringFromTable(@"HS_W5", INFOPLIST, nil) forState:UIControlStateNormal];
    [week6 setTitle:NSLocalizedStringFromTable(@"HS_W6", INFOPLIST, nil) forState:UIControlStateNormal];
    [week7 setTitle:NSLocalizedStringFromTable(@"HS_W7", INFOPLIST, nil) forState:UIControlStateNormal];
    
}

-(NSArray *)getRangeArr
{
    NSArray *range = [[NSArray alloc] initWithObjects:@"50",@"100",@"150",@"200", nil];
    
    return range;
}


-(void)Set_Init:(NSDictionary *)dic
{
    [self Btn_init];
    NSLog(@"dic = %@",dic);
    if (dic) {
        
   
    startStr = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"start"] ]substringWithRange:NSMakeRange(11, 5)];
                
    endStr = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"end"] ]substringWithRange:NSMakeRange(11, 5)];

    rangeStr = [dic objectForKey:@"radius"];
        
        
    t1 = [dic objectForKey:@"t1"];
    t2 = [dic objectForKey:@"t2"];
    t3 = [dic objectForKey:@"t3"];
    t4 = [dic objectForKey:@"t4"];
    t5 = [dic objectForKey:@"t5"];
    t6 = [dic objectForKey:@"t6"];
    t7 = [dic objectForKey:@"t7"];
    addrStr = [dic objectForKey:@"address"];
    
        if ([addrStr isEqualToString:@"(null)"])
        {
            addrStr = @"";
        }
        
    addrLbl.text = [NSString stringWithFormat:@"%@",addrStr];
        
    latitudeStr = [dic objectForKey:@"latitude"];
    longitudeStr = [dic objectForKey:@"longitude"];
    
    [startBtn setTitle:startStr forState:UIControlStateNormal];
    [endBtn setTitle:endStr forState:UIControlStateNormal];
    [actRangeBtn setTitle:[NSString stringWithFormat:@"%@M",rangeStr] forState:UIControlStateNormal];
    
    
    if ([t1 isEqualToString:@"1"]) {
        [[week1 layer] setBackgroundColor:selbackgroundColor.CGColor];
        
        [week1 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    if ([t2 isEqualToString:@"1"]) {
        [[week2 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week2 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    
    if ([t3 isEqualToString:@"1"]) {
        [[week3 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week3 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    
    if ([t4 isEqualToString:@"1"]) {
        [[week4 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week4 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    
    if ([t5 isEqualToString:@"1"]) {
        [[week5 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week5 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    
    if ([t6 isEqualToString:@"1"]) {
        [[week6 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week6 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
    
    if ([t7 isEqualToString:@"1"]) {
        [[week7 layer] setBackgroundColor:selbackgroundColor.CGColor];
        [week7 setTitleColor:seltitleColor forState:UIControlStateNormal];
    }
        
    }
}


-(void)SaveLeaveSet
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowStr = [dateFormatter stringFromDate:nowDate];
    
    NSLog(@"start %@",startStr);
    NSLog(@"endStr %@",endStr);
    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@ %@",nowStr,startStr],@"start",[NSString stringWithFormat:@"%@ %@",nowStr,endStr],@"end",@"1",@"number",rangeStr,@"radius",latitudeStr,@"latitude",longitudeStr,@"longitude",t1,@"t1",t2,@"t2",t3,@"t3",t4,@"t4",t5,@"t5",t6,@"t6",t7,@"t7",addressTxt.text,@"address", nil];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@ %@",nowStr,startStr],@"start",[NSString stringWithFormat:@"%@ %@",nowStr,endStr],@"end",@"1",@"number",rangeStr,@"radius",latitudeStr,@"latitude",longitudeStr,@"longitude",t1,@"t1",t2,@"t2",t3,@"t3",t4,@"t4",t5,@"t5",t6,@"t6",t7,@"t7",addrStr,@"address", nil];
    
    NSLog(@"dic = %@",dic);
    [(MainClass *)MainObj Send_Leavedata:dic];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)changeTime:(id)sender {
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    }
    else {
        // use UIAlertView
        [self useActionSheet:sender];
    }
    
}
- (void)useAlerController:(id)sender{
    // use UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
       {
           ////todo
           NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
           [dateFormatter setDateFormat:@"HH:mm"];
           
           NSString *selectStr = [dateFormatter stringFromDate:datePicker.date];
           
           if ([(UIView*)sender tag] == 101) {
               NSLog(@"101");
               startStr = selectStr;
           }else
           {
               NSLog(@"102");
               endStr = selectStr;
           }
           
           [(UIButton *)selectBtn setTitle:[NSString stringWithFormat:@"%@",selectStr] forState:UIControlStateNormal];
       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
       {

       }];
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minuteInterval = 5;
    

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];

    
    switch ([(UIView*)sender tag]) {
        case 101:
            datePicker.date = [formatter dateFromString:startStr];
            //            datePicker.maximumDate = [formatter dateFromString:endStr];
            break;
            
        case 102:
            datePicker.date = [formatter dateFromString:endStr];
            //            datePicker.minimumDate = [formatter dateFromString:startStr];
            break;
    }
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}
- (void)useActionSheet:(id)sender{
    selectBtn = sender;
    UIActionSheet *changeRange = [[UIActionSheet alloc] initWithTitle:@"\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n" delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    [changeRange setTag:101];
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minuteInterval = 5;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    switch ([(UIView*)selectBtn tag]) {
        case 101:
            datePicker.date = [formatter dateFromString:startStr];
            //            datePicker.maximumDate = [formatter dateFromString:endStr];
            break;
            
        case 102:
            datePicker.date = [formatter dateFromString:endStr];
            //            datePicker.minimumDate = [formatter dateFromString:startStr];
            break;
    }
    
    
    [changeRange addSubview:datePicker];
    [changeRange showInView:self];
}
- (IBAction)changeRange:(id)sender {
    if ([UIAlertController class]) {
        [self useACRange:sender];
    }
    else {
        // use UIAlertView
        [self useACTRange:sender];
    }
    
}
- (void)useACRange:(id)sender{
    // use UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
       {
           ////todo
           rangeStr = [rangeArr objectAtIndex:selectNum];
           [actRangeBtn setTitle:[NSString stringWithFormat:@"%@M",rangeStr] forState:UIControlStateNormal];
           
       }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
   {
       
   }];
    
    UIPickerView *rangePicker = [[UIPickerView alloc] init];
    rangePicker.delegate = self;
    rangePicker.showsSelectionIndicator = YES;
    rangePicker.tag = 102;
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}
-(void)useACTRange:(id)sender{
    UIActionSheet *changeRange = [[UIActionSheet alloc] initWithTitle:@"\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n" delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    [changeRange setTag:201];
    UIPickerView *rangePicker = [[UIPickerView alloc] init];
    rangePicker.delegate = self;
    rangePicker.showsSelectionIndicator = YES;
    rangePicker.tag = 102;
    [changeRange addSubview:rangePicker];
    [changeRange showInView:self];
}



-(IBAction)selectWeek:(id)sender
{
    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    switch ([(UIView*)sender tag]) {
        case 101:
            if ([t1 isEqualToString:@"1"]) {
                NSLog(@"test is isMon");
                t1 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t1 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 102:
            if ([t2 isEqualToString:@"1"]) {
                NSLog(@"test is isTue");
                t2 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t2 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 103:
            if ([t3 isEqualToString:@"1"]) {
                NSLog(@"test is isWed");
                t3 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t3 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 104:
            if ([t4 isEqualToString:@"1"]) {
                NSLog(@"test is isThe");
                t4 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t4 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 105:
            if ([t5 isEqualToString:@"1"]) {
                NSLog(@"test is isFri");
                t5 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t5 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 106:
            if ([t6 isEqualToString:@"1"]) {
                NSLog(@"test is isSat");
                t6 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t6 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
            
        case 107:
            if ([t7 isEqualToString:@"1"]) {
                NSLog(@"test is isSun");
                t7 = @"0";
                [[(UIButton *)sender layer] setBackgroundColor:backgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:titleColor forState:UIControlStateNormal];
            }else{
                NSLog(@"test is No");
                t7 = @"1";
                [[(UIButton *)sender layer] setBackgroundColor:selbackgroundColor.CGColor];
                [(UIButton *)sender setTitleColor:seltitleColor forState:UIControlStateNormal];
            }
            break;
    }
    
    
}



-(void)Btn_init
{
    
    [[week1 layer] setCornerRadius:8.0f];
    [[week1 layer] setMasksToBounds:YES];
    [[week1 layer] setBackgroundColor:backgroundColor.CGColor];
    [week1 setTitleColor:titleColor forState:UIControlStateNormal];
    [week1 setHidden:NO];
    
    [[week2 layer] setCornerRadius:8.0f];
    [[week2 layer] setMasksToBounds:YES];
    [[week2 layer] setBackgroundColor:backgroundColor.CGColor];
    [week2 setTitleColor:titleColor forState:UIControlStateNormal];
    [week2 setHidden:NO];
    
    [[week3 layer] setCornerRadius:8.0f];
    [[week3 layer] setMasksToBounds:YES];
    [[week3 layer] setBackgroundColor:backgroundColor.CGColor];
    [week3 setTitleColor:titleColor forState:UIControlStateNormal];
    [week3 setHidden:NO];
    
    [[week4 layer] setCornerRadius:8.0f];
    [[week4 layer] setMasksToBounds:YES];
    [[week4 layer] setBackgroundColor:backgroundColor.CGColor];
    [week4 setTitleColor:titleColor forState:UIControlStateNormal];
    [week4 setHidden:NO];
    
    [[week5 layer] setCornerRadius:8.0f];
    [[week5 layer] setMasksToBounds:YES];
    [[week5 layer] setBackgroundColor:backgroundColor.CGColor];
    [week5 setTitleColor:titleColor forState:UIControlStateNormal];
    [week5 setHidden:NO];
    
    [[week6 layer] setCornerRadius:8.0f];
    [[week6 layer] setMasksToBounds:YES];
    [[week6 layer] setBackgroundColor:backgroundColor.CGColor];
    [week6 setTitleColor:titleColor forState:UIControlStateNormal];
    [week6 setHidden:NO];
    
    [[week7 layer] setCornerRadius:8.0f];
    [[week7 layer] setMasksToBounds:YES];
    [[week7 layer] setBackgroundColor:backgroundColor.CGColor];
    [week7 setTitleColor:titleColor forState:UIControlStateNormal];
    [week7 setHidden:NO];
    
}


#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@M",[rangeArr objectAtIndex:row]];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [rangeArr count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectNum = row;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button Index = %i",buttonIndex);
    if (buttonIndex == 0) {
        
        if ([actionSheet tag] == 101) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            
            NSString *selectStr = [dateFormatter stringFromDate:datePicker.date];
            
            if ([(UIView*)selectBtn tag] == 101) {
                NSLog(@"101");
                startStr = selectStr;
            }else
            {
                NSLog(@"102");
                endStr = selectStr;
            }
            
            [(UIButton *)selectBtn setTitle:[NSString stringWithFormat:@"%@",selectStr] forState:UIControlStateNormal];
        }
        
        
        if ([actionSheet tag] == 201) {
            rangeStr = [rangeArr objectAtIndex:selectNum];
            [actRangeBtn setTitle:[NSString stringWithFormat:@"%@M",rangeStr] forState:UIControlStateNormal];
        }
    }
}



- (IBAction)checkMap:(id)sender
{
    [(MainClass *)MainObj Other_MouseDown:951];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:latitudeStr,@"latitude",longitudeStr,@"longitude",addrStr,@"address",rangeStr,@"radius", nil];
    
    [(MainClass *)MainObj Show_LeaveMapdata:dic];
    
}

-(void)ChangeAddr:(NSDictionary *)dic
{
    NSLog(@"dic %@",dic);
    addrStr = [dic objectForKey:@"address"];
    latitudeStr = [dic objectForKey:@"latitude"];
    longitudeStr = [dic objectForKey:@"longitude"];
    rangeStr = [dic objectForKey:@"radius"];
    
    addrLbl.text = [NSString stringWithFormat:@"%@",addrStr];
    [actRangeBtn setTitle:[NSString stringWithFormat:@"%@M",rangeStr] forState:UIControlStateNormal];
}

@end
