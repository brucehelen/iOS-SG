//
//  CreateNewAccViewController.m
//  AngelCare
//
//  Created by macmini on 13/6/25.
//
//

#import "CreateNewAccViewController.h"

@interface CreateNewAccViewController ()

@end

@implementation CreateNewAccViewController
@synthesize accTxt,checkBtn,pass1Txt,pass2Txt,phoneTxt,emailTxt,memberBtn,privacyBtn,checkMemberAndPrivacy,sendBtn,agreeLbl,checkName,Navi;


NSURLConnection *Check_Connect;
NSMutableData *Check_tempData;    //下載時暫存用的記憶體
long long Check_expectedLength;        //檔案大小

NSURLConnection *Email_Connect;
NSMutableData *Email_tempData;    //下載時暫存用的記憶體
long long Email_expectedLength;        //檔案大小

NSURLConnection *NewAcc_Connect;
NSMutableData *NewAcc_tempData;    //下載時暫存用的記憶體
long long NewAcc_expectedLength;        //檔案大小

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Navi.title = NSLocalizedStringFromTable(@"NewAcc", INFOPLIST, nil);
    
    accTxt.placeholder = NSLocalizedStringFromTable(@"Login_ACC", INFOPLIST, nil);
    
    [checkBtn setTitle:NSLocalizedStringFromTable(@"CheckButton", INFOPLIST, nil) forState:UIControlStateNormal];
    checkName.placeholder = NSLocalizedStringFromTable(@"CheckName", INFOPLIST, nil);
    
    
    pass1Txt.placeholder = NSLocalizedStringFromTable(@"Login_PWD", INFOPLIST, nil);
    pass2Txt.placeholder = NSLocalizedStringFromTable(@"Login_PWD2", INFOPLIST, nil);
    
    phoneTxt.placeholder = NSLocalizedStringFromTable(@"PhoneNumber", INFOPLIST, nil);
    
    emailTxt.placeholder = NSLocalizedStringFromTable(@"Email", INFOPLIST, nil);
    NSMutableAttributedString *memberString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"MemberList", INFOPLIST, nil)];
    [memberString setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Oblique" size:15.0],NSForegroundColorAttributeName:[UIColor whiteColor],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[memberString length])];
    NSMutableAttributedString *privacyString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedStringFromTable(@"PrivacyList", INFOPLIST, nil)];
    [privacyString setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Oblique" size:15.0],NSForegroundColorAttributeName:[UIColor whiteColor],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[privacyString length])];
    [memberBtn setAttributedTitle:memberString forState:UIControlStateNormal];
    
    [privacyBtn setAttributedTitle:privacyString forState:UIControlStateNormal];
    
    [sendBtn setTitle:NSLocalizedStringFromTable(@"Create_Send", INFOPLIST, nil) forState:UIControlStateNormal];
    agreeLbl.text = NSLocalizedStringFromTable(@"AgreeLabel", INFOPLIST, nil);
    
    accTxt.keyboardType = UIKeyboardTypeASCIICapable;
    pass1Txt.keyboardType = UIKeyboardTypeASCIICapable;
    [pass1Txt setSecureTextEntry:YES];
    pass2Txt.keyboardType = UIKeyboardTypeASCIICapable;
    [pass2Txt setSecureTextEntry:YES];
    phoneTxt.keyboardType = UIKeyboardTypeASCIICapable;
    emailTxt.keyboardType = UIKeyboardTypeASCIICapable;
    accTxt.delegate = self;
    [accTxt setTag:101];
    pass1Txt.delegate = self;
    pass2Txt.delegate = self;
    phoneTxt.delegate = self;
    emailTxt.delegate = self;
    checkName.delegate = self;
    isCheckAcc = NO;
    isAgree = NO;
//    checkMemberAndPrivacy.layer.borderWidth = 1.0f;
    checkMemberAndPrivacy.layer.borderColor = [[UIColor blackColor] CGColor];
    checkMemberAndPrivacy.layer.cornerRadius = 8.0f;
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [self doCornerRadius:_btnCancel];
    [self doCornerRadius:_btnCreate];
    [self doCornerRadiusWithlbl:_lblBG1];
    [self doCornerRadiusWithlbl:_lblBG2];
    [self doCornerRadiusWithlbl:_lblBG3];
    [_lblBG1 setBackgroundColor:[UIColor colorWithRed:219/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [_lblBG2 setBackgroundColor:[UIColor colorWithRed:219/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    [_lblBG3 setBackgroundColor:[UIColor colorWithRed:219/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _lblTitle.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] CGColor], (id)[[UIColor colorWithRed:126.0/255.0 green:126/255.0 blue:126/255.0 alpha:1] CGColor], nil]; // 由上到下的漸層顏色
    [_lblTitle.layer insertSublayer:gradient atIndex:0];
    _lblTitle.text = @"Create New Account";
}
- (void)doCornerRadius:(UIButton*)btn{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:8.0]; //设置矩圆角半径
//    [btn.layer setBorderWidth:1.0];   //边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
//    [btn.layer setBorderColor:colorref];//边框颜色
}
- (void)doCornerRadiusWithlbl:(UILabel*)lbl{
    [lbl.layer setMasksToBounds:YES];
    [lbl.layer setCornerRadius:8.0];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frames = textField.frame;
    int offset = frames.origin.y + 32 - (self.view.frame.size.height - 300.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField tag] == 101) {
        if (![accountStr isEqualToString:textField.text]) {
            isCheckAcc = NO;
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"return");
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

-(void)resetViewAndKeyBoard
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [accTxt resignFirstResponder];
    [pass1Txt resignFirstResponder];
    [pass2Txt resignFirstResponder];
    [phoneTxt resignFirstResponder];
    [emailTxt resignFirstResponder];
    [checkName resignFirstResponder];
}

//觸碰背景隱藏鍵盤
-(IBAction)backgroundBtnClick:(id)sender
{
    [self resetViewAndKeyBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkBtnClick:(id)sender {
    
    [self resetViewAndKeyBoard];
    UIAlertView *alertView;
    if ([accTxt.text length] >= 6 && [accTxt.text length] <=12) {
        
        
        if([accTxt.text isMatchedByRegex:@"^[A-Za-z0-9]+$"])
        {
            //格式正確
            [self checkAccount:accTxt.text];
        }else
        {
            //格式不正確
            alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"CheckAccount2", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
            [alertView show];
        }
        
    }else
    {
        //帳號長度小於6
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"CheckAccount1", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }
    
    
}

//驗證帳號Api
-(void)checkAccount:(NSString *)account
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *CheckaccountApi = [NSString stringWithFormat:@"%@/API/AppChkAccountDup.html",INK_Url_1];
    
    NSString *postString = [NSString stringWithFormat:@"userAccount=%@",account];
    NSData *httpBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setURL:[NSURL URLWithString:CheckaccountApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    NSLog(@"test = %@",CheckaccountApi);
    
    Check_tempData = [NSMutableData alloc];
    Check_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}


//驗證EmailApi
-(void)checkEmail:(NSString *)emailStr
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *checkEmailApi = [NSString stringWithFormat:@"%@/API/AppChkEmailDup.html",INK_Url_1];
    
    NSString *httpBodyString = [NSString stringWithFormat:@"email=%@",emailStr];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setURL:[NSURL URLWithString:checkEmailApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Email_tempData = [[NSMutableData alloc] init];
    Email_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}

//建立新帳號
-(void)addNewAccount
{
    NSString *nameString = [checkName.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *phoneString = [phoneTxt.text stringByReplacingOccurrencesOfString:@"+" withString:@"%2b"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *addNewAccApi = [NSString stringWithFormat:@"%@/API/AppCreateAccount.html",INK_Url_1];
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@&realname=%@&password=%@&email=%@&phone=%@",accTxt.text,nameString,pass1Txt.text,emailTxt.text,phoneString];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"api = %@",addNewAccApi);
    
    
    [request setURL:[NSURL URLWithString:addNewAccApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    NewAcc_tempData = [NSMutableData alloc];
    NewAcc_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];

}


//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    if(connection == Check_Connect)
    {
        [Check_tempData appendData:incomingData];
    }
    
    if (connection == Email_Connect) {
        [Email_tempData appendData:incomingData];
    }
    
    if (connection == NewAcc_Connect) {
        [NewAcc_tempData appendData:incomingData];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    
    
    if(connection == Check_Connect)
    {
        [self HttpCheckAccount];
    }
    
    if (connection == Email_Connect) {
        [self HttpCheckEmail];
    }
    
    if (connection == NewAcc_Connect) {
        [self HttpNewAcc];
        NSLog(@"New acc");
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    if(connection == Check_Connect)
    {
        [Check_tempData setLength:0];
        Check_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    
    if(connection == Email_Connect)
    {
        [Email_tempData setLength:0];
        Email_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    
    if (connection == NewAcc_Connect) {
        [NewAcc_tempData setLength:0];
        NewAcc_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"error = %@",[error localizedDescription]);
	[HUD hide:YES];
//    [CheckErrorCode Check_Error:@"999"];
    if (error.code == ErrorTimeOut) {
        NSLog(@"Time out!");
        [self showMsg:NSLocalizedStringFromTable(@"ErrorTimeOut", INFOPLIST, nil) andTag:1001];
    }
    else{
        [CheckErrorCode Check_Error:@"999"];
    }
}

- (void)showMsg:(NSString*) strMsg andTag:(int) tag{
    NSLog(@"%@",strMsg);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                          message:NSLocalizedStringFromTable(strMsg, INFOPLIST, nil)
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    alert.tag = tag;
    [alert show];
}

//檢查帳號回傳解析
-(void)HttpCheckAccount
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Check_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
//    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"OK");
        UIAlertView *alertView;
        if ([[usersOne objectForKey:@"duplicate"] integerValue] == 1) {
            alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"CheckAccount3", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
            [alertView show];
            isCheckAcc = NO;
            accountStr = accTxt.text;
        }else
        {
            NSLog(@"no duplicate");
            alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"CheckAccountOK", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
            [alertView show];
            isCheckAcc = YES;
        }
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");
        isCheckAcc = NO;
        
    }
    [HUD hide:YES];
}



//驗證Email是否重複
-(void)HttpCheckEmail
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Email_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"OK");
        [HUD hide:YES];
        UIAlertView *alertView;
        if ([[usersOne objectForKey:@"duplicate"] integerValue] == 1) {
            alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck8", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
            [alertView show];
            
        }else
        {
            [self addNewAccount];//新增帳號
            NSLog(@"add new account");
        }
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");
        isCheckAcc = NO;
        [HUD hide:YES];
    }
}

//建立新帳號 回傳解析
-(void)HttpNewAcc
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:NewAcc_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    if( [status isEqualToString:str1]  )
    {
        NSLog(@"OK");
        [HUD hide:YES];
        UIAlertView *alertView;
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck0", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView setTag:101];
        [alertView show];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
    }
    [HUD hide:YES];
}

-(void)addLoadingView
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    //    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HUD show:YES];
}

//會員條款
- (IBAction)memberBtnClick:(id)sender {
    
}

//隱私權條款
- (IBAction)privacyBtnClick:(id)sender {
    
}

- (IBAction)checkMemberAndPrivacyBtnClick:(id)sender {
    
    if (isAgree) {
//        [checkMemberAndPrivacy setBackgroundImage:[UIImage imageNamed:@"icon_check_0.png"] forState:UIControlStateNormal];
        
        [checkMemberAndPrivacy setImage:[UIImage imageNamed:@"check_ok"] forState:UIControlStateNormal];
        
        
        
        isAgree = NO;
    }else
    {
//        [checkMemberAndPrivacy setBackgroundImage:[UIImage imageNamed:@"icon_check_1.png"] forState:UIControlStateNormal];
        [checkMemberAndPrivacy setImage:[UIImage imageNamed:@"check_ok_mark"] forState:UIControlStateNormal];
        
        isAgree = YES;
    }
    
    
}

//alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 101) {
        //ios7 modify
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self dismissModalViewControllerAnimated:YES];
    }
}


