//
//  MyHisCell.m
//  AngelCare
//
//  Created by macmini on 13/7/10.
//
//

#import "MyHisCell.h"

@implementation MyHisCell
@synthesize titleLbl,timeLbl;
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
