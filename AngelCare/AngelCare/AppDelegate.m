//
//  AppDelegate.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BMapKit.h"
#import "MainClass.h"
#import <dlfcn.h>
#import "KMLocationManager.h"
#import "KMCommonClass.h"

BMKMapManager *_mapManager;

@implementation AppDelegate
{
    NSString *m_deviceToken;
    MainClass *mainObj;
}

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize login;

#pragma mark - Reveal
// 界面调试用
- (void)loadReveal
{
    if (NSClassFromString(@"IBARevealLoader") == nil)
    {
        NSString *revealLibName = @"libReveal";
        NSString *revealLibExtension = @"dylib";
        NSString *error;
        NSString *dyLibPath = [[NSBundle mainBundle] pathForResource:revealLibName ofType:revealLibExtension];
        
        if (dyLibPath != nil)
        {
            NSLog(@"Loading dynamic library: %@", dyLibPath);
            void *revealLib = dlopen([dyLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
            
            if (revealLib == NULL)
            {
                error = [NSString stringWithUTF8String:dlerror()];
            }
        }
        else
        {
            error = @"File not found.";
        }
        
        if (error != nil)
        {
            NSString *message = [NSString stringWithFormat:@"%@.%@ failed to load with error: %@", revealLibName, revealLibExtension, error];
            NSLog(@"message = %@", message);
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self loadReveal];
    
    NSString *wifiName = [KMCommonClass getWifiName];
    NSLog(@"wifiName = %@, %@", wifiName, [KMCommonClass getWifiMac]);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"BwwKfS68uEdbAUvB8ClfwR8H"
                  generalDelegate:nil];
    if (!ret) {
        NSLog(@"*** Baidu manager start failed!");
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIStoryboard *iPhoneStoryboard;
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;

        if (iOSDeviceScreenSize.height == 568)      // iphone5, 6, 6p
        {
            NSLog(@"iphone5...");
            iPhoneStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone4"
                                                         bundle:nil];
        } else {
            NSLog(@"iphone4");
            iPhoneStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle:nil];
        }

        UIViewController *loginViewController = [iPhoneStoryboard instantiateViewControllerWithIdentifier:@"Login"];
        self.window.rootViewController = loginViewController;
        if (![defaults objectForKey:@"First"]) {
            [login firstLogin];
        }
    }

    mainObj = [MainClass new];
    _isoGetter = [GetISOCountryCode new];

    [self registerNotification];

    return YES;
}

#pragma mark - 推送相关

#pragma mark 接收到DeviceToken
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str = [NSString stringWithFormat:@"%@", deviceToken];

    // 去掉空格和<>
    NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@">" withString:@""];

    [[NSUserDefaults standardUserDefaults] setObject:newString forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] setObject:newString forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSLog(@"DeviceToken = %@", newString);

    m_deviceToken = newString;

    double delayInSeconds = 15.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"---> send DeviceToken[%@] to server", newString);
        [self updateToken];
    });
}

#pragma mark 接收到推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"RemoteNotification = %@", userInfo);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Receive_Notification_Comm"
                                                        object:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];

    NSLog(@"userInfo = %@", [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"loc-args"]);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma mark 获取token失败
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"获取token失败: %@", err);
}

#pragma mark -
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [self cancelLoginRemind];
    [self loginRemind];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"--->applicationDidBecomeActive");

    //偏移校準
    if(!_isoGetter)
        _isoGetter = [GetISOCountryCode new];
    [_isoGetter startSignificantChangeUpdates];

    if (m_deviceToken) {
        [self updateToken];
    }

    [self cancelLoginRemind];
}

- (void)updateToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (mainObj) {
        if ([defaults objectForKey:@"userAccount"] &&
            [defaults objectForKey:@"userHash"] ) {
            [mainObj UpdateToken:[defaults objectForKey:@"userAccount"]
                         andHash:[defaults objectForKey:@"userHash"]
                        andToken:m_deviceToken];
        }
    }
}

- (void)cancelLoginRemind
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
        if ([uid isEqualToString:@"LoginRemind"])
        {
            NSLog(@"Delete LoginRemind!");
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
        }
    }
}

- (void)loginRemind
{
    //m  h  d 96hr
    NSDate *alertTime = [[NSDate date] dateByAddingTimeInterval:86400 * 4];
//    NSDate *alertTime = [[NSDate date] dateByAddingTimeInterval:5];
    //本地提醒推播
    UILocalNotification *notification;
    if (!notification) {
        notification = [[UILocalNotification alloc] init];
    }
    notification.userInfo = @{@"uid": @"LoginRemind"};
    notification.fireDate = alertTime;
    notification.alertBody = NSLocalizedStringFromTable(@"ReLogin", INFOPLIST, nil);
    notification.repeatInterval = NSDayCalendarUnit;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)registerNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert |
                                                       UIUserNotificationTypeBadge)
                                           categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |
                                                                               UIRemoteNotificationTypeSound |
                                                                               UIRemoteNotificationTypeBadge)];
    }
}

@end
