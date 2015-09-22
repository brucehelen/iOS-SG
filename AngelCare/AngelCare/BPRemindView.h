//
//  BPRemindView.h
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import <UIKit/UIKit.h>

@interface BPRemindView : UIView<UITextFieldDelegate>
{
    IBOutlet UILabel *bgLbl;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *bpsLbl;
    IBOutlet UILabel *bpdLbl;
    IBOutlet UILabel *mmhg1;
    IBOutlet UILabel *mmhg2;
    
    IBOutlet UILabel *lblHigherThan;
    
    IBOutlet UILabel *lblHigherThan2;
    
    IBOutlet UILabel *lblSendAlarm;
    
    IBOutlet UILabel *lblSendAlaram2;
    
    IBOutlet UILabel *lblEnTxt1;
    
    IBOutlet UILabel *lblEnTxt2;
    
    
    IBOutlet UILabel *lblRemind1Title;
    IBOutlet UILabel *lblRemind1Content;
    IBOutlet UIImageView *imgRemind1;
    IBOutlet UIView *viewRemind2;
    IBOutlet UIView *viewRemind3;
    IBOutlet UILabel *lblRemind2Title;
    IBOutlet UILabel *lblRemind3Title;
    IBOutlet UILabel *lblRemind3Sup;
    
    //parent View
    id  MainObj;
    IBOutlet UITextField *bpdDownlimit;
    IBOutlet UITextField *bpdUplimit;
    IBOutlet UITextField *bpsDownlimit;
    IBOutlet UITextField *bpsUplimit;
    
    IBOutlet UIScrollView *scrollView;
    
    
    IBOutlet UIView *viewRemind;
    
    
}

//血壓資訊
-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveBP;

@end
