//
//  BOCell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/19.
//
//

#import <UIKit/UIKit.h>

@interface BOCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblBO;
@property (strong, nonatomic) IBOutlet UILabel *lblPul;
@property (strong, nonatomic) IBOutlet UILabel *lblBOTitle;

@end
