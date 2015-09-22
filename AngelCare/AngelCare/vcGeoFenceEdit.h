//
//  vcGeoFenceEdit.h
//  mCareWatch
//
//  Created by Roger on 2014/6/3.
//
//
#define StartBTN 201
#define EndBTN 202
#define Mon 101
#define Tue 102
#define Wed 103
#define The 104
#define Fri 105
#define Sat 106
#define Sun 107

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MainClass.h"
#import "MBProgressHUD.h"
@interface vcGeoFenceEdit : UIViewController
<UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,UISearchBarDelegate,MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblStartTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEndTime;

@property (strong, nonatomic) IBOutlet UITextField *txtName;


@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UIButton *btnEnd;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;
@property (strong, nonatomic) IBOutlet UIButton *btn7;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UIButton *btnReset;


@property (strong, nonatomic) IBOutlet MKMapView *map;


- (IBAction)ibaSelectTime:(id)sender;
- (IBAction)ibaSelectWeek:(id)sender;
- (IBAction)ibaCancel:(id)sender;
- (IBAction)ibaSave:(id)sender;

@property (nonatomic, strong) CLLocationManager* locationManager;


@property (strong, nonatomic) IBOutlet UISearchBar *barSearch;

@property (strong, nonatomic)NSDictionary *dict;
@property (nonatomic)int no;
@property (strong, nonatomic) MainClass *mainObj;

-(void)closeLoading;
-(void)addloadingView;

@property (strong, nonatomic) IBOutlet UIView *viewWeb;
@property (strong, nonatomic) IBOutlet UIWebView *webInfo;
- (IBAction)ibaHideWeb:(id)sender;
- (IBAction)ibaShowWeb:(id)sender;


@end
