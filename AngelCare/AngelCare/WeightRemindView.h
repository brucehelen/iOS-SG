//
//  WeightRemindView.h
//  AngelCare
//
//  Created by macmini on 13/7/12.
//
//

#import <UIKit/UIKit.h>

//體重資訊
@interface WeightRemindView : UIView<UITextFieldDelegate>
{
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *sexLbl;
    IBOutlet UILabel *boyLbl;
    IBOutlet UILabel *girlLbl;
    IBOutlet UILabel *yearLbl;
    IBOutlet UILabel *oldLbl;
    IBOutlet UILabel *tallLbl;
    IBOutlet UILabel *cmLbl;
    IBOutlet UILabel *weightLbl;
    IBOutlet UILabel *kgLbl;
    IBOutlet UILabel *bodyfatLbl;
    IBOutlet UILabel *persentLbl;
    IBOutlet UILabel *idealWeightLbl;
    IBOutlet UILabel *idealbodyLbl;
    IBOutlet UILabel *kgLbl2;
    IBOutlet UILabel *persentLbl2;
    
    IBOutlet UIButton *menBtn;
    IBOutlet UIButton *girlBtn;
    IBOutlet UITextField *yearTxt;
    IBOutlet UITextField *tallTxt;
    IBOutlet UITextField *weightTxt;
    IBOutlet UITextField *fatTxt;
    IBOutlet UITextField *idealWeightTxt;
    IBOutlet UITextField *idealfatTxt;

    __weak IBOutlet UILabel *weightTLabel;
    
    __weak IBOutlet UILabel *fatTLabel;
    
    // 目标体重
    __weak IBOutlet UITextField *weightT;
    // 目标体脂
    __weak IBOutlet UITextField *fatT;

    int sex;

    id  MainObj;
}

-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveWeight;

-(IBAction)seleBoyGirl:(id)sender;

@end
