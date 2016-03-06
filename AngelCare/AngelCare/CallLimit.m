//
//  CallLimit.m
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import "CallLimit.h"
#import "MainClass.h"
#import "ViewController.h"

#define HS_Call_EachMin NSLocalizedStringFromTable(@"HS_Call_EachMin", INFOPLIST, nil)

#define HS_Call_Sync NSLocalizedStringFromTable(@"HS_Call_Sync", INFOPLIST, nil)

#define HS_Call_WatchSync NSLocalizedStringFromTable(@"HS_Call_WatchSync", INFOPLIST, nil)

#define HS_Call_GPS NSLocalizedStringFromTable(@"HS_Call_GPS", INFOPLIST, nil)

#define HS_Call_WatchGpsSync NSLocalizedStringFromTable(@"HS_Call_WatchGpsSync", INFOPLIST, nil)

#define HS_CallLimit NSLocalizedStringFromTable(@"HS_CallLimit", INFOPLIST, nil)

#define HS_Call_SMS NSLocalizedStringFromTable(@"HS_Call_SMS", INFOPLIST, nil)

#define HS_Call_phoneLimit NSLocalizedStringFromTable(@"HS_Call_phoneLimit", INFOPLIST, nil)

#define HS_Call_MonthLimit NSLocalizedStringFromTable(@"HS_Call_MonthLimit", INFOPLIST, nil)

#define HS_Call_Minutes NSLocalizedStringFromTable(@"HS_Call_Minutes", INFOPLIST, nil)

@implementation CallLimit
{
    NSURLConnection *Date_Connect;
    NSMutableData *Date_tempData;
    
    NSString *imei;
    NSString *phone;
    
    ViewController *vc;
}
@synthesize synctimearr,gpstimearr;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)Set_Init:(NSDictionary *)dic
{
    
    [syncLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    [gpsLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    [callLimitLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    [HS_CallLimitLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    
    if (dic) {
        NSLog(@"dic = %@",dic);
        syncStr = [dic objectForKey:@"value1"];
        gpsStr = [dic objectForKey:@"value2"];
        phoneStr = [dic objectForKey:@"value3"];
        callStr = [dic objectForKey:@"value4"];
        

        
        NSLog(@"synctimearr = %@",synctimearr);
        
        for (int i = 0; [synctimearr count] > i; i++)
        {
            if ([syncStr integerValue] == [[[[synctimearr objectAtIndex:i] objectForKey:@"id"] objectForKey:@"itemNo"] integerValue])
            {
                [syncBtn setTitle:[[synctimearr objectAtIndex:i] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)] forState:UIControlStateNormal];
                syncStr = [[synctimearr objectAtIndex:i] objectForKey:@"value"];
            }
            
            
        }
        
        for (int j = 0; [gpstimearr count] > j; j++)
        {
            if ([gpsStr integerValue] == [[[gpstimearr objectAtIndex:j] objectForKey:@"value"] integerValue])
            {
                [gpsBtn setTitle:[[gpstimearr objectAtIndex:j] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)] forState:UIControlStateNormal];
            }
        }
        
        
        
        
        phoneLimitTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"value3"]];
        callLimitTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"value4"]];
        
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithphoneLimitTxt)],
                               nil];
        [numberToolbar sizeToFit];
        
        UIToolbar* numberToolbar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar2.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar2.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithcallLimitTxt)],
                               nil];
        [numberToolbar2 sizeToFit];
        
        
//        phoneLimitTxt.inputAccessoryView = numberToolbar;
//        callLimitTxt.inputAccessoryView = numberToolbar2;
    }
}


-(void)doneWithphoneLimitTxt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [phoneLimitTxt resignFirstResponder];
}

-(void)doneWithcallLimitTxt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [callLimitTxt resignFirstResponder];
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
    phoneLimitTxt.delegate = self;
    callLimitTxt.delegate = self;
    syncLbl.text = HS_Call_Sync;
    syncStrLbl.text = HS_Call_WatchSync;
    gpsLbl.text = HS_Call_GPS;
    gpsStrLbl.text = HS_Call_WatchGpsSync;
    HS_CallLimitLbl.text = HS_CallLimit;
    phoneStrLbl.text = HS_Call_SMS;
    callLimitLbl.text = HS_Call_phoneLimit;
    callStrLbl.text  = HS_Call_MonthLimit;
    minuteLbl.text = HS_Call_Minutes;
    minute2Lbl.text = HS_Call_Minutes;
}



