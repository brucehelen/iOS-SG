//
//  CreateNewAccViewController.h
//  AngelCare
//
//  Created by macmini on 13/6/25.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "RegexKitLite.h"
#import "CheckErrorCode.h"
#import "define.h"

@interface CreateNewAccViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    BOOL isCheckAcc;
    BOOL isAgree;
    NSString *accountStr;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *Navi;

@property (strong, nonatomic) IBOutlet UITextField *accTxt;
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic) IBOutlet UITextField *checkName;

@property (strong, nonatomic) IBOutlet UITextField *pass1Txt;
@property (strong, nonatomic) IBOutlet UITextField *pass2Txt;

@property (strong, nonatomic) IBOutlet UITextField *phoneTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIButton *memberBtn;
@property (strong, nonatomic) IBOutlet UIButton *privacyBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkMemberAndPrivacy;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) IBOutlet UILabel *agreeLbl;

@property (strong, nonatomic) IBOutlet UILabel *lblBG1;
@property (strong, nonatomic) IBOutlet UILabel *lblBG2;
@property (strong, nonatomic) IBOutlet UILabel *lblBG3;

@property (strong, nonatomic) IBOutlet UIButton *btnCreate;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UIButton *btnUser;

//驗證帳號
- (IBAction)checkBtnClick:(id)sender;
//會員條款
- (IBAction)memberBtnClick:(id)sender;
//隱私條款
- (IBAction)privacyBtnClick:(id)sender;

//同意
- (IBAction)checkMemberAndPrivacyBtnClick:(id)sender;
//送出
- (IBAction)sendBtnClick:(id)sender;

//回上頁
-(IBAction)backBtnClick:(id)sender;

//觸碰背景隱藏鍵盤
-(IBAction)backgroundBtnClick:(id)sender;

@end
