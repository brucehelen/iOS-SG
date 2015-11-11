//
//  UserSetView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/10/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSetCell.h"

@interface UserSetView : UIView
{
    NSMutableArray *userSetArr;

    id  MainObj;
}

@property (nonatomic,strong) IBOutlet UITableView *userSetTableView;

- (void)Do_Init:(id)sender;

- (void)Set_Init:(id)sender SetDic:(NSDictionary *)dic;

@end
