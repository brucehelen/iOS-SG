//
//  MeasureRemind.m
//  AngelCare
//
//  Created by macmini on 13/7/11.
//
//

#import "MeasureRemind.h"
#import "MainClass.h"


#define HS_BPRemind NSLocalizedStringFromTable(@"HS_BPRemind", INFOPLIST, nil)

#define HS_BSRemind NSLocalizedStringFromTable(@"HS_BSRemind", INFOPLIST, nil)

#define HS_BORemind NSLocalizedStringFromTable(@"HS_BORemind", INFOPLIST, nil)

#define HS_Weight NSLocalizedStringFromTable(@"HS_Weight", INFOPLIST, nil)

#define HS_Sport NSLocalizedStringFromTable(@"HS_Sport", INFOPLIST, nil)

@implementation MeasureRemind

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(IBAction)measureBtnClick:(id)sender
{
    NSLog(@"measureBtnClick");
    [(MainClass *)MainObj Other_MouseDown:[(UIView*)sender tag]];
}


//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender
{
    NSLog(@"set it BPView");
    MainObj = sender;
    //ntt modify
//    [self SetBgView:bgView1 AndColor:[UIColor colorWithRed:0.541 green:0.803 blue:1 alpha:1]];
//    
//    [self SetBgView:bgView2 AndColor:[UIColor colorWithRed:0.454 green:0.674 blue:1 alpha:1]];
//    
//    [self SetBgView:bgView3 AndColor:[UIColor colorWithRed:0.505 green:0.933 blue:0.99 alpha:1]];
//    
//    [self SetBgView:bgView4 AndColor:[UIColor colorWithRed:0.921 green:0.909 blue:0.262 alpha:1]];
//    
//    [self SetBgView:bgView5 AndColor:[UIColor colorWithRed:1 green:0.729 blue:0.207 alpha:1]];
    
    title1.text = HS_BPRemind;
    title2.text = HS_BSRemind;
    title3.text = HS_BORemind;
    title4.text = HS_Weight;
    title5.text = HS_Sport;
    
    [title1 setTextColor:[UIColor blackColor]];
    [title2 setTextColor:[UIColor blackColor]];
    [title3 setTextColor:[UIColor blackColor]];
    [title4 setTextColor:[UIColor blackColor]];
    [title5 setTextColor:[UIColor blackColor]];
}




//設定每個icon的背景顏色
-(void)SetBgView:(UIView *)bgView AndColor:(UIColor *)changeColor
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[changeColor CGColor],(id)[[UIColor whiteColor] CGColor],  nil]; // 由上到下的漸層顏色
    [bgView.layer insertSublayer:gradient atIndex:0];
    bgView.layer.cornerRadius = 8.0f;
    bgView.layer.masksToBounds = YES;
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
