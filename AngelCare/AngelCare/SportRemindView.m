//
//  SportRemindView.m
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import "SportRemindView.h"
#import "MainClass.h"

@implementation SportRemindView

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
    if (dic) {
        stepRangeTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"StepRange"]];
        stepCountTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"StepCount"]];
        distanceTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Distance"]];
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                               nil];
        [numberToolbar sizeToFit];
        
//        stepCountTxt.inputAccessoryView = numberToolbar;
//        stepRangeTxt.inputAccessoryView = numberToolbar;
//        distanceTxt.inputAccessoryView = numberToolbar;
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
    
    [stepCountTxt resignFirstResponder];
    [stepRangeTxt resignFirstResponder];
    [distanceTxt resignFirstResponder];
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
    stepRangeTxt.delegate = self;
    stepCountTxt.delegate = self;
    distanceTxt.delegate = self;
    stepLengthLbl.text = NSLocalizedStringFromTable(@"HS_S_STEPLENGTH", INFOPLIST, nil);
    stepLengthLbl.textColor = [UIColor blackColor];
//    stepLengthLbl.backgroundColor =[UIColor yellowColor];
//    stepLengthLbl.backgroundColor = [UIColor clearColor];
    distanceLbl.text = NSLocalizedStringFromTable(@"HS_S_IDDISTANCE", INFOPLIST, nil);
    distanceLbl.textColor = [UIColor blackColor];
//    distanceLbl.backgroundColor = [UIColor clearColor];
    stepCountLbl.text = NSLocalizedStringFromTable(@"HS_S_IDSTEP", INFOPLIST, nil);
    stepCountLbl.textColor = [UIColor blackColor];
//    stepCountLbl.backgroundColor = [UIColor clearColor];
    lblCMTitle.text = NSLocalizedStringFromTable(@"StepLengthUnit", INFOPLIST, nil);
    lblCMTitle.textColor = [UIColor blackColor];

    lblKMTitle.text = NSLocalizedStringFromTable(@"DistanceUnit", INFOPLIST, nil);
    lblKMTitle.textColor = [UIColor blackColor];

    lblStepTitle.text = NSLocalizedStringFromTable(@"StepCountUnit", INFOPLIST, nil);
    lblStepTitle.textColor = [UIColor blackColor];

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

-(void)SaveSport
{
    if (![stepRangeTxt.text isEqualToString:@""] && ![stepCountTxt.text isEqualToString:@""] && ![distanceTxt.text isEqualToString:@""]) {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:stepRangeTxt.text,@"StepRange",stepCountTxt.text,@"StepCount",distanceTxt.text,@"Distance", nil];
        
        [(MainClass *)MainObj Send_Sportdata:dic];
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
