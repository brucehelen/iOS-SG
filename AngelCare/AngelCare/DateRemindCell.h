//
//  DateRemindCell.h
//  AngelCare
//
//  Created by macmini on 13/6/26.
//
//

#import <UIKit/UIKit.h>

@interface DateRemindCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIButton *clockBtn;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;

@end
