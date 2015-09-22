//
//  ShowImage.h
//  AngelCare
//
//  Created by macmini on 2013/12/26.
//
//

#import <UIKit/UIKit.h>
@protocol ShowImageDelegate <NSObject>
@required
-(void)ShowImgClick:(int)type;
@end

@interface ShowImage : UIView
{
    IBOutlet UILabel *titleLbl;
    IBOutlet UITableView *showImageTable;
    NSString *img_url1;
    NSString *img_url2;
    NSString *img_url3;
    NSString *img_url4;
    NSArray *imgUrlArr;
}

@property (strong) NSObject <ShowImageDelegate> *delegate;

-(void)Do_Init;

-(void)Set_Init:(NSDictionary *)dic;



@end
