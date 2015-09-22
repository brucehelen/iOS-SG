//
//  SafeViewController.h
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SafeCell.h"
#import <QuartzCore/QuartzCore.h>
#import "define.h"
#import "FPPopoverController.h"

@interface SafeViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate>
{
    NSDate *nowDate;
    NSDateFormatter *formatter;
    int nowDateInt;
    
    //parent View
    id  MainObj;
    
}
@property(nonatomic,strong) NSArray *safeArray;

-(void)Do_Init:(id)sender;

-(void)reloadData;
@end
