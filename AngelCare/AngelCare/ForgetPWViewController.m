//
//  ForgetPWViewController.m
//  AngelCare
//
//  Created by macmini on 13/6/26.
//
//

#import "ForgetPWViewController.h"

@interface ForgetPWViewController ()

@end

@implementation ForgetPWViewController
@synthesize insertAcc,accTxt,insertEmail,emailTxt,sendBtn,Navi;


NSURLConnection *Forget_Connect;
NSMutableData *Forget_tempData;    //下載時暫存用的記憶體
long long Forget_expectedLength;        //檔案大小


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
    Navi.title = NSLocalizedStringFromTable(@"ForgetPassword", INFOPLIST, nil);
    insertAcc.text = NSLocalizedStringFromTable(@"InsertAcc", INFOPLIST, nil);
    insertEmail.text = NSLocalizedStringFromTable(@"InsertEmail", INFOPLIST, nil);
    
    accTxt.placeholder = NSLocalizedStringFromTable(@"Login_ACC", INFOPLIST, nil);
    emailTxt.placeholder = NSLocalizedStringFromTable(@"Email", INFOPLIST, nil);
    
    [sendBtn setTitle:NSLocalizedStringFromTable(@"Send", INFOPLIST, nil) forState:UIControlStateNormal];
    
    accTxt.delegate = self;
    emailTxt.delegate = self;
    
	// Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInsertAcc:nil];
    [self setAccTxt:nil];
    [self setInsertEmail:nil];
    [self setEmailTxt:nil];
    [self setSendBtn:nil];
    [self setNavi:nil];
    [super viewDidUnload];
}
- (IBAction)backBtnClick:(id)sender {
    //ios7 modify
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendBtnClick:(id)sender {
    
    if ([accTxt.text length] >0 || [emailTxt.text length] >0) {
        NSLog(@"送出");
        [self ForgetPwdAcc:accTxt.text andEmail:emailTxt.text];
    }else
    {
        NSLog(@"請輸入帳號或Email");
        
        NSString *forgetpassword = [NSString stringWithFormat:@"%@%@",NSLocalizedStringFromTable(@"InsertAcc", INFOPLIST, nil),NSLocalizedStringFromTable(@"InsertEmail", INFOPLIST, nil)];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:forgetpassword delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) otherButtonTitles: nil];
        
        [alertView show];
    }
    
}


-(void)ForgetPwdAcc:(NSString *)acc andEmail:(NSString *)email
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    NSString *forgetPwApi = [NSString stringWithFormat:@"%@/API/AppSendPWD.html?userAccount=%@&email=%@",INK_Url_1,acc,email];
    
    NSLog(@"api = %@",forgetPwApi);
    
    
    [request setURL:[NSURL URLWithString:forgetPwApi]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Forget_tempData = [NSMutableData alloc];
    Forget_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
}


//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    if(connection == Forget_Connect)
    {
        [Forget_tempData appendData:incomingData];
    }
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    
    
    if(connection == Forget_Connect)
    {
        [self HttpForgetData];
    }
}



- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    if(connection == Forget_Connect)
    {
        [Forget_tempData setLength:0];
        Forget_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
}


//讀取登入資料
-(void)HttpForgetData
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Forget_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    [HUD hide:YES];
    
    if( [status isEqualToString:str1]  )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"isSentEmail", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) otherButtonTitles: nil];
        
        [alertView setTag:101];
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
    if ([alertView tag] == 101) {
        //ios7 modify
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self dismissModalViewControllerAnimated:YES];
    }
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


- (IBAction)backgroundBtnClick:(id)sender
{
    [accTxt resignFirstResponder];
    [emailTxt resignFirstResponder];
}


@end
