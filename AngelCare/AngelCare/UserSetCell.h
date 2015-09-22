//
//  UserSetCell.h
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import <UIKit/UIKit.h>

@interface UserSetCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *titleLbl;
@property (nonatomic,strong) IBOutlet UILabel *infoLbl;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *lineView;


@end
