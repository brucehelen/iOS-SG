//
//  LoginViewController.m
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import "LoginViewController.h"
//#define ACCTXT NSLocalizedStringFromTable(@"Login_ACC", INFOPLIST, nil)
//#define PWDTXT NSLocalizedStringFromTable(@"Login_PWD", INFOPLIST, nil)
//
//#define ACCTXT NSLocalizedStringFromTable(@"Login_ACC", INFOPLIST, nil)

#define ACCTXT NSLocalizedStringFromTable(@"WebAccSup", INFOPLIST, nil)
#define PWDTXT NSLocalizedStringFromTable(@"WebPwdSup", INFOPLIST, nil)
#define TOTALPAGE 13

@interface LoginViewController ()
{
    NSString* autoLogin;
    NSString* rememberMe;
}
@end

@implementation LoginViewController
@synthesize accTxt,pwdTxt,loginBtn,forgetBtn,createBtn,qrcodeLoginBtn;

NSURLConnection *Login_Connect;
NSMutableData *Login_tempData;    //下載時暫存用的記憶體
long long Login_expectedLength;        //檔案大小

NSURLConnection *Resend_Connect;
NSMutableData *Resend_tempData;    //下載時暫存用的記憶體
long long Resend_expectedLength;        //檔案大小

NSURLConnection *ChangeLogo_Connect;
NSMutableData *ChangeLogo_tempData;    //下載時暫存用的記憶體
long long ChangeLogo_expectedLength;        //檔案大小


NSURLConnection *ChangeImgUrl_Connect;
NSMutableData *ChangeImgUrl_tempData;    //下載時暫存用的記憶體
long long ChangeImgUrl_expectedLength;        //檔案大小

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
    iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    [pageControl setNumberOfPages:TOTALPAGE];
    pageControl.currentPage = 0;
    float totalweight = iOSDeviceScreenSize.width*TOTALPAGE;
    firstScrollView.contentSize = CGSizeMake(totalweight, 480);
    firstScrollView.pagingEnabled = YES;
    accTxt.delegate = self;
    pwdTxt.delegate = self;
    accTxt.placeholder = ACCTXT;
    pwdTxt.placeholder = PWDTXT;
    [pwdTxt setSecureTextEntry:YES];
    [loginBtn setTitle:NSLocalizedStringFromTable(@"Login_LoginBtn", INFOPLIST, nil) forState:UIControlStateNormal];
    [forgetBtn setTitle:NSLocalizedStringFromTable(@"Login_ForgetBtn", INFOPLIST, nil) forState:UIControlStateNormal];
    [createBtn setTitle:NSLocalizedStringFromTable(@"Login_NewAccBtn", INFOPLIST, nil) forState:UIControlStateNormal];
    [qrcodeLoginBtn setTitle:NSLocalizedStringFromTable(@"Login_QRCodeLoginBtnReturn", INFOPLIST, nil) forState:UIControlStateNormal];
    //20140321 update
    self.lblAutoLogin.text = NSLocalizedStringFromTable(@"AutoLogin", INFOPLIST, nil);
    self.lblRememberMe.text = NSLocalizedStringFromTable(@"RememberMe", INFOPLIST, nil);
    [self InitBtnAutoLogin];
    [self InitBtnRememberMe];
    //20140321 update
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    token = [defaults objectForKey:@"token"];
    [self LoadAndChangeLogo];
	// Do any additional setup after loading the view.
    
}
//20140321 update
- (void)InitBtnAutoLogin{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"AutoLogin"]; //Add the file name
    autoLogin = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"autoLogin %@",autoLogin);
    
    [self changeAutoLoginImage];
}
- (void)InitBtnRememberMe{
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath2 = [paths2 objectAtIndex:0]; //Get the docs directory
    NSString *filePath2 = [documentsPath2 stringByAppendingPathComponent:@"rememberMe"]; //Add the file name
    rememberMe = [[NSString alloc]initWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"rememberMe %@",rememberMe);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults dictionaryRepresentation]);
    if ([rememberMe isEqualToString:@"YES"]) {
        accTxt.text = [defaults objectForKey:@"userAccount"];
        pwdTxt.text = [defaults objectForKey:@"userHash"];
    }
    [self changeRememberMeImage];
}
- (void)changeRememberMeImage{
    if ([rememberMe isEqualToString:@"YES"]) {
        [self.btnRememberMe setBackgroundImage:[UIImage imageNamed:@"check_on.png"] forState:UIControlStateNormal];
    }
    else{
        [self.btnRememberMe setBackgroundImage:[UIImage imageNamed:@"check_off.png"] forState:UIControlStateNormal];
    }
}
- (void)changeAutoLoginImage{
    if ([autoLogin isEqualToString:@"YES"]) {
        [self.btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"check_on.png"] forState:UIControlStateNormal];
    }
    else{
        [self.btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"check_off.png"] forState:UIControlStateNormal];
    }
    
}
//20140321 update

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat width = firstScrollView.frame.size.width;
    NSInteger currentPage = ((firstScrollView.contentOffset.x - width / 2) / width) + 1;
    [pageControl setCurrentPage:currentPage];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"scrollView end %f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.x >= 3840) {
        [enterBtn setTitle:NSLocalizedStringFromTable(@"StartUse", INFOPLIST, nil) forState:UIControlStateNormal];
    }else
    {
        [enterBtn setTitle:@"SKIP" forState:UIControlStateNormal];
    }
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//點擊登入按鈕
-(IBAction)loginBtnClick:(id)sender
{
    /*GA Start*/
    /*
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Login"// Event category (required)
                                                          action:@"Btn_Click"  // Event action (required)
                                                           label:@"Click_Login"          // Event label
                                                           value:nil] build]];    // Event value
    [[GAI sharedInstance] dispatch];
     */
    /*GA End*/
    
    if (([accTxt.text length]>0) && [pwdTxt.text length]>0) {
        
        [self resetViewAndKeyBoard];
        [self loginWithAcc:accTxt.text andPwd:pwdTxt.text];
        NSLog(@"YES");
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                        message:NSLocalizedStringFromTable(@"Login_EMPTY", INFOPLIST, nil)
                              
                              delegate
                                                               : self cancelButtonTitle:
                              NSLocalizedStringFromTable(@"ALERT_MESSAGE_CLOSE", INFOPLIST, nil)
                                              otherButtonTitles: nil];
        
        [alert show];
    NSLog(@"NO");
    }
}

