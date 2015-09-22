//
//  LeaveAnno.h
//  AngelCare
//
//  Created by macmini on 13/8/2.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LeaveAnno : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    BOOL    IsGPS_Sw;
    int    ImageNum;
}

- (id)initWithCoordinate: (CLLocationCoordinate2D)coords :(BOOL)Is_GPS;

-( BOOL) Get_GPS_Sw;
-( int) Get_ImageNum;
-( void) Set_ImageNum:(int)NewNum;

@end
