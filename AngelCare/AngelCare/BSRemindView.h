//
//  BSRemindView.h
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import <UIKit/UIKit.h>

@interface BSRemindView : UIView<UITextFieldDelegate,UIActionSheetDelegate>
{
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *bgLbl;
    IBOutlet UILabel *bgLbl2;
    IBOutlet UILabel *titleLbl1;
    IBOutlet UILabel *titleLbl2;
    
    IBOutlet UILabel *beforeMeal;
    IBOutlet UILabel *afterMeal;
    IBOutlet UILabel *beforeSlp;
    
    IBOutlet UILabel *bftime;
    IBOutlet UILabel *lutime;
    IBOutlet UILabel *dintime;
    
    IBOutlet UILabel *bs1;
    IBOutlet UILabel *bs2;
    IBOutlet UILabel *bs3;

    // 飯前血糖上限
    IBOutlet UITextField *beforeMealUpTxt;
    // 飯後血糖上限
    IBOutlet UITextField *afterMealUpTxt;

    IBOutlet UIButton *bfStartBtn;
    IBOutlet UIButton *bfEndBtn;
    IBOutlet UIButton *lunchStartBtn;
    IBOutlet UIButton *lunchEndBtn;
    IBOutlet UIButton *dinnerStartBtn;
    IBOutlet UIButton *dinnerEndBtn;
    
    // bruce@20151010
    __weak IBOutlet UILabel *bgBloodMaxValue;
    
    __weak IBOutlet UILabel *bgBloodMaxInfo;
    
    NSString *bfStartStr;
    NSString *bfEndStr;
    NSString *lunchStartStr;
    NSString *lunchEndStr;
    NSString *dinnerStartStr;
    NSString *dinnerEndStr;
    
    id  MainObj;
    
    UIDatePicker *picker;
    id selectBtn;
    
    IBOutlet UILabel *lblEn1;
    IBOutlet UILabel *lblEn2;
    IBOutlet UILabel *lblCh1;
    IBOutlet UILabel *lblCh2;

    // 血糖单位
    IBOutlet UILabel *lblUnit1;
    IBOutlet UILabel *lblUnit2;
}

//選擇吃飯時間
-(IBAction)selectDate:(id)sender;

//血糖資訊
-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveBS;

@end