//同步時間
-(NSString *)syncValueReturn:(int)value
{
    //    0 = 取消定時回報
    //    1 = 每小時一次
    //    2 = 每2小時一次
    //    3 = 每3小時一次
    //    4 = 每4小時一次
    //    5 = 每6小時一次
    //    6 = 每12小時一次
    //    7 = 每半小時一次
    //    8 = 每20分鐘一次
    //    9 = 每15分鐘一次
    //    10 = 每12分鐘一次
    //    11 = 每10分鐘一次
    //    12 = 每6分鐘一次
    NSString *valueStr;
    
    switch (value) {
        case 0:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_0", INFOPLIST, nil);
            break;
            
        case 1:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_1", INFOPLIST, nil);
            break;
            
        case 2:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_2", INFOPLIST, nil);
            break;
            
            
        case 3:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_3", INFOPLIST, nil);
            break;
            
            
        case 4:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_4", INFOPLIST, nil);
            break;
            
            
        case 5:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_5", INFOPLIST, nil);
            break;
            
            
        case 6:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_6", INFOPLIST, nil);
            break;
            
            
        case 7:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_7", INFOPLIST, nil);
            break;
            
            
        case 8:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_8", INFOPLIST, nil);
            break;
            
        case 9:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_9", INFOPLIST, nil);
            break;
            
            
        case 10:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_10", INFOPLIST, nil);
            break;
            
            
        case 11:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_11", INFOPLIST, nil);
            break;
            
            
        case 12:
            valueStr = NSLocalizedStringFromTable(@"HS_Call_Sync_12", INFOPLIST, nil);
            break;
    }
    return valueStr;
}

//取得所有的Type
-(NSArray *)getSync
{
    NSString *sync0 = NSLocalizedStringFromTable(@"HS_Call_Sync_0", INFOPLIST, nil);
    
    NSString *sync1 = NSLocalizedStringFromTable(@"HS_Call_Sync_1", INFOPLIST, nil);
    
    NSString *sync2 = NSLocalizedStringFromTable(@"HS_Call_Sync_2", INFOPLIST, nil);
    
    NSString *sync3 = NSLocalizedStringFromTable(@"HS_Call_Sync_3", INFOPLIST, nil);
    
    NSString *sync4 = NSLocalizedStringFromTable(@"HS_Call_Sync_4", INFOPLIST, nil);
    
    NSString *sync5 = NSLocalizedStringFromTable(@"HS_Call_Sync_5", INFOPLIST, nil);
    
    NSString *sync6 = NSLocalizedStringFromTable(@"HS_Call_Sync_6", INFOPLIST, nil);
    
    NSString *sync7 = NSLocalizedStringFromTable(@"HS_Call_Sync_7", INFOPLIST, nil);
    
    NSString *sync8 = NSLocalizedStringFromTable(@"HS_Call_Sync_8", INFOPLIST, nil);
    
    NSString *sync9 = NSLocalizedStringFromTable(@"HS_Call_Sync_9", INFOPLIST, nil);
    
    NSString *sync10 = NSLocalizedStringFromTable(@"HS_Call_Sync_10", INFOPLIST, nil);
    
    NSString *sync11 = NSLocalizedStringFromTable(@"HS_Call_Sync_11", INFOPLIST, nil);
    
    NSString *sync12 = NSLocalizedStringFromTable(@"HS_Call_Sync_12", INFOPLIST, nil);
    
    NSArray *syncArr = [[NSArray alloc]initWithObjects:sync0,sync1,sync2,sync3,sync4,sync5,sync6,sync7,sync8,sync9,sync10,sync11,sync12, nil];
    
    return syncArr;
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






-(void)SaveCall
{
    saveNum = 1;
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:syncStr,@"value",[NSString stringWithFormat:@"%i",saveNum],@"number", nil];
    NSLog(@"send dic %@",dic);
    [(MainClass *)MainObj Send_Calldata:dic];
    
}

