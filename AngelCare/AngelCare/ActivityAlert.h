//
//  ActivityAlert.h
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import <UIKit/UIKit.h>
@class MLTableAlert;
@interface ActivityAlert : UIView
<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UIButton *btnEnd;
@property (strong, nonatomic) IBOutlet UIButton *btnOn;

@property (strong, nonatomic) MLTableAlert *alert;

- (IBAction)ibaStart:(id)sender;
- (IBAction)ibaEnd:(id)sender;
- (IBAction)ibaOpen:(id)sender;
- (IBAction)ibaSelectTime:(id)sender;

- (void)do_initWithDict:(NSDictionary*)dict andSender:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnGW7;
@property (strong, nonatomic) IBOutlet UIButton *btnGW1;
@property (strong, nonatomic) IBOutlet UIButton *btnGW2;
@property (strong, nonatomic) IBOutlet UIButton *btnGW3;
@property (strong, nonatomic) IBOutlet UIButton *btnGW4;
@property (strong, nonatomic) IBOutlet UIButton *btnGW5;
@property (strong, nonatomic) IBOutlet UIButton *btnGW6;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UISwitch *switchBtn;

-(void)SaveSetting;
@end
