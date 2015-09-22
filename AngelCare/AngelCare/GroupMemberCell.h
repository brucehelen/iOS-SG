//
//  GroupMemberCell.h
//  AngelCare
//
//  Created by macmini on 13/6/27.
//
//

#import <UIKit/UIKit.h>

@interface GroupMemberCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *isUserImg;
@property (strong, nonatomic) IBOutlet UIImageView *typeImg;
@end
