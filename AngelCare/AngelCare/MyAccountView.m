//
//  MyAccountView.m
//  AngelCare
//
//  Created by macmini on 13/8/8.
//
//

#import "MyAccountView.h"
#import "MainClass.h"
@implementation MyAccountView
@synthesize accTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)Do_Init:(id)sender
{
    MainObj = sender;
    titleArr = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"Personal_MyAccount_Name", INFOPLIST, nil),NSLocalizedStringFromTable(@"Personal_MyAccount_Email", INFOPLIST, nil),NSLocalizedStringFromTable(@"Personal_MyAccount_Phone", INFOPLIST, nil), nil];
    
    lbl_changepw.text = NSLocalizedStringFromTable(@"ChangePw", INFOPLIST, nil);
    lbl_changeInfo.text = NSLocalizedStringFromTable(@"ChagneAccInfo", INFOPLIST, nil);
    
    [accTableView layer].cornerRadius = 8.0f;
    
    changePwView.layer.borderWidth = 5.0f;
    subchangePwView.layer.cornerRadius = 8.0f;
    changePwView.layer.cornerRadius = 8.0f;
    titleBgLbl.layer.cornerRadius = 8.0f;
    changePwView.layer.borderColor = [[UIColor whiteColor] CGColor];
    changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    [changePwView removeFromSuperview];
    changePwFrame = changePwView.frame;
    firstTxt.delegate = self;
    secTxt.delegate = self;
    thirdTxt.delegate = self;
    bgView.layer.cornerRadius = 8.0f;
}

-(void)Set_Init:(NSArray *)arr
{
    NSLog(@"arr = %@",arr);
    nameArr = arr;
    [accTableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyAccountCell";
    MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MyAccountCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyAccountCell_iPad" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyAccountCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.titleLbl.text = [titleArr objectAtIndex:indexPath.row];
    if (nameArr.count < indexPath.row+1) {
    }
    @try {
        // do something
        cell.nameLbl.text = [nameArr objectAtIndex:indexPath.row];
    }
    @catch (NSException *exception) {
        // error happened! do something about the error state
        NSLog(@"exc = %@",exception);
    }
    @finally {
        // do something to keep the program still running properly
//        cell.nameLbl.text = @"";
        if ([cell.nameLbl.text isEqualToString:@"Label"]) {
            cell.nameLbl.text = @"";
        }
    }
    return cell;
}


-(IBAction)changePW:(id)sender
{
    
    [self addSubview:changePwView];
    nowView = 1;
    titleLbl.text = NSLocalizedStringFromTable(@"ChangePw", INFOPLIST, nil);    
    firstLbl.text = NSLocalizedStringFromTable(@"OriginalPW", INFOPLIST, nil);
    secLbl.text = NSLocalizedStringFromTable(@"NewPw", INFOPLIST, nil);
    thirdLbl.text = NSLocalizedStringFromTable(@"AgainPw", INFOPLIST, nil);
    
    [firstLbl setFrame:CGRectMake(firstLbl.frame.origin.x, firstLbl.frame.origin.y, 300, firstLbl.frame.size.height)];
    [secLbl setFrame:CGRectMake(secLbl.frame.origin.x, secLbl.frame.origin.y, 300, secLbl.frame.size.height)];
    [thirdLbl setFrame:CGRectMake(thirdLbl.frame.origin.x, thirdLbl.frame.origin.y, 300, thirdLbl.frame.size.height)];
    
    thirdTxt.keyboardType = UIKeyboardTypeASCIICapable;
    firstTxt.text = @"";
    secTxt.text = @"";
    thirdTxt.text = @"";
    firstTxt.placeholder = NSLocalizedStringFromTable(@"pOPwd", INFOPLIST, nil);
    secTxt.placeholder = NSLocalizedStringFromTable(@"pNPwd", INFOPLIST, nil);
    thirdTxt.placeholder = NSLocalizedStringFromTable(@"pAPwd", INFOPLIST, nil);
    
//    NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor blueColor], NSFontAttributeName : [UIFont systemFontOfSize:8.0f]};
//    NSAttributedString *str = [[NSAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"pOPwd", INFOPLIST, nil) attributes:attrs];
//    firstTxt.attributedPlaceholder = str;
    
    [firstTxt setSecureTextEntry:YES];
    [secTxt setSecureTextEntry:YES];
    [thirdTxt setSecureTextEntry:YES];
    
    [saveBtn setTitle:NSLocalizedStringFromTable(@"HS_SAVE", INFOPLIST, nil) forState:UIControlStateNormal];
    [cancelBtn setTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         changePwView.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}


//修改帳號資訊
-(IBAction)changeAccInf:(id)sender
{
    [firstTxt resignFirstResponder];
    [secTxt resignFirstResponder];
    [thirdTxt resignFirstResponder];
    [self addSubview:changePwView];
    titleLbl.text = NSLocalizedStringFromTable(@"Personal_MyAccount", INFOPLIST, nil);
    firstLbl.text = [titleArr objectAtIndex:0];
    secLbl.text = [titleArr objectAtIndex:1];
    thirdLbl.text = [titleArr objectAtIndex:2];
    
    
    firstTxt.text = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:0]];
    secTxt.text = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:1]];
    
    @try {
        // do something
        thirdTxt.text = [NSString stringWithFormat:@"%@",[[nameArr objectAtIndex:2] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    @catch (NSException *exception) {
        // error happened! do something about the error state
        NSLog(@"exc = %@",exception);
        thirdTxt.text = @"";
    }
    @finally {
        // do something to keep the program still running properly
        
    }

    thirdTxt.keyboardType = UIKeyboardTypeDecimalPad;
//    thirdTxt.text = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:2]];
    [firstTxt setSecureTextEntry:NO];
    [secTxt setSecureTextEntry:NO];
    [thirdTxt setSecureTextEntry:NO];
    [saveBtn setTitle:NSLocalizedStringFromTable(@"HS_SAVE", INFOPLIST, nil) forState:UIControlStateNormal];
    [cancelBtn setTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) forState:UIControlStateNormal];
    nowView = 2;
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         changePwView.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}






- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /*
    CGRect frames = textField.frame;
    int offset = frames.origin.y + 32 - (changePwView.frame.size.height - 180.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = changePwView.frame.size.width;
    float height = changePwView.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(10.0f, -offset,width,height);
        changePwView.frame = rect;
    }
    [UIView commitAnimations];
     */
    
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    
    if (iOSDeviceScreenSize.height < 568)
    {
        CGRect frames = textField.frame;
        int offset = frames.origin.y + 32 - (changePwView.frame.size.height - 180.0);//键盘高度216
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = changePwView.frame.size.width;
        float height = changePwView.frame.size.height;
        if(offset > 0)
        {
            CGRect rect = CGRectMake(10.0f, -offset,width,height);
            changePwView.frame = rect;
        }
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return");
    /*
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(10.0f, 96.0f, changePwView.frame.size.width, changePwView.frame.size.height);
    changePwView.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
     */
    
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    
    if (iOSDeviceScreenSize.height < 568)
    {
        NSLog(@"return");
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(10.0f, 96.0f, changePwView.frame.size.width, changePwView.frame.size.height);
        changePwView.frame = rect;
        [UIView commitAnimations];
        
    }
    [textField resignFirstResponder];
    return YES;
}



- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         changePwView.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}


- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         changePwView.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
}

- (void)animationStoped
{
    
}


//關閉
-(IBAction)closeChangePwView:(id)sender
{
    changePwView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    changePwView.frame = changePwFrame;
    [UIView commitAnimations];
    
    [firstTxt resignFirstResponder];
    [secTxt resignFirstResponder];
    [thirdTxt resignFirstResponder];
    
    [changePwView removeFromSuperview];
    [accTableView reloadData];
}


//儲存
-(IBAction)saveChange:(id)sender
{
    [firstTxt resignFirstResponder];
    [secTxt resignFirstResponder];
    [thirdTxt resignFirstResponder];
    
    switch (nowView) {
        case 1:
            [self CheckPw];
            break;
        case 2:
            [self CheckInfo];
            break;
    }
    
    
}

//檢查密碼
-(void)CheckPw
{
    NSLog(@"pw1 %@ pw2 %@ pw3 %@",firstTxt.text,secTxt.text,thirdTxt.text);
    
    if (firstTxt.text.length >0)//原始密碼有無輸入
    {
        if (secTxt.text.length >=8 || thirdTxt.text.length >=8)
        {
            if ([secTxt.text isEqualToString:thirdTxt.text])
            {
                NSLog(@"OK Save to Server pw1 %@ pw2 %@ pw3 %@",firstTxt.text,secTxt.text,thirdTxt.text);
                [(MainClass *)MainObj Send_OldPw:firstTxt.text AndNewPw:secTxt.text];
                
                
            }else
            {
                [self AlertError:NSLocalizedStringFromTable(@"Personal_PWChange_Error3", INFOPLIST, nil)];
            }
        }else
        {
            [self AlertError:NSLocalizedStringFromTable(@"Personal_PWChange_Error2", INFOPLIST, nil)];
        }
        
        
    }
    else
    {
        [self AlertError:NSLocalizedStringFromTable(@"Personal_PWChange_Error1", INFOPLIST, nil)];
    }
}

//檢查帳號資訊
-(void)CheckInfo
{
    if (firstTxt.text.length>0 && secTxt.text.length>0 && thirdTxt.text.length >0)
    {
        if ([secTxt.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"])//檢查Email格式)
        {
            NSLog(@"pw1 %@ pw2 %@ pw3 %@",firstTxt.text,secTxt.text,thirdTxt.text);
//            if ([thirdTxt.text isMatchedByRegex:@"^\\d+$"])
            if ([thirdTxt.text isMatchedByRegex:@"^[0-9\\+]+$"])
            {
                NSString *newPhone = [thirdTxt.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
                //檢查成功後發送
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:firstTxt.text,@"name",secTxt.text,@"email",newPhone,@"phone", nil];
                [(MainClass *)MainObj Send_AccInfo:dic];
                [firstTxt resignFirstResponder];
                [secTxt resignFirstResponder];
                [thirdTxt resignFirstResponder];
                [accTableView reloadData];
                
            }else
            {
                //電話格式錯誤
                [self AlertError:NSLocalizedStringFromTable(@"Personal_MyAccount_Error3", INFOPLIST, nil)];
            }
            
        }else
        {
            //Email格式錯誤
            [self AlertError:NSLocalizedStringFromTable(@"Personal_MyAccount_Error2", INFOPLIST, nil)];
        }
    }else
    {
        [self AlertError:NSLocalizedStringFromTable(@"Personal_MyAccount_Error1", INFOPLIST, nil)];
    }
}



-(void)AlertError:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                    message:error
                          
                          delegate
                                                           : self cancelButtonTitle:
                          kLoadString(@"ALERT_MESSAGE_CLOSE")
                                          otherButtonTitles: nil];
    
    [alert show];
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
