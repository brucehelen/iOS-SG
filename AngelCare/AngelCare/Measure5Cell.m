//
//  Measure5Cell.m
//  AngelCare
//
//  Created by macmini on 13/6/24.
//
//

#import "Measure5Cell.h"

@implementation Measure5Cell
@synthesize dateLbl,pic,picNum,stepLbl,stepNum,distanceLbl,distanceNum,calLbl,calNum;


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
