//
//  MeasureRemind.h
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import <UIKit/UIKit.h>

@interface MeasureRemind : UIView
{
    IBOutlet UIButton *BPRemind;
    IBOutlet UIButton *BSRemind;
    IBOutlet UIButton *BORemind;
    IBOutlet UIButton *SportRemind;
    IBOutlet UIButton *WeightRemind;
    
    IBOutlet UIView *bgView1;
    IBOutlet UIView *bgView2;
    IBOutlet UIView *bgView3;
    IBOutlet UIView *bgView4;
    IBOutlet UIView *bgView5;
    
    IBOutlet UILabel *title1;
    IBOutlet UILabel *title2;
    IBOutlet UILabel *title3;
    IBOutlet UILabel *title4;
    IBOutlet UILabel *title5;
    
    //parent View
    id  MainObj;
    
}

-(void)Do_Init:(id)sender;

-(IBAction)measureBtnClick:(id)sender;
@end