//送出時須驗證
- (IBAction)sendBtnClick:(id)sender {
    
    NSLog(@"[pass1Txt length] %i" , [pass1Txt.text length]);
    
    UIAlertView *alertView;
    
    if ([accTxt.text length]<=6 && [accTxt.text length] >=12) {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"CheckAccount1", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }
    /*國外版本不需要驗證帳號
    else if (!isCheckAcc)//先判斷是否驗證過帳號
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck1", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }*/
    else if (![checkName.text length]>0)//判斷姓名長度
    {
        
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck2", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
        
    }else if ([pass1Txt.text length] <8)
        //密碼是否介於8-12位元
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck3", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }
    else if ([pass1Txt.text length]>12)
        //密碼是否介於8-12位元
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck3", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }else if (![pass1Txt.text isEqualToString:pass2Txt.text])//判斷是否兩個密碼相等
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck4", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }else if (![emailTxt.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"])//檢查Email格式
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck6", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }else if (!isAgree)
    {
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck7", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alertView show];
    }else
    {
        NSLog(@"no error");
        
        if ([phoneTxt.text length] > 0)
        {       //手機號碼長度 與字元判斷
            if (![phoneTxt.text isMatchedByRegex:@"^[0-9\\+]+$"]) {
                alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"SendCheck5", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
                [alertView show];
            }else
            {
                [self checkEmail:emailTxt.text];
            }
            
            NSLog(@"phone length ");
            
        }else
        {
            NSLog(@"start checkEmail");
            [self checkEmail:emailTxt.text];
        }
        
        
    }
    
}

-(IBAction)backBtnClick:(id)sender
{
    //ios7 modify
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setAccTxt:nil];
    [self setCheckBtn:nil];
    [self setPhoneTxt:nil];
    [self setPass1Txt:nil];
    [self setPass2Txt:nil];
    [self setEmailTxt:nil];
    [self setMemberBtn:nil];
    [self setPrivacyBtn:nil];
    [self setCheckMemberAndPrivacy:nil];
    [self setSendBtn:nil];
    [self setCheckName:nil];
    [self setNavi:nil];
    [super viewDidUnload];
}
@end
