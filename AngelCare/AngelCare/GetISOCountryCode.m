//
//  GetISOCountryCode.m
//  testGetCoutryUsingUserlocation
//
//  Created by Roger on 2014/3/5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//
// Note: Need import framework:CoreLocation,AddressBook。

#import "GetISOCountryCode.h"
#import <dispatch/dispatch.h>

@implementation GetISOCountryCode
{
    dispatch_semaphore_t sema;
}

- (void)startSignificantChangeUpdates
{
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!self.locationManager)
            self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if (IOS_VERSION >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }

        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation]; // 这里会提示用户获取地理位置的权限
        [self.locationManager performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay:60]; // 60 秒后停止监听
    }
}

- (void)stopSignificantChangesUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        placemark = placemarks[0];
        
        NSDictionary *addressDictionary = [placemark addressDictionary];
        NSString *city = addressDictionary[(NSString *)kABPersonAddressCityKey];
        NSString *state = addressDictionary[(NSString *)kABPersonAddressStateKey];
        NSString *country = placemark.country;
        NSLog(@"%@",[NSString stringWithFormat:@"%@, %@, %@, %@", city, state, country,placemark.ISOcountryCode]);
        NSLog(@"ISOcountryCode = %@",placemark.ISOcountryCode);
        _ISOCode = placemark.ISOcountryCode;
        NSString *ISOCode = placemark.ISOcountryCode;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"ISOCode"]; //Add the file name
        [ISOCode writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

        NSString *isoCode = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",isoCode);
    }];

    [manager stopUpdatingLocation];
}

@end
