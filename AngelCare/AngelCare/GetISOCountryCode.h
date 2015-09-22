//
//  GetISOCountryCode.h
//  testGetCoutryUsingUserlocation
//
//  Created by Roger on 2014/3/5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface GetISOCountryCode : NSObject <CLLocationManagerDelegate>
{
    id      MainObj;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *ISOCode;

- (void)startSignificantChangeUpdates;

@end
