//
//  GroupMemberViewController.h
//  AngelCare
//
//  Created by macmini on 13/6/27.
//
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "GroupMemberCell.h"
#import "HashSHA256.h"
#import "MBProgressHUD.h"
#import "CheckErrorCode.h"
#import "ECSlidingViewController.h"
#import "UnderRightViewController.h"

@interface GroupMemberViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    int delNum;
}

@property (nonatomic,strong) NSMutableArray *memberArray;
@property (nonatomic,strong) IBOutlet UITableView *memberList;
//增加使用者
-(IBAction)addMember:(id)sender;

//回首頁
-(IBAction)backToMainView:(id)sender;

@end
