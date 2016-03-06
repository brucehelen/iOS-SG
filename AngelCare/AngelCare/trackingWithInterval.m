//
//  trackingWithInterval.m
//  mCareWatch
//
//  Created by Roger on 2014/5/28.
//
//

#import "trackingWithInterval.h"
#import "define.h"
#import "MainClass.h"
#import "KMCommonClass.h"

@implementation trackingWithInterval
{
    UIDatePicker *datePicker;
    NSString *gpsStr;
    NSString *syncStr;
    NSString *startStr;
    NSString *endStr;
    NSString *startGStr;
    NSString *endGStr;
    NSString *onStr;
    NSString *gpsV;
    NSString *wifiV;
    
    NSString *w7;
    NSString *w1;
    NSString *w2;
    NSString *w3;
    NSString *w4;
    NSString *w5;
    NSString *w6;
    
    NSString *gw7;
    NSString *gw1;
    NSString *gw2;
    NSString *gw3;
    NSString *gw4;
    NSString *gw5;
    NSString *gw6;

    NSString *gpsOn;
    NSString *wifiOn;
}

@synthesize synctimearr,gpstimearr;


- (void)do_initWithDict:(NSDictionary*)dict andSender:(id)sender
{
    MainObj = sender;
    gpsStr = @"";
    syncStr = @"";
    startStr = @"";
    endStr = @"";
    startGStr = @"";
    endGStr = @"";
    onStr = @"";
    w1 = @"NO";
    w2 = @"NO";
    w3 = @"NO";
    w4 = @"NO";
    w5 = @"NO";
    w6 = @"NO";
    w7 = @"NO";
    gw1 = @"NO";
    gw2 = @"NO";
    gw3 = @"NO";
    gw4 = @"NO";
    gw5 = @"NO";
    gw6 = @"NO";
    gw7 = @"NO";
    
    gpsOn = @"";
    wifiOn = @"";
    
    _lblGStart.text = NSLocalizedStringFromTable(@"C_StartTime", INFOPLIST, nil);
    _lblGEnd.text = NSLocalizedStringFromTable(@"C_EndTime", INFOPLIST, nil);
    
    _lblWStart.text = NSLocalizedStringFromTable(@"C_StartTime", INFOPLIST, nil);
    _lblWEnd.text = NSLocalizedStringFromTable(@"C_EndTime", INFOPLIST, nil);

    syncStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wifiV"]];
    wifiV = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wifiV"]];
    startStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wifiS"]];
    endStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wifiE"]];
    gpsStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gpsV"]];
    gpsV = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gpsV"]];
    startGStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gpsS"]];
    endGStr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gpsE"]];

    wifiOn = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wifiO"]];
    gpsOn = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gpsO"]];

    [_switchGPS setOnTintColor:[UIColor orangeColor]];
    [_switchGPS setTintColor:[UIColor orangeColor]];
    [_switchWifi setOnTintColor:[UIColor orangeColor]];
    [_switchWifi setTintColor:[UIColor orangeColor]];

    if ([wifiOn isEqualToString:@"1"]) {
        [_switchWifi setOn:YES];
    }
    else{
        [_switchWifi setOn:NO];
    }
    if ([gpsOn isEqualToString:@"1"]) {
        [_switchGPS setOn:YES];
    }
    else{
        [_switchGPS setOn:NO];
    }

    for (int i = 0; i < synctimearr.count; i++) {
        NSDictionary *dict = [synctimearr objectAtIndex:i];
        NSString *keyV = @"value";
        NSString *val = [NSString stringWithFormat:@"%@",[dict objectForKey:keyV]];
        if ([val isEqualToString:syncStr]) {
            syncStr = [dict objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)];
            break;
        }
    }

    for (int i = 0; i < gpstimearr.count; i++) {
        NSDictionary *dict = [gpstimearr objectAtIndex:i];
        NSString *keyV = @"value";
        NSString *val = [NSString stringWithFormat:@"%@",[dict objectForKey:keyV]];
        switch ([gpsStr integerValue]) {
            case 0:
                gpsStr = @"0";
                break;
            case 10:
                gpsStr = @"1";
                break;
            case 15:
                gpsStr = @"2";
                break;
            case 20:
                gpsStr = @"3";
                break;
            case 5:
                gpsStr = @"4";
                break;
            case 30:
                gpsStr = @"5";
                break;
                
            default:
                break;
        }
        if ([val isEqualToString:gpsStr]) {
            gpsStr = [dict objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)];
            break;
        }
    }

    //處理週期
    NSString *wifiW = [dict objectForKey:@"wifiW"];
    NSString *gpsW = [dict objectForKey:@"gpsW"];
    [self handleWeekWithWifi:wifiW andGPS:gpsW];
    [_btnSync setTitle:syncStr forState:UIControlStateNormal];
    [_btnStartTime setTitle:startStr forState:UIControlStateNormal];
    [_btnEndTime setTitle:endStr forState:UIControlStateNormal];
    [_btnGPSf setTitle:gpsStr forState:UIControlStateNormal];
    [_btnStartG setTitle:startGStr forState:UIControlStateNormal];
    [_btnEndG setTitle:endGStr forState:UIControlStateNormal];
    [_btnOpenWhich setTitle:onStr forState:UIControlStateNormal];
    [self setBtnImage:_btnW1 withStatus:w1 withWeek:@"1"];
    [self setBtnImage:_btnW2 withStatus:w2 withWeek:@"2"];
    [self setBtnImage:_btnW3 withStatus:w3 withWeek:@"3"];
    [self setBtnImage:_btnW4 withStatus:w4 withWeek:@"4"];
    [self setBtnImage:_btnW5 withStatus:w5 withWeek:@"5"];
    [self setBtnImage:_btnW6 withStatus:w6 withWeek:@"6"];
    [self setBtnImage:_btnW7 withStatus:w7 withWeek:@"7"];
    [self setBtnImage:_btnGW1 withStatus:gw1 withWeek:@"1"];
    [self setBtnImage:_btnGW2 withStatus:gw2 withWeek:@"2"];
    [self setBtnImage:_btnGW3 withStatus:gw3 withWeek:@"3"];
    [self setBtnImage:_btnGW4 withStatus:gw4 withWeek:@"4"];
    [self setBtnImage:_btnGW5 withStatus:gw5 withWeek:@"5"];
    [self setBtnImage:_btnGW6 withStatus:gw6 withWeek:@"6"];
    [self setBtnImage:_btnGW7 withStatus:gw7 withWeek:@"7"];
    [self doCornerRadius:_btnEndG];
    [self doCornerRadius:_btnEndTime];
    [self doCornerRadius:_btnGPSf];
    [self doCornerRadius:_btnOpenWhich];
    [self doCornerRadius:_btnStartG];
    [self doCornerRadius:_btnStartTime];
    [self doCornerRadius:_btnSync];
    [self doCornerRadiusView:_gpsView];
    [self doCornerRadiusView:_wifiView];
}

