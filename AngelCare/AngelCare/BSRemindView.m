//
//  BSRemindView.m
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import "BSRemindView.h"
#import "MainClass.h"

@implementation BSRemindView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//血糖資訊
- (void)Set_Init:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);

    //read file
    [self setUnitForLbl];
    lblUnit1.userInteractionEnabled = YES;
    lblUnit2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUnit)];
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUnit)];
    [lblUnit1 addGestureRecognizer:tapGesture1];
    [lblUnit2 addGestureRecognizer:tapGesture2];

    if (dic) {
        NSLog(@"text");
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        if (![language isEqualToString:@"en"]) {// 非英語
            viewRemind.hidden = YES;
            lblCh1.hidden = NO;
            lblCh2.hidden = NO;
            lblEn1.hidden = YES;
            lblEn2.hidden = YES;
            int tmpY = 30;
            int tmpX = 10;

            [beforeMealUpTxt setFrame:CGRectMake(103 - tmpX, 95 - tmpY, beforeMealUpTxt.frame.size.width, beforeMealUpTxt.frame.size.height)];
            [lblUnit1 setFrame:CGRectMake(160 - tmpX, 90 - tmpY + 10, lblUnit1.frame.size.width, lblUnit1.frame.size.height)];
            
            [afterMealUpTxt setFrame:CGRectMake(103 - tmpX, 163 - tmpY, afterMealUpTxt.frame.size.width, afterMealUpTxt.frame.size.height)];
            [lblUnit2 setFrame:CGRectMake(160 - tmpX, 158 - tmpY + 10, lblUnit2.frame.size.width, lblUnit2.frame.size.height)];
            lblCh1.text = NSLocalizedStringFromTable(@"ExceedWillSendAlarm", INFOPLIST, nil);
                    lblCh1.textColor = [UIColor blackColor];
            lblCh2.text = NSLocalizedStringFromTable(@"ExceedWillSendAlarm", INFOPLIST, nil);
                    lblCh2.textColor = [UIColor blackColor];
        }
        else{
            viewRemind.hidden = YES;
            
            lblCh1.hidden = YES;
            lblCh2.hidden = YES;
            lblEn1.hidden = NO;
            lblEn2.hidden = NO;
            lblEn2.textColor = [UIColor blackColor];
            lblEn1.textColor = [UIColor blackColor];
            int tmpX = 30;
            int tmpY = 30;
            [beforeMealUpTxt setFrame:CGRectMake(45 - tmpX, 110 - tmpY, beforeMealUpTxt.frame.size.width, beforeMealUpTxt.frame.size.height)];
            [lblUnit1 setFrame:CGRectMake(102 - tmpX, 105 - tmpY + 10, lblUnit1.frame.size.width, lblUnit1.frame.size.height)];
            
            [afterMealUpTxt setFrame:CGRectMake(45 - tmpX, 181 - tmpY, afterMealUpTxt.frame.size.width, afterMealUpTxt.frame.size.height)];
            [lblUnit2 setFrame:CGRectMake(102 - tmpX, 176 - tmpY + 10, lblUnit2.frame.size.width, lblUnit2.frame.size.height)];
            
        }
        
        bgBloodMaxValue.text = NSLocalizedStringFromTable(@"bgBloodMaxValue", INFOPLIST, nil);
        bgBloodMaxInfo.text = NSLocalizedStringFromTable(@"bgBloodMaxInfo", INFOPLIST, nil);
        
        int beforeMealValue = [NSString stringWithFormat:@"%@",[dic objectForKey:@"beforeMealUp"]].intValue;
        beforeMealUpTxt.text = [NSString stringWithFormat:@"%.1f", beforeMealValue/10.0/18.0];
        beforeMealDownTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"beforeMealDown"]];
        
        beforeMealValue = [NSString stringWithFormat:@"%@", [dic objectForKey:@"afterMealUp"]].intValue;
        afterMealUpTxt.text = [NSString stringWithFormat:@"%.1f", beforeMealValue/10.0/18.0];

        afterMealDownTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"afterMealDown"]];
        bedTimeUpTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bedTimeUp"]];
        bedTimeDownTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bedTimeDown"]];

        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                               nil];
        [numberToolbar sizeToFit];

        beforeMealUpTxt.inputAccessoryView = numberToolbar;
        beforeMealDownTxt.inputAccessoryView = numberToolbar;
        afterMealUpTxt.inputAccessoryView = numberToolbar;
        afterMealDownTxt.inputAccessoryView = numberToolbar;
        bedTimeDownTxt.inputAccessoryView = numberToolbar;
        bedTimeUpTxt.inputAccessoryView = numberToolbar;

        bfStartStr = [dic objectForKey:@"breakfastStart"];
        bfEndStr = [dic objectForKey:@"breakfastEnd"];
        lunchStartStr = [dic objectForKey:@"lunchStart"];
        lunchEndStr = [dic objectForKey:@"lunchEnd"];
        dinnerStartStr = [dic objectForKey:@"dinnerStart"];
        dinnerEndStr = [dic objectForKey:@"dinnerEnd"];

        [bfStartBtn setTitle:bfStartStr forState:UIControlStateNormal];
        [bfEndBtn setTitle:bfEndStr forState:UIControlStateNormal];
        [lunchStartBtn setTitle:lunchStartStr forState:UIControlStateNormal];
        [lunchEndBtn setTitle:lunchEndStr forState:UIControlStateNormal];
        [dinnerStartBtn setTitle:dinnerStartStr forState:UIControlStateNormal];
        [dinnerEndBtn setTitle:dinnerEndStr forState:UIControlStateNormal];
        bfStartBtn.backgroundColor=[UIColor yellowColor];
        bfEndBtn.backgroundColor=[UIColor yellowColor];
        lunchStartBtn.backgroundColor=[UIColor yellowColor];
        lunchEndBtn.backgroundColor=[UIColor yellowColor];
        dinnerStartBtn.backgroundColor=[UIColor yellowColor];
        dinnerEndBtn.backgroundColor=[UIColor yellowColor];
    }
}

