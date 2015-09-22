//
//  QrcodeLoginViewController.h
//  AngelLite
//
//  Created by macmini on 13/11/8.
//
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "HashSHA256.h"
#import "CheckErrorCode.h"
#import "MBProgressHUD.h"
//#import <ZXingWidgetController.h>
#import <AVFoundation/AVFoundation.h>
//@interface QrcodeLoginViewController : UIViewController<MBProgressHUDDelegate,ZXingDelegate>

@interface QrcodeLoginViewController : UIViewController<MBProgressHUDDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    NSString *userAcc;
    NSString *userPwd;
    NSString *token;
    NSURLConnection *Login_Connect;
    NSMutableData *Login_tempData;    //下載時暫存用的記憶體
    long long Login_expectedLength;        //檔案大小
    MBProgressHUD *HUD;
    
    IBOutlet UIButton *whereToBuyBtn;
    IBOutlet UIButton *useAccBtn;
    IBOutlet UIButton *qrcodeBtn;
    IBOutlet UIImageView *img_logo;
}

//點擊QRCode登入
-(IBAction)qrcodeLogin:(id)sender;
-(IBAction)normalLogin:(id)sender;
-(IBAction)whereToBuy:(id)sender;



@property (strong, nonatomic) IBOutlet UIButton *btnTestAcc;
- (IBAction)ibaTestAcc:(id)sender;


@end