- (void)doCornerRadius:(UIButton*)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:8.0]; //设置矩圆角半径
}

- (void)doCornerRadiusView:(UIView*)v
{
    [v.layer setMasksToBounds:YES];
    [v.layer setCornerRadius:8.0]; //设置矩圆角半径
}

- (void) handleWeekWithWifi:(NSString*)strW andGPS:(NSString*)strG
{
    for (int i = 0; i < strW.length; i++) {
        NSRange range = NSMakeRange(i,1);
        int tmp = [[strW substringWithRange:range]intValue];
        switch (tmp) {
            case 1:
                w1 = @"YES";
                break;
            case 2:
                w2 = @"YES";
                break;
            case 3:
                w3 = @"YES";
                break;
            case 4:
                w4 = @"YES";
                break;
            case 5:
                w5 = @"YES";
                break;
            case 6:
                w6 = @"YES";
                break;
            case 7:
                w7 = @"YES";
                break;
                
            default:
                break;
        }
    }
    for (int i = 0; i < strG.length; i++) {
        NSRange range = NSMakeRange(i,1);
        int tmp = [[strG substringWithRange:range]intValue];
        switch (tmp) {
            case 1:
                gw1 = @"YES";
                break;
            case 2:
                gw2 = @"YES";
                break;
            case 3:
                gw3 = @"YES";
                break;
            case 4:
                gw4 = @"YES";
                break;
            case 5:
                gw5 = @"YES";
                break;
            case 6:
                gw6 = @"YES";
                break;
            case 7:
                gw7 = @"YES";
                break;
                
            default:
                break;
        }
    }
}

