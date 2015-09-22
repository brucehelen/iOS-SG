//
//  GeoCell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import <UIKit/UIKit.h>
#import "MainClass.h"
@interface GeoCell : UITableViewCell
<UIGestureRecognizerDelegate>
- (void)addGes;

@property (strong, nonatomic) IBOutlet UILabel *lblST;
@property (strong, nonatomic) IBOutlet UILabel *lblET;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblw1;
@property (strong, nonatomic) IBOutlet UILabel *lblw2;
@property (strong, nonatomic) IBOutlet UILabel *lblw3;
@property (strong, nonatomic) IBOutlet UILabel *lblw4;
@property (strong, nonatomic) IBOutlet UILabel *lblw5;
@property (strong, nonatomic) IBOutlet UILabel *lblw6;
@property (strong, nonatomic) IBOutlet UILabel *lblw7;

@property (strong, nonatomic) IBOutlet UISwitch *btnSwitch;

- (void)do_initWithDict:(NSDictionary*)dict;

- (IBAction)ibaSwitch:(id)sender;

@property (nonatomic)int no;
@property (strong, nonatomic) MainClass *mainObj;

@end
