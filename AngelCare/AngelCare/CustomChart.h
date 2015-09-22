//
//  CustomChart.h
//  mCareWatch
//
//  Created by Roger on 2014/5/2.
//
//

#import <UIKit/UIKit.h>

@interface CustomChart : UIView
{
    //parent View
    id  MainObj;
    
    //血壓，血糖，血氧類別
    int type;
    
    
    //是否為圖表
//    BOOL isChart;
    
    NSArray *dataArr;
    NSDictionary *remindDic;
    
    IBOutlet UITextView *remindView;
    IBOutlet UIButton *changeViewBtn;
    
    IBOutlet UIButton *dayBtn;
    IBOutlet UIButton *weekBtn;
    IBOutlet UIButton *monthBtn;
    IBOutlet UIButton *IntervalBtn;
    
    
    IBOutlet UIButton *btnChartOrList;
}
@property (nonatomic) BOOL isChart;
- (void)doInit;

-(void)Set_Init:(NSArray *)arr withType:(int)tmpType;
//重新讀取資料
-(void)reloadData;
-(void)drawChart;
-(void)Set_RemindInit:(NSDictionary *)dic withType:(int) m_type;
@property (nonatomic,strong) NSDictionary *limitDict;
@property (nonatomic,strong) NSDictionary *limitLineDict;
@end