//登入
- (void)loginWithAcc:(NSString *)acc andPwd:(NSString *)pwd
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];

    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
    //    NSLog(tmpstr);
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    //    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    NSLog(@"dataIn: %@", dataIn);
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    NSLog(@"Hash : %@", hash);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;

    if(token.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=0&appid=%i",acc, hash,[arr objectAtIndex:0],[arr objectAtIndex:1],APPID];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@%%20%@&device=0&token=%@&appid=%i",acc, hash,[arr objectAtIndex:0],[arr objectAtIndex:1],token,APPID];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogin.html",INK_Url_1];
    
    NSLog(@"Login API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    
    
    
    Login_tempData = [NSMutableData alloc];
    Login_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}


//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    if(connection == Login_Connect)
    {
        [Login_tempData appendData:incomingData];
    }
    
    if (connection == Resend_Connect) {
        [Resend_tempData appendData:incomingData];
    }
    
    if (connection == ChangeLogo_Connect) {
        [ChangeLogo_tempData appendData:incomingData];
    }else if (connection == ChangeImgUrl_Connect)
    {
        [ChangeImgUrl_tempData appendData:incomingData];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    
    
    if(connection == Login_Connect)
    {
        [self HttpReadLoginData];
    }
    
    if (connection == Resend_Connect) {
        [self HttpResendData];
    }
    
    if (connection == ChangeLogo_Connect) {
        [self HttpChangeLogoURL];
    }else if (connection == ChangeImgUrl_Connect)
    {
        [self HttpChangeImage];
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    if(connection == Login_Connect)
    {
        [Login_tempData setLength:0];
        Login_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    
    if (connection == Resend_Connect) {
        [Resend_tempData setLength:0];
        Resend_expectedLength = [aResponse expectedContentLength];
    }
    
    if (connection == ChangeLogo_Connect) {
        [ChangeLogo_tempData setLength:0];
        ChangeLogo_expectedLength = [aResponse expectedContentLength];
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error = %@",[error localizedDescription]);
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

//讀取登入資料
-(void)HttpReadLoginData
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Login_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    
    //20140321update
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"AutoLogin"]; //Add the file name
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath2 = [paths2 objectAtIndex:0]; //Get the docs directory
    NSString *filePath2 = [documentsPath2 stringByAppendingPathComponent:@"rememberMe"];
    [autoLogin writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [rememberMe writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //20140321update

    if ([status isEqualToString:str1])
    {
//        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
//        [self presentModalViewController:ViewController animated:YES];
        [self loadUserDic:[usersOne objectForKey:@"list"]];
    }
    else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
        [HUD hide:YES];
    }
}

//儲存所有佩戴者帳號
-(void)loadUserDic:(NSArray *)arr
{
    NSLog(@"%@",arr);
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    //清空所有佩戴者資料
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    int accNum = 0;
    
    for (int i=0; i<[arr count]; i++) {
        
//        if ([[[arr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
        //擋住使用者 type = 1 is 700
        if ([[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType1] ||
            [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType2]
            )
        {
        
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"type"] forKey:[NSString stringWithFormat:@"Type%i",accNum+1]];
            
            NSLog(@"account Acc %@ Key %@",[[arr objectAtIndex:i] objectForKey:@"account"],[NSString stringWithFormat:@"Acc%i",accNum+1]);
             NSLog(@"Name %@ Key %@",[[arr objectAtIndex:i] objectForKey:@"name"],[NSString stringWithFormat:@"Name%i",accNum+1]);
                
            accNum++;
        }
    }
//    if (accTxt.text.length == 0) {
//        
//    }
//    else{
//        
//    }
    [defaults setObject:accTxt.text forKey:@"userAccount"];
    [defaults setObject:pwdTxt.text forKey:@"userHash"];
    [defaults setInteger:accNum forKey:@"totalcount"];
    [defaults setInteger:0 forKey:@"MAP_TYPE"];
    [defaults setInteger:1 forKey:@"nowuser"];
    [defaults setInteger:1 forKey:@"quickCall"];
    [defaults setObject:token forKey:@"token"];
    //save accList 擋住使用者(需要)
    [defaults setObject:arr forKey:@"accList"];
    [defaults synchronize];

//    [defaults synchronize];
    
    UIViewController *naviViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
    //ios7 modify

    [self presentViewController:naviViewController animated:YES completion:^{
        NSLog(@"default = %@",[defaults objectForKey:@"Name1"]);
        [HUD hide:YES];
    }];
//    [self presentModalViewController:naviViewController animated:YES];
    
    
}


//讀取重寄驗證信解析
-(void)HttpResendData
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Resend_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [HUD hide:YES];
    
    if( [status isEqualToString:str1]  )
    {
        //重寄驗證信成功
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"Login_AuthResend", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        
        [alertView show];
        
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");
    }
    
}


//alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"is tag = %i",[alertView tag]);
    if ([alertView tag] == 3) {
        //帳號未啓用
        if (buttonIndex == 1) {
            NSLog(@"resend");
            [self Resend:accTxt.text];
        }
    }
}


