//
//  UnderRightViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "UnderRightViewController.h"

@interface UnderRightViewController()
{
    NSString *testAcc;
    BOOL willLogOut;
}
@property (nonatomic, assign) CGFloat peekLeftAmount;
@end

@implementation UnderRightViewController
@synthesize peekLeftAmount,settingArray,setView;


NSURLConnection *Logout_Connect;
NSMutableData *Logout_tempData;    //下載時暫存用的記憶體
long long Logout_expectedLength;        //檔案大小

NSURLConnection *NotiLogout_Connect;
NSMutableData *NotiLogout_tempData;    //下載時暫存用的記憶體
long long NotiLogout_expectedLength;        //檔案大小

NSURLConnection *NotiLogin_Connect;
NSMutableData *NotiLogin_tempData;    //下載時暫存用的記憶體
long long NotiLogin_expectedLength;        //檔案大小


- (void)viewDidLoad
{
  [super viewDidLoad];
    _navi.title = NSLocalizedStringFromTable(@"Header_Setting", INFOPLIST, nil);
    
    
    NSArray *set1 = [NSArray arrayWithObjects:NSLocalizedStringFromTable(@"Personal_MyAccount", INFOPLIST, nil),NSLocalizedStringFromTable(@"Personal_WatcherManager", INFOPLIST, nil), nil];
    
    NSString *verson = [NSString stringWithFormat:@"%@ %@",NSLocalizedStringFromTable(@"Setting_Version", INFOPLIST, nil),[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];
    
//    NSArray *set2 = [NSArray arrayWithObjects:NSLocalizedStringFromTable(@"Setting_Notification", INFOPLIST, nil),
//                     NSLocalizedStringFromTable(@"Setting_Question", INFOPLIST, nil),NSLocalizedStringFromTable(@"Setting_AboutUS", INFOPLIST, nil),NSLocalizedStringFromTable(@"Setting_Logout", INFOPLIST, nil),verson, nil];
    
    NSArray *set2 = [NSArray arrayWithObjects:NSLocalizedStringFromTable(@"Setting_Notification", INFOPLIST, nil),NSLocalizedStringFromTable(@"Setting_Logout", INFOPLIST, nil),verson, nil];
    
    settingArray = [NSArray arrayWithObjects:set1,set2, nil];
    
  self.peekLeftAmount = 60.0f;
  [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
  self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dict = [defaults dictionaryRepresentation];
    NSLog(@"右側Menu");
//    NSLog(@"userdefaults = %@",dict);
    NSLog(@"userAcc = %@",[defaults objectForKey:@"userAccount"]);
    testAcc = [defaults objectForKey:@"userAccount"];
    willLogOut = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [settingArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return NSLocalizedStringFromTable(@"Setting_Personal", INFOPLIST, nil);
    }
    if (section == 1)
    {
        return NSLocalizedStringFromTable(@"Setting_Setting", INFOPLIST, nil);
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [[settingArray objectAtIndex:sectionIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ComposeCell";
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SetCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SetCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.title.text = [[settingArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.btn1.hidden = YES;
    cell.btn2.hidden = YES;
    cell.switch1.hidden = YES;
    
    /*
    if ((indexPath.section == 1 )&& (indexPath.row == 0)) {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults integerForKey:@"MAP_TYPE"] == 0) {
            [cell.btn1 setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
            [cell.btn2 setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
        }else
        {
            [cell.btn1 setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
            [cell.btn2 setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
        }
     
        cell.btn1.hidden = NO;
        cell.btn2.hidden = NO;
        cell.google.text = NSLocalizedStringFromTable(@"MapSet_Default", INFOPLIST, nil);
        cell.google.hidden = NO;
        cell.baidu.text = NSLocalizedStringFromTable(@"MapSet_Baidu", INFOPLIST, nil);
        cell.baidu.hidden = NO;
        [cell.btn1 setTag:0];
        [cell.btn2 setTag:1];
        
        [cell.btn1 addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn2 addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventTouchUpInside];
        
     
    }
    
     
    if ((indexPath.section == 1 )&& (indexPath.row == 1)) {
        cell.switch1.hidden = NO;
        [cell.switch1 addTarget:self action:@selector(quickCall:) forControlEvents:UIControlEventValueChanged];
    }
    */
    
    if ((indexPath.section == 1 )&& (indexPath.row == 0)) {
        cell.switch1.hidden = NO;
        [cell.switch1 addTarget:self action:@selector(notification:) forControlEvents:UIControlEventValueChanged];
    }
    
//    if ((indexPath.section == 1 )&& (indexPath.row == 1)) {
//        cell.switch1.hidden = NO;
//        [cell.switch1 addTarget:self action:@selector(Activity_tracking:) forControlEvents:UIControlEventValueChanged];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        //isTestAcc
        if ([testAcc isEqualToString:@"test"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
            [alert show];
            return;
        }
        //isTestAcc End
        switch (indexPath.row) {
                
            case 0://我的帳號
            {
                [self.slidingViewController resetTopViewWithAnimations:nil
                                                            onComplete:^{
                    [(MainClass *)self.slidingViewController.topViewController.view Other_MouseDown:1001];
                }];
            }
                break;
                
            case 1://佩戴者管理
            {
                [self.slidingViewController resetTopViewWithAnimations:nil onComplete:^{
                    [(MainClass *)self.slidingViewController.topViewController.view Other_MouseDown:1004];
                }];
            }
                break;
                
        }
    
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            
//            case 1://常見問題
////                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mcarewatch.com.au/"]];
//                break;
//                
//            case 2://關於我們
////                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mcarewatch.com.au/"]];
//                
////                [self LogOut];
//                
////                [self tempLogout];
//                
//                break;
            case 1://登出
                NSLog(@"Activity tracking");
                
                [self LogOut];
                
                //                [self tempLogout];
                
                break;
            case 2://登出
                NSLog(@"isLogOut");
                
                [self LogOut];
                
                //                [self tempLogout];
                
                break;
                
            default:
                break;
        }
    }
    
    
}





//登出
-(void)LogOut
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *acc = [defaults objectForKey:@"userAccount"];
    NSString *pwd = [defaults objectForKey:@"userHash"];
    NSString *token = [defaults objectForKey:@"token"];
    
//    NSLog(@"Top View is %@",[(ViewController *)self.slidingViewController.topViewController token]);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
    //    NSLog(tmpstr);
    
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
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&token=012345&appid=%i&device=0",acc, hash,dateString,APPID];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&token=%@&appid=%i&device=0",acc, hash,dateString,token,APPID];
        
    }
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogout.html",INK_Url_1];
    
    NSLog(@"Logout API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];

    Logout_tempData = [NSMutableData alloc];
    Logout_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
}

-(void)addloadingView
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    //    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [HUD show:YES];
}

//登出解析
-(void)Http_Logout
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Logout_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    
    if( [status isEqualToString:str1]  )
    {
        
        
        
        
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        //清空所有佩戴者資料
        NSDictionary * dict = [defaults dictionaryRepresentation];
        //20140321
        NSString *acc = [defaults objectForKey:@"userAccount"];
        NSString *pwd = [defaults objectForKey:@"userHash"];
        //20140321
        
        for (id key in dict) {
            if (![key isEqualToString:@"token"]) {
                [defaults removeObjectForKey:key];
            }
        }
        [defaults synchronize];
        
        
        //20140321
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"AutoLogin"]; //Add the file name
        NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath2 = [paths2 objectAtIndex:0]; //Get the docs directory
        NSString *filePath2 = [documentsPath2 stringByAppendingPathComponent:@"rememberMe"];
        //        NSString *autoLogin;
        NSString *rememberMe;
        [@"NO" writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        rememberMe = [[NSString alloc]initWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
        [rememberMe writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if ([rememberMe isEqualToString:@"YES"]) {
            if (![acc isEqualToString:@"test"]) {
                [defaults setObject:acc forKey:@"userAccount"];
                [defaults setObject:pwd forKey:@"userHash"];
            }
            else{
                [@"NO" writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        }
        [defaults synchronize];
        //20140321
        
        willLogOut = YES;
        UIViewController *qrcodelogin = [self.storyboard instantiateInitialViewController];
        
        [self.navigationController pushViewController:qrcodelogin animated:NO];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        [HUD hide:YES];
    }
}

//暫時使用此方法  等Token問題解決
-(void)tempLogout
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    //清空所有佩戴者資料
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    UIViewController *login = [self.storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:login animated:NO];
}




-(IBAction)quickCall:(id)sender
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    UISwitch *switchView = (UISwitch *)sender;
    if ([switchView isOn])  {
        [defaults setInteger:1 forKey:@"quickCall"];
        NSLog(@"open");
    } else {
        [defaults setInteger:0 forKey:@"quickCall"];
        NSLog(@"close");
    }
    [defaults synchronize];
    
}

//開啟推播通知
-(void)OpenNotification
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *acc = [defaults objectForKey:@"userAccount"];
    NSString *pwd = [defaults objectForKey:@"userHash"];
    NSString *token = [(ViewController *)self.slidingViewController.topViewController token];
    
    //    NSLog(@"Top View is %@",[(ViewController *)self.slidingViewController.topViewController token]);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
    //    NSLog(tmpstr);
    
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
    
    if(token.length >10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&token=%@&appid=%i&device=0",acc, hash,dateString,token,APPID];
    }
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogin.html",INK_Url_1];
    
    NSLog(@"Login API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    NotiLogout_tempData = [NSMutableData alloc];
    NotiLogout_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
}



//關閉推播通知
-(void)CloseNotification
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *acc = [defaults objectForKey:@"userAccount"];
    NSString *pwd = [defaults objectForKey:@"userHash"];
    NSString *token = [(ViewController *)self.slidingViewController.topViewController token];
    
    //    NSLog(@"Top View is %@",[(ViewController *)self.slidingViewController.topViewController token]);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    tmpstr =[NSString stringWithFormat:@"%@%@%@", acc, pwd,dateString];
    
    //    NSLog(tmpstr);
    
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
    
    if(token.length >10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&data=%@&timeStamp=%@&token=%@&appid=%i&device=0",acc, hash,dateString,token,APPID];
    }
    
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *loginApi = [NSString stringWithFormat:@"%@/AppLogout.html",INK_Url_1];
    
    NSLog(@"Logout API = %@?%@",loginApi,httpBodyString);
    
    [request setURL:[NSURL URLWithString:loginApi]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    NotiLogout_tempData = [NSMutableData alloc];
    NotiLogout_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addloadingView];
}

-(IBAction)Activity_tracking:(id)sender
{
    UISwitch *switchView = (UISwitch *)sender;
    if ([switchView isOn])  {
        //開啟推播通知
        NSLog(@"Activity_tracking open");
        
    } else {
        //關閉推播通知
        
        NSLog(@"Activity_tracking close");
    }
}


-(IBAction)notification:(id)sender
{
    UISwitch *switchView = (UISwitch *)sender;
    if ([switchView isOn])  {
        //開啟推播通知
        NSLog(@"open");
        [self OpenNotification];
    } else {
        //關閉推播通知
        [self CloseNotification];
        NSLog(@"close");
    }
}

//改變預設地圖
-(IBAction)changeMapType:(id)sender
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:[(UIView*)sender tag] forKey:@"MAP_TYPE"];
    [defaults synchronize];
    
    [setView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"self top view %@",self.slidingViewController.topViewController);
    
    if ([self.slidingViewController.topViewController isKindOfClass:[ViewController class]]) {
        [(MainClass *)self.slidingViewController.topViewController.view Right_Return];
    }
}

- (void)viewDidUnload {
    [self setNavi:nil];
    [super viewDidUnload];
}


//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    NSLog(@"didReceiveData");
    
    if(connection == Logout_Connect)
    {
        [Logout_tempData appendData:incomingData];
    }else if (NotiLogout_Connect)
    {
        [NotiLogout_tempData appendData:incomingData];
    }else if (NotiLogin_Connect)
    {
        [NotiLogin_tempData appendData:incomingData];
    }
}

- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    
    NSLog(@"didReceiveResponse");
    
    //取得狀態
    if(connection == Logout_Connect)
    {
        [Logout_tempData setLength:0];
        Logout_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }else if (connection == NotiLogout_Connect)
    {
        [NotiLogout_tempData setLength:0];
        NotiLogout_expectedLength = [aResponse expectedContentLength];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    NSLog(@"connectionDidFinishLoading");
    
    if(connection == Logout_Connect)
    {
        [self Http_Logout];
    }else if (connection == NotiLogout_Connect)
    {
        [self Http_NotiLogout];
    }else if (connection == NotiLogin_Connect)
    {
        [self Http_NotiLogin];
    }
}

//關閉推播解析
-(void)Http_NotiLogout
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:NotiLogout_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0];
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSLog(@"users one = %@",usersOne);
    
    [HUD hide:YES];
    if( [status isEqualToString:str1]  )
    {
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
    }
}

//開啟推播解析
-(void)Http_NotiLogin
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:NotiLogin_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    [HUD hide:YES];
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    if( [status isEqualToString:str1]  )
    {
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
    }
}

@end
