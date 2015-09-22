//
//  Measure1Cell.h
//  AngelCare
//
//  Created by macmini on 13/6/18.
//
//

#import <UIKit/UIKit.h>

@interface Measure1Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UIImageView *firstImg;
@property (strong, nonatomic) IBOutlet UILabel *firstCountLbl;

@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *firstNum;
@property (strong, nonatomic) IBOutlet UIImageView *secondImg;
@property (strong, nonatomic) IBOutlet UILabel *secondCountLbl;
@property (strong, nonatomic) IBOutlet UILabel *secondName;
@property (strong, nonatomic) IBOutlet UILabel *secondNum;
@property (strong, nonatomic) IBOutlet UILabel *pulseLbl;
@property (strong, nonatomic) IBOutlet UILabel *pulseNum;

@end
