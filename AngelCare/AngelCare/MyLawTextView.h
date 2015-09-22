//
//  MyLawTextView.h
//  Project_OldAngel
//
//  Created by Lion User on 12/11/6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyLawTextView : UIView
{
    
    IBOutlet UIScrollView *myScrollView;
}


//設定為英文版本
-(void)Set_En;

//設定為簡體版本
-(void)Set_Cn;

//設定為繁體版本
-(void)Set_Tw;

@end
