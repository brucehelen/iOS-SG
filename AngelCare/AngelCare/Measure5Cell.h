//
//  Measure5Cell.h
//  AngelCare
//
//  Created by macmini on 13/6/24.
//
//

#import <UIKit/UIKit.h>

@interface Measure5Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *picNum;
@property (strong, nonatomic) IBOutlet UILabel *stepLbl;
@property (strong, nonatomic) IBOutlet UILabel *stepNum;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanceNum;
@property (strong, nonatomic) IBOutlet UILabel *calLbl;
@property (strong, nonatomic) IBOutlet UILabel *calNum;

@end