- (void)setBtnImage:(UIButton*)btn
         withStatus:(NSString*)status
           withWeek:(NSString*)idxW
{
    int w = [idxW intValue];

    if ([KMCommonClass currentLanguageCN]) {
        switch (w) {
            case 1:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_mon_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_mon"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 2:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_tue_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_tue"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 3:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_wed_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_wed"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 4:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_thu_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_thu"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 5:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_fri_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_fri"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 6:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_sat_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_sat"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 7:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_sun_01"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_sun"]
                                   forState:UIControlStateNormal];
                }
                break;
            default:
                break;
        }
    } else {
        switch (w) {
            case 1:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_mm"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_m1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 2:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_t"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_t1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 3:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_w"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_w1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 4:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_t"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_t1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 5:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_f"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_f1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 6:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_s"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_s1"]
                                   forState:UIControlStateNormal];
                }
                break;
            case 7:
                if ([status isEqualToString:@"YES"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_s"]
                                   forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"icon_week_s1"]
                                   forState:UIControlStateNormal];
                }
                break;
            default:
                break;
        }

    }
    
}

- (IBAction)ibaSyncAndGpsf:(id)sender {
    NSArray *tmpTimes = @[@"0",@"5",@"10",@"15",@"20",@"30"];
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      if ([(UIView*)sender tag] == 201)
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
                      
                      if ([(UIView*)sender tag] == 201) {
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
         
         
         if ([(UIView*)sender tag] == 201) {
             
             [_btnSync setTitle:[NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
             syncStr = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
             wifiV = syncStr;
             
         }else
         {
             
             [_btnGPSf setTitle:[NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
             gpsStr = [NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
             gpsV = [tmpTimes objectAtIndex:selectedIndex.row];
         }
         
         NSLog(@"gps str = %@",gpsStr);
         NSLog(@"syncStr str = %@",syncStr);
         
     } andCompletionBlock:^{
         //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
         
     }];
    
    [self.alert show];
}

- (IBAction)ibaSwitchChange:(id)sender {
    switch ([(UIView*)sender tag]) {
        case 101://wifi
            if (_switchWifi.on) {
                [_switchGPS setOn:NO animated:YES];
                gpsOn = @"0";
                wifiOn = @"1";
            }
            else{
                wifiOn = @"0";
            }
            break;
        case 102://gps
            if (_switchGPS.on) {
                [_switchWifi setOn:NO animated:YES];
                gpsOn = @"1";
                wifiOn = @"0";
            }
            else{
                gpsOn = @"0";
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)ibaSelectTime:(id)sender {
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    }
    else {
        // use UIAlertView
        [self addActionSheetInView:sender];
    }
}
- (void)useAlerController:(id)sender{
    // use UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
   {
       NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
       [pickdate setDateFormat:@"HH:mm"];
       
       NSLog(@"pick = %@",[pickdate stringFromDate:[datePicker date]]);
       switch ([(UIView*)sender tag]) {
           case 101:
               startStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnStartTime setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
           case 102:
               endStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnEndTime setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
           case 301:
               startGStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnStartG setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
           case 302:
               endGStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnEndG setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
               
           default:
               break;
       }
       
   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    [self setDatePicker];
    
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    
    UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}

- (void)addActionSheetInView:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil)
                                                       delegate:self
                                              cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) , nil];
    sheet.tag = [(UIView*)sender tag];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, 300, 300)];

    datePicker.datePickerMode = UIDatePickerModeTime;
    NSLog(@"start %@",[[(UIButton*)sender titleLabel] text]);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    [sheet addSubview:datePicker];

    [sheet showInView:self];
}

- (void)setDatePicker
{
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, 300, 300)];
    //    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    datePicker.datePickerMode = UIDatePickerModeTime;
    //    datePicker.maximumDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
        [pickdate setDateFormat:@"HH:mm"];
        
        NSLog(@"pick = %@",[pickdate stringFromDate:[datePicker date]]);
        switch ([actionSheet tag]) {
            case 101:
                startStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnStartTime setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
            case 102:
                endStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnEndTime setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
            case 301:
                startGStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnStartG setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
            case 302:
                endGStr = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnEndG setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
    }
    NSLog(@"action sheet index %i",buttonIndex);
}

