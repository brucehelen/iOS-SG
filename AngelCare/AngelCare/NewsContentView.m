//
//  NewsContentView.m
//  AngelCare
//
//  Created by macmini on 13/8/1.
//
//

#import "NewsContentView.h"

@implementation NewsContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)Do_Init:(id)sender
{
    MainObj = sender;
}

-(void)Set_Init:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);
    titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
    titleLbl.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    
    startTimeLbl.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"startTime"]];
    endTimeLbl.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"endTime"]];
    
    NSString *contentStr= [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    //ios7 modify
    NSDictionary *attributes = @{NSFontAttributeName: titleLbl.font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [contentStr boundingRectWithSize:CGSizeMake(180.0f, 42.0f)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    CGSize strsize = rect.size;
//    CGSize strsize = [contentStr sizeWithFont:titleLbl.font
//                            constrainedToSize:CGSizeMake(180.0f, 42.0f)
//                                lineBreakMode:titleLbl.lineBreakMode];
    
    CGRect titleFrame = titleLbl.frame;
    titleFrame.size = strsize;
    titleLbl.frame = titleFrame;
    
    NSLog(@"strsize = %f %f",strsize.width,strsize.height);
    
    contentTxt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"detail"]];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
