//
//  MyAnnotation.m
//  Project_GoogleMap
//
//  Created by Lion User on 12/9/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface MyAnnotation : NSObject <MKAnnotation> 
{
    CLLocationCoordinate2D coordinate;
    BOOL    IsGPS_Sw;
    int isGPS_GSM_WIFI;
    int    ImageNum;
}

@property (nonatomic, copy) NSString *title;

- (id)initWithCoordinate: (CLLocationCoordinate2D)coords :(BOOL)Is_GPS;
//- (id)initWithCoordinate: (CLLocationCoordinate2D)coords :(int)_GPS_GSM_WIFI;

-( BOOL) Get_GPS_Sw;
-( int) Get_ImageNum;
-( void) Set_ImageNum:(int)NewNum;
//- (int) Get_isGPS_GSM_WIFI;
@end