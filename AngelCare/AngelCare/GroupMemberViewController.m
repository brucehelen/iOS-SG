//
//  GroupMemberViewController.m
//  AngelCare
//
//  Created by macmini on 13/6/27.
//
//

#import "GroupMemberViewController.h"

@interface GroupMemberViewController ()

@end

@implementation GroupMemberViewController
@synthesize memberArray,memberList;


NSURLConnection *Add_Connect;
NSMutableData *Add_tempData;    //下載時暫存用的記憶體
long long Add_expectedLength;        //檔案大小

NSURLConnection *Del_Connect;
NSMutableData *Del_tempData;    //下載時暫存用的記憶體
long long Del_expectedLength;        //檔案大小

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
    [self readMemberList];
	// Do any additional setup after loading the view.
}

-(void)setInitSlider
{
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}


-(void)readMemberList
{
    memberArray = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    int nowuser = [[defaults objectForKey:@"nowuser"] integerValue];
    
    for (int i=0; i < [[defaults objectForKey:@"totalcount"] integerValue]; i++) {
        
        
        NSString *nameStr =[defaults objectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        NSString *isUser;
        if (i+1 == nowuser) {
            isUser = @"1";
        }else
        {
            isUser = @"0";
        }
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nameStr,@"name" ,isUser,@"now",nil];
        [memberArray addObject:dic];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [memberArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"GroupMemberCell";
    GroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    if (cell == nil) {
        cell = [[GroupMemberCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupMemberCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupMemberCell" owner:self options:nil] objectAtIndex:0];
    }
    
    [cell.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [cell.deleteBtn setTag:indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteMember:) forControlEvents:UIControlEventTouchUpInside];
    cell.NameLbl.text = [[memberArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    if ([[[memberArray objectAtIndex:indexPath.row] objectForKey:@"now"] integerValue]==1) {
        cell.isUserImg.image = [UIImage imageNamed:@"Red_Check_mark_1.png"];
    }else
    {
        cell.isUserImg.image = [UIImage imageNamed:@""];
    }
    
    
    return cell;
        
    
}


//刪除使用者
-(IBAction)deleteMember:(id)sender
{
    delNum = [(UIView*)sender tag];
    UIAlertView *addalertView = [[UIAlertView alloc] initWithTitle: NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                           message:@"是否要刪除使用者"
                                                          delegate:self
                                                 cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                                 otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    
    
    addalertView.tag = 2;
    
    [addalertView show];
}



//增加使用者
-(IBAction)addMember:(id)sender
{
    UIAlertView *addalertView = [[UIAlertView alloc] initWithTitle: NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                                 otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    
    addalertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    addalertView.tag = 1;
    
    [addalertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button Index = %i",buttonIndex);
    
    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            //        NSLog(@"account %@ ",[[alertView textFieldAtIndex:0] text]);
            //        NSLog(@"pwd %@ ",[[alertView textFieldAtIndex:1] text]);
            
            NSString *accStr = [[alertView textFieldAtIndex:0] text];
            NSString *pwdStr = [[alertView textFieldAtIndex:1] text];
            
            [self Add_UserAccount:accStr Pwd:pwdStr];
        }
    }
    
    if ([alertView tag] == 2) {
        if (buttonIndex == 1) {
            
            NSLog(@"test");
            NSUserDefaults *defaults;
            defaults = [NSUserDefaults standardUserDefaults];
            NSString *accNum = [NSString stringWithFormat:@"Acc%i",delNum+1];
            NSString *accStr = [defaults objectForKey:accNum];
            NSLog(@"accStr = %@",accStr);
            [self DeleteUserAccount:accStr];
        }
    }
}

//新增佩帶者資料(傳輸)
-(void) Add_UserAccount:(NSString *)acc Pwd:(NSString *)pwd
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *tmpSaveToken = [defaults objectForKey:@"token"];
    NSString *userAcc = [defaults objectForKey:@"userAccount"];
    NSString *userHash = [defaults objectForKey:@"userHash"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    
    
    
    tmpstr =[NSString stringWithFormat:@"%@%@%@", userAcc, userHash,dateString];
    
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSString *httpBodyString;
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=iOS",userAcc,acc,pwd,hash,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&gppassword=%@&data=%@&timeStamp=%@%%20%@&token=%@&device=iOS",userAcc,acc,pwd,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],tmpSaveToken];
        
    }
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppAddGroupMember.html",INK_Url_1];
    NSLog(@"loginApi = %@?%@",loginApi,httpBodyString);
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [request setURL:[NSURL URLWithString:loginApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Add_tempData = [NSMutableData alloc];
    Add_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
    
}


//刪除佩戴者
-(void)DeleteUserAccount:(NSString *)acc
{
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *tmpSaveToken = [defaults objectForKey:@"token"];
    NSString *userAcc = [defaults objectForKey:@"userAccount"];
    NSString *userHash = [defaults objectForKey:@"userHash"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    
    
    NSString *tmpstr;
    
    
    
    tmpstr =[NSString stringWithFormat:@"%@%@%@", userAcc, userHash,dateString];
    
    
    NSArray *arr = [dateString componentsSeparatedByString:@" "];
    
    
    
    NSData *dataIn = [tmpstr dataUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(dataIn.bytes, dataIn.length,  digest);
    
    
    NSData *out2=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out2 description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    request.timeoutInterval = TimeOutLimit;
    
    NSString *httpBodyString;
    if(tmpSaveToken.length <10)
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&data=%@&timeStamp=%@%%20%@&token=012345&device=iOS",userAcc,acc,hash,[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
    else
    {
        httpBodyString = [NSString stringWithFormat:@"userAccount=%@&gpaccount=%@&data=%@&timeStamp=%@%%20%@&token=%@&device=iOS",userAcc,acc,hash,[arr objectAtIndex:0],[arr objectAtIndex:1],tmpSaveToken];
        
    }
    NSString *loginApi = [NSString stringWithFormat:@"%@/API/AppDelGroupMember.html",INK_Url_1];
    NSLog(@"loginApi = %@?%@",loginApi,httpBodyString);
    
    
    NSData *httpBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [request setURL:[NSURL URLWithString:loginApi]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:httpBody];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    Del_tempData = [NSMutableData alloc];
    Del_Connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self addLoadingView];
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


//收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
    if(connection == Add_Connect)
    {
        [Add_tempData appendData:incomingData];
    }
    
    if(connection == Del_Connect)
    {
        [Del_tempData appendData:incomingData];
    }
}


- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{  //連線建立成功
    //取得狀態
    if(connection == Add_Connect)
    {
        [Add_tempData setLength:0];
        Add_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
    
    if(connection == Del_Connect)
    {
        [Del_tempData setLength:0];
        Del_expectedLength = [aResponse expectedContentLength]; //儲存檔案長度
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
    //取得可讀寫的路徑
    
    
    if(connection == Add_Connect)
    {
        [self HttpAddData];
    }
    
    if(connection == Del_Connect)
    {
        [self HttpDelData];
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
//解析新增使用者
-(void)HttpAddData
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Add_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSArray *arr = [usersOne objectForKey:@"list"];
    NSLog(@"arr = %@",arr);
    [HUD hide:YES];
    
    
    if( [status isEqualToString:str1]  )
    {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        for (int i =0; i<[arr count]; i++) {
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",i+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",i+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",i+1]];
        }
        [defaults setInteger:[arr count] forKey:@"totalcount"];
        [defaults synchronize];
        [self readMemberList];
        [memberList reloadData];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");

    }
}



//解析刪除使用者
-(void)HttpDelData
{
    NSError *error;
    NSInputStream *inStream = [[NSInputStream alloc] initWithData:Del_tempData];
    [inStream open];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithStream:inStream options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    NSLog(@"users one = %@",usersOne);
    NSString *status = [usersOne objectForKey:@"status"];
    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    
    NSArray *arr = [usersOne objectForKey:@"list"];
    NSLog(@"arr = %@",arr);
    [HUD hide:YES];
    
    
    if( [status isEqualToString:str1]  )
    {
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        for (int i =0; i<[arr count]; i++) {
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",i+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",i+1]];
            [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",i+1]];
        }
        [defaults setInteger:[arr count] forKey:@"totalcount"];
        [defaults synchronize];
        [self readMemberList];
        [memberList reloadData];
        
    }else
    {
        NSString *str1 =[usersOne objectForKey:@"msg"];
        [CheckErrorCode Check_Error:str1];
        NSLog(@"error happen");
        
    }
}


-(IBAction)backToMainView:(id)sender
{
    NSString *identifier = @"Index";
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    self.slidingViewController.topViewController = newTopViewController;
    [self.slidingViewController resetTopView];
}

@end
