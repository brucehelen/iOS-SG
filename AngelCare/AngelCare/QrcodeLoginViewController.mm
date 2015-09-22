//
//  QrcodeLoginViewController.m
//  AngelLite
//
//  Created by macmini on 13/11/8.
//
//

#import "QrcodeLoginViewController.h"
//#import <QRCodeReader.h>
//#import <Crashlytics/Crashlytics.h>
@interface QrcodeLoginViewController ()
{
    UIButton *button;
}
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;


@end



@implementation QrcodeLoginViewController

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
    [whereToBuyBtn setTitle:NSLocalizedStringFromTable(@"Login_WhereToBuy", INFOPLIST, nil) forState:UIControlStateNormal];
    [useAccBtn setTitle:NSLocalizedStringFromTable(@"Login_UserAcc", INFOPLIST, nil) forState:UIControlStateNormal];
    
    [qrcodeBtn setTitle:NSLocalizedStringFromTable(@"Login_QRCodeLoginBtn", INFOPLIST, nil) forState:UIControlStateNormal];
    
    [self.btnTestAcc setTitle:NSLocalizedStringFromTable(@"TestAccount", INFOPLIST, nil) forState:UIControlStateNormal];
    
    [self LoadAndChangeLogo];
	// Do any additional setup after loading the view.
    
    UIButton *btnC = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnC addTarget:self action:@selector(crash) forControlEvents:UIControlEventTouchUpInside];
    [btnC setTitle:@"crash" forState:UIControlStateNormal];
//    [self.view addSubview:btnC];
}
- (void)crash{
//    [[Crashlytics sharedInst- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)resultance] crash];
}
//點擊QRCode登入



//掃描結果
//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
//{
//    NSLog(@"result = %@",result);
//    // 扫描界面退出
//    [self dismissViewControllerAnimated:NO completion:^{
//        NSLog(@"dismissViewControllerAnimated");
//        userAcc = result;
//        [self showalertViewToEnterPwd];
//    }];
//}


//取消掃描
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
//{
//    NSLog(@"cancel");
//    //ios7 modify
//    [self dismissViewControllerAnimated:NO completion:nil];
////    [self dismissModalViewControllerAnimated:NO];
//}

    //拍攝完成後按下使用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    /*
        // 得到条形码结果
        id<NSFastEnumeration> results =
        [info objectForKey: ZBarReaderControllerResults];
        ZBarSymbol *symbol = nil;
        for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
        
        //取得
        NSLog(@"symbol.data = %@",symbol.data);
        
        
        // 扫描界面退出
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"dismissViewControllerAnimated");
            userAcc = symbol.data;
            [self showalertViewToEnterPwd];
        }];
     */
}

    
-(void)showalertViewToEnterPwd
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"Login_QRCodeAlert", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    
    [alertView show];
}
    
    
    
    
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        NSLog(@"button Index = %i",buttonIndex);
    
            if (buttonIndex == 1) {
                //        NSLog(@"account %@ ",[[alertView textFieldAtIndex:0] text]);
                //        NSLog(@"pwd %@ ",[[alertView textFieldAtIndex:1] text]);
                
                userPwd = [[alertView textFieldAtIndex:0] text];
                
//                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userAcc,@"account",userPwd,@"pwd", nil];
                
                NSLog(@"userAcc = %@  userPwd = %@",userAcc,userPwd);
                [self loginWithAcc:userAcc andPwd:userPwd];
//                [(MainClass *)MainObj Send_AddMemberdata:dic];
            }
}
        

    
//登入
-(void)loginWithAcc:(NSString *)acc andPwd:(NSString *)pwd
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
        
        NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        token = [defaults objectForKey:@"token"];
        
        NSLog(@"token = ====== %@",[defaults objectForKey:@"token"]);
        
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
        
        //    token = @"94095199e97111b9cc088e8c518627ce9b2576dbb5067af5bd8980841f3023c5";
        
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

    //LoadingView
-(void)addLoadingView
{
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Loading";
    }
    
        //    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        [HUD show:YES];
}

    //收到封包，將收到的資料塞進緩衝中並修改進度條
