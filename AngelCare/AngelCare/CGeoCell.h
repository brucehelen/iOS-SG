//
//  CGeoCell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/30.
//
//

#import <UIKit/UIKit.h>
#import "MainClass.h"
@interface CGeoCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *btnCreate;
- (IBAction)ibaCreate:(id)sender;

@property (nonatomic)int no;
@property (strong, nonatomic) MainClass *mainObj;
@end
