//
//  PersonInfoCell.h
//  AngelCare
//
//  Created by macmini on 13/7/3.
//
//

#import <UIKit/UIKit.h>

@interface PersonInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *UserNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *UserSexLbl;
@property (strong, nonatomic) IBOutlet UILabel *UserAddressLbl;
@property (strong, nonatomic) IBOutlet UILabel *IMEILbl;
@property (strong, nonatomic) IBOutlet UILabel *UserPhone;
@property (strong, nonatomic) IBOutlet UILabel *UserCarrer;
@property (strong, nonatomic) IBOutlet UIImageView *UserImg;
@property (strong, nonatomic) IBOutlet UIButton *ImgBtn;

@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *SexLbl;
@property (strong, nonatomic) IBOutlet UILabel *AddrLbl;
@property (strong, nonatomic) IBOutlet UILabel *imei;
@property (strong, nonatomic) IBOutlet UILabel *PhoneLbl;
@property (strong, nonatomic) IBOutlet UILabel *Carrier;


@end
