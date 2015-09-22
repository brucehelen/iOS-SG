//
//  LeaveRemind.h
//  AngelCare
//
//  Created by macmini on 13/7/24.
//
//

#import <UIKit/UIKit.h>

@interface LeaveRemind : UIView<UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    id MainObj;
    NSString *startStr;
    NSString *endStr;
    NSString *rangeStr;
    NSArray *rangeArr;
    int selectNum;
    UIDatePicker *datePicker;
    id selectBtn;
    
    NSString *latitudeStr;
    NSString *longitudeStr;
    NSString *addrStr;
    
    NSString *t1;
    NSString *t2;
    NSString *t3;
    NSString *t4;
    NSString *t5;
    NSString *t6;
    NSString *t7;
    
    IBOutlet UIButton *week1;
    IBOutlet UIButton *week2;
    IBOutlet UIButton *week3;
    IBOutlet UIButton *week4;
    IBOutlet UIButton *week5;
    IBOutlet UIButton *week6;
    IBOutlet UIButton *week7;
    
    UIColor *backgroundColor;
    UIColor *titleColor;
    UIColor *selbackgroundColor;
    UIColor *seltitleColor;
    
}
@property (strong, nonatomic) IBOutlet UILabel *timeareaLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet UILabel *actRangeLbl;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UIButton *endBtn;
@property (strong, nonatomic) IBOutlet UILabel *addrLbl;
@property (strong, nonatomic) IBOutlet UIButton *actRangeBtn;
@property (strong, nonatomic) IBOutlet UIButton *MapBtn;
@property (strong, nonatomic) IBOutlet UILabel *periodrLbl;

-(void)Do_Init:(id)sender;
-(void)Set_Init:(NSDictionary *)dic;

-(void)SaveLeaveSet;

- (IBAction)changeTime:(id)sender;
- (IBAction)changeRange:(id)sender;
- (IBAction)checkMap:(id)sender;

-(void)ChangeAddr:(NSDictionary *)dic;

@end