//重寄驗證信
-(void)Resend:(NSString *)account
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *ResendApi = [NSString stringWithFormat:@"%@/API/AppSendAuthEmail.html",INK_Url_1];
    
    NSString *httpBodyString = [NSString stringWithFormat:@"userAccount=%@",account];
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"api = %@",ResendApi);
    
    
    
    [request setURL:[NSURL URLWithString:ResendApi]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Resend_tempData = [NSMutableData alloc];
    Resend_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}




//設定推播Token
-(void)setToken:(NSString *)temptoken
{
    token = temptoken;
    NSLog(@"is token = %@",token);
}









-(IBAction)backgroundBtn_Click:(id)sender
{
    [self resetViewAndKeyBoard];
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
    [pwdTxt resignFirstResponder];
}

//LoadingView
-(void)addLoadingView
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    //    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HUD show:YES];
}


-(NSString *)returnToken
{
    NSLog(@"token %@",token);
    return token;
}


-(void)firstLogin
{
    NSLog(@"YES");
    iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    
    for (int i = 0; i < TOTALPAGE; i++) {
        UIImageView *imageName = [[UIImageView alloc] initWithFrame:CGRectMake(iOSDeviceScreenSize.width*i, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
        NSString *imageStr = [NSString stringWithFormat:@"f%i.png",i+1];
        NSLog(@"imageStr = %@",imageStr);
        [imageName setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f%i.png",i+1]]];
        
        [firstScrollView addSubview:imageName];
    }
    
    int j = TOTALPAGE -1;
    
    int lastPageWeight = iOSDeviceScreenSize.width*j;
    int lastPageWeight1 = iOSDeviceScreenSize.width*(j+1);
        
    int centerWeight = lastPageWeight +(lastPageWeight1 - lastPageWeight)/2;
        
    NSLog(@"lastPageWeight = %i lastPageWeight1 = %i centerWeight = %i",lastPageWeight ,lastPageWeight1,centerWeight);
    
    
    enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 400, 60, 40)];
    [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [enterBtn setTitle:@"SKIP" forState:UIControlStateNormal];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [firstView addSubview:enterBtn];
    [self.view addSubview:firstView];
    
    /*
    UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(centerWeight-50, iOSDeviceScreenSize.height - 100, 100, 40)];
    [enterBtn layer].cornerRadius = 8.0f;
    [enterBtn layer].borderWidth = 2.0f;
    [enterBtn layer].borderColor = [[UIColor whiteColor] CGColor];
    [enterBtn layer].backgroundColor = [[UIColor orangeColor] CGColor];
    [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(3840, 0, 60, 40)];
    
        
    [enterBtn setTitle:NSLocalizedStringFromTable(@"StartUse", INFOPLIST, nil) forState:UIControlStateNormal];
    [firstScrollView addSubview:enterBtn];
    
    
    [self.view addSubview:firstView];
     */
}

-(IBAction)enterBtnClick:(id)sender
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:@"First"];
    
    [firstView removeFromSuperview];
}

