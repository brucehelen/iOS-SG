//
//  Format2Cell.m
//  AngelCare
//
//  Created by macmini on 2013/11/25.
//
//

#import "Format2Cell.h"

@implementation Format2Cell
@synthesize titleLbl,subtitleLbl,noLbl,imgFamily,Btn_family;

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

@end
