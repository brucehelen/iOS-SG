//
//  MyAccountView.h
//  AngelCare
//
//  Created by macmini on 13/8/8.
//
//

#import <UIKit/UIKit.h>
#import "MyAccountCell.h"
#import "EditMyAccountCell.h"

@interface MyAccountView : UIView<UITextFieldDelegate>
{
    id MainObj;
    NSArray *titleArr;
    NSArray *nameArr;
    IBOutlet UIView *changePwView;
    IBOutlet UIView *subchangePwView;
    IBOutlet UILabel *titleBgLbl;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *firstLbl;
    IBOutlet UILabel *secLbl;
    IBOutlet UILabel *thirdLbl;
    
    IBOutlet UITextField *firstTxt;
    IBOutlet UITextField *secTxt;
    IBOutlet UITextField *thirdTxt;
    
    IBOutlet UIButton *saveBtn;
    IBOutlet UIButton *cancelBtn;
    
    int nowView;
    CGRect changePwFrame;
    
    IBOutlet UIView *bgView;
    
    IBOutlet UIButton *btn_changePw;
    IBOutlet UIButton *btn_changeInfo;
    
    IBOutlet UILabel *lbl_changepw;
    IBOutlet UILabel *lbl_changeInfo;
}

@property (nonatomic,strong) IBOutlet UITableView *accTableView;


-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSArray *)arr;

//修改密碼
-(IBAction)changePW:(id)sender;

//修改帳號資訊
-(IBAction)changeAccInf:(id)sender;
//關閉
-(IBAction)closeChangePwView:(id)sender;

//儲存
-(IBAction)saveChange:(id)sender;

@end
