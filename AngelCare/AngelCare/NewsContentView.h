//
//  NewsContentView.h
//  AngelCare
//
//  Created by macmini on 13/8/1.
//
//

#import <UIKit/UIKit.h>

@interface NewsContentView : UIView
{
    id MainObj;
    
    IBOutlet UIScrollView *scrollview;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *startTimeLbl;
    IBOutlet UILabel *endTimeLbl;
    IBOutlet UIImageView *coverImg;
    IBOutlet UITextView *contentTxt;
}

-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSDictionary *)dic;

@end
