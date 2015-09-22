//
//  LeaveAnno.m
//  AngelCare
//
//  Created by macmini on 13/8/2.
//
//

#import "LeaveAnno.h"

@implementation LeaveAnno
@synthesize coordinate;

- (id)initWithCoordinate: (CLLocationCoordinate2D)coords : (BOOL)Is_GPS
{
    self = [super init];
    if (self != nil)
    {
        coordinate = coords;
        IsGPS_Sw = Is_GPS;
        ImageNum =1;
        
    }
    return self;
}

-( void) Set_ImageNum:(int)NewNum
{
    ImageNum = NewNum;
}


-( int) Get_ImageNum
{
    
    return ImageNum;
}

- (void) dealloc
{
    
}


-( BOOL) Get_GPS_Sw
{
    
    return IsGPS_Sw;
}


-(NSString *)title
{
    return [NSString stringWithFormat:@"(%f,%f)",coordinate.latitude,coordinate.longitude];
}
@end
