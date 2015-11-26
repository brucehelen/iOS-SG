//
//  BPRemindView.m
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import "BPRemindView.h"
#import "MainClass.h"

//首先选择Localizable.strings（English）文件，添加如下内容：
//
//"loading" ="Loading...";
//
//然后选择Localizable.strings（Chinese）文件，添加如下内容：
//"loading" ="加载中...";
//
//内容注意一定要以分号结尾，否则无法识别。然后是在代码中使用：
//NSString *loading = NSLocalizedString(@"loading",@"")；

#define DIASTOLIC NSLocalizedStringFromTable(@"DIASTOLIC", INFOPLIST, nil)

#define SYSTOLIC NSLocalizedStringFromTable(@"SYSTOLIC", INFOPLIST, nil)

#define HS_BPRange NSLocalizedStringFromTable(@"HS_BPRange", INFOPLIST, nil)

@implementation BPRemindView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}



// 血压
-(void)Set_Init:(NSDictionary *)dic
{
    NSLog(@"Set_Init dic = %@",dic);


    bpdDownlimit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bpdDownlimit"]];
    bpdUplimit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bpdUplimit"]];

    bpsDownlimit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bpsDownlimit"]];
    bpsUplimit.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bpsUplimit"]];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];

    lblHigherThan.hidden = NO;
    lblHigherThan2.hidden = NO;
    lblSendAlaram2.hidden = NO;
    lblSendAlarm.hidden = NO;
    lblEnTxt1.hidden = YES;
    lblEnTxt2.hidden = YES;
    lblRemind1Content.hidden = YES;
    lblRemind1Title.hidden = YES;
    imgRemind1.hidden = YES;
    viewRemind2.hidden = YES;
    viewRemind3.hidden = YES;

    titleLbl.text = NSLocalizedStringFromTable(@"BPThresholdTitle", INFOPLIST, nil);
    lblHigherThan.text = NSLocalizedStringFromTable(@"HigherThan", INFOPLIST, nil);
    lblHigherThan2.text = NSLocalizedStringFromTable(@"HigherThan", INFOPLIST, nil);
    lblSendAlarm.text = NSLocalizedStringFromTable(@"SendAlarm", INFOPLIST, nil);
    lblSendAlaram2.text = NSLocalizedStringFromTable(@"SendAlarm", INFOPLIST, nil);
    lblRemind1Content.text = NSLocalizedStringFromTable(@"lblRemind1Content", INFOPLIST, nil);
    lblRemind1Title.text = NSLocalizedStringFromTable(@"lblRemind1Title", INFOPLIST, nil);
    lblRemind2Title.text = NSLocalizedStringFromTable(@"lblRemind2Title", INFOPLIST, nil);
    lblRemind3Sup.text = NSLocalizedStringFromTable(@"lblRemind3Sup", INFOPLIST, nil);
    lblRemind3Title.text = NSLocalizedStringFromTable(@"lblRemind3Title", INFOPLIST, nil);
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Return" style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                           nil];
    [numberToolbar sizeToFit];
    bpdDownlimit.inputAccessoryView = numberToolbar;
    bpdUplimit.inputAccessoryView = numberToolbar;
    bpsDownlimit.inputAccessoryView = numberToolbar;
    bpsUplimit.inputAccessoryView = numberToolbar;
}


-(IBAction)donwWithTxt:(id)sender
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    
    [bpdDownlimit resignFirstResponder];
    [bpdUplimit resignFirstResponder];
    [bpsDownlimit resignFirstResponder];
    [bpsUplimit resignFirstResponder];
    
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
    bpdDownlimit.delegate = self;
    bpdUplimit.delegate = self;
    bpsDownlimit.delegate  = self;
    bpsUplimit.delegate = self;
    bgLbl.layer.cornerRadius = 8.0f;
    [bgLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    scrollView.contentSize = CGSizeMake(280, 0);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        scrollView.contentSize = CGSizeMake(768, 1000);
    }
    
//    NSString *loading = NSLocalizedString(@"DIASTOLIC",@"舒张压");
    

    
//    bpsLbl.text = loading;//NSLocalizedStringFromTable(@"DIASTOLIC", INFOPLIST, nil);
    bpsLbl.text = NSLocalizedStringFromTable(@"DIASTOLIC", INFOPLIST, nil);
                    bpsLbl.textColor = [UIColor blackColor];
    bpdLbl.text = NSLocalizedStringFromTable(@"SYSTOLIC", INFOPLIST, nil);
                    bpdLbl.textColor = [UIColor blackColor];
    mmhg1.text = NSLocalizedStringFromTable(@"HS_BP1", INFOPLIST, nil);
                    mmhg1.textColor = [UIColor blackColor];
    mmhg2.text = NSLocalizedStringFromTable(@"HS_BP2", INFOPLIST, nil);
        mmhg2.textColor = [UIColor blackColor];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)SaveBP
{
    [bpdDownlimit resignFirstResponder];
    [bpdUplimit resignFirstResponder];
    [bpsUplimit resignFirstResponder];
    [bpsDownlimit resignFirstResponder];
    //
    bpdDownlimit.text = @"0";
    bpsDownlimit.text = @"0";
    if (![bpdUplimit.text isEqualToString:@""] && ![bpdDownlimit.text isEqualToString:@""] && ![bpsDownlimit.text isEqualToString:@""] && ![bpsUplimit.text isEqualToString:@""]) {
        NSLog(@"ok");
        
        if ([bpdUplimit.text integerValue]<=[bpdDownlimit.text integerValue])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_BP_Error1 delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
            
            [alertView show];
            NSLog(@"error 1 bpsu %@ bpsd %@",bpdUplimit.text,bpdDownlimit.text);
            
        }else if ([bpsUplimit.text integerValue]<= [bpsDownlimit.text integerValue])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_BP_Error2 delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
            
            [alertView show];
            NSLog(@"error 2");
        }else
        {
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:bpdDownlimit.text,@"bpdDownlimit",bpdUplimit.text,@"bpdUplimit",bpsDownlimit.text,@"bpsDownlimit",bpsUplimit.text,@"bpsUplimit", nil];
        
        [(MainClass *)MainObj Send_BPdata:dic];
        }
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE message:ALERT_REMIND_NULL delegate:self cancelButtonTitle:ALERT_REMIND_OK otherButtonTitles: nil];
        
        [alertView show];
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

@end
