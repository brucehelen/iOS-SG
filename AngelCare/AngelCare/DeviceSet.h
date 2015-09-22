//
//  DeviceSet.h
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@class MLTableAlert;

@interface DeviceSet : UIView
<MFMessageComposeViewControllerDelegate>
{
    IBOutlet UIButton *smsReadBtn;
    IBOutlet UIButton *sosLongBtn;
    IBOutlet UIButton *familyBtn;
    IBOutlet UIButton *dontBotherBtn;
    IBOutlet UIButton *sosSMSBtn;
    IBOutlet UIButton *btnVoiceMail;
    
    
    
    IBOutlet UIButton *timeareaBtn;
    IBOutlet UIButton *languageBtn;
    
    IBOutlet UILabel *smsReadLbl;
    IBOutlet UILabel *sosLongLbl;
    IBOutlet UILabel *familyLbl;
    IBOutlet UILabel *dontBotherLbl;
    IBOutlet UILabel *sosSMSLbl;
    IBOutlet UILabel *timeareaLbl;
    IBOutlet UILabel *languageLbl;
    
    NSString *switch1;
    NSString *switch2;
    NSString *switch3;
    NSString *switch4;
    NSString *switch5;
    NSString *switch6;
    
    NSString *areaStr;
    NSString *langStr;
    
    
    id MainObj;
    
    int saveNum;
    
    
    IBOutlet UIScrollView *scrView;
    
    
    IBOutlet UILabel *syncLbl;
    IBOutlet UIButton *syncBtn;
}
@property (nonatomic,strong) NSArray *timezoneArr;
@property (nonatomic,strong) NSArray *langArr;
@property (strong, nonatomic) MLTableAlert *alert;

-(void)Set_Init:(NSDictionary *)dic;

-(void)Do_Init:(id)sender;

-(void)SaveDevSet;

//設定開啓或關閉
-(IBAction)changeEnable:(id)sender;

-(void)ChangeTimeZoneTitle:(NSString *)name SelectNumber:(NSString *)number;

-(void)ChangeLanguageTitle:(NSString *)name SelectNumber:(NSString *)number;

-(void)sendNext;


//
-(IBAction)timeSelect:(id)sender;
-(IBAction)ibaRemoteSynch:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRS;
@property (strong, nonatomic) IBOutlet UILabel *lblSync;
-(void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone;
@property (nonatomic,strong) NSArray *synctimearr;
-(void)Set_Init_Call:(NSDictionary *)dic;
-(void)SaveCall;
@end
