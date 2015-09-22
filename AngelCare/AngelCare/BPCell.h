//
//  BPCell.h
//  mCareWatch
//
//  Created by Roger on 2014/5/19.
//
//

#import <UIKit/UIKit.h>

@interface BPCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblSys;
@property (strong, nonatomic) IBOutlet UILabel *lblDia;
@property (strong, nonatomic) IBOutlet UILabel *lblPul;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;


@property (strong, nonatomic) IBOutlet UILabel *lblSPTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDPTitle;

@end
