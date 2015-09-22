//
//  Measure1Cell.m
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import "Measure1Cell.h"

@implementation Measure1Cell
@synthesize dateLbl,firstImg,firstCountLbl,firstName,firstNum,secondImg,secondCountLbl,secondName,secondNum,pulseNum;

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
