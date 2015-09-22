//
//  LeaveMap.h
//  AngelCare
//
//  Created by macmini on 13/7/24.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "BMapKit.h"
#import "Base64.h"
#import "MyAnnotation.h"

@interface LeaveMap : UIView<MKMapViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    id MainObj;
    IBOutlet MKMapView *map_view;
    IBOutlet MKMapView *googleMapView;
//    IBOutlet BMKMapView *baiduMapView;
    IBOutlet UITextField *addrTxt;
    
    IBOutlet UIButton *rangeBtn;
    
    NSString *longitude;
    NSString *latitude;
    NSString *radius;
    NSString *addr;
    
    CLLocationCoordinate2D coordinate;
    NSString *addrString;
    NSArray *rangeArr;
    int selectNum;
    
    
    UIActionSheet *actionSheet;
    UIPickerView *picker;
    
    IBOutlet UILabel *addressLbl;
    IBOutlet UILabel *rangeLbl;
    IBOutlet UIButton *checkBtn;
}


-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSDictionary *)dic;

//設定範圍顯示圈
-(void)Set_Circle:(NSString *)longitude :(NSString *)latitude :(NSString *)radius;

-(NSDictionary *)saveAddr;

-(IBAction)checkAddrString:(id)sender;

- (IBAction)changeRange:(id)sender;

@end
