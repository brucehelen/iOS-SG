//
//  NewsView.h
//  AngelCare
//
//  Created by macmini on 13/8/1.
//
//

#import <UIKit/UIKit.h>
#import "NewsCell.h"

@interface NewsView : UIView
{
    id MainObj;
    NSArray *newsArr;
}

-(void)Do_Init:(id)sender;

-(void)Set_Init:(NSArray *)arr;

@end
