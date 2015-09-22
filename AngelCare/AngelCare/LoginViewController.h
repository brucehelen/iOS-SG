//
//  LoginViewController.h
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "HashSHA256.h"
#import "CheckErrorCode.h"
#import "MBProgressHUD.h"
#import "CheckNetWork.h"
#import "ViewController.h"

@class MLTableAlert;

@interface LoginViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate,UIScrollViewDelegate>
{
    NSString *token;
    MBProgressHUD *HUD;
    CheckNetwork *checkNetWork;
    IBOutlet UIView *firstView;
    IBOutlet UIScrollView *firstScrollView;
    IBOutlet UIPageControl *pageControl;
    CGSize iOSDeviceScreenSize;
    UIButton *enterBtn;
    
    IBOutlet UIView *changeLogo;
    IBOutlet UITextField *changePw;
    IBOutlet UIButton *btn_download;
    IBOutlet UIButton *btn_cancel;
    IBOutlet UIButton *btn_clear;
    int changeCount;
    NSString *changePwStr;
    IBOutlet UIImageView *img_logo;
}

@property (strong, nonatomic) MLTableAlert *alert;

@property (nonatomic,strong) IBOutlet UITextField *accTxt;
@property (nonatomic,strong) IBOutlet UITextField *pwdTxt;
@property (nonatomic,strong) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong) IBOutlet UIButton *forgetBtn;
@property (nonatomic,strong) IBOutlet UIButton *createBtn;
@property (nonatomic,strong) IBOutlet UIButton *qrcodeLoginBtn;

//20140321 update
@property (strong, nonatomic) IBOutlet UILabel *lblAutoLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblRememberMe;
@property (strong, nonatomic) IBOutlet UIButton *btnAutoLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnRememberMe;
- (IBAction)ibaAutoLogin:(id)sender;
- (IBAction)ibaRememberMe:(id)sender;
//20140321 update


-(void)setToken:(NSString *)token;

//登入
-(IBAction)loginBtnClick:(id)sender;

-(IBAction)backgroundBtn_Click:(id)sender;

-(NSString *)returnToken;

-(void)firstLogin;

-(IBAction)enterBtnClick:(id)sender;

-(IBAction)QrcodeLogin:(id)sender;

-(IBAction)changeLogo:(id)sender;

-(IBAction)changeFunction:(id)sender;
-(void)loginWithAcc:(NSString *)acc andPwd:(NSString *)pwd;
@end
