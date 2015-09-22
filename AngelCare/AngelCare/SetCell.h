//
//  SetCell.h
//  angelcare
//
//  Created by macmini on 13/4/11.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UISwitch *switch1;
@property (strong, nonatomic) IBOutlet UILabel *google;
@property (strong, nonatomic) IBOutlet UILabel *baidu;

- (IBAction)btnchange:(id)sender;
- (IBAction)switchchange:(id)sender;

@end
