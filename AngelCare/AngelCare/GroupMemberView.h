//
//  GroupMemberView.h
//  AngelCare
//
//  Created by 林 益弘 on 13/7/17.
//
//

#import <UIKit/UIKit.h>


@interface GroupMemberView : UIView<UIGestureRecognizerDelegate>
{
    id MainObj;
    NSMutableArray *memberArray;
    int delNum;
    IBOutlet UITableView *list;
    IBOutlet UIView *addBgView;
    IBOutlet UIView *addAccView;
    IBOutlet UILabel *titleBgLbl;
    BOOL isShowDelAlert;
    UILongPressGestureRecognizer *lpgr;
    IBOutlet UILabel *lblAddMode;
    
}

//新增模式
-(void)addTypeSelect;

//增加使用者
-(IBAction)addMember:(id)sender;

-(void)Do_Init:(id)sender;

-(void)Set_Init:(int)nowuser;

-(void)reloadData:(int)nowuser;

//選擇新增帳號視窗關閉
-(IBAction)closeBtnClick:(id)sender;

@end
