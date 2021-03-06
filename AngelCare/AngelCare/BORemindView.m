//
//  BORemindView.m
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import "BORemindView.h"
#import "MainClass.h"

@implementation BORemindView

//血氧資訊
-(void)Set_Init:(NSDictionary *)dic
{
    if (dic) {
        lblEn.text = NSLocalizedStringFromTable(@"BORember_TIP_INFO", INFOPLIST, nil);
        Up_limit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uplimit"]];
        Down_limit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"downlimit"]];
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                               nil];
        [numberToolbar sizeToFit];
        
//        Up_limit.inputAccessoryView = numberToolbar;
//        Down_limit.inputAccessoryView = numberToolbar;
        remindLbl.text = NSLocalizedStringFromTable(@"HS_BORemindTxt", INFOPLIST, nil);
                remindLbl.textColor = [UIColor blackColor];
        boconcentrationLbl.text = NSLocalizedStringFromTable(@"HS_BOCon", INFOPLIST, nil);
                boconcentrationLbl.textColor = [UIColor blackColor];
    }
}

- (IBAction)donwWithTxt:(id)sender
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    
    [Up_limit resignFirstResponder];
    [Down_limit resignFirstResponder];
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
    if (offset > 0) {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)SaveBO
{
    [Up_limit resignFirstResponder];
    [Down_limit resignFirstResponder];

    Up_limit.text = @"100";
    if (![Up_limit.text isEqualToString:@""] && ![Down_limit.text isEqualToString:@""]) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:Up_limit.text,@"uplimit",Down_limit.text,@"downlimit", nil];
        [(MainClass *)MainObj Send_BOdata:dic];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE
                                                            message:ALERT_REMIND_NULL
                                                           delegate:self
                                                  cancelButtonTitle:ALERT_REMIND_OK
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)Do_Init:(id)sender
{
    MainObj = sender;
    Up_limit.delegate = self;
    Down_limit.delegate = self;
    titleLbl.text = NSLocalizedStringFromTable(@"HS_BORange", INFOPLIST, nil);

    backLbl.layer.cornerRadius = 8.0f;
    back2Lbl.layer.cornerRadius = 8.0f;
    [backLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
}

@end
