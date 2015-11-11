//
//  CGeoCell.m
//  mCareWatch
//
//  Created by Roger on 2014/5/30.
//
//

#import "CGeoCell.h"
#import "vcGeoFenceEdit.h"
#import "ViewController.h"
#import "vcGeoFenceEdit.h"
@implementation CGeoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)ibaCreate:(id)sender
{
    NSLog(@"create a new geofence");
    ViewController *vc = (ViewController*)[[[[[[self nextResponder]nextResponder]nextResponder]nextResponder]nextResponder]nextResponder];
    UIStoryboard *mainStoryboard = vc.storyboard;
    
    vcGeoFenceEdit *tmp = (vcGeoFenceEdit*)[mainStoryboard
            instantiateViewControllerWithIdentifier: @"vcGeoFenceEdit"];
    tmp.no = self.no;
    tmp.mainObj = self.mainObj;
    [vc presentViewController:tmp animated:YES completion:^{
        
    }];

}
@end
