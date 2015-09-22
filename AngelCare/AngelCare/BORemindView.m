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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//血氧資訊
-(void)Set_Init:(NSDictionary *)dic
{
    if (dic)
    {
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if (![language isEqualToString:@"en"]) {// 非英語
            lblCh.hidden = NO;
            lblEn.hidden = YES;
            lblUnit.hidden = YES;
            int tmpX = 23;
            int tmpY = 30;
            [Down_limit setFrame:CGRectMake(86 - tmpX, 107 - tmpY, Down_limit.frame.size.width, Down_limit.frame.size.height)];
            lblCh.text = NSLocalizedStringFromTable(@"BelowWillSendAlarm", INFOPLIST, nil);
                lblCh.textColor = [UIColor blackColor];

        }
        else{
            lblCh.hidden = YES;
            lblEn.hidden = NO;
            lblUnit.hidden = NO;
            lblEn.textColor = [UIColor blackColor];
            lblUnit.textColor = [UIColor blackColor];
            int tmpX = 23;
            int tmpY = 30;
            [Down_limit setFrame:CGRectMake(48 - tmpX, 135 - tmpY, Down_limit.frame.size.width, Down_limit.frame.size.height)];
        }
        Up_limit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uplimit"]];
        Down_limit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"downlimit"]];
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                               nil];
        [numberToolbar sizeToFit];
        
        Up_limit.inputAccessoryView = numberToolbar;
        Down_limit.inputAccessoryView = numberToolbar;
        remindLbl.text = NSLocalizedStringFromTable(@"HS_BORemindTxt", INFOPLIST, nil);
                remindLbl.textColor = [UIColor blackColor];
        boconcentrationLbl.text = NSLocalizedStringFromTable(@"HS_BOCon", INFOPLIST, nil);
                boconcentrationLbl.textColor = [UIColor blackColor];
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
    if(offset > 0)
    {
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

-(void)SaveBO
{
    [Up_limit resignFirstResponder];
    [Down_limit resignFirstResponder];
    //
    Up_limit.text = @"100";
    if (![Up_limit.text isEqualToString:@""] && ![Down_limit.text isEqualToString:@""])
    {
        
//        if ([Up_limit.text integerValue] <= [Down_limit.text integerValue])
//        {
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_BO_Error1 delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
//            
//            [alertView show];
//            
//        }else
//        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:Up_limit.text,@"uplimit",Down_limit.text,@"downlimit", nil];
            
            [(MainClass *)MainObj Send_BOdata:dic];
//        }
        
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_REMIND_NULL delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
        
        [alertView show];
    }
    
    
}


-(void)Do_Init:(id)sender
{
    MainObj = sender;
    Up_limit.delegate = self;
    Down_limit.delegate = self;
    titleLbl.text = NSLocalizedStringFromTable(@"HS_BORange", INFOPLIST, nil);
    
    backLbl.layer.cornerRadius = 8.0f;
    back2Lbl.layer.cornerRadius = 8.0f;
    [backLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
