//
//  MyHisCell.h
//  AngelCare
//
//  Created by macmini on 13/7/10.
//
//

#import <UIKit/UIKit.h>

@interface MyHisCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *timeLbl;
@property (nonatomic,strong) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIView *viewBg;

@end