-(IBAction)donwWithTxt:(id)sender
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    
    [beforeMealUpTxt resignFirstResponder];
    [beforeMealDownTxt resignFirstResponder];
    [afterMealUpTxt resignFirstResponder];
    [afterMealDownTxt resignFirstResponder];
    [bedTimeDownTxt resignFirstResponder];
    [bedTimeUpTxt resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frames = textField.frame;
    int offset = frames.origin.y + 32 - (self.frame.size.height - 300.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return = %@",textField);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)Do_Init:(id)sender
{
    MainObj = sender;
    beforeMealDownTxt.delegate = self;
    beforeMealUpTxt.delegate = self;
    afterMealDownTxt.delegate = self;
    afterMealUpTxt.delegate = self;
    bedTimeUpTxt.delegate = self;
    bedTimeDownTxt.delegate = self;
    bgLbl.layer.cornerRadius = 8.0f;
    [bgLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];

    bgLbl2.layer.cornerRadius = 8.0f;
    [bgLbl2 setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];

    scrollView.contentSize = CGSizeMake(304, 0);
    titleLbl1.text = NSLocalizedStringFromTable(@"HS_BSRange", INFOPLIST, ni);
    titleLbl2.text = NSLocalizedStringFromTable(@"HS_BS_MEALTIME", INFOPLIST, ni);
    
    beforeMeal.text = NSLocalizedStringFromTable(@"HS_BS_BEFOREMEAL", INFOPLIST, ni);
        beforeMeal.textColor = [UIColor blackColor];
    afterMeal.text = NSLocalizedStringFromTable(@"HS_BS_AFTEREMEAL", INFOPLIST, ni);
        afterMeal.textColor = [UIColor blackColor];
    beforeSlp.text = NSLocalizedStringFromTable(@"HS_BS_BEFORSLEEP", INFOPLIST, ni);
        beforeSlp.textColor = [UIColor blackColor];
    bftime.text = NSLocalizedStringFromTable(@"HS_BS_BREAKFAST", INFOPLIST, ni);
        bftime.textColor = [UIColor blackColor];
    lutime.text = NSLocalizedStringFromTable(@"HS_BS_LUNCH", INFOPLIST, ni);
        lutime.textColor = [UIColor blackColor];
    dintime.text = NSLocalizedStringFromTable(@"HS_BS_DINNER", INFOPLIST, ni);
        dintime.textColor = [UIColor blackColor];
    bs1.text = NSLocalizedStringFromTable(@"HS_BS_1", INFOPLIST, ni);
        bs1.textColor = [UIColor blackColor];
    bs2.text = NSLocalizedStringFromTable(@"HS_BS_1", INFOPLIST, ni);
        bs2.textColor = [UIColor blackColor];
    bs3.text = NSLocalizedStringFromTable(@"HS_BS_1", INFOPLIST, ni);
        bs3.textColor = [UIColor blackColor];
}


//選擇吃飯時間
-(IBAction)selectDate:(id)sender
{
    selectBtn = sender;
    
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    }
    else {
        // use UIAlertView
        [self useActionSheet:sender];
    }
    
}
- (void)useAlerController:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
   {
       ////todo
       NSDate *selectDate = picker.date;
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:@"HH:mm"];
       NSString *selectStr = [formatter stringFromDate:selectDate];
       
       switch ([(UIView*)selectBtn tag]) {
           case 101:
               bfStartStr = selectStr;
               break;
           case 102:
               bfEndStr = selectStr;
               break;
               
           case 103:
               lunchStartStr = selectStr;
               break;
               
           case 104:
               lunchEndStr = selectStr;
               break;
               
           case 105:
               dinnerStartStr = selectStr;
               break;
               
           case 106:
               dinnerEndStr = selectStr;
               break;
               
           default:
               break;
       }
       [(UIButton *)selectBtn setTitle:selectStr forState:UIControlStateNormal];
       
   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
   {
       
   }];
    
    picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.minuteInterval = 1;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    switch ([(UIView*)selectBtn tag]) {
        case 101:
            if (![bfStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:bfStartStr];
                picker.maximumDate = [formatter dateFromString:bfEndStr];
            }
            break;
            
        case 102:
            if (![bfEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:bfEndStr];
                picker.minimumDate = [formatter dateFromString:bfStartStr];
            }
            
            break;
            
        case 103:
            if (![lunchStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:lunchStartStr];
                picker.maximumDate = [formatter dateFromString:lunchEndStr];
            }
            break;
            
        case 104:
            if (![lunchEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:lunchEndStr];
                picker.minimumDate = [formatter dateFromString:lunchStartStr];
            }
            
            break;
            
        case 105:
            if (![dinnerStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:dinnerStartStr];
                picker.maximumDate = [formatter dateFromString:dinnerEndStr];
            }
            
            break;
            
        case 106:
            if (![dinnerEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:dinnerEndStr];
                picker.minimumDate = [formatter dateFromString:dinnerStartStr];
            }
            
            break;
    }
    
    [alert.view addSubview:picker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}

