//
//  ActivityAlert.m
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import "ActivityAlert.h"
#import "define.h"
#import "MainClass.h"
@implementation ActivityAlert
{
    UIDatePicker *datePicker;
    NSString *strStart;
    NSString *strEnd;
    NSString *strOpen;
    id  MainObj;
    
    NSString *gw7;
    NSString *gw1;
    NSString *gw2;
    NSString *gw3;
    NSString *gw4;
    NSString *gw5;
    NSString *gw6;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)ibaStart:(id)sender {
}

- (IBAction)ibaEnd:(id)sender {
}

- (IBAction)ibaOpen:(id)sender {
    NSArray *tmpA = @[@"Off",@"On"];
    self.alert = [MLTableAlert tableAlertWithTitle:@"" cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      //                      if ([sender tag] == 201)
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
                      
                      //                      if ([sender tag] == 201) {
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
         
         
         //         if ([sender tag] == 201) {
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
         [_btnOn setTitle:[NSString stringWithFormat:@"%@",[tmpA objectAtIndex:selectedIndex.row]]forState:UIControlStateNormal];
         strOpen = [tmpA objectAtIndex:selectedIndex.row];
         if (selectedIndex.row == 0) {
             strOpen = [NSString stringWithFormat:@"0"];
         }
         else{
             strOpen = [NSString stringWithFormat:@"1"];
         }
         NSLog(@"on str = %@",strOpen);
         
         
         
     } andCompletionBlock:^{
         //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
         
     }];
    
    [self.alert show];
}

