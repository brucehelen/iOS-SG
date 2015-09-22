//
//  MyHisCell2.m
//  AngelCare
//
//  Created by macmini on 13/7/23.
//
//

#import "MyHisCell2.h"

@implementation MyHisCell2
@synthesize startTimeLbl,endTimeLbl,lengthLbl;

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
