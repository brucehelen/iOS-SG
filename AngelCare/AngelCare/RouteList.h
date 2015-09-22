//
//  RouteList.h
//  AngelBaby
//
//  Created by macmini on 13/6/4.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RouteListDelegate

@required

- (void)mainButtonWasPressed:(id)sender;
- (void)didselectCellNum:(int)number;
@end

@interface RouteList : UIView

@property (nonatomic,strong) NSArray *routeListArr;
@property (nonatomic,strong) IBOutlet UITableView *routeTable;
@property (strong) NSObject <RouteListDelegate> *delegate;

- (IBAction)onMainButton:(id)sender;
@end
