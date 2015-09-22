//
//  AutoLocatingCell.h
//  3GSW
//
//  Created by Roger on 2015/3/30.
//
//

#import <UIKit/UIKit.h>

@interface AutoLocatingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (strong, nonatomic) IBOutlet UILabel *createTitleLabel;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@end
