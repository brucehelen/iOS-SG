//
//  FallSet.m
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import "FallSet.h"
#import "MainClass.h"

@implementation FallSet

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
    NSLog(@"fall set = %@",dic);
    if (dic) {
        
        enableStr = [dic objectForKey:@"FailSwitch"];
        
        if ([enableStr isEqualToString:@"on"] ) {
            
            isEnable = 1;
            [enableBtn setImage:[UIImage imageNamed:@"btn_check_on.png"] forState:UIControlStateNormal];
        }else
        {
            isEnable = 0;
            [enableBtn setImage:[UIImage imageNamed:@"btn_check_off.png"] forState:UIControlStateNormal];
        }
        
        levelStr  = [dic objectForKey:@"Level"];
        
        [LevelBtn setTitle:enableStr forState:UIControlStateNormal];
        
//        switch ([levelStr integerValue]) {
//            default:
//            case 0:
//                [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level0", INFOPLIST, nil) forState:UIControlStateNormal];
//                enableStr = @"off";
//                break;
//            
//            case 1:
//                [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level1", INFOPLIST, nil) forState:UIControlStateNormal];
//                enableStr = @"on";
//                break;
//            
//            case 2:
//                [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level2", INFOPLIST, nil) forState:UIControlStateNormal];
//                enableStr = @"on";
//                break;
//                
//            case 3:
//                [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level3", INFOPLIST, nil) forState:UIControlStateNormal];
//                enableStr = @"on";
//                break;
//                
////            case 4:
////                [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level4", INFOPLIST, nil) forState:UIControlStateNormal];
//                break;
//        }
        
        phone1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone1"]];
        phone2.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone2"]];
        phone3.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone3"]];
        
        
        
        
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithphone1Txt)],
                               nil];
        [numberToolbar sizeToFit];
        
        UIToolbar* numberToolbar2 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar2.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar2.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithphone2Txt)],
                                nil];
        [numberToolbar2 sizeToFit];
        
        UIToolbar* numberToolbar3 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar3.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar3.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"BUG_report_Return", INFOPLIST, nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithphone3Txt)],
                                nil];
        [numberToolbar3 sizeToFit];
        
        phone1.inputAccessoryView = numberToolbar;
        phone2.inputAccessoryView = numberToolbar2;
        phone3.inputAccessoryView = numberToolbar3;

    }
    
    
}


-(void)doneWithphone1Txt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [phone1 resignFirstResponder];
}

-(void)doneWithphone2Txt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [phone2 resignFirstResponder];
}

-(void)doneWithphone3Txt{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [phone3 resignFirstResponder];
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
    phone1.delegate = self;
    phone2.delegate = self;
    phone3.delegate = self;
    fallDownLbl.text = NSLocalizedStringFromTable(@"HS_Fall_Enable", INFOPLIST, nil);
    levelLbl.text = NSLocalizedStringFromTable(@"HS_Fall_Sence", INFOPLIST, nil);
    fallLbl.text = NSLocalizedStringFromTable(@"HS_Fall_Remind", INFOPLIST, nil);
    
    tel1Lbl.text = NSLocalizedStringFromTable(@"HS_Fall_Phone1", INFOPLIST, nil);
    
    tel2Lbl.text = NSLocalizedStringFromTable(@"HS_Fall_Phone2", INFOPLIST, nil);
    
    tel3Lbl.text = NSLocalizedStringFromTable(@"HS_Fall_Phone3", INFOPLIST, nil);
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


-(IBAction)isEnableBtnClick:(id)sender
{
    if (isEnable == 1) {
        
        
        
        isEnable = 0;
        enableStr = @"off";
        [enableBtn setImage:[UIImage imageNamed:@"btn_check_off.png"] forState:UIControlStateNormal];
    }else
    {
        isEnable = 1;
        enableStr = @"on";
        [enableBtn setImage:[UIImage imageNamed:@"btn_check_on.png"] forState:
         UIControlStateNormal];
    }
    
    NSLog(@"enable = %@",enableStr);
}



//儲存跌倒設定
-(void)SaveFallSet
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:enableStr,@"FallSwitch",@"1",@"Level",phone1.text,@"Phone1",phone2.text,@"Phone2",phone3.text,@"Phone3", nil];
    
    [(MainClass *)MainObj Send_Falldata:dic];
}


-(IBAction)changeLevel:(id)sender
{
//    [(MainClass *)MainObj changeFallLevel];
    if ( [LevelBtn.titleLabel.text isEqualToString:@"On"]) {
        [LevelBtn setTitle:@"Off" forState:UIControlStateNormal];
        enableStr = @"Off";
    }
    else{
        [LevelBtn setTitle:@"On" forState:UIControlStateNormal];
        enableStr = @"On";
    }
}

-(void)ChangeLevelBtnTitle:(int)n
{
    switch (n) {
        case 0:
            [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level0", INFOPLIST, nil) forState:UIControlStateNormal];
            break;
        case 1:
            [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level1", INFOPLIST, nil) forState:UIControlStateNormal];
            break;
            
        case 2:
            [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level2", INFOPLIST, nil) forState:UIControlStateNormal];
            break;
            
        case 3:
            [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level3", INFOPLIST, nil) forState:UIControlStateNormal];
            break;
            
//        case 4:
//            [LevelBtn setTitle:NSLocalizedStringFromTable(@"HS_Fall_level4", INFOPLIST, nil) forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }

    levelStr = [NSString stringWithFormat:@"%i",n];
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
