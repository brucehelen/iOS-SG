//
//  BORemindView.h
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import <UIKit/UIKit.h>

@interface BORemindView : UIView<UITextFieldDelegate>
{
    IBOutlet UILabel *backLbl;
    IBOutlet UILabel *titleLbl;
    IBOutlet UITextField *Up_limit;
    IBOutlet UITextField *Down_limit;
    IBOutlet UILabel *back2Lbl;
    IBOutlet UILabel *remindLbl;
    
    IBOutlet UILabel *boconcentrationLbl;

    
    IBOutlet UILabel *lblEn;
    
    IBOutlet UILabel *lblCh;
    
    
    IBOutlet UILabel *lblUnit;
    
    id  MainObj;
}

//血氧資訊
-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveBO;

@end
