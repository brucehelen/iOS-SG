//
//  WeightRemindView.m
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import "WeightRemindView.h"
#import "MainClass.h"

@implementation WeightRemindView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

//血氧資訊
- (void)Set_Init:(NSDictionary *)dic
{
    if (dic) {
        if ([[dic objectForKey:@"sex"] integerValue] == 0) {
            [menBtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
            [girlBtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
        }else{
            [menBtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
            [girlBtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
        }
        sex = [[dic objectForKey:@"sex"] intValue];

        yearTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"years"]];
        weightTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"weight"]];
        tallTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"height"]];
        fatTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bodyfat"]];
        weightT.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"weightT"]];
        fatT.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bodyfatT"]];

        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(donwWithTxt:)],
                               nil];
        [numberToolbar sizeToFit];

        yearTxt.inputAccessoryView = numberToolbar;
        weightTxt.inputAccessoryView = numberToolbar;
        tallTxt.inputAccessoryView = numberToolbar;
        fatTxt.inputAccessoryView = numberToolbar;
        idealWeightTxt.inputAccessoryView = numberToolbar;
        idealfatTxt.inputAccessoryView = numberToolbar;
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
    
    [yearTxt resignFirstResponder];
    [weightTxt resignFirstResponder];
    [tallTxt resignFirstResponder];
    [fatTxt resignFirstResponder];
    [idealfatTxt resignFirstResponder];
    [idealWeightTxt resignFirstResponder];
}

- (void)Do_Init:(id)sender
{
    MainObj = sender;

    yearTxt.delegate = self;
    weightTxt.delegate = self;
    tallTxt.delegate = self;
    fatTxt.delegate = self;
    idealfatTxt.delegate = self;
    idealWeightTxt.delegate = self;
    scrollView.contentSize = CGSizeMake(280, 460);
    sexLbl.text = NSLocalizedStringFromTable(@"HS_W_SEX", INFOPLIST, nil);
        sexLbl.textColor = [UIColor blackColor];
    boyLbl.text = NSLocalizedStringFromTable(@"HS_W_BOY", INFOPLIST, nil);
        boyLbl.textColor = [UIColor blackColor];
    girlLbl.text = NSLocalizedStringFromTable(@"HS_W_GIRL", INFOPLIST, nil);
        girlLbl.textColor = [UIColor blackColor];
    yearLbl.text = NSLocalizedStringFromTable(@"HS_W_YEAR", INFOPLIST, nil);
        yearLbl.textColor = [UIColor blackColor];
    oldLbl.text = NSLocalizedStringFromTable(@"HS_W_OLD", INFOPLIST, nil);
        oldLbl.textColor = [UIColor blackColor];
    tallLbl.text = NSLocalizedStringFromTable(@"HS_W_TALL", INFOPLIST, nil);
        tallLbl.textColor = [UIColor blackColor];

    cmLbl.text = NSLocalizedStringFromTable(@"HS_W_CM", INFOPLIST, nil);
        cmLbl.textColor = [UIColor blackColor];

    weightLbl.text = NSLocalizedStringFromTable(@"HS_W_WEIGHT", INFOPLIST, nil);
        weightLbl.textColor = [UIColor blackColor];
    kgLbl.text = NSLocalizedStringFromTable(@"HS_W_KG", INFOPLIST, nil);
        kgLbl.textColor = [UIColor blackColor];
    bodyfatLbl.text = NSLocalizedStringFromTable(@"HS_W_BODY", INFOPLIST, nil);
        bodyfatLbl.textColor = [UIColor blackColor];
    persentLbl.text = NSLocalizedStringFromTable(@"HS_W_PERSENT", INFOPLIST, nil);
        persentLbl.textColor = [UIColor blackColor];
    idealWeightLbl.text = NSLocalizedStringFromTable(@"HS_W_IDWEIGHT", INFOPLIST, nil);
        idealWeightLbl.textColor = [UIColor blackColor];
    
    weightTLabel.text = NSLocalizedStringFromTable(@"HS_W_IDWEIGHT", INFOPLIST, nil);
    
    kgLbl2.text = NSLocalizedStringFromTable(@"HS_W_KG", INFOPLIST, nil);
        kgLbl2.textColor = [UIColor blackColor];
    
    idealbodyLbl.text = NSLocalizedStringFromTable(@"HS_W_IDBODY", INFOPLIST, nil);
        idealbodyLbl.textColor = [UIColor blackColor];
    
    fatTLabel.text = NSLocalizedStringFromTable(@"HS_W_IDBODY", INFOPLIST, nil);
    
    
    persentLbl2.text = NSLocalizedStringFromTable(@"HS_W_PERSENT", INFOPLIST, nil);
        persentLbl2.textColor = [UIColor blackColor];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frames = textField.frame;
    int offset = frames.origin.y + 32 - (self.frame.size.height - 320.0);//键盘高度216
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

- (void)SaveWeight
{
    if (![yearTxt.text isEqualToString:@""] &&
        ![weightTxt.text isEqualToString:@""] &&
        ![tallTxt.text isEqualToString:@""] &&
        ![fatTxt.text isEqualToString:@""] &&
        ![idealWeightTxt.text isEqualToString:@""] &&
        ![idealfatTxt.text isEqualToString:@""])
    {
        /*
         bodyfat = "20.0";
         height = "170.0";
         weight = "60.0";
         years = 115;
         */
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             yearTxt.text, @"years",
                             weightTxt.text, @"weight",
                             tallTxt.text, @"height",
                             fatTxt.text, @"bodyfat",
                             weightT.text, @"weightT",
                             weightTxt.text, @"weightT",
                             fatT.text, @"bodyfatT",
                             fatTxt.text, @"bodyfatT",
                             [NSString stringWithFormat:@"%i", sex], @"sex",
                             nil];

        NSLog(@"dict = %@", dic);

        // 开始设置
        [(MainClass *)MainObj Send_Weightdata:dic];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:ALERT_REMIND_TITLE
                                                            message:ALERT_REMIND_NULL
                                                           delegate:self
                                                  cancelButtonTitle:ALERT_REMIND_OK
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (IBAction)seleBoyGirl:(id)sender
{
    if ([(UIView*)sender tag] == 2) {
        [menBtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
        [girlBtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
        sex = 1;
    } else {
        [menBtn setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
        [girlBtn setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
        sex = 0;
    }
}

@end
