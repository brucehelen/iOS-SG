//
//  SosMapView.h
//  AngelCare
//
//  Created by macmini on 13/8/28.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BMapKit.h"

@interface SosMapView : UIView<MKMapViewDelegate, BMKMapViewDelegate, BMKGeoCodeSearchDelegate>
{
    IBOutlet MKMapView *map_view;
    IBOutlet UIButton *closeBtn;
    IBOutlet UITextView *infoTxt;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *titleBg;
    IBOutlet MKMapView *googleMapView;
    IBOutlet BMKMapView *baiduMapView;
    
    
    IBOutlet UILabel *lblGPS;
    IBOutlet UILabel *lblGSM;
    IBOutlet UILabel *lblWifi;
    NSDictionary *dataDic;
    //parent View
    id      MainObj;
    
    int isGPS_GSM_WIFI;
}

-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSDictionary *)dic;

//關閉
-(IBAction)closeChangePwView:(id)sender;

- (void)setGPS_GSM_WIFI:(int)_GPS_GSM_WIFI;

@end
