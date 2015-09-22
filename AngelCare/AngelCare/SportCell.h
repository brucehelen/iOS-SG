//
//  SportCell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/20.
//
//

#import <UIKit/UIKit.h>

@interface SportCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblStep;
@property (strong, nonatomic) IBOutlet UILabel *lblDis;
@property (strong, nonatomic) IBOutlet UILabel *lblDisTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblStepsTitle;

@end