- (void)useActionSheet:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedStringFromTable(@"HS_BS_SELECTTIME", INFOPLIST, nil) delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"確定", nil];
    picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeTime;
    picker.minuteInterval = 1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSLog(@"select btn = %i",[(UIView*)selectBtn tag]);
    
    switch ([(UIView*)selectBtn tag]) {
        case 101:
            if (![bfStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:bfStartStr];
                picker.maximumDate = [formatter dateFromString:bfEndStr];
            }
            break;
            
        case 102:
            if (![bfEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:bfEndStr];
                picker.minimumDate = [formatter dateFromString:bfStartStr];
            }
            
            break;
            
        case 103:
            if (![lunchStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:lunchStartStr];
                picker.maximumDate = [formatter dateFromString:lunchEndStr];
            }
            break;
            
        case 104:
            if (![lunchEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:lunchEndStr];
                picker.minimumDate = [formatter dateFromString:lunchStartStr];
            }
            
            break;
            
        case 105:
            if (![dinnerStartStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:dinnerStartStr];
                picker.maximumDate = [formatter dateFromString:dinnerEndStr];
            }
            
            break;
            
        case 106:
            if (![dinnerEndStr isEqualToString:@""]) {
                picker.date = [formatter dateFromString:dinnerEndStr];
                picker.minimumDate = [formatter dateFromString:dinnerStartStr];
            }
            
            break;
    }
    
    
    [actionSheet addSubview:picker];
    [actionSheet showInView:self];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"touch up %i",buttonIndex);
    //0為確定  1為取消
    NSLog(@"touch up %i",buttonIndex);
    //0為確定  1為取消
    if (actionSheet.tag == 1099) {
        NSLog(@"換單位");
        NSString *unit = @"";
        if (buttonIndex == 0) {
            unit = @"mmol/L";
        }
        else if (buttonIndex == 1){
            unit = @"mg/dl";
        }
        else if (buttonIndex == 2){
            unit = @"mg/L";
        }
        else{
            
        }
        //wirte unit to file
        if ([unit length] != 0) {
            lblUnit1.text = unit;
            lblUnit2.text = unit;
            [self writeUnitToFile:[NSString stringWithFormat:@"%d",buttonIndex]];
        }
        
    }
    else{
        if (buttonIndex == 0) {
            NSDate *selectDate = picker.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            NSString *selectStr = [formatter stringFromDate:selectDate];
            
            switch ([(UIView*)selectBtn tag]) {
                case 101:
                    bfStartStr = selectStr;
                    break;
                case 102:
                    bfEndStr = selectStr;
                    break;
                    
                case 103:
                    lunchStartStr = selectStr;
                    break;
                    
                case 104:
                    lunchEndStr = selectStr;
                    break;
                    
                case 105:
                    dinnerStartStr = selectStr;
                    break;
                    
                case 106:
                    dinnerEndStr = selectStr;
                    break;
                    
                default:
                    break;
            }
            [(UIButton *)selectBtn setTitle:selectStr forState:UIControlStateNormal];
        }
    }
    
}

