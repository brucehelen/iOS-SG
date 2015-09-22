//
//  GraphView.h
//  GraphView
//
//  Created by macmini on 13/6/24.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphView : UIView
{
    CGFloat viewWidth;  //View的寬
    CGFloat viewHeight; //View的高
    
    NSInteger Ymax;     //Y軸最大值 為整數
    NSInteger Xmax;     //X軸最大值 單位為天數
    
    NSMutableArray *chartArr;  //長條圖的Array
    NSMutableArray *pointArr;  //折線圖的Array
    NSMutableArray *chartnameArr;   //長條圖顯示名字用的Array
    NSMutableArray *pointnameArr;   //折線圖顯示名字用的Array
    
    
    NSString *MaxDate;          //最大日期
    NSString *MinDate;          //最小日期
    NSInteger MaxDateNum;      //最大日期秒數
    NSInteger MinDateNum;      //最小日期秒數
    
}
- (void)Set_initFrame:(CGRect)frame;

//加入長條圖
-(void)addChart:(NSArray *)value withName:(NSString *)name;

//加入折線圖
-(void)addLineWithArray:(NSArray *)value withName:(NSString *)name;

@property (nonatomic) CGFloat LeftWhiteWidth;   //圖表左邊與View的距離
@property (nonatomic) CGFloat RightWhiteWidth;  //圖表右邊與View的距離
@property (nonatomic) CGFloat UpWhiteHeight;    //圖表上面與View的距離
@property (nonatomic) CGFloat DownWhiteHeight;  //圖表下方與View的距離

@property (nonatomic) NSInteger Xnumber;        //X軸預設幾個刻度
@property (nonatomic) NSInteger Ynumber;        //Y軸預設幾個刻度

@property (nonatomic) NSString *dateFormatter;  //日期的格式
@property (nonatomic) CGFloat ChartWidth;       //長條圖的寬度


@end