-(void)sendNext
{
    
    saveNum ++;
    
    NSLog(@"send %i",saveNum);
    
    if (saveNum <= 4) {
        
    
    NSString *sendValue;
    
    switch (saveNum) {
        case 2:
            sendValue = gpsStr;
            break;
        case 3:
            sendValue = phoneLimitTxt.text;
            break;
            
        case 4:
            sendValue = callLimitTxt.text;
            break;
            
        default:
            break;
    }
    
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:sendValue,@"value",[NSString stringWithFormat:@"%i",saveNum],@"number", nil];
    NSLog(@"send dic %@",dic);
        [(MainClass *)MainObj Send_Calldata:dic];
    
    }else
    {
        
        [(MainClass *)MainObj AlertTitleShow:NSLocalizedStringFromTable(@"HS_CALL", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        
        [(MainClass *)MainObj Send_CallReload];
    }
}


-(IBAction)timeSelect:(id)sender
{
    
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      if ([(UIView*)sender tag] == 101)
                      {
                          return [synctimearr count];
                      }else
                      {
                          return [gpstimearr count];
                      }
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      //                      cell.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d", indexPath.section, indexPath.row];
                      
                      if ([(UIView*)sender tag] == 101) {
                          cell.textLabel.text = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] ;
                      }else
                      {
                          cell.textLabel.text = [NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] ;
                      }
                      
                      
                                             
                      
//                      cell.textLabel.text = [NSString stringWithFormat:@"%@",[syncType objectAtIndex:indexPath.row]] ;
                      
                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 350;
    
    // configure actions to perform
    
    
    
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
    {
        //		self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
        
        
        if ([(UIView*)sender tag] == 101) {
            
            [syncBtn setTitle:[NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
            syncStr = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
            
        }else
        {
            
            [gpsBtn setTitle:[NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
            gpsStr = [NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
        }
        
        NSLog(@"gps str = %@",gpsStr);
        NSLog(@"syncStr str = %@",syncStr);
        
    } andCompletionBlock:^{
        //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
        
    }];
    
    [self.alert show];

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index %i",buttonIndex);
    if (buttonIndex == 0) {
        //確定
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH"];
        NSString *hourString = [dateFormatter stringFromDate:picker.date];
        
        [dateFormatter setDateFormat:@"mm"];
        NSString *minuteString = [dateFormatter stringFromDate:picker.date];
        
        if ([(UIView*)selectBtn tag] == 101) {
            syncStr = [NSString stringWithFormat:@"%i",[hourString integerValue]*60 + [minuteString integerValue]];
            [syncBtn setTitle:[NSString stringWithFormat:@"每%@分鐘",syncStr] forState:UIControlStateNormal];
            
        }else
        {
            gpsStr = [NSString stringWithFormat:@"%i",[hourString integerValue]*60 + [minuteString integerValue]];
            [gpsBtn setTitle:[NSString stringWithFormat:@"每%@分鐘",gpsStr] forState:UIControlStateNormal];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)ibaRemoteSynch:(id)sender {
    //
    [(MainClass *)MainObj Send_MapUserImei];//get phone data
}

- (void)sendMsg{
    //-----
    NSString *verificationText = @"1122";
    
    //-----
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    //判斷裝置是否在可傳送訊息的狀態
    if([MFMessageComposeViewController canSendText]) {
        
        NSString *smsbody = [NSString stringWithFormat:@"#sYc#%@#%@#",imei,verificationText];
        //設定SMS訊息內容
        controller.body = smsbody;
        
        //設定接傳送對象的號碼
        controller.recipients = [NSArray arrayWithObjects:phone,nil];
        
        //設定代理
        controller.messageComposeDelegate = self;
        
        //開啟SMS訊息
        //            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentModalViewController:controller animated:YES];
        
        vc = (ViewController*)[[self nextResponder] nextResponder];
        NSLog(@"%@",[[self nextResponder] nextResponder]);
        [vc presentViewController:controller animated:YES completion:nil];
    }
}

-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone
{
    imei = getimei;
    phone = _phone;
    UIAlertView *alert;
    if ([phone length] == 0) {
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"NOPHONENUMBER", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles:nil];
        alert.tag = 199;
        [alert show];
    }
    else{
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"MsgSendAlertInfoSync", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"OK") otherButtonTitles:nil];
        alert.tag = 808;
        [alert show];
    }
    
    
}
//使用者完成操作時所呼叫的內建函式
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSString *alertString;
    UIAlertView *sendAlertView = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    switch (result) {
        case MessageComposeResultSent:
            //訊息傳送成功
            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            [sendAlertView setTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)];
            [sendAlertView setMessage:alertString];
            [sendAlertView show];
//            privacyView.hidden = YES;
            break;
            
        case MessageComposeResultFailed:
            //訊息傳送失敗
            //            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            break;
            
        case MessageComposeResultCancelled:
            //訊息被使用者取消傳送
            //            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            
            break;
            
        default:
            break;
    }
    //ios7 modify
    [vc dismissViewControllerAnimated:YES completion:nil];
    //    [vc dismissModalViewControllerAnimated:YES];
    
    //    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] dismissModalViewControllerAnimated:YES];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 808) {
        [self sendMsg];
    }

}

@end
