//
//  UnderRightViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ECSlidingViewController.h"
#import "ViewController.h"
#import "define.h"
#import "SetCell.h"
#import "MBProgressHUD.h"
#import "CheckErrorCode.h"
#import "QrcodeLoginViewController.h"

@protocol UnderRightDelegate <NSObject>

@required
-(void)UpdateSetting;

@optional
-(void)changeState:(int)num;

@end


@interface UnderRightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@property (nonatomic,strong) IBOutlet UITableView *setView;

@property (strong) NSObject <UnderRightDelegate> *delegate;
@property (strong, nonatomic) IBOutlet UINavigationItem *navi;
@property (nonatomic,strong) NSArray *settingArray;
@end
