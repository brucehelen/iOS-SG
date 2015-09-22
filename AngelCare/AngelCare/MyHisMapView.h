//
//  MyHisMapView.h
//  AngelCare
//
//  Created by macmini on 13/7/15.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BMapKit.h"
#import "Base64.h"

@interface MyHisMapView : UIView <MKMapViewDelegate,BMKGeoCodeSearchDelegate>
{
    NSDictionary *mapDic;
    IBOutlet MKMapView *map_view;
    IBOutlet MKMapView *googleMapView;
    IBOutlet UITextView *noteTxt;
    BMKMapView *baiduMapView;
    id MainObj;
}

-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSDictionary *)dic;

-(void)ChangeMapType;

//設定地圖模式
-(void)MapMoushDown:(int)type;

@end
