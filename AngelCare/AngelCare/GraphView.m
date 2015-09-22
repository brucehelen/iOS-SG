//
//  GraphView.m
//  GraphView
//
//  Created by macmini on 13/6/24.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "GraphView.h"
#import "UIView+ZXQuartz.h"
@implementation GraphView

@synthesize UpWhiteHeight,DownWhiteHeight,LeftWhiteWidth,RightWhiteWidth;

@synthesize Ynumber,Xnumber;
@synthesize dateFormatter;
@synthesize ChartWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)Set_initFrame:(CGRect)frame
{
    NSLog(@"frame width = %f height = %f",frame.size.width,frame.size.height);
    
    viewWidth = frame.size.width;
    viewHeight = frame.size.height;
    chartArr = [[NSMutableArray alloc] init];
    pointArr = [[NSMutableArray alloc] init];
    chartnameArr = [[NSMutableArray alloc] init];
    pointnameArr = [[NSMutableArray alloc] init];
    MaxDate = @"";
    MinDate = @"";
}

//加入長條圖
-(void)addChart:(NSArray *)value withName:(NSString *)name
{
    
    NSLog(@"value = %@",value);
    
    //先加入chartArr
    [chartArr addObject:value];
    [chartnameArr addObject:name];
    
    for (int i = 0; i <[value count]; i++) {
        //MaxDate是否為空值
        if ([MaxDate isEqualToString:@""]) {
            MaxDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MaxDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        //MinDate是否為空值
        if ([MinDate isEqualToString:@""]) {
            MinDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MinDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        if (MaxDateNum < [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter]) {
            MaxDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MaxDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        if (MinDateNum > [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter]) {
            MinDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MinDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        NSLog(@"Ymax%i = %i",i,Ymax);
        if ([[[value objectAtIndex:i] objectForKey:@"value"] integerValue] > Ymax) {
            
            Ymax = [[[value objectAtIndex:i] objectForKey:@"value"] integerValue];
        }
    }
    
    NSLog(@"chartnameArr = %@",chartnameArr);
}


//加入折線圖
-(void)addLineWithArray:(NSArray *)value withName:(NSString *)name
{
    NSLog(@"value = %@",value);
    [pointArr addObject:value];
    for (int i = 0; i <[value count]; i++) {
        //MaxDate是否為空值
        if ([MaxDate isEqualToString:@""]) {
            MaxDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MaxDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        //MinDate是否為空值
        if ([MinDate isEqualToString:@""]) {
            MinDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MinDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        if (MaxDateNum < [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter]) {
            MaxDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MaxDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        
        if (MinDateNum > [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter]) {
            MinDate = [[value objectAtIndex:i] objectForKey:@"date"];
            MinDateNum = [self timeTosec:[[value objectAtIndex:i] objectForKey:@"date"] andFormatter:dateFormatter];
        }
        NSLog(@"Ymax2%i = %i",i,Ymax);
        if ([[[value objectAtIndex:i] objectForKey:@"value"] integerValue] > Ymax) {
            Ymax = [[[value objectAtIndex:i] objectForKey:@"value"] integerValue];
        }
    }
    
    [pointnameArr addObject:name];
}



//將時間轉換為秒數
-(int)timeTosec:(NSString *)time andFormatter:(NSString *)formatter
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:formatter];
    NSDate *startd=[date dateFromString:time];
    
    NSLog(@"formatter = %@",formatter);
    NSLog(@"timeTosec time = %@",time);
    
    return [startd timeIntervalSince1970]*1;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //劃線方式皆由上到下 左到右
    NSLog(@"draw Rect %f",viewWidth);
    
    
    // Drawing code
    UIColor *black = [UIColor blackColor];
    [black setStroke];//设置线条颜色
    
    //畫X軸
    [self drawLineFrom:CGPointMake(LeftWhiteWidth, viewHeight - DownWhiteHeight)
                    to:CGPointMake(viewWidth - RightWhiteWidth, viewHeight - DownWhiteHeight)];
    
    //畫Y軸
    [self drawLineFrom:CGPointMake(LeftWhiteWidth, DownWhiteHeight)
                    to:CGPointMake(LeftWhiteWidth, viewHeight - DownWhiteHeight)];
    NSLog(@"draw 1");
    //畫Y軸刻度
    //先計算Y軸長度 -10 
    CGFloat YPerlength = (viewHeight - UpWhiteHeight - DownWhiteHeight - 10)/Ynumber;
    
    //假設Y最大值為180
    
    
    if (Ymax <= 180) {
        Ymax = 180;
    }
    NSLog(@"Ymax final = %i",Ymax);
    
    for (int i = 0; i <= Ynumber; i++) {
        //畫Y軸 -
        if (i != 0) {
            [self drawLineFrom:CGPointMake(LeftWhiteWidth-2, viewHeight - DownWhiteHeight - YPerlength*i)
                            to:CGPointMake(LeftWhiteWidth+2, viewHeight - DownWhiteHeight - YPerlength*i)];
        }
        
        
        //加入Y軸的Label
        if (DownWhiteHeight != 0) {
            UILabel *YLbl = [[UILabel alloc] initWithFrame:CGRectMake(LeftWhiteWidth - LeftWhiteWidth -2, viewHeight - DownWhiteHeight - 5 - YPerlength*i , LeftWhiteWidth, 10.0f)];
            YLbl.textAlignment = NSTextAlignmentRight;
            YLbl.text = [NSString stringWithFormat:@"%i",Ymax/Ynumber*i];
            NSLog(@"label = %i",Ymax/Ynumber*i);
            YLbl.backgroundColor = [UIColor clearColor];
            YLbl.font = [UIFont systemFontOfSize:12];
            [self addSubview:YLbl];
        }
        
    }
    
    
    //畫Y軸刻度
    //先計算Y軸長度 -5
//    CGFloat Xperlength = (viewWidth - LeftWhiteWidth - RightWhiteWidth - 10)/Xnumber;
    
    //天數
//    Xmax = 10;
    
    
    /*
    for (int j = 1; j <= Xnumber; j++) {
        
        //畫X軸 -
        [self drawLineFrom:CGPointMake(LeftWhiteWidth + Xperlength*j, viewHeight - DownWhiteHeight -2)
                        to:CGPointMake(LeftWhiteWidth + Xperlength*j, viewHeight - DownWhiteHeight +2)];
        
        
        //加入X軸的Label
        UILabel *XLbl = [[UILabel alloc] initWithFrame:CGRectMake(LeftWhiteWidth + Xperlength*j -7.5, viewHeight - DownWhiteHeight +5, 15, 10)];
        
        XLbl.textAlignment = NSTextAlignmentCenter;
        XLbl.text = [NSString stringWithFormat:@"%i",Xmax/Xnumber*j];
        XLbl.backgroundColor = [UIColor clearColor];
        XLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:XLbl];
         
    }
     */
    
    
    
    
//    NSLog(@"first point = %f",LeftWhiteWidth + Xperlength);
//    NSLog(@"last point = %f",LeftWhiteWidth + Xperlength*Xnumber);
    //最小日期取00:00:00
    NSLog(@"draw 2");
    
    NSLog(@"MinDate = %@",MinDate);
    
    //畫chart One
    UIColor *grenn = [UIColor colorWithRed:0.74
                                     green:0.93
                                      blue:0.34
                                     alpha:1];
    
    UIColor *white = [UIColor colorWithRed:1
                                     green:1
                                      blue:1
                                     alpha:1];
    
    UIColor *purple = [UIColor colorWithRed:0.74
                                      green:0.39
                                       blue:0.87
                                      alpha:1];
    UIColor *orange = [UIColor colorWithRed:0.91 green:0.74 blue:0.18 alpha:1];
    
    if (![MinDate isEqualToString:@""]) {
        
        NSString *mindateString;
        NSString *maxdateString;
        if ([dateFormatter length] > 16) {
            mindateString = [NSString stringWithFormat:@"%@:00",[MinDate substringToIndex:16]];
            //最大日期取23:59:59
            maxdateString = [NSString stringWithFormat:@"%@:59",[MaxDate substringToIndex:16]];
        }else
        {
            mindateString = [NSString stringWithFormat:@"%@ 00:00",[MinDate substringToIndex:10]];
            //最大日期取23:59:59
            maxdateString = [NSString stringWithFormat:@"%@ 23:59",[MaxDate substringToIndex:10]];
        }
    
    
        NSLog(@"mindateString = %@",mindateString);
    
    MinDateNum = [self timeTosec:mindateString andFormatter:dateFormatter];
        
        NSLog(@"MinDateNum = %i",MinDateNum);
    
    MaxDateNum = [self timeTosec:maxdateString andFormatter:dateFormatter];
    
    
    NSLog(@"maxDate = %@ maxDateNum = %i",maxdateString,MaxDateNum);
    NSLog(@"minDate = %@ minDateNum = %i",mindateString,MinDateNum);
    
    //畫X軸的- 必須先算出幾天
    NSInteger totalDay = (MaxDateNum - MinDateNum)/60/60/24+1;
    NSLog(@"total day = %i",totalDay);

   CGFloat Xperlength = (viewWidth - LeftWhiteWidth - RightWhiteWidth - 10)/totalDay;
    
    for (int i = 1; i<= totalDay; i++) {
        //畫X軸 -
        [self drawLineFrom:CGPointMake(LeftWhiteWidth + Xperlength*i, viewHeight - DownWhiteHeight -2)
                        to:CGPointMake(LeftWhiteWidth + Xperlength*i, viewHeight - DownWhiteHeight +2)];
        
        UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(LeftWhiteWidth + Xperlength*i - 10, viewHeight - DownWhiteHeight + 10, 35, 10)];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        NSDate *Valuedate = [NSDate dateWithTimeIntervalSince1970:MinDateNum+60*60*24*i];

        
        NSString *dateString = [formatter stringFromDate:Valuedate];
        
        dateLbl.textAlignment = NSTextAlignmentRight;
        
        NSLog(@"date string = %@",dateString);
        
        
        dateLbl.text = dateString;
        dateLbl.backgroundColor = [UIColor clearColor];
        dateLbl.font = [UIFont systemFontOfSize:12];
        dateLbl.transform = CGAffineTransformMakeRotation(1);
        
        if ([dateFormatter length]<=16) {
            [self addSubview:dateLbl];
        }
        
        
    }
    
    NSLog(@"draw 3");
    
//    NSInteger DifMaxandMin = MaxDateNum - MinDateNum;
    
    NSInteger MaxXLength = LeftWhiteWidth + Xperlength*totalDay ;
    NSInteger MinXLength = LeftWhiteWidth;
    
    NSInteger MaxYLength = DownWhiteHeight + YPerlength*Ynumber;
    NSInteger MinYLength = viewHeight - DownWhiteHeight;
    
    NSLog(@"max y = %i min y = %i",MaxYLength,MinYLength);
    
    
    
    //畫長條圖
    
    for (int l=0; l<[chartArr count]; l++)
    {
        
        
        switch (l) {
            case 0:
                NSLog(@"log 0");
                [grenn setFill];
                [white setStroke];
                break;
            
            case 1:
                NSLog(@"log 1");
                [purple setFill];
                [white setStroke];
                break;
            default:
                break;
        }
        
        NSLog(@"chartArr %@",[chartArr objectAtIndex:l]);
        
        for (int m=0; m<[[chartArr objectAtIndex:l] count]; m++)
        {
            NSInteger dateValue = [self timeTosec:[[[chartArr objectAtIndex:l] objectAtIndex:m] objectForKey:@"date"] andFormatter:dateFormatter];
            NSInteger Value = [[[[chartArr objectAtIndex:l] objectAtIndex:m] objectForKey:@"value"] integerValue];
            
            
            NSInteger Xvalue = ((MaxXLength - MinXLength) * (dateValue - MinDateNum)/(MaxDateNum - MinDateNum)) + MinXLength;
            
            NSInteger Yvalue = (viewHeight - DownWhiteHeight - UpWhiteHeight -10) /Ymax * Value;
            
//            NSLog(@"xvalue = %i date value = %i",Xvalue,dateValue);
            
            NSLog(@"value = %i Yvalue = %f",Value,viewHeight - DownWhiteHeight - Yvalue);
            
            [self drawRectangle:CGRectMake(Xvalue - (ChartWidth/2), viewHeight - DownWhiteHeight - Yvalue, ChartWidth, Yvalue-1)];
        }
        
        
    }
    
    
    //畫折線圖
    for (int n=0; n<[pointArr count]; n++) {
        switch (n) {
            case 0:
                [orange setFill];
                [orange setStroke];
                break;
                
            case 1:
                [purple setFill];
                [white setStroke];
                break;
            default:
                break;
        }
        NSMutableArray *lines = [[NSMutableArray alloc] init];
        for (int p=0; p<[[pointArr objectAtIndex:n] count]; p++)
        {
            //畫點
            NSInteger dateValue = [self timeTosec:[[[pointArr objectAtIndex:n] objectAtIndex:p] objectForKey:@"date"] andFormatter:dateFormatter];
            NSInteger Value = [[[[pointArr objectAtIndex:n] objectAtIndex:p] objectForKey:@"value"] integerValue];
            
            
            NSInteger Xvalue = ((MaxXLength - MinXLength) * (dateValue - MinDateNum)/(MaxDateNum - MinDateNum)) + MinXLength;
            
            NSInteger Yvalue = (viewHeight - DownWhiteHeight - UpWhiteHeight -10) /Ymax * Value;
            
            [self drawCircleWithCenter:CGPointMake(Xvalue,viewHeight - DownWhiteHeight - Yvalue) radius:2];
            
            //畫線
            NSValue *point = [NSValue valueWithCGPoint:CGPointMake(Xvalue, viewHeight - DownWhiteHeight - Yvalue)];
            [lines addObject:point];
        }
        
        
        
        if ([lines count] >1) {
//            [self drawCircleWithCenter:CGPointMake(viewWidth*0.75,UpWhiteHeight) radius:2];
            
            CGContextRef     context = UIGraphicsGetCurrentContext();
            //將折線的寬度設為2
            CGContextSetLineWidth(context, 2.0f);
            
            [self drawLines:lines];
            
            
        }
        
    }
    
    
    NSLog(@"chartnameArr = %i",[chartnameArr count]);
        
    }
    
    NSLog(@"chartnameArr  = %i",[chartnameArr count]);
    
    for (int i =0; i < [chartnameArr count]; i++) {
        
        switch (i) {
            case 0:
                [grenn setFill];
                [grenn setStroke];
                break;
            case 1:
                [purple setFill];
                [purple setStroke];
                break;
                
            case 2:
                break;
                
            default:
                break;
        }
        NSLog(@"int i = %i",i);
        [self drawCircleWithCenter:CGPointMake(viewWidth*0.25*(i+1),UpWhiteHeight) radius:2];
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth*0.25*(i+1)+5, UpWhiteHeight-12, 80, 20)];
        nameLbl.numberOfLines = 0;
        nameLbl.textAlignment = NSTextAlignmentLeft;
        nameLbl.text = [chartnameArr objectAtIndex:i];
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:nameLbl];
    }
    
    NSLog(@"chart arr = %@",pointnameArr);
    int k = 0;
    for (int j = [chartnameArr count]; j<([pointnameArr count]+[chartnameArr count]); j++)
    {
        
        switch (k) {
            case 0:
                [orange setFill];
                [orange setStroke];
                break;
                
            default:
                break;
        }
        
        NSLog(@"int j = %i",j);
        
        [self drawCircleWithCenter:CGPointMake(viewWidth*0.25*(j+1),UpWhiteHeight) radius:2];
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth*0.25*(j+1)+5, UpWhiteHeight-12, 80, 20)];
        nameLbl.numberOfLines = 0;
        nameLbl.textAlignment = NSTextAlignmentLeft;
        
        
        nameLbl.text = [pointnameArr objectAtIndex:k];
        NSLog(@"Name = %@",[pointnameArr objectAtIndex:k]);
        nameLbl.backgroundColor = [UIColor clearColor];
        nameLbl.font = [UIFont systemFontOfSize:12];
        [self addSubview:nameLbl];
        k++;
    }
    
    
}





@end