- (IBAction)ibaOpenWhich:(id)sender {
    NSArray *tmpA = @[@"GPS",@"Wifi",@"None"];
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
//                      if ([(UIView*)sender tag] == 201)
//                      {
//                          return [synctimearr count];
//                      }else
//                      {
//                          return [gpstimearr count];
//                      }
                      return [tmpA count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      //                      cell.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d", indexPath.section, indexPath.row];
                    
//                      if ([(UIView*)sender tag] == 201) {
//                          cell.textLabel.text = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] ;
//                      }else
//                      {
//                          cell.textLabel.text = [NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:indexPath.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] ;
//                      }
                      cell.textLabel.text = [NSString stringWithFormat:@"%@",[tmpA objectAtIndex:indexPath.row]];
                      //                      cell.textLabel.text = [NSString stringWithFormat:@"%@",[syncType objectAtIndex:indexPath.row]] ;
                      
                      
                      return cell;
                  }];
    // Setting custom alert height
    self.alert.height = 0;
    // configure actions to perform
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         //		self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
         
         
//         if ([(UIView*)sender tag] == 201) {
//             
//             [_btnSync setTitle:[NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
//             syncStr = [NSString stringWithFormat:@"%@",[[synctimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
//             
//         }else
//         {
//             
//             [_btnGPSf setTitle:[NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:NSLocalizedStringFromTable(@"SystemLanguage", INFOPLIST, nil)]] forState:UIControlStateNormal];
//             gpsStr = [NSString stringWithFormat:@"%@",[[gpstimearr objectAtIndex:selectedIndex.row] objectForKey:@"value"]];
//         }
         [_btnOpenWhich setTitle:[NSString stringWithFormat:@"%@",[tmpA objectAtIndex:selectedIndex.row]]forState:UIControlStateNormal];
         onStr = [tmpA objectAtIndex:selectedIndex.row];
         NSLog(@"on str = %@",onStr);

         
         
     } andCompletionBlock:^{
         //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
         
     }];
    
    [self.alert show];
}


-(void)SaveSetting
{
//    NSString *gpsOn = @"";
//    NSString *wifiOn = @"";
//    if ([onStr isEqualToString:@"GPS"]) {
//        gpsOn = @"1";
//        wifiOn = @"0";
//    }
//    else if([onStr isEqualToString:@"None"]){
//        gpsOn = @"0";
//        wifiOn = @"0";
//    }
//    else{
//        gpsOn = @"0";
//        wifiOn = @"1";
//    }
    NSLog(@"gps %@",gpsStr);
    NSLog(@"startG %@",startGStr);
    NSLog(@"endG %@",endGStr);
    NSLog(@"Wifi %@",syncStr);
    NSLog(@"start %@",startStr);
    NSLog(@"end %@",endGStr);
    NSLog(@"gpsOn %@",gpsOn);
    NSLog(@"wifiOn %@",wifiOn);
    NSLog(@"w7 %@",w7);
    NSLog(@"w1 %@",w1);
    NSLog(@"w2 %@",w2);
    NSLog(@"w3 %@",w3);
    NSLog(@"w4 %@",w4);
    NSLog(@"w5 %@",w5);
    NSLog(@"w6 %@",w6);
    NSLog(@"gw7 %@",gw7);
    NSLog(@"gw1 %@",gw1);
    NSLog(@"gw2 %@",gw2);
    NSLog(@"gw3 %@",gw3);
    NSLog(@"gw4 %@",gw4);
    NSLog(@"gw5 %@",gw5);
    NSLog(@"gw6 %@",gw6);




    NSDictionary *dict = @{@"gpsV": gpsV,
                           @"startG": startGStr,
                           @"endG": endGStr,
                           @"wifiV": wifiV,
                           @"start": startStr,
                           @"end": endStr,
                           @"gpsOn": gpsOn,
                           @"wifiOn": wifiOn,
                           @"w7": w7,
                           @"w1": w1,
                           @"w2": w2,
                           @"w3": w3,
                           @"w4": w4,
                           @"w5": w5,
                           @"w6": w6,
                           @"gw7": gw7,
                           @"gw1": gw1,
                           @"gw2": gw2,
                           @"gw3": gw3,
                           @"gw4": gw4,
                           @"gw5": gw5,
                           @"gw6": gw6};
    
    NSLog(@"dict %@",dict);
//    NSDictionary *savedic = [[NSDictionary alloc] initWithObjectsAndKeys:switch1,@"value1",switch2,@"value2",switch3,@"value3",switch4,@"value4",switch5,@"value5",areaStr,@"value6",langStr,@"value7", nil];
    
    [(MainClass *)MainObj Save_TWISetting:dict];
}