-(IBAction)QrcodeLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}


//隱藏功能換Logo
-(IBAction)changeLogo:(id)sender
{
    changeCount ++;
    NSLog(@"Change Logo Click %i",changeCount);
    if (changeCount == 20)
    {
        changeCount = 0;
        [self.view addSubview:changeLogo];
        changePw.text = @"";
    }else
    {
        
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");
//    accTxt.text = @"test";
//    pwdTxt.text = @"test";
    changeCount =0;
}

-(IBAction)changeFunction:(id)sender
{
    NSLog(@"sender Tag = %i",[(UIView*)sender tag]);
    [changePw resignFirstResponder];
    
    switch ([(UIView*)sender tag]) {
        case 1:
            [self downLoadLogo];
            break;
        
        case 2://取消
            [changeLogo removeFromSuperview];
            break;
            
        case 3:
            [self clearLogo];
            break;
    }
}

//選擇下載Logo
-(void)downLoadLogo
{
    if (changePw.text.length >0)
    {
        //讀取清單
        [self getLogoListWithPwd:changePw.text];
        changePwStr = changePw.text;
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"請輸入密碼" delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
        [alertView show];
    }
}



-(void)getLogoListWithPwd:(NSString *)pwd
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    httpBodyString = [NSString stringWithFormat:@"demoKey=%@",pwd];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"http://210.242.50.125:8080/salesWeb/API/getPicList.do"];
    
    NSLog(@"changeLogo API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    
    
    
    ChangeLogo_tempData = [NSMutableData alloc];
    ChangeLogo_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}