- (IBAction)ibaSelectTime:(id)sender {
    if ([UIAlertController class]) {
        [self useAlertViewcontroller:sender];
    }
    else {
        // use UIAlertView
        [self useActionSheet:sender];
    }

}
- (void)useAlertViewcontroller:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
   {
       ////todo
       NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
       [pickdate setDateFormat:@"HH:mm"];
       NSLog(@"pick = %@",[pickdate stringFromDate:[datePicker date]]);
       switch ([(UIView*)sender tag]) {
           case 101:
               strStart = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnStart setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
           case 102:
               strEnd = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
               [_btnEnd setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
               break;
               
               
           default:
               break;
       }
   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {
       
    }];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    //    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[[[self nextResponder]nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];

}
- (void)useActionSheet:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) delegate:self cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) , nil];
    sheet.tag = [(UIView*)sender tag];
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    //    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    datePicker.datePickerMode = UIDatePickerModeTime;
    //    datePicker.maximumDate = [NSDate date];
    
    NSLog(@"start %@",[[(UIButton*)sender titleLabel] text]);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    [sheet addSubview:datePicker];
    
    [sheet showInView:self];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
        [pickdate setDateFormat:@"HH:mm"];
        
        NSLog(@"pick = %@",[pickdate stringFromDate:[datePicker date]]);
        switch ([actionSheet tag]) {
            case 101:
                strStart = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnStart setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
            case 102:
                strEnd = [NSString stringWithFormat:@"%@:00",[pickdate stringFromDate:[datePicker date]]];
                [_btnEnd setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                break;
            
                
            default:
                break;
        }
        
    }
    NSLog(@"action sheet index %i",buttonIndex);
}
- (IBAction)ibaOpenWhich:(id)sender {
    
}
- (void)do_initWithDict:(NSDictionary*)dict andSender:(id)sender{
    [_lblTitle setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    _lblTitle.layer.cornerRadius = 8.0f;
    MainObj = sender;
    strStart = @"";
    strEnd = @"";
    strOpen = @"";
    gw1 = @"NO";
    gw2 = @"NO";
    gw3 = @"NO";
    gw4 = @"NO";
    gw5 = @"NO";
    gw6 = @"NO";
    gw7 = @"NO";
    
//    NSDictionary *dict = @{
//                           @"S": gpsStart,
//                           @"E": gpsEnd,
//                           @"O": gpsOn,
//                           @"W": gpsW};
    strStart = [dict objectForKey:@"S"];
    strEnd = [dict objectForKey:@"E"];
    strOpen = [NSString stringWithFormat:@"%@",[dict objectForKey:@"O"]];
    
    NSString *gpsW = [dict objectForKey:@"W"];
    [self handleWeekWithGPS:gpsW];
    
    [self setBtnImage:_btnGW1 withStatus:gw1 withWeek:@"M"];
    [self setBtnImage:_btnGW2 withStatus:gw2 withWeek:@"T"];
    [self setBtnImage:_btnGW3 withStatus:gw3 withWeek:@"W"];
    [self setBtnImage:_btnGW4 withStatus:gw4 withWeek:@"T"];
    [self setBtnImage:_btnGW5 withStatus:gw5 withWeek:@"F"];
    [self setBtnImage:_btnGW6 withStatus:gw6 withWeek:@"S"];
    [self setBtnImage:_btnGW7 withStatus:gw7 withWeek:@"S"];
    
    [_btnEnd setTitle:strEnd forState:UIControlStateNormal];
    [_btnStart setTitle:strStart forState:UIControlStateNormal];
    
    if ([strOpen isEqualToString:@"0"]) {//no
//        [_btnOn setTitle:@"Off" forState:UIControlStateNormal];
        [_switchBtn setOn:NO];
    }
    else{
//        [_btnOn setTitle:@"On" forState:UIControlStateNormal];
        [_switchBtn setOn:YES];
    }
    
    [_switchBtn setOnTintColor:[UIColor orangeColor]];
    [_switchBtn setTintColor:[UIColor orangeColor]];
}


- (IBAction)ibaPressWhichW:(id)sender{
    
    switch ([(UIView*)sender tag]) {
        case 701:
            if ([gw1 isEqualToString:@"YES"]) {
                gw1 = @"NO";
                [_btnGW1 setBackgroundImage:[UIImage imageNamed:@"icon_week_M1"] forState:UIControlStateNormal];
            }
            else{
                gw1 = @"YES";
                [_btnGW1 setBackgroundImage:[UIImage imageNamed:@"icon_week_M"] forState:UIControlStateNormal];
            }
            break;
        case 702:
            if ([gw2 isEqualToString:@"YES"]) {
                gw2 = @"NO";
                [_btnGW2 setBackgroundImage:[UIImage imageNamed:@"icon_week_T1"] forState:UIControlStateNormal];
            }
            else{
                gw2 = @"YES";
                [_btnGW2 setBackgroundImage:[UIImage imageNamed:@"icon_week_T"] forState:UIControlStateNormal];
            }
            break;
        case 703:
            if ([gw3 isEqualToString:@"YES"]) {
                gw3 = @"NO";
                [_btnGW3 setBackgroundImage:[UIImage imageNamed:@"icon_week_W1"] forState:UIControlStateNormal];
            }
            else{
                gw3 = @"YES";
                [_btnGW3 setBackgroundImage:[UIImage imageNamed:@"icon_week_W"] forState:UIControlStateNormal];
            }
            break;
        case 704:
            if ([gw4 isEqualToString:@"YES"]) {
                gw4 = @"NO";
                [_btnGW4 setBackgroundImage:[UIImage imageNamed:@"icon_week_T1"] forState:UIControlStateNormal];
            }
            else{
                gw4 = @"YES";
                [_btnGW4 setBackgroundImage:[UIImage imageNamed:@"icon_week_T"] forState:UIControlStateNormal];
            }
            break;
        case 705:
            if ([gw5 isEqualToString:@"YES"]) {
                gw5 = @"NO";
                [_btnGW5 setBackgroundImage:[UIImage imageNamed:@"icon_week_F1"] forState:UIControlStateNormal];
            }
            else{
                gw5 = @"YES";
                [_btnGW5 setBackgroundImage:[UIImage imageNamed:@"icon_week_F"] forState:UIControlStateNormal];
            }
            break;
        case 706:
            if ([gw6 isEqualToString:@"YES"]) {
                gw6 = @"NO";
                [_btnGW6 setBackgroundImage:[UIImage imageNamed:@"icon_week_S1"] forState:UIControlStateNormal];
            }
            else{
                gw6 = @"YES";
                [_btnGW6 setBackgroundImage:[UIImage imageNamed:@"icon_week_S"] forState:UIControlStateNormal];
            }
            break;
        case 707:
            if ([gw7 isEqualToString:@"YES"]) {
                gw7 = @"NO";
                [_btnGW7 setBackgroundImage:[UIImage imageNamed:@"icon_week_S1"] forState:UIControlStateNormal];
            }
            else{
                gw7 = @"YES";
                [_btnGW7 setBackgroundImage:[UIImage imageNamed:@"icon_week_S"] forState:UIControlStateNormal];
            }
            break;
            
        default:
            break;
    }
}
- (void) setBtnImage:(UIButton*)btn withStatus:(NSString*)status withWeek:(NSString*)idxW{
    NSString *imgName = @"";
    if ([status isEqualToString:@"YES"]) {
        imgName = [NSString stringWithFormat:@"icon_week_%@",idxW];
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    else{
        imgName = [NSString stringWithFormat:@"icon_week_%@1",idxW];
        [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
}
- (void) handleWeekWithGPS:(NSString*)strG{
    
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
-(void)SaveSetting
{
    
    NSLog(@"strOpen %@",strOpen);
    NSLog(@"strStart %@",strStart);
    NSLog(@"strEnd %@",strEnd);
    NSLog(@"gw7 %@",gw7);
    NSLog(@"gw1 %@",gw1);
    NSLog(@"gw2 %@",gw2);
    NSLog(@"gw3 %@",gw3);
    NSLog(@"gw4 %@",gw4);
    NSLog(@"gw5 %@",gw5);
    NSLog(@"gw6 %@",gw6);
    
    
    
    
    NSDictionary *dict = @{@"O": strOpen,
                           @"S": strStart,
                           @"E": strEnd,
                           @"gw7": gw7,
                           @"gw1": gw1,
                           @"gw2": gw2,
                           @"gw3": gw3,
                           @"gw4": gw4,
                           @"gw5": gw5,
                           @"gw6": gw6};
    
    NSLog(@"dict %@",dict);
    //    NSDictionary *savedic = [[NSDictionary alloc] initWithObjectsAndKeys:switch1,@"value1",switch2,@"value2",switch3,@"value3",switch4,@"value4",switch5,@"value5",areaStr,@"value6",langStr,@"value7", nil];
    
    [(MainClass *)MainObj Save_AASetting:dict];
}
- (IBAction)ibaSwitchChange:(id)sender {
    if (_switchBtn.on) {
        strOpen = @"1";
    }
    else{
        strOpen = @"0";
    }
}

@end
