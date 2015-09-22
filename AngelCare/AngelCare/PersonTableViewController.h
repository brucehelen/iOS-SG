//
//  PersonTableViewController.h
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "personCell.h"
@interface PersonTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *nowDate;
    NSDateFormatter *formatter;
    int nowDateInt;
}
@property(nonatomic,strong) NSArray *personArray;

-(void)reloadData;
@end