-(void)HttpChangeLogoURL
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ChangeLogo_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];
    
    NSLog(@"usersOne = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [HUD hide:YES];
    
    if( [status isEqualToString:str1]  )
    {
    self.alert = [MLTableAlert tableAlertWithTitle:@"圖片列表" cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) numberOfRows:^NSInteger (NSInteger section)
                  {
                      /*
                       if (self.rowsNumField.text == nil || [self.rowsNumField.text length] == 0 || [self.rowsNumField.text isEqualToString:@"0"])
                       return 1;
                       else
                       return [self.rowsNumField.text integerValue];
                       */
                      return [[usersOne objectForKey:@"list"] count];
                  }
                                          andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                      
                      
                      
                      
                      cell.textLabel.text = [NSString stringWithFormat:@"%@",[[[usersOne objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name"]];

                      
                      return cell;
                  }];
    
    // Setting custom alert height
    self.alert.height = 350;
    
    // configure actions to perform
    
    
    
    [self.alert configureSelectionBlock:^(NSIndexPath *selectedIndex)
     {
         //		self.resultLabel.text = [NSString stringWithFormat:@"Selected Index\nSection: %d Row: %d", selectedIndex.section, selectedIndex.row];
         [self downLoadImage:[[[[usersOne objectForKey:@"list"] objectAtIndex:selectedIndex.row] objectForKey:@"pid"] integerValue]];
     } andCompletionBlock:^{
         //		self.resultLabel.text = @"Cancel Button Pressed\nNo Cells Selected";
         
     }];
    
    [self.alert show];
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}


//選擇後開始下載圖片
-(void)downLoadImage:(int)selectNum
{
    NSLog(@"select Num = %i",selectNum);
    [changeLogo removeFromSuperview];
    [self downLoadImageUrl:changePwStr andPid:selectNum];
}



-(void)downLoadImageUrl:(NSString *)pwd andPid:(int)pid
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *httpBodyString;
    
    httpBodyString = [NSString stringWithFormat:@"demoKey=%@&pid=%i",pwd,pid];
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"http://210.242.50.125:8080/salesWeb/API/getPic.do"];
    
    NSLog(@"changeLogo API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    
    
    
    ChangeImgUrl_tempData = [[NSMutableData alloc] init];
    ChangeImgUrl_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}




-(void)HttpChangeImage
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:ChangeImgUrl_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];
    
    NSLog(@"usersOne = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    NSArray *imgArr = [usersOne objectForKey:@"list"];
    [HUD hide:YES];
    
    if( [status isEqualToString:str1]  )
    {
        NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        for (int i = 0; i < [imgArr count]; i++)
        {
            //Definitions
            
            //下載儲存icon
            if ([[[imgArr objectAtIndex:i] objectForKey:@"type"] integerValue] == 0)
            {
                //Get Image From URL
                UIImage * imageFromURL = [self getImageFromURL:[[imgArr objectAtIndex:i] objectForKey:@"ios"]];
                
                //Save Image to Directory
                [self saveImage:imageFromURL withFileName:@"ios_icon" ofType:@"png" inDirectory:documentsDirectoryPath];
            }
            
            //下載儲存icon
            if ([[[imgArr objectAtIndex:i] objectForKey:@"type"] integerValue] == 1)
            {
                //Get Image From URL
                UIImage * imageFromURL = [self getImageFromURL:[[imgArr objectAtIndex:i] objectForKey:@"ios"]];
                
                //Save Image to Directory
                [self saveImage:imageFromURL withFileName:@"ios_logo" ofType:@"png" inDirectory:documentsDirectoryPath];
            }
            
            //下載儲存icon
            if ([[[imgArr objectAtIndex:i] objectForKey:@"type"] integerValue] == 2)
            {
                //Get Image From URL
                UIImage * imageFromURL = [self getImageFromURL:[[imgArr objectAtIndex:i] objectForKey:@"ios"]];
                
                //Save Image to Directory
                [self saveImage:imageFromURL withFileName:@"ios_bar" ofType:@"png" inDirectory:documentsDirectoryPath];
            }
        }
        
        [self LoadAndChangeLogo];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1 WithSender:self];
        NSLog(@"error happen");
    }
}



-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}


-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

//下載並更換Logo
-(void)LoadAndChangeLogo
{
    //Definitions
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //Load Image From Directory
    UIImage * imageFromWeb = [self loadImage:@"ios_logo" ofType:@"png" inDirectory:documentsDirectoryPath];
    
    if (imageFromWeb)
    {
        img_logo.image = imageFromWeb;
    }else
    {
        img_logo.image = [UIImage imageNamed:@"logo.png"];
    }
    
}




-(void)clearLogo
{
    [changeLogo removeFromSuperview];
    //Definitions
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath_icon = [documentsDirectoryPath stringByAppendingString:@"/ios_icon.png"];
    NSString *filePath_logo = [documentsDirectoryPath stringByAppendingString:@"/ios_logo.png"];
    NSString *filePath_bar = [documentsDirectoryPath stringByAppendingString:@"/ios_bar.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    //判斷plist檔案存在時才刪除icon
    if ([fileManager fileExistsAtPath: filePath_icon])
    {
        [fileManager removeItemAtPath:filePath_icon error:NULL];
    }
    
    //判斷plist檔案存在時才刪除Logo
    if ([fileManager fileExistsAtPath: filePath_logo])
    {
        [fileManager removeItemAtPath:filePath_logo error:NULL];
    }
    
    //判斷plist檔案存在時才刪除bar
    if ([fileManager fileExistsAtPath: filePath_bar])
    {
        [fileManager removeItemAtPath:filePath_bar error:NULL];
    }
    [self LoadAndChangeLogo];
}


-(void)viewDidAppear:(BOOL)animated
{
//    self.screenName = @"View_Login";
    [super viewDidAppear:animated];
}

//20140321 update
- (IBAction)ibaAutoLogin:(id)sender {
    if ([autoLogin isEqualToString:@"YES"]) {
        autoLogin = @"NO";
    }
    else{
        autoLogin = @"YES";
    }
    [self changeAutoLoginImage];
}

- (IBAction)ibaRememberMe:(id)sender {
    if ([rememberMe isEqualToString:@"YES"]) {
        rememberMe = @"NO";
    }
    else{
        rememberMe = @"YES";
    }
    [self changeRememberMeImage];
}
//20140321 update
@end
