//
//  AppDelegate.h
//  Project_OldAngel
//
//  Created by Lion User on 12/9/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "GetISOCountryCode.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) LoginViewController *login;
@property (strong, nonatomic) GetISOCountryCode *isoGetter;

@end
