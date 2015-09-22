//
//  ForgetPWViewController.h
//  AngelCare
//
//  Created by macmini on 13/6/26.
//
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "MBProgressHUD.h"
#import "CheckErrorCode.h"
@interface ForgetPWViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UILabel *insertAcc;
@property (strong, nonatomic) IBOutlet UITextField *accTxt;
@property (strong, nonatomic) IBOutlet UILabel *insertEmail;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) IBOutlet UINavigationItem *Navi;



//返回
- (IBAction)backBtnClick:(id)sender;
//送出
- (IBAction)sendBtnClick:(id)sender;

- (IBAction)backgroundBtnClick:(id)sender;

@end
