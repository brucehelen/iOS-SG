//
//  WECell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/19.
//
//

#import <UIKit/UIKit.h>

@interface WECell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) IBOutlet UILabel *lblBMI;
@property (strong, nonatomic) IBOutlet UILabel *lblFat;


@property (strong, nonatomic) IBOutlet UILabel *lblBWTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblBMITitle;
@property (strong, nonatomic) IBOutlet UILabel *lblBFTitle;

@end