- (void)SaveBS
{
    // 判斷是否為空直
    [beforeMealUpTxt resignFirstResponder];
    [beforeMealDownTxt resignFirstResponder];
    [afterMealUpTxt resignFirstResponder];
    [afterMealDownTxt resignFirstResponder];
    [bedTimeDownTxt resignFirstResponder];
    [bedTimeUpTxt resignFirstResponder];

    beforeMealDownTxt.text = @"0";
    afterMealDownTxt.text = @"0";
    bedTimeUpTxt.text = @"0";
    bedTimeDownTxt.text = @"0";

    if (![beforeMealDownTxt.text isEqualToString:@""] &&
        ![beforeMealUpTxt.text isEqualToString:@""] &&
        ![afterMealDownTxt.text isEqualToString:@""] &&
        ![afterMealUpTxt.text isEqualToString:@""] &&
        ![bedTimeUpTxt.text isEqualToString:@""] &&
        ![bedTimeDownTxt.text isEqualToString:@""])
    {
        int value1 = beforeMealUpTxt.text.floatValue*18*10;
        NSString *string1 = [NSString stringWithFormat:@"%d", value1];
        value1 = afterMealUpTxt.text.floatValue*18*10;
        NSString *string2 = [NSString stringWithFormat:@"%d", value1];
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             beforeMealDownTxt.text,@"beforeMealDown",
                             string1, @"beforeMealUp",
                             afterMealDownTxt.text, @"afterMealDown",
                             string2, @"afterMealUp",
                             bedTimeUpTxt.text, @"bedTimeUp",
                             bedTimeDownTxt.text, @"bedTimeDown",
                             bfStartStr, @"breakfastStart",
                             bfEndStr, @"breakfastEnd",
                             lunchStartStr, @"lunchStart",
                             lunchEndStr, @"lunchEnd",
                             dinnerStartStr, @"dinnerStart",
                             dinnerEndStr, @"dinnerEnd", nil];

        [(MainClass *)MainObj Send_BSdata:dic];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_REMIND_NULL delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)setUnitForLbl
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"unit.txt"];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSString *unit = @"";
    if ([content length] == 0) {
        unit = @"mmol/L";
    } else {
        if ([content isEqualToString:@"0"]) {
            unit = @"mmol/L";
        }
        else if ([content isEqualToString:@"1"]) {
            unit = @"mg/dl";
        }
        else{
            unit = @"mg/L";
        }
    }

    lblUnit1.text = unit;
    lblUnit2.text = unit;
}

- (void)showUnit
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"請選擇單位:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:
                            @"mmol/L",
                            @"mg/dl",
                            @"mg/L",
                            nil];
    popup.tag = 1099;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)writeUnitToFile:(NSString*)unit
{
    NSLog(@"%@,writeUnitToFile",self);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSError *error;
    BOOL succeed = [unit writeToFile:[documentsDirectory stringByAppendingPathComponent:@"unit.txt"]
                          atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!succeed){

    }
}


@end
