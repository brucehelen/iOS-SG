//
//  FallSet.h
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import <UIKit/UIKit.h>

@interface FallSet : UIView<UITextFieldDelegate>
{
    IBOutlet UILabel *fallDownLbl;
    IBOutlet UILabel *levelLbl;
    IBOutlet UILabel *fallLbl;
    IBOutlet UILabel *tel1Lbl;
    IBOutlet UILabel *tel2Lbl;
    IBOutlet UILabel *tel3Lbl;
    
    id MainObj;
    
    IBOutlet UIButton *enableBtn;
    IBOutlet UIButton *LevelBtn;
    IBOutlet UITextField *phone1;
    IBOutlet UITextField *phone2;
    IBOutlet UITextField *phone3;
    
    int isEnable;   //是否開啓
    NSString *enableStr;
    NSString *levelStr;
}

-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveFallSet;

-(void)ChangeLevelBtnTitle:(int)n;

-(IBAction)isEnableBtnClick:(id)sender;
-(IBAction)changeLevel:(id)sender;

@end