-(void) connection:(NSURLConnection *)connection didReceiveData: (NSData *) incomingData
{
        if(connection == Login_Connect)
        {
            [Login_tempData appendData:incomingData];
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{   //檔案下載完成
        //取得可讀寫的路徑
        
        
        if(connection == Login_Connect)
        {
            [self HttpReadLoginData];
        }
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
        
        if( [status isEqualToString:str1]  )
        {
            //        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
            //        [self presentModalViewController:ViewController animated:YES];
            [self loadUserDic:[usersOne objectForKey:@"list"]];
            
        }else
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
        
        NSLog(@"default token = %@",[defaults objectForKey:@"token"]);
        token = [defaults objectForKey:@"token"];
        //清空所有佩戴者資料
        NSDictionary * dict = [defaults dictionaryRepresentation];
        for (id key in dict) {
            
                [defaults removeObjectForKey:key];
        }
        [defaults synchronize];
        
        int accNum = 0;
        for (int i=0; i<[arr count]; i++)
        {
            //判斷是否為小手機
            NSLog(@"typetype === %i",[[[arr objectAtIndex:i] objectForKey:@"type"] integerValue]);
            //擋住使用者
//            if ([[[arr objectAtIndex:i] objectForKey:@"type"] integerValue] != 0 )
            if ([[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType1] ||
                [[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] objectForKey:@"type"]] isEqualToString:UserDeviceType2]
                )
            {
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"account"] forKey:[NSString stringWithFormat:@"Acc%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"name"] forKey:[NSString stringWithFormat:@"Name%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"phone"] forKey:[NSString stringWithFormat:@"Phone%i",accNum+1]];
                [defaults setObject:[[arr objectAtIndex:i] objectForKey:@"type"] forKey:[NSString stringWithFormat:@"Type%i",accNum+1]];
                accNum ++;
            }
            
        }
        
        [defaults setObject:userAcc forKey:@"userAccount"];
        [defaults setObject:userPwd forKey:@"userHash"];
        [defaults setInteger:accNum forKey:@"totalcount"];
        [defaults setInteger:0 forKey:@"MAP_TYPE"];
        [defaults setInteger:1 forKey:@"nowuser"];
        [defaults setInteger:1 forKey:@"quickCall"];
        [defaults setObject:token forKey:@"token"];
        [defaults setInteger:0 forKey:@"MODE"];//預設老人模式
        //檢查設備電話前置作業
        //save accList
        [defaults setObject:arr forKey:@"accList"];
        [defaults setObject:@"YES" forKey:@"isQRcodeLogin"];
        [defaults synchronize];
        
        
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *nowDate;
        nowDate = [dateFormatter stringFromDate:now];
        NSDictionary *importantDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"isEnable",@"08:00",@"time",nowDate,@"date", nil];
        
        NSArray *improtantArr = [[NSArray alloc] initWithObjects:importantDic,importantDic, nil];
        [defaults setObject:improtantArr forKey:@"importantRemind"];
        
        NSDictionary *onSchoolDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"isEnable",@"0",@"w1",@"0",@"w2",@"0",@"w3",@"0",@"w4",@"0",@"w5",@"0",@"w6",@"0",@"w7",@"08:00",@"time", nil];
        NSArray *onSchoolArr = [[NSArray alloc] initWithObjects:onSchoolDic,onSchoolDic,onSchoolDic,onSchoolDic,onSchoolDic, nil];
        
        
        [defaults setObject:onSchoolArr forKey:@"onSchoolRemind"];
        [defaults synchronize];
        
        UIViewController *naviViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navi"];
        //ios7 modify
        [self presentViewController:naviViewController animated:YES completion:nil];
//        [self presentModalViewController:naviViewController animated:YES];
        
        NSLog(@"default = %@",[defaults objectForKey:@"Name1"]);
        [HUD hide:YES];
}


-(IBAction)normalLogin:(id)sender
{
    /*GA Start*/
    /*
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"View_Welcome"// Event category (required)
                                                          action:@"Btn_Click"  // Event action (required)
                                                           label:@"Click_Use_Normal"          // Event label
                                                           value:nil] build]];    // Event value
    [[GAI sharedInstance] dispatch];
    */
    /*GA End*/
}



-(IBAction)whereToBuy:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.guidercare.com"];
   [[UIApplication sharedApplication] openURL:url];
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

-(void)viewWillAppear:(BOOL)animated
{
    [self LoadAndChangeLogo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
//    self.screenName = @"View_Welcome";
    [super viewDidAppear:animated];
}

- (IBAction)ibaTestAcc:(id)sender {
    NSLog(@"***ibaTestAcc***");
    userAcc = @"guiderchina";
    userPwd = @"12345678";
    [self loginWithAcc:userAcc andPwd:userPwd];
}

#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    //add back
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(removeLayer)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}
-(void)removeLayer{
    [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
    [button removeFromSuperview];
    
}

-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            //            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            //            [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            _isReading = NO;
            
            // If the audio player is not nil, then play the sound effect.
            //            if (_audioPlayer) {
            //                [_audioPlayer play];
            //            }
            //成功！call api
            NSLog(@"%@",[metadataObj stringValue]);
            userAcc = [metadataObj stringValue];
            dispatch_sync(dispatch_get_main_queue(), ^{
                //                [self Send_AddMemberdataAcc:[metadataObj stringValue]];
                [self removeLayer];
                [self showalertViewToEnterPwd];
            });
            
        }
    }
    
    
}

-(IBAction)qrcodeLogin:(id)sender
{
    //new method
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            //            [_bbitemStart setTitle:@"Stop"];
            //            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
        // The bar button item's title should change again.
        //        [_bbitemStart setTitle:@"Start!"];
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}

@end
