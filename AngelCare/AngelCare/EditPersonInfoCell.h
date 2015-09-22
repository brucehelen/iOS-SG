//
//  EditPersonInfoCell.h
//  AngelCare
//
//  Created by macmini on 13/7/4.
//
//

#import <UIKit/UIKit.h>

@interface EditPersonInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *SexLbl;
@property (strong, nonatomic) IBOutlet UILabel *AddrLbl;
@property (strong, nonatomic) IBOutlet UILabel *imei;
@property (strong, nonatomic) IBOutlet UILabel *PhoneLbl;
@property (strong, nonatomic) IBOutlet UILabel *CarrierLbl;
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *addrTxt;
@property (strong, nonatomic) IBOutlet UILabel *IMEILbl;

@property (strong, nonatomic) IBOutlet UITextField *phoneTxt;

@property (strong, nonatomic) IBOutlet UILabel *UserCarrierLbl;


@property (strong, nonatomic) IBOutlet UIButton *ImgBtn;
@property (strong, nonatomic) IBOutlet UIImageView *UserImg;
@property (strong, nonatomic) IBOutlet UIButton *manBtn;
@property (strong, nonatomic) IBOutlet UIButton *womanbtn;
@property (strong, nonatomic) IBOutlet UILabel *manLbl;
@property (strong, nonatomic) IBOutlet UILabel *womanLbl;

@property (strong, nonatomic) IBOutlet UILabel *lblAddr;


@end
