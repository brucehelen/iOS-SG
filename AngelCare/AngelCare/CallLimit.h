//
//  CallLimit.h
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class MLTableAlert;

@interface CallLimit : UIView<UITextFieldDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>
{
    IBOutlet UILabel *syncLbl;
    IBOutlet UILabel *syncStrLbl;
    
    IBOutlet UILabel *gpsLbl;
    IBOutlet UILabel *gpsStrLbl;
    IBOutlet UILabel *HS_CallLimitLbl;
    IBOutlet UILabel *phoneLimitLbl;
    IBOutlet UILabel *minuteLbl;
    IBOutlet UILabel *phoneStrLbl;
    IBOutlet UILabel *callLimitLbl;
    IBOutlet UILabel *minute2Lbl;
    IBOutlet UILabel *callStrLbl;
    
    IBOutlet UIButton *syncBtn;
    IBOutlet UIButton *gpsBtn;
    IBOutlet UITextField *phoneLimitTxt;
    IBOutlet UITextField *callLimitTxt;
    
    NSString *syncStr;
    NSString *gpsStr;
    NSString *phoneStr;
    NSString *callStr;
    
    UIDatePicker *picker;
    
    id  MainObj;
    
    id selectBtn;
    
    int saveNum;
    NSArray *synctimearr;
    NSArray *gpstimearr;
}
@property (nonatomic,strong) NSArray *synctimearr;
@property (nonatomic,strong) NSArray *gpstimearr;
@property (strong, nonatomic) MLTableAlert *alert;

-(void)sendNext;

-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveCall;


-(IBAction)timeSelect:(id)sender;

//增加簡訊同步
@property (strong, nonatomic) IBOutlet UIButton *btnRS;
- (IBAction)ibaRemoteSynch:(id)sender;
-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone;
@property (strong, nonatomic) IBOutlet UILabel *lblSync;

@end
