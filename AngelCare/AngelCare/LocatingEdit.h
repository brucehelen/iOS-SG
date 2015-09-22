//
//  LocatingEdit.h
//  3GSW
//
//  Created by Roger on 2015/3/30.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"
#import "Base64.h"
#import <MessageUI/MessageUI.h>
@interface LocatingEdit : UIView
<MKMapViewDelegate, CLLocationManagerDelegate,BMKGeoCodeSearchDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>

@property int index;
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *AddressTextField;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UILabel *WIFITitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *WIFIMACLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString * nameString;
@property (strong, nonatomic) NSString * g_no;
@property (strong, nonatomic) NSString * WiFiMac;
- (IBAction)ibaSave:(id)sender;
- (void)Do_init:(id)sender;
- (void)SetIMEI:(NSString *)getimei AndPhone:(NSString *)_phone;
- (void)stopTimer;
@end
