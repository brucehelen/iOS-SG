//
//  DeviceSet.m
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import "DeviceSet.h"
#import "MainClass.h"

#define BTN_CHECK @"btn_check_on.png"
#define BTN_NOT_CHECK @"btn_check_off.png"
#define HS_Call_Sync NSLocalizedStringFromTable(@"HS_Call_Sync", INFOPLIST, nil)

#import "ViewController.h"

@interface DeviceSet()

@end

@implementation DeviceSet
{
    NSString *syncStr;
    NSString *imei;
    NSString *phone;

    ViewController *vc;
}

@synthesize timezoneArr,langArr;
@synthesize synctimearr;

- (void)Set_Init:(NSDictionary *)dic
{
    self.lblSync.text = NSLocalizedStringFromTable(@"Device_Set_lblSync", INFOPLIST, nil);
    
    [self.btnRS setTitle:NSLocalizedStringFromTable(@"Device_Set_btnRS", INFOPLIST, nil)
                forState:UIControlStateNormal];

    syncImLabel.text = NSLocalizedStringFromTable(@"Device_Set_btnRS", INFOPLIST, nil);

    if (dic) {
        switch1 = [dic objectForKey:@"Switch1"];
        switch2 = [dic objectForKey:@"Switch2"];
        switch3 = [dic objectForKey:@"Switch3"];
        switch4 = [dic objectForKey:@"Switch4"];
        switch5 = [dic objectForKey:@"Switch5"];
        NSString *tmpV = [dic objectForKey:@"voiceMail"];

        if ([[NSString stringWithFormat:@"%@", tmpV] isEqualToString:@"1"]) {
            switch6 = @"on";
        }
        else{
            switch6 = @"off";
        }
        areaStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Area"]];
        langStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Language"]];

        if ([[NSString stringWithFormat:@"%@",areaStr] isEqualToString:@""]) {
            areaStr = @"0";
        }

        if ([[NSString stringWithFormat:@"%@",langStr] isEqualToString:@""]) {
            langStr = @"0";
        }

        for (int i = 0; i < [timezoneArr count]; i++) {
            if ([[[timezoneArr objectAtIndex:i] objectForKey:@"value"] integerValue] == [areaStr integerValue])
            {
                [timeareaBtn setTitle:[NSString stringWithFormat:@"%@",[[timezoneArr objectAtIndex:i] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
            }
        }

        for (int j = 0; j<[langArr count]; j++) {
            if ([[[langArr objectAtIndex:j] objectForKey:@"value"] integerValue] == [langStr integerValue]) {
                [languageBtn setTitle:[NSString stringWithFormat:@"%@",[[langArr objectAtIndex: j] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]]  forState:UIControlStateNormal];
            }
        }

        if ([switch1 isEqualToString:@"on"]) {
            
            [smsReadBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            switch1 = @"off";
            [smsReadBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
        
        if ([switch2 isEqualToString:@"on"]) {
            [sosLongBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            switch2 = @"off";
            [sosLongBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
        
        if ([switch3 isEqualToString:@"on"]) {
            NSLog(@"switch3 On");
            switch3 = @"on";
            [familyBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            NSLog(@"switch3 Off");
            switch3 = @"off";
            [familyBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
        
        if ([switch4 isEqualToString:@"on"]) {
            [dontBotherBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            switch4 = @"off";
            [dontBotherBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
        
        if ([switch5 isEqualToString:@"on"]) {
            [sosSMSBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            
            switch5 = @"off";
            [sosSMSBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
        
        if ([switch6 isEqualToString:@"on"]) {
            [btnVoiceMail setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
        }else
        {
            
            switch6 = @"off";
            [btnVoiceMail setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
        }
    }

    [syncLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
}


//設定開啓或關閉
-(IBAction)changeEnable:(id)sender
{
    NSLog(@"sender tag = %ld",[(UIView*)sender tag]);

    switch ([(UIView*)sender tag]) {
        case 101:
            if ([switch1 isEqualToString:@"on"]) {
                [smsReadBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch1 = @"off";
                NSLog(@"switch1 off %@",switch1);
            }else
            {
                [smsReadBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch1 = @"on";
                NSLog(@"switch1 on %@", switch1);
            }
            break;
        case 102:
            if ([switch2 isEqualToString:@"on"]) {
                [sosLongBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch2 = @"off";
            }else
            {
                [sosLongBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch2 = @"on";
            }
            break;
            
        case 103:
            if ([switch3 isEqualToString:@"on"]) {
                [familyBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch3 = @"off";
            }else
            {
                [familyBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch3 = @"on";
            }
            break;
            
        case 104:
            if ([switch4 isEqualToString:@"on"]) {
                [dontBotherBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch4 = @"off";
            }else
            {
                [dontBotherBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch4 = @"on";
            }
            break;
            
        case 105:
            if ([switch5 isEqualToString:@"on"]) {
                [sosSMSBtn setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch5 = @"off";
            }else
            {
                [sosSMSBtn setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch5 = @"on";
            }
            break;
            
        case 108:
            if ([switch6 isEqualToString:@"on"]) {
                [btnVoiceMail setImage:[UIImage imageNamed:BTN_NOT_CHECK] forState:UIControlStateNormal];
                switch6 = @"off";
            }else
            {
                [btnVoiceMail setImage:[UIImage imageNamed:BTN_CHECK] forState:UIControlStateNormal];
                switch6 = @"on";
            }
            break;
        case 106:
            [self changeTimeZone];
            break;
            
        case 107:
            [self changeLanguage];
            break;
    }
}

- (void)Do_Init:(id)sender
{
    MainObj = sender;
    smsReadLbl.text = NSLocalizedStringFromTable(@"HS_Setting_SMS", INFOPLIST, nil);

    sosLongLbl.text = NSLocalizedStringFromTable(@"HS_Setting_SOSKEYLONGPUSH", INFOPLIST, nil);
    sosLongPressTipLabel.text = NSLocalizedStringFromTable(@"HS_Setting_SOSKEYLONGPUSH_TIP", INFOPLIST, nil);

    familyLbl.text = NSLocalizedStringFromTable(@"HS_Setting_LongFamily", INFOPLIST, nil);
    familyTipLabel.text = NSLocalizedStringFromTable(@"HS_Setting_LongFamily_TIP", INFOPLIST, nil);

    dontBotherLbl.text = NSLocalizedStringFromTable(@"HS_Setting_BROTHER", INFOPLIST, nil);
    dontBotherTipLabel.text = NSLocalizedStringFromTable(@"HS_Setting_BROTHER_TIP", INFOPLIST, nil);

    sosSMSLbl.text = NSLocalizedStringFromTable(@"HS_Setting_SOSSMS", INFOPLIST, nil);
    SosSMSTip.text = NSLocalizedStringFromTable(@"HS_Setting_SOSSMS_TIP", INFOPLIST, nil);

    timeareaLbl.text = NSLocalizedStringFromTable(@"HS_Setting_TimeZone", INFOPLIST, nil);

    languageLbl.text = NSLocalizedStringFromTable(@"HS_Setting_Language", INFOPLIST, nil);

    [smsReadLbl setTextColor:[UIColor blackColor]];
    [sosLongLbl setTextColor:[UIColor blackColor]];
    [familyLbl setTextColor:[UIColor blackColor]];
    [dontBotherLbl setTextColor:[UIColor blackColor]];
    [sosSMSLbl setTextColor:[UIColor blackColor]];
    [timeareaLbl setTextColor:[UIColor blackColor]];
    [languageLbl setTextColor:[UIColor blackColor]];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height + 280;

    [scrView setContentSize:CGSizeMake(320, screenHeight)];

    [syncLbl setText:HS_Call_Sync];
}

- (void)SaveDevSet
{
    NSString *vSwitch = @"";
    if ([switch6 isEqualToString:@"on"]) {
        vSwitch = @"1";
    }
    else{
        vSwitch = @"0";
    }
    NSDictionary *savedic = [[NSDictionary alloc] initWithObjectsAndKeys:switch1,@"value1",switch2,@"value2",switch3,@"value3",switch4,@"value4",switch5,@"value5",areaStr,@"value6",langStr,@"value7",vSwitch,@"voiceMail", nil];
    
    [(MainClass *)MainObj Send_Devicedata:savedic];
}



-(void)sendNext
{
    
    saveNum ++;
    
    NSLog(@"send %i",saveNum);
    NSLog(@"send %@",switch3);
    
    if (saveNum <= 7) {
        
        
        NSString *sendValue;
        
        switch (saveNum) {
            case 2:
                sendValue = switch2;
                break;
            case 3:
                sendValue = switch3;
                break;
                
            case 4:
                sendValue = switch4;
                break;
            case 5:
                sendValue = switch5;
                break;
                
            case 6:
                sendValue = areaStr;
                break;
                
            case 7:
                sendValue = langStr;
                break;
                
            default:
                break;
        }
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:sendValue,@"value",[NSString stringWithFormat:@"%i",saveNum],@"number", nil];
        NSLog(@"send dic %@",dic);
        [(MainClass *)MainObj Send_Devicedata:dic];
        
    }else
    {
        [(MainClass *)MainObj AlertTitleShow:NSLocalizedStringFromTable(@"HS_Setting", INFOPLIST, nil) andMessage:NSLocalizedStringFromTable(@"HS_SAVE_OK", INFOPLIST, nil)];
        [(MainClass *)MainObj Send_DevReload];
    }
}



//改變時區
-(void)changeTimeZone
{
    
    
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:@"Cancel" numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      return [timezoneArr count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      //                      cell.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d", indexPath.section, indexPath.row];
                      
                      cell.textLabel.text = [NSString stringWithFormat:@"%@", [[timezoneArr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]];
                      
                      
                      return cell;
                  }];

    self.alert.height = 350;

    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        [timeareaBtn setTitle:[NSString stringWithFormat:@"%@",[[timezoneArr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
        areaStr = [NSString stringWithFormat:@"%@",[[timezoneArr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
        NSLog(@"area Str = %@",areaStr);
        
    } andCompletionBlock:^{
    }];
    [self.alert show];
}

//改變時區
- (void)changeLanguage
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:@"Cancel"
                                      numberOfRows:^NSInteger (NSInteger section) {
                      return [langArr count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath) {
                                              static NSString *CellIdentifier = @"CellIdentifier";
                                              UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                                              if (cell == nil)
                                                  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                                              cell.textLabel.text = [NSString stringWithFormat:@"%@",[[langArr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]];
                                              return cell;
                                          }];
    self.alert.height = 350;

    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex){
        [languageBtn setTitle:[NSString stringWithFormat:@"%@",[[langArr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];

        langStr = [NSString stringWithFormat:@"%@",[[langArr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
        NSLog(@"Lang Str = %@",langStr);
    } andCompletionBlock:^{
    }];

    [self.alert show];
}

- (void)ChangeTimeZoneTitle:(NSString *)name SelectNumber:(NSString *)number;
{
    NSLog(@"time zone title = %@ %@",name , number);
    [timeareaBtn setTitle:name forState:UIControlStateNormal];
    areaStr = number;
}


- (void)ChangeLanguageTitle:(NSString *)name SelectNumber:(NSString *)number
{
    [languageBtn setTitle:name forState:UIControlStateNormal];
    langStr = number;
}

- (IBAction)timeSelect:(id)sender
{
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) numberOfRows:^NSInteger (NSInteger section)
                  {
                      return [synctimearr count];
                  }
                  andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                          cell.textLabel.text = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] ;

                      return cell;
                  }];

    self.alert.height = 350;

    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         [syncBtn setTitle:[NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
         syncStr = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
             
         
         NSLog(@"syncStr str = %@",syncStr);
         
     } andCompletionBlock:^{

     }];

    [self.alert show];
}

- (IBAction)ibaRemoteSynch:(id)sender
{
    [(MainClass *)MainObj Send_MapUserImei];//get phone data
}

- (void)SetIMEI:(NSString *)getimei
       AndPhone:(NSString *)_phone
{
    imei = getimei;
    phone = _phone;
    UIAlertView *alert;

    if ([phone length] == 0) {
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"NOPHONENUMBER", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles:nil];
        alert.tag = 199;
        [alert show];
    } else {
        alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"MsgSendAlertInfoSync", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles:nil];
        alert.tag = 808;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 808) {
        [self sendMsg];
    }
}

- (void)sendMsg
{
    NSString *verificationText = @"1122";

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

        vc = (ViewController*)[[self nextResponder] nextResponder];
        NSLog(@"%@",[[self nextResponder] nextResponder]);
        [vc presentViewController:controller animated:YES completion:nil];
    }
}

//使用者完成操作時所呼叫的內建函式
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    NSString *alertString;
    UIAlertView *sendAlertView = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    switch (result) {
        case MessageComposeResultSent:
            //訊息傳送成功
            alertString = [(MainClass *)MainObj Get_DefineString:SMS_ALERTMESSAGE_1] ;
            [sendAlertView setTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil)];
            [sendAlertView setMessage:alertString];
            [sendAlertView show];
            break;

        case MessageComposeResultFailed:
            break;

        case MessageComposeResultCancelled:
            break;

        default:
            break;
    }

    //ios7 modify
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)Set_Init_Call:(NSDictionary *)dic
{
    [syncLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];

    syncImLabel.backgroundColor = [ColorHex colorWithHexString:@"3c3c3c"];

    if (dic) {
        NSString *tmpsyncStr = [dic objectForKey:@"value1"];
        for (int i = 0; [synctimearr count] > i; i++) {
            if ([tmpsyncStr integerValue] == [[[[synctimearr objectAtIndex:i] objectForKey:@"id"] objectForKey:@"itemNo"] integerValue])
            {
                [syncBtn setTitle:[[synctimearr objectAtIndex:i] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)] forState:UIControlStateNormal];
                syncStr = [[synctimearr objectAtIndex:i] objectForKey:@"value"];
            }
        }
    }
}

- (void)SaveCall
{
    saveNum = 1;

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:syncStr,@"value",[NSString stringWithFormat:@"%i",saveNum],@"number", nil];
    NSLog(@"send dic %@",dic);
    [(MainClass *)MainObj Send_Calldata:dic];
}

@end
