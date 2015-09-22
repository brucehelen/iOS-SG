//
//  SportRemindView.h
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import <UIKit/UIKit.h>

@interface SportRemindView : UIView<UITextFieldDelegate>
{
    IBOutlet UILabel *stepLengthLbl;
    IBOutlet UILabel *distanceLbl;
    IBOutlet UILabel *stepCountLbl;
    
    IBOutlet UITextField *stepRangeTxt;
    IBOutlet UITextField *distanceTxt;
    IBOutlet UITextField *stepCountTxt;
    
    IBOutlet UILabel *lblCMTitle;
    IBOutlet UILabel *lblKMTitle;
    IBOutlet UILabel *lblStepTitle;
    
    id  MainObj;
}

-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveSport;

@end
