//
//  SetCell.m
//  angelcare
//
//  Created by macmini on 13/4/11.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnchange:(id)sender {
    NSLog(@"tag = %i",[sender tag]);
}

- (IBAction)switchchange:(id)sender {
}
@end
