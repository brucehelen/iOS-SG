//
//  personCell.h
//  AngelCare
//
//  Created by macmini on 13/8/15.
//
//

#import <UIKit/UIKit.h>

@interface personCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *serviceLbl;
@property (nonatomic,strong) IBOutlet UILabel *titleLbl;
@property (nonatomic,strong) IBOutlet UILabel *timeLbl;
@property (nonatomic,strong) IBOutlet UILabel *contentLbl;
+ (CGFloat)heightForMessage:(NSString *)message  andLabel:(UILabel *)contentLbl;
@end