- (IBAction)ibaPressWhichW:(UIButton *)sender
{
    switch ([(UIView*)sender tag]) {
        case 601:
            if ([w1 isEqualToString:@"YES"]) {
                w1 = @"NO";
            } else {
                w1 = @"YES";
            }
            [self setBtnImage:_btnW1
                   withStatus:w1
                     withWeek:@"1"];
            break;
        case 602:
            if ([w2 isEqualToString:@"YES"]) {
                w2 = @"NO";
            } else {
                w2 = @"YES";
            }
            [self setBtnImage:_btnW2
                   withStatus:w2
                     withWeek:@"2"];
            break;
        case 603:
            if ([w3 isEqualToString:@"YES"]) {
                w3 = @"NO";
            } else {
                w3 = @"YES";
            }
            [self setBtnImage:_btnW3
                   withStatus:w3
                     withWeek:@"3"];
            break;
        case 604:
            if ([w4 isEqualToString:@"YES"]) {
                w4 = @"NO";
            } else {
                w4 = @"YES";
            }
            [self setBtnImage:_btnW4
                   withStatus:w4
                     withWeek:@"4"];
            break;
        case 605:
            if ([w5 isEqualToString:@"YES"]) {
                w5 = @"NO";
            } else {
                w5 = @"YES";
            }
            [self setBtnImage:_btnW5
                   withStatus:w5
                     withWeek:@"5"];
            break;
        case 606:
            if ([w6 isEqualToString:@"YES"]) {
                w6 = @"NO";
            } else {
                w6 = @"YES";
            }
            [self setBtnImage:_btnW6
                   withStatus:w6
                     withWeek:@"6"];
            break;
        case 607:
            if ([w7 isEqualToString:@"YES"]) {
                w7 = @"NO";
            } else {
                w7 = @"YES";
            }
            [self setBtnImage:_btnW7
                   withStatus:w7
                     withWeek:@"7"];
            break;
        case 701:
            if ([gw1 isEqualToString:@"YES"]) {
                gw1 = @"NO";
            } else {
                gw1 = @"YES";
            }
            [self setBtnImage:_btnGW1
                   withStatus:gw1
                     withWeek:@"1"];
            break;
        case 702:
            if ([gw2 isEqualToString:@"YES"]) {
                gw2 = @"NO";
            } else {
                gw2 = @"YES";
            }
            [self setBtnImage:_btnGW2
                   withStatus:gw2
                     withWeek:@"2"];
            break;
        case 703:
            if ([gw3 isEqualToString:@"YES"]) {
                gw3 = @"NO";
            } else {
                gw3 = @"YES";
            }
            [self setBtnImage:_btnGW3
                   withStatus:gw3
                     withWeek:@"3"];
            break;
        case 704:
            if ([gw4 isEqualToString:@"YES"]) {
                gw4 = @"NO";
            } else {
                gw4 = @"YES";
            }
            [self setBtnImage:_btnGW4
                   withStatus:gw4
                     withWeek:@"4"];
            break;
        case 705:
            if ([gw5 isEqualToString:@"YES"]) {
                gw5 = @"NO";
            } else {
                gw5 = @"YES";
            }
            [self setBtnImage:_btnGW5
                   withStatus:gw5
                     withWeek:@"5"];
            break;
        case 706:
            if ([gw6 isEqualToString:@"YES"]) {
                gw6 = @"NO";
            } else {
                gw6 = @"YES";
            }
            [self setBtnImage:_btnGW6
                   withStatus:gw6
                     withWeek:@"6"];
            break;
        case 707:
            if ([gw7 isEqualToString:@"YES"]) {
                gw7 = @"NO";
            } else {
                gw7 = @"YES";
            }
            [self setBtnImage:_btnGW7
                   withStatus:gw7
                     withWeek:@"7"];
            break;
        default:
            break;
    }
}


@end
