//
//  trackingWithInterval.h
//  mCareWatch
//
//  Created by Roger on 2014/5/28.
//
//

#import <UIKit/UIKit.h>
@class MLTableAlert;

@interface trackingWithInterval : UIView
<UIActionSheetDelegate>
{
    id  MainObj;
}



@property (strong, nonatomic) IBOutlet UILabel *lblGStart;
@property (strong, nonatomic) IBOutlet UILabel *lblGEnd;
@property (strong, nonatomic) IBOutlet UILabel *lblWStart;
@property (strong, nonatomic) IBOutlet UILabel *lblWEnd;


@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblFuncInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnStartTime;
@property (strong, nonatomic) IBOutlet UIButton *btnEndTime;
@property (strong, nonatomic) IBOutlet UIButton *btnSync;
@property (strong, nonatomic) IBOutlet UIButton *btnGPSf;

@property (strong, nonatomic) IBOutlet UIButton *btnStartG;
@property (strong, nonatomic) IBOutlet UIButton *btnEndG;

@property (strong, nonatomic) IBOutlet UIButton *btnOpenWhich;

@property (strong, nonatomic) IBOutlet UIButton *btnW7;
@property (strong, nonatomic) IBOutlet UIButton *btnW1;
@property (strong, nonatomic) IBOutlet UIButton *btnW2;
@property (strong, nonatomic) IBOutlet UIButton *btnW3;
@property (strong, nonatomic) IBOutlet UIButton *btnW4;
@property (strong, nonatomic) IBOutlet UIButton *btnW5;
@property (strong, nonatomic) IBOutlet UIButton *btnW6;

@property (strong, nonatomic) IBOutlet UIButton *btnGW7;
@property (strong, nonatomic) IBOutlet UIButton *btnGW1;
@property (strong, nonatomic) IBOutlet UIButton *btnGW2;
@property (strong, nonatomic) IBOutlet UIButton *btnGW3;
@property (strong, nonatomic) IBOutlet UIButton *btnGW4;
@property (strong, nonatomic) IBOutlet UIButton *btnGW5;
@property (strong, nonatomic) IBOutlet UIButton *btnGW6;

@property (strong, nonatomic) IBOutlet UIView *gpsView;
@property (strong, nonatomic) IBOutlet UIView *wifiView;


@property (strong, nonatomic) IBOutlet UISwitch *switchWifi;
@property (strong, nonatomic) IBOutlet UISwitch *switchGPS;

- (IBAction)ibaPressWhichW:(id)sender;

- (IBAction)ibaSync:(id)sender;
- (IBAction)ibaGPSf:(id)sender;
- (IBAction)ibaSyncAndGpsf:(id)sender;


- (IBAction)ibaSwitchChange:(id)sender;



- (IBAction)ibaSelectTime:(id)sender;

- (IBAction)ibaOpenWhich:(id)sender;

@property (nonatomic,strong) NSArray *synctimearr;
@property (nonatomic,strong) NSArray *gpstimearr;

@property (strong, nonatomic) MLTableAlert *alert;

@property (strong, nonatomic) IBOutlet UISegmentedControl *seg;
- (IBAction)segChange:(id)sender;
-(void)SaveSetting;
//- (void)do_initWithDict:(NSDictionary*)dict;
- (void)do_initWithDict:(NSDictionary*)dict andSender:(id)sender;


@end
