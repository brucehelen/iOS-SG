//
//  SystemViewController.h
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemCell.h"
#import "define.h"
#import "HashSHA256.h"
@interface SystemViewController : UITableViewController
{
    NSDate *nowDate;
    NSDateFormatter *formatter;
    int nowDateInt;
}

@property(nonatomic,strong) NSArray *systemArray;
-(void)reloadData;


@end
