//
//  UserSetCell.m
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import "UserSetCell.h"

@implementation UserSetCell
@synthesize titleLbl,infoLbl;

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
