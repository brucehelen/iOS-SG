//
//  CustomChart.m
//  mCareWatch
//
//  Created by Roger on 2014/5/2.
//
//

#import "CustomChart.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "BPCell.h"
#import "BGCell.h"
#import "BOCell.h"
#import "WECell.h"
#import "SportCell.h"
#import "define.h"
#import "MainClass.h"


#define bp 0
#define BPCellHeight 130
#define BGCellHeight 95

//for BP
#define systolicRed 180
#define systolicOrange 180
#define systolicYellow 160
#define systolicGreen 140


#define diastolicRed 110
#define diastolicOrange 110
#define diastolicYellow 100
#define diastolicGreen 90

@interface CustomChart () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSInteger numberOfPage;
    NSMutableArray *pileOfData;
    UILabel *first;
    UILabel *second;
    UILabel *third;
    UILabel *four;
    UIPageControl *_pageControl;
    UIScrollView *_scrollview;
    UITableView *table;
    UILabel *infoLbl;
    //BP
    int limitRed;
    int limitOrange;
    int limitYellow;
    int limitGreen;
    
    //BG
    float limitBG;
    //we
    //sport
    int goalStep;
    int goalDis;
    UIColor *weColor;
    //
    int oldType;
    
    UIButton *info;
    UIWebView *infoWeb;
    UIView *viewWebBg;
    UILabel *lblUnit;
    
    //
    int unitDef;
    
    //血壓
    int bpdDownlimit;
    int bpdUplimit;
    int bpsDownlimit;
    int bpsUplimit;
    //血糖
    int afterMealDown;
    int afterMealUp;
    int bedTimeDown;
    int bedTimeUp;
    int beforeMealDown;
    int beforeMealUp;
}

@end

@implementation CustomChart
@synthesize isChart;


- (void)setUnitDef
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"unit.txt"];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    if ([content length] == 0) {
        unitDef = 0;
    }
    else{
        unitDef = [content intValue];
    }
    
}


- (void)Set_Init:(NSArray *)arr withType:(int)tmpType
{
    //
    [self setUnitDef];
    //
    oldType = type;
    if (isChart) {
        //        [changeViewBtn setTitle:List forState:UIControlStateNormal];
        [btnChartOrList setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
        [btnChartOrList setTitle:@"圖表" forState:UIControlStateNormal];
    }else
    {
        //        [changeViewBtn setTitle:Chart forState:UIControlStateNormal];
        [btnChartOrList setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
        [btnChartOrList setTitle:@"列表" forState:UIControlStateNormal];
    }
    type = tmpType;
    if (type != oldType) {
        [dayBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
//        [dayBtn setTitle:@"日" forState:UIControlStateNormal];
        [weekBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
//        [weekBtn setTitle:@"週" forState:UIControlStateNormal];
        [monthBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
//        [monthBtn setTitle:@"月" forState:UIControlStateNormal];
        [IntervalBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up.png"] forState:UIControlStateNormal];
//        [IntervalBtn setTitle:@"週期" forState:UIControlStateNormal];
    }
    dataArr = [NSArray new];

    [dayBtn setTitle:@"day" forState:UIControlStateNormal];
    [weekBtn setTitle:@"week" forState:UIControlStateNormal];
    [monthBtn setTitle:@"month" forState:UIControlStateNormal];
    [IntervalBtn setTitle:@"Interval" forState:UIControlStateNormal];

    if (arr.count != 0) {
        NSMutableArray *m_tmp = [NSMutableArray new];
        NSMutableArray *mm_tmp = [NSMutableArray new];
        if (arr.count >= 7) {
            for (int i = (int)arr.count; i > (arr.count -7) ; i--) {
                [m_tmp addObject:[arr objectAtIndex:i-1]];
            }
            for (int i = 6; i >= 0; i--) {
                [mm_tmp addObject:[m_tmp objectAtIndex:i]];
            }
            dataArr = [[NSArray alloc]initWithArray:mm_tmp];
        }
        else{
            for (int i = (int)arr.count; i > 0 ; i--) {
                [m_tmp addObject:[arr objectAtIndex:i-1]];
            }
            for (int i = (int)arr.count; i > 0; i--) {
                [mm_tmp addObject:[m_tmp objectAtIndex:i-1]];
            }
            dataArr = [[NSArray alloc]initWithArray:mm_tmp];
        }

        if (tmpType == 2) {
            [self handleUnit:dataArr];
        }
    }

    NSLog(@"data arr = %@, %d", dataArr, tmpType);

    if (tmpType == 2) {
        for (NSDictionary *dict in dataArr) {
            float value = [[dict objectForKey:@"bloodglucose"] floatValue];
            int value2 = value * 10;
            float value3 = value2/10.0;
            [dict setValue:@(value3) forKey:@"bloodglucose"];
        }
    }
}

- (void) handleUnit:(NSArray *)datas{
    NSMutableArray *tmpA = [NSMutableArray new];
    for (int i = 0;  i < [datas count]; i++) {
//        int bs = [[[datas objectAtIndex:i]objectForKey:@"bloodglucose"]intValue];
        int unit = [[[datas objectAtIndex:i] objectForKey:@"unit"]intValue];
        float num = [[[datas objectAtIndex:i] objectForKey:@"bloodglucose"]floatValue];
        if (unitDef == 0) { //mmol/L
//            cell.unit.text = @"mmol/L";
            if (unit == 1) {//mmol/L = md/gl / 18
                num = num / 18; //100 => 10 / 18
            }
            else if(unit == 2){//mg/L = mg/dl / 10
                num = num / 18 / 10; //95 => 9.5 * 18 / 10
            }
            else{
                num = num;
            }
        }
        else if (unitDef == 1){//mg/dl
//            cell.unit.text = @"mg/dl";
            if (unit==0)  {//md/gl = mmol / * 18
                num = num * 18;
            }
            else if(unit == 2){//md/gl = md/L / 10
                num = num / 10;
            }
            else{
                num = num;
            }
        }
        else{// mg/L
//            cell.unit.text = @"mg/L";
            if (unit == 0)  {//mg/L = mmol/l * 18 / 10
                num = num * 18 / 10;
            }
            else if(unit == 1){//mg/L = mg/dl / 10
                num = num / 10;
            }
            else{
                num = num;
            }
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[datas objectAtIndex:i]];
        [dict setObject:@(num) forKey:@"bloodglucose"];
//        cell.bsLbl.text = [NSString stringWithFormat:@"%d",num];
        //////
        NSLog(@"dict %@",[datas objectAtIndex:i]);
        [tmpA addObject:dict];
    }
    dataArr = [NSArray arrayWithArray:tmpA];
    NSLog(@"%@,dataArr = %@",[self class],dataArr);
    
    //limitBG = [[remindDic objectForKey:@"beforeMealUp"]floatValue];
}

- (void) handleUnitBG{
    limitBG = [[remindDic objectForKey:@"beforeMealUp"]floatValue];
    float num = limitBG; //mg/dl
    if (unitDef == 0) { //mmol/L
                        // mg/dl / 18 = mmol/L
        //            cell.unit.text = @"mmol/L";
        num = num / 10 / 18;
    }
    else if (unitDef == 1){// mg/dl
                           // mg/dl = mg/dl
        num = num / 10;
    }
    else{// mg/L
         // mg/L = mg/dl / 10
        num = num / 10 / 10;
    }
    limitBG = num;
}
// 重新讀取資料
- (void)reloadData
{
    NSLog(@"reloadData");
    NSLog(@"isChart %i",isChart);
    NSLog(@"data arr = %@",dataArr);
    
    switch (type) {
        case 1://血壓
            NSLog(@"BP ReloadData");
            //                [self BPReloadData];
            //                [self handleData:dataArr[0]];
            if (![self chkArrayHaveData:dataArr withKey:@"systolic"]) {
                break;
            }

            [self handleDataWithArray:dataArr];
            break;

        case 2://血糖
            NSLog(@"BS ReloadData");
            //                [self BSReloadData];
            if (![self chkArrayHaveData:dataArr withKey:@"bloodglucose"]) {
                break;
            }

            [self handleDataWithArray:dataArr];
            break;
            
        case 3://血氧
            //                [self BOReloadData];
//            if (![self chkArrayHaveData:dataArr withKey:@"dist"]) {
//                break;
//            }

            [self handleDataWithArray:dataArr];
            break;
            
        case 4://體重
            //                [self WeightReload];
            if (![self chkArrayHaveData:dataArr withKey:@"weight"]) {
                break;
            }

            [self handleDataWithArray:dataArr];
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            if (![self chkArrayHaveData:dataArr withKey:@"dist"]) {
                break;
            }
            [self handleDataWithArray:dataArr];
            break;
            
        default:
            break;
    }

}
- (BOOL)chkArrayHaveData:(NSArray*)array withKey:(NSString*)key{
    BOOL result = YES;
    NSDictionary *dict;
    if (array.count >0) {
        dict = [array lastObject];
        if ([dict objectForKey:key]) {
            result = YES;
        }
        else{
            result = NO;
        }
    }
    else{
        result = NO;
    }
    return result;
}

- (void)doInit
{
    [dayBtn setHidden:YES];
    [weekBtn setHidden:YES];
    [monthBtn setHidden:YES];
    [IntervalBtn setHidden:YES];
    [btnChartOrList setHidden:YES];

    pileOfData = [NSMutableArray new];
    dataArr = [NSArray new];
}

- (void)drawChart
{
    //remove older view
    for (id obj in self.subviews) {
        NSLog(@"%@",[obj class]);
        if ([obj isKindOfClass:[UIScrollView class]] ||
            [obj isKindOfClass:[UIPageControl class]]) {
            [obj removeFromSuperview];
        }
        else{
            
        }
    }
    
    double pY;
    if (self.frame.size.height == 480) {
        pY = 405;
    }
    else{
        pY = 490;
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, pY, 320, 37)];
//    [_pageControl setNumberOfPages:pileOfData.count];
    NSInteger m_numberOfPage = 1;
    if((type == 1) || (type == 2)){
        m_numberOfPage = 3;
    }
    [_pageControl setNumberOfPages:m_numberOfPage];
    [_pageControl setCurrentPage:0];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [_pageControl addTarget:self action:@selector(changeCurrentPage:) forControlEvents:UIControlEventValueChanged];
//    [_pageControl setBackgroundColor:[UIColor blueColor]];
    
    int ar_y = 85;
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ar_y, self.frame.size.width, self.frame.size.height-ar_y)];
    [_scrollview setPagingEnabled:YES];
    [_scrollview setShowsHorizontalScrollIndicator:NO];
    [_scrollview setShowsVerticalScrollIndicator:NO];
    [_scrollview setScrollsToTop:NO];
    [_scrollview setDelegate:self];
    
    CGFloat width, height;
    width = _scrollview.frame.size.width;
    height = _scrollview.frame.size.height;
    [_scrollview setContentSize:CGSizeMake(width * m_numberOfPage, height)];
    [self addSubview:_scrollview];
//    [self addSubview:_pageControl];

    
    [info removeFromSuperview];
    info = [UIButton buttonWithType:UIButtonTypeCustom];
    [info addTarget:self
               action:@selector(InfoMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [info setTitle:@"" forState:UIControlStateNormal];
    [info setBackgroundImage:[UIImage imageNamed:@"info_icon"] forState:UIControlStateNormal];
    info.frame = CGRectMake(5, pY+10, 25, 25.0);
    //不加說明
//    if (type != 5) {
//        [self addSubview:info];
//    }
    //remove info view
    [infoWeb removeFromSuperview];
    infoWeb = nil;
    
    //
//    [self setlblUnit];
    
    NSLog(@"pileOfData.c = %lu", (unsigned long)pileOfData.count);
    
    if (pileOfData.count == 0) {
        [self justDrawXYAxis];
    }
    else{
        [self drawCauseHaveData];
    }

    [self drawTable];
}

- (void)setlblUnit:(SHLineGraphView*)_view
{
    NSLog(@"setlblUnit");

    lblUnit = [[UILabel alloc]initWithFrame:CGRectMake(5, -5, 200, 30)];
    [lblUnit setFont:[UIFont systemFontOfSize:12]];

    switch (type) {
        case 1://血壓
            lblUnit.text = @"mmHg";
            break;
            
        case 2://血糖
//            sdfsdf
//            lblUnit.text = @"mg/dl";
            if (unitDef == 0) {
                lblUnit.text = @"mmol/L";
            }
            else if (unitDef == 1){
                lblUnit.text = @"mg/dl";
            }
            else{
                lblUnit.text = @"mg/L";
            }

            break;
            
        case 3://血氧
            lblUnit.text = @"%";
            break;
            
        case 4://體重
            lblUnit.text = @"Kg";
            break;
            
        case 5://計步器
            lblUnit.text = @"m";
            break;

        default:
            break;
    }

    lblUnit.textColor = [UIColor blackColor];

    [_view addSubview:lblUnit];
}

- (void)InfoMethod:(id)sender
{
    NSLog(@"InfoMethod...");
    NSString* strUrl = @"";

    //change ip
    NSArray *pathList;
    NSString *path;
    NSString *apiURL;
    //取得可讀寫的路徑
    pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [pathList  objectAtIndex:0];
    //加上檔名
    path = [path stringByAppendingPathComponent:@"IP"];
    //判斷檔案是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //讀取檔案
        apiURL= [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    } else {
        apiURL = INK_Url_1;
    }

    switch (type) {
        case 1://血壓
            strUrl = @"/BloodPressure.html";
            break;
            
        case 2://血糖
            strUrl = @"/BloodGlucose.html";
            break;
            
        case 3://血氧
            strUrl = @"/BloodOxygen.html";
            break;

        case 4://體重
            strUrl = @"/BMI.html";
            break;
            
        case 5://計步器
            break;
            
        default:
            
            break;
    }
    
    strUrl = [NSString stringWithFormat:@"%@%@",apiURL,strUrl];
    NSLog(@"URL = %@",strUrl);
    if (!infoWeb) {
        [self addWebViewWithString:strUrl];
    }

}

- (void)addWebViewWithString:(NSString*)strUrl
{
    NSLog(@"addWebViewWithString");
    MainClass *main = (MainClass*)[self nextResponder];
    //
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    viewWebBg = [[UIView alloc]initWithFrame:screenRect];
    [viewWebBg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [main addSubview:viewWebBg];

    //add info web
    infoWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    //設定網址
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [infoWeb loadRequest:requestObj];
    [main addSubview:infoWeb];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close addTarget:self
              action:@selector(closeWeb:)
    forControlEvents:UIControlEventTouchUpInside];
    [close setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    close.frame = CGRectMake(280, 0, 40, 40.0);
    [infoWeb addSubview:close];
}

- (void)closeWeb:(id)sender
{
    [infoWeb removeFromSuperview];
    infoWeb = nil;
}

- (void)drawTable
{
    //new table also
    table = nil;
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, self.frame.size.width, self.frame.size.height-200)];// 175+25
    [table setBackgroundColor:[UIColor clearColor]];
    table.delegate = self;
    table.dataSource = self;
    [self addSubview:table];
    table.hidden = YES;

    //add info label
    if (infoLbl) {
        [infoLbl removeFromSuperview];
    }
    infoLbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 130+table.frame.size.height+2, 80, 25)];
    [infoLbl setBackgroundColor:[UIColor grayColor]];
    // Bruce@20150928
    [infoLbl setTextColor:[UIColor greenColor]];
    [infoLbl setTextAlignment:NSTextAlignmentCenter];
    NSLog(@"infoLbl %@",infoLbl);
    [self addSubview:infoLbl];
    infoLbl.hidden = YES;
    switch (type) {
        case 1://血壓
            NSLog(@"BP ReloadData");
            //                [self BPReloadData];
            //                [self handleData:dataArr[0]];
            //            [self handleDataWithArray:dataArr];
            infoLbl.text = @"*mmHg";
            break;
            
        case 2://血糖
            NSLog(@"BS ReloadData");
            //                [self BSReloadData];
//            infoLbl.text = @"*mg/dl";
            if (unitDef == 0) {
                infoLbl.text = @"*mmol/L";
            }
            else if (unitDef == 1){
                infoLbl.text = @"*mg/dl";
            }
            else{
                infoLbl.text = @"*mg/L";
            }
            break;
            
        case 3://血氧
            //                [self BOReloadData];
            infoLbl.text = @"*%";
            break;
            
        case 4://體重
            //                [self WeightReload];
            infoLbl.text = @"*kg";
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            infoLbl.text = @"*m";
            break;
            
        default:

            break;
    }
}

- (double)return_gY
{
    double gY = 0.0;

    if (self.frame.size.height == 480) {
        gY = 240 + 50;
    }
    else{
        gY = 290 + 60;
    }

    return gY;
}

- (double)return_3y
{
    // 40 y 30
    double gY = 0.0;
    if (self.frame.size.height == 480) {
        gY = 30;
    } else {
        gY = 40;
    }

    return gY;
}

- (double)return_3yType45
{
    // 40 y 30
    double gY = 0.0;
    if (self.frame.size.height == 480) {
        gY = 20;
    }
    else{
        gY = 40;
    }
    return gY;
}

- (double)return_12h
{
    //    70 h 40
    double gY = 0.0;
    if (self.frame.size.height == 480) {
        gY = 40;
    }
    else
    {
        gY = 70;
    }
    return gY;
}

- (double)return_3h{
    //    30 h 10
    double gY = 0.0;
    if (self.frame.size.height == 480) {
        gY = 10;
    }
    else{
        gY = 30;
    }
    return gY;
}

//畫出XY軸以及資料
- (void)drawCauseHaveData
{
    SHLineGraphView *_lineGraph;
    //畫兩個圖
    for (int i = 0; i < 2; i++)
    for (NSInteger idx = 0; idx < 1; idx++) {
        //init view
        UIView *viewG = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 375 + 35)];
        
        //initate the graph view
        double gY = [self return_gY];
        UILabel *lblBg;
        //310
        _lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(5, 0 + 10, 310, gY)];
        // add lbl
        [self setY_VandStep:_lineGraph];
        _lineGraph.limitDict = _limitDict;
        _lineGraph.limitLineDict = _limitLineDict;
        _lineGraph.currentPage = i;
        switch (type) {
            case 1:
                first = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 190, [self return_12h])];
                second = [[UILabel alloc]initWithFrame:CGRectMake(200, _lineGraph.frame.size.height + 15, 115, [self return_12h])];
                third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15 + [self return_3y], 190, [self return_3h])];
                break;
            case 2:
                first = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 310, [self return_12h])];
                third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15 + [self return_3y], 310, [self return_3h])];
                break;
            case 3:
                first = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 190, [self return_12h])];
                second = [[UILabel alloc]initWithFrame:CGRectMake(200, _lineGraph.frame.size.height + 15, 115, [self return_12h])];
                third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15 + [self return_3y], 190, [self return_3h])];
                break;
            case 4:
                first = [[UILabel alloc]initWithFrame:CGRectMake(10, _lineGraph.frame.size.height + 17, 145, [self return_12h]- 20)];
                second = [[UILabel alloc]initWithFrame:CGRectMake(160, _lineGraph.frame.size.height + 17, 60, [self return_12h]- 20)];
                third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 21 + [self return_3yType45], 300, [self return_3h])];
                lblBg = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 310, [self return_12h])];
                [lblBg setBackgroundColor:[UIColor grayColor]];
                [viewG addSubview:lblBg];
                four = [[UILabel alloc]initWithFrame:CGRectMake(225, _lineGraph.frame.size.height + 17,85, [self return_12h]- 20)];
                four.numberOfLines = 0;
                [viewG addSubview:four];
                break;
            case 5:
                first = [[UILabel alloc]initWithFrame:CGRectMake(10, _lineGraph.frame.size.height + 17, 145, [self return_12h]- 20)];
                second = [[UILabel alloc]initWithFrame:CGRectMake(160, _lineGraph.frame.size.height + 17, 150, [self return_12h]- 20)];
                third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 21 + [self return_3yType45], 300, [self return_3h])];
                lblBg = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 310, [self return_12h])];
                [lblBg setBackgroundColor:[UIColor grayColor]];
                [viewG addSubview:lblBg];

                break;
            default:
                break;
        }

        [self handel123Lbl];
        first.numberOfLines = 0;
        second.numberOfLines = 0;
        third.numberOfLines = 0;

        if (i != 1) {
            [viewG addSubview:first];
            [viewG addSubview:second];
            [viewG addSubview:third];
        }

        _lineGraph.graphType = type;
        _lineGraph.first = first;
        _lineGraph.second = second;
        _lineGraph.third = third;
        four.backgroundColor = [UIColor greenColor];
        _lineGraph.four = four;
        _lineGraph.datas = pileOfData[idx];

        [self addLineGraph:_lineGraph andPageNumber:idx];

        [self setlblUnit:_lineGraph];
        
        [viewG addSubview:_lineGraph];

        [_scrollview addSubview:viewG];
    }

    //加上 改善建議
    int wY = 0;
    if (self.frame.size.height == 480) {
        wY = - 23;
    }
    else{
        wY = 65;
    }

    NSString *overXType = [_lineGraph overXType];
    NSLog(@"type = %@", overXType);

    UIWebView *viewG = [[UIWebView alloc]initWithFrame:CGRectMake(320*2, 2, 320, 375 + wY)];
    viewG.scalesPageToFit = YES;
    NSString *urlString = @"";
    NSString *urlLocalString = nil;
    switch (type) {
        case 1:     // 血压
            if (overXType.length == 0 || [overXType isEqualToString:@"B"]) {
                urlString = @"http://210.242.50.125:7000/angelcare/hypotension.html";
            } else {
                urlString = @"http://210.242.50.125:7000/angelcare/hypertension.html";
            }
            urlLocalString = @"hypertension";
            break;
        case 2:     // 血糖
            if (overXType.length == 0 || [overXType isEqualToString:@"B"]) {
                urlString = @"http://210.242.50.125:7000/angelcare/hypoglycemia.html";
            } else {
                urlString = @"http://210.242.50.125:7000/angelcare/highbloodsugar.html";
            }
            urlLocalString = @"highbloodsugar";
            break;
        default:
            break;
    }

    NSURL *url = nil;

    // 取得当前系统的语言，如果不是中文就加载本地的html文件
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];

    NSString* path = [[NSBundle mainBundle] pathForResource:urlLocalString ofType:@"html"];
    if ([preferredLang isEqualToString:@"zh-Hans"] || path == nil) {
        url = [NSURL URLWithString:urlString];
    } else {
        url = [NSURL fileURLWithPath:path];
    }

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [viewG loadRequest:requestObj];

    [viewG setBackgroundColor:[UIColor whiteColor]];
    [_scrollview addSubview:viewG];
}

- (void)setY_VandStep:(SHLineGraphView*)graph
{
    NSDictionary *dict;
    switch (type) {
        case 1://血壓
            dict = [self returnStepAndMin];
            graph.initY = [[dict objectForKey:@"min"]intValue];
            graph.initStep = [[dict objectForKey:@"step"]intValue];
            break;
            
        case 2://血糖
            dict = [self returnStepAndMinWithKey:@"bloodglucose"];
            graph.initY = [[dict objectForKey:@"min"]intValue];
            graph.initStep = [[dict objectForKey:@"step"]intValue];
//            graph.initY = 40;
//            graph.initStep = 20;
            break;
            
        case 3://血氧
            //                [self BOReloadData];
            graph.initY = 20;
            graph.initStep = 10;
            break;
            
        case 4://體重
            //                [self WeightReload];
            dict = [self returnStepAndMinWithKey:@"weight"];
            graph.initYF = [[dict objectForKey:@"min"]floatValue];
            graph.initStepF = [[dict objectForKey:@"step"]floatValue];
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            graph.initY = 0;
            graph.initStep = [self returnStepForSportDistance];
            break;
            
        default:
            
            break;
    }
}
- (int) returnStepForSportDistance{
    int _max = 0.0;
    goalDis = [[remindDic objectForKey:@"Distance"]floatValue];
    NSMutableArray *tmpA = [[NSMutableArray alloc]initWithArray:dataArr];
//    NSDictionary *dict = @{@"dist": @(goalDis)};
    [tmpA addObject:@{@"dist": @(goalDis)}];
    for (int i = 0; i < tmpA.count; i++) {
        int tmp = [[tmpA[i] objectForKey:@"dist"]intValue];
        NSLog(@"%@",[tmpA[i] objectForKey:@"dist"]);
        if (tmp > _max) {
            _max = tmp;
        }
    }
    NSLog(@"_max = %d",_max);
    while ((_max %8 != 0)) {
        int tmp = _max % 8;
        _max = _max - tmp + 8;
    }
    return _max/8;
}

- (NSDictionary*) returnStepAndMin{
    NSDictionary *dict;
    int _max = 0.0;
    int _min = 999999999;
    if (dataArr.count == 0) {
        dict = @{@"step": @(20),@"min":@(40)};
        return dict;
    }
    NSMutableArray *tmpData = [NSMutableArray new];
    for (int i = 0; i < dataArr.count; i++) {
        [tmpData addObject:[dataArr[i] objectForKey:@"diastolic"]];
        [tmpData addObject:[dataArr[i] objectForKey:@"systolic"]];
    }
    if (_limitLineDict) {
        [tmpData addObject:[_limitLineDict objectForKey:@"bpdUplimit"]];
        [tmpData addObject:[_limitLineDict objectForKey:@"bpsUplimit"]];
    }
    //
    for (int i = 0; i < tmpData.count; i++) {
        int tmp = [tmpData[i] intValue];
        if (tmp > _max) {
            _max = tmp;
        }
    }
    for (int i = 0; i < tmpData.count; i++) {
        int tmp = [tmpData[i]intValue];
//        NSLog(@"%@",[tmpData[i] objectForKey:@"dist"]);
        if (tmp < _min) {
            _min = tmp;
        }
    }
    
    NSLog(@"_max %d",_max);
    int goal = _max - _min;
    while ((goal %8 != 0)) {
        int tmp = goal % 8;
        goal = goal - tmp + 8;
    }
    
    
    dict = @{@"step": @(goal/8),@"min":@(_min)};
    return dict;
}

- (NSDictionary*) returnStepAndMinWithKey:(NSString*)key
{
    NSDictionary *dict;
    int _max = 0.0;
    int _min = 999999999;

    if (dataArr.count == 0) {
        dict = @{@"step":@(20), @"min":@(40)};
        return dict;
    }

    NSMutableArray *tmpData = [NSMutableArray new];
    for (int i = 0; i < dataArr.count; i++) {
        [tmpData addObject:@([[dataArr[i] objectForKey:key] floatValue])];
    }

    for (int i = 0; i < tmpData.count; i++) {
        int tmp = [tmpData[i] intValue];
        if (tmp > _max) {
            _max = tmp;
        }
    }

    for (int i = 0; i < tmpData.count; i++) {
        int tmp = [tmpData[i]intValue];
        //        NSLog(@"%@",[tmpData[i] objectForKey:@"dist"]);
        if (tmp < _min) {
            _min = tmp;
        }
    }

    NSLog(@"_max %d", _max);
    if (_max == _min) {
        if ([key isEqualToString:@"weight"]) {
            _max = (_max + _min);//*0.1;
        }
        else{
            _max = (_max + _min);
        }
        _min = 0;
    }

    int goal = _max - _min;
    while ((goal %8 != 0)) {
        int tmp = goal % 8;
        goal = goal - tmp + 8;
    }

    dict = @{@"step":@(goal/8),@"min":@(_min)};
    if (type == 4) {
        dict = @{@"step": @(goal/8*0.1),@"min":@(_min*0.1)};
    }

    return dict;
}

- (void)handel123Lbl
{
    if (self.frame.size.height == 480) {
        [first setFont:[UIFont systemFontOfSize:14]];
        [second setFont:[UIFont systemFontOfSize:14]];
        [third setFont:[UIFont systemFontOfSize:12]];
    }
    
    [first setBackgroundColor:[UIColor orangeColor]];
    [second setBackgroundColor:[UIColor blackColor]];
    [first setTextColor:[UIColor blackColor]];
    // bruce
    [second setTextColor:[UIColor whiteColor]];
    [third setTextColor:[UIColor grayColor]];
    [first setTextAlignment:NSTextAlignmentCenter];
    [second setTextAlignment:NSTextAlignmentCenter];
    [third setTextAlignment:NSTextAlignmentCenter];
    [four setTextAlignment:NSTextAlignmentCenter];
    first.font = [UIFont systemFontOfSize:20];
    second.font = [UIFont systemFontOfSize:20];
    if (type == 5 || type == 4) {
        first.font = [UIFont systemFontOfSize:18];
        second.font = [UIFont systemFontOfSize:18];
        four.font = [UIFont systemFontOfSize:18];
        [second setTextColor:[UIColor blackColor]];
        [third setTextColor:[UIColor colorWithRed:58/255.0 green:222/255.0 blue:223/255.0 alpha:1]];
        if (self.frame.size.height == 480) {
            
            [first setFont:[UIFont systemFontOfSize:12]];
            [second setFont:[UIFont systemFontOfSize:12]];
            four.font = [UIFont systemFontOfSize:12];
            [third setFont:[UIFont systemFontOfSize:12]];
            
        }
    }
}
//只畫出XY軸
- (void)justDrawXYAxis{
    //init view
    UIView *viewG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 375)];
    //initate the graph view
    //#define _5GraphHeight 290
    double gY = [self return_gY];
//    if (self.frame.size.height == 480) {
//        gY = 220;
//    }
//    else{
//        gY = 290;
//    }
//    70
//    30
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(5, 0 + 10, 310, gY)];
    [self setY_VandStep:_lineGraph];
    first = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15, 190, [self return_12h])];
    second = [[UILabel alloc]initWithFrame:CGRectMake(200, _lineGraph.frame.size.height + 15, 115, [self return_12h])];
    third = [[UILabel alloc]initWithFrame:CGRectMake(5, _lineGraph.frame.size.height + 15 + [self return_3y], 190, [self return_3h])];
    
    [self handel123Lbl];
    
    [viewG addSubview:first];
    [viewG addSubview:second];
    [viewG addSubview:third];
    //        NSInteger idx = 1;
    _lineGraph.graphType = type;
    _lineGraph.first = first;
    _lineGraph.second = second;
    _lineGraph.third = third;
    [self addLineGraph:_lineGraph andPageNumber:0];
    [viewG addSubview:_lineGraph];
    [_scrollview addSubview:viewG];
    
    NSLog(@"%@",[viewG subviews]);
}

- (void)addLineGraph:(SHLineGraphView*)_lineGraph andPageNumber:(NSInteger)dataIdx
{
    _lineGraph.tag = dataIdx;
    //SHLineGraphView set background
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _lineGraph.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:255.0/255.0
                                                                     green:238.0/255.0
                                                                      blue:190.0/255.0
                                                                     alpha:1] CGColor],
                       (id)[[UIColor colorWithRed:238.0/255.0
                                            green:197.0/255.0
                                             blue:157.0/255.0
                                            alpha:1]
                            CGColor],
                       nil]; // 由上到下的漸層顏色

    [_lineGraph.layer insertSublayer:gradient atIndex:0];

    //set the main graph area theme attributes
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey :[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;

    //set the line graph attributes
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    // change INTERVAL_COUNT can change blocks
    _lineGraph.yAxisRange = @(200);
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"";

    NSArray *keys;
    switch (type) {
        case 1://血壓
            keys = @[@"systolic",@"diastolic"];
            break;

        case 2://血糖
            keys = @[@"bloodglucose"];
            [self handleUnitBG];
            _lineGraph.limitBG = limitBG;
            break;

        case 3://血氧
            keys = @[@"oxygen"];
            //                [self BOReloadData];
            break;

        case 4://體重
            //                [self WeightReload];
            keys = @[@"weight"];
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            _lineGraph.goalStep = [[remindDic objectForKey:@"StepCount"]integerValue];
            _lineGraph.goalDis = [[remindDic objectForKey:@"Distance"]integerValue];
            goalStep = [[remindDic objectForKey:@"StepCount"]intValue];
            goalDis = [[remindDic objectForKey:@"Distance"]intValue];
            keys = @[@"dist"];
            break;
            
        default:
            break;
    }

    _lineGraph.keys = keys;

    if (pileOfData.count != 0) {//有資料就畫圖
        NSMutableArray *plots = [NSMutableArray new];
        //
        [self setXLabelToGraph:_lineGraph andData: pileOfData[dataIdx]];
        for (int i = 0; i < keys.count; i++) {
            [_lineGraph initRange:keys[i]];
            [plots addObject:[self AddPlot:pileOfData[dataIdx] andKey:keys[i] andGraph:_lineGraph]];
        }
        //You can as much `SHPlots` as you can in a `SHLineGraphView`
        [_lineGraph setupTheView];
    }
    else{
        [_lineGraph drawXYAxis:nil];
    }
}

#pragma mark - handle plot
- (void) setXLabelToGraph:(SHLineGraphView*)graph andData:(NSMutableArray*)data
{
    NSMutableArray *tmpData = [NSMutableArray new];

    //抓出時間來設定x坐標
    for (int i = 1; i < [data count]+1; i++) {
        NSString *time;
        if (type != 5) {
             time = [[data objectAtIndex:i-1]objectForKey:@"time"];
        }
        else{
            time = [[data objectAtIndex:i-1]objectForKey:@"end"];
        }
        time = [NSString stringWithFormat:@"%@",[time substringFromIndex:5]];
        NSDictionary *tmpDict = @{@(i): time};
        [tmpData addObject:tmpDict];
    }

    graph.xAxisValues = [NSArray arrayWithArray:tmpData];
}

- (SHPlot*)AddPlot:(NSMutableArray*)data andKey:(NSString*)key andGraph:(SHLineGraphView*)graph
{
    SHPlot *plot = [[SHPlot alloc] init];
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    NSMutableArray *tmpData  = [NSMutableArray new];
    //    NSLog(@"one of data %@",[[data objectAtIndex:0] objectForKey:key]);
    for (int i = 1; i < [data count]+1; i++) {
        NSDictionary *tmpDict;
        if ([key isEqualToString:@"weight"]) {//do weight / 10
            tmpDict = @{@(i): @([[[data objectAtIndex:i-1]objectForKey:key]doubleValue]/10.0)};
        }
        else{
            tmpDict = @{@(i): [[data objectAtIndex:i-1]objectForKey:key]};
        }
        
        [tmpData addObject:tmpDict];
    }
    plot.plottingValues = [NSArray arrayWithArray:tmpData];
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    //    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8"];
    plot.plottingPointsLabels = arr;
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    plot.plotThemeAttributes = _plotThemeAttributes;
    [graph addPlot:plot];
    
    
    return plot;
}
- (BOOL)shouldAutorotate
{
	return YES;
}

- (void)getData{
    
    //-- Make URL request with server
    NSHTTPURLResponse *response = nil;
    //    NSString *jsonUrlString = [NSString stringWithFormat:@"http://dev.blazedream.in/arrichion/challenges/leader_board/service:1/user_id:12/limit:0,20"];
    //    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *stringURL = @"http://ap1.guidercare.com:8080/angelcare/API/AppGetBPData.html?userAccount=gd100&account=IBC-01&data=abf8fc1009c0963c13c66332fd6cd9547644c7c6c9e7d38f4d781dafeb083b79&timeStamp=2014-04-30 09:40&Start=2013-08-01 00:00&End=2013-08-30 23:59";
    NSURL *url = [NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //-- JSON Parsing
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"Result = %@",result);
    
    //    for (NSMutableDictionary *dic in result)
    //    {
    //        NSString *string = dic[@"array"];
    //        if (string)
    //        {
    //            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //            dic[@"array"] = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //        }
    //        else
    //        {
    //            NSLog(@"Error in url response");
    //        }
    //    }
    [self handleData:result[0]];
}

- (void)handleData:(NSDictionary*)dict
{
    NSLog(@"handle Data");
    NSArray *array = [dict objectForKey:@"Data"];
    NSLog(@"array.count %lu",(unsigned long)array.count);
    NSInteger totalData = array.count;
    if (totalData == 0) {
        numberOfPage = 0;
    }
    numberOfPage = floor(totalData/8.0);
    for (int i = 0;  i < numberOfPage; i++) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (int j = 0; j < 8; j++) {
            [tmp addObject:[array objectAtIndex:j + i*8]];
        }
        [pileOfData addObject:tmp];
    }//donot look this

    NSLog(@"pileOfData %lu",(unsigned long)pileOfData.count);
    NSLog(@"pileOfData %@",pileOfData);
}

- (void)handleDataWithArray:(NSArray*)array
{
    NSLog(@"handleDataWithArray");

    NSInteger totalData = array.count;

    if (totalData == 0) {
        numberOfPage = 0;
    }

    numberOfPage = ceil(totalData/8.0);
    for (int i = 0;  i < numberOfPage; i++) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (int j = 0; j < 8; j++) {
            if ((j+ i*8) >= totalData) {
                break;
            }
            [tmp addObject:[array objectAtIndex:j + i*8]];
        }
        [pileOfData addObject:tmp];
    }

    NSLog(@"pileOfData %lu",(unsigned long)pileOfData.count);
    NSLog(@"handleDataWithArray pileOfData -> %@", pileOfData);
}

- (void)handleBottomLbl:(NSInteger)idx
{
    NSLog(@"pileofdata %@",pileOfData[1]);
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat width = _scrollview.frame.size.width;
    NSInteger currentPage = ((_scrollview.contentOffset.x - width / 2) / width) + 1;
    [_pageControl setCurrentPage:currentPage];
    //    NSLog(@"scrollViewDidScroll %f",width);
//    NSLog(@"currentPage %ld",(long)currentPage);
    if (currentPage == 2) {
        [lblUnit setHidden:YES];
    }
    else{
        [lblUnit setHidden:NO];
    }
    
}

- (IBAction)changeCurrentPage:(UIPageControl *)sender {
    NSInteger page = _pageControl.currentPage;
    
    CGFloat width, height;
    width = _scrollview.frame.size.width;
    height = _scrollview.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [_scrollview scrollRectToVisible:frame animated:YES];
}

- (IBAction)ibaChartOrList:(id)sender {
    if (isChart) {
        isChart = !isChart;
        BOOL tmp = YES;
        table.hidden = tmp;
        infoLbl.hidden = tmp;
        _pageControl.hidden = !tmp;
        _scrollview.hidden = !tmp;
        [btnChartOrList setBackgroundImage:[UIImage imageNamed:@"icon_record_up"] forState:UIControlStateNormal];
        [btnChartOrList setTitle:@"列表" forState:UIControlStateNormal];
        [lblUnit setHidden:NO];//20140703 fix bug Roger
    }
    else{
        isChart = !isChart;
        BOOL tmp = YES;
        table.hidden = !tmp;
        infoLbl.hidden = !tmp;
        _pageControl.hidden = tmp;
        _scrollview.hidden = tmp;
        [btnChartOrList setBackgroundImage:[UIImage imageNamed:@"icon_record_up"] forState:UIControlStateNormal];
        [btnChartOrList setTitle:@"圖表" forState:UIControlStateNormal];
        [lblUnit setHidden:YES];//20140703 fix bug Roger
    }
}

#pragma mark - make a tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"dataArr %d", (int)dataArr.count);

    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [dataArr objectAtIndex:indexPath.row];

    id cell;
    switch (type) {
        case 1://血壓
            NSLog(@"BP ReloadData");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BPCell" owner:self options:nil] objectAtIndex:0];
            [[(BPCell*)cell lblDPTitle]setText: NSLocalizedStringFromTable(@"DP*", INFOPLIST, nil)];
            [[(BPCell*)cell lblSPTitle]setText: NSLocalizedStringFromTable(@"SP*", INFOPLIST, nil)];
            [self setCellLbl:[(BPCell*)cell lblDia] andKey:@"diastolic" andDict:dict];
            [self setCellLbl:[(BPCell*)cell lblSys] andKey:@"systolic" andDict:dict];
            [self setLblTimeFormatter:[(BPCell*)cell lblTime] andDict:dict];
            [[(BPCell*)cell lblPul] setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"heartbeat"]]];
            break;

        case 2://血糖
            NSLog(@"BS ReloadData");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BGCell" owner:self options:nil] objectAtIndex:0];
            [[(BGCell*)cell lblBGTitle]setText: NSLocalizedStringFromTable(@"BG*", INFOPLIST, nil)];
            [self setCellLbl:[(BGCell*)cell lblBG] andKey:@"bloodglucose" andDict:dict];
            [self setLblTimeFormatter:[(BGCell*)cell lblTime] andDict:dict];
            //                [self BSReloadData];
            break;
            
        case 3://血氧
            //                [self BOReloadData];
            NSLog(@"BO ReloadData");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BOCell" owner:self options:nil] objectAtIndex:0];
            [[(BOCell*)cell lblBOTitle]setText: NSLocalizedStringFromTable(@"BO*", INFOPLIST, nil)];
            [self setCellLbl:[(BOCell*)cell lblBO] andKey:@"oxygen" andDict:dict];
            [self setCellLbl:[(BOCell*)cell lblPul] andKey:@"heartbeat" andDict:dict];
            [self setLblTimeFormatter:[(BOCell*)cell lblTime] andDict:dict];
            break;
            
        case 4://體重
            //                [self WeightReload];
            NSLog(@"Weight ReloadData");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WECell" owner:self options:nil] objectAtIndex:0];
            [[(WECell*)cell lblBWTitle]setText: NSLocalizedStringFromTable(@"BW*", INFOPLIST, nil)];
            [[(WECell*)cell lblBFTitle]setText: NSLocalizedStringFromTable(@"BF%", INFOPLIST, nil)];
            [self setCellLbl:[(WECell*)cell lblBMI] andKey:@"bmiCal" andDict:dict];
            [self setCellLbl:[(WECell*)cell lblFat] andKey:@"body_fat" andDict:dict];
            [self setCellLbl:[(WECell*)cell lblWeight] andKey:@"weight" andDict:dict];
            [self setLblTimeFormatter:[(WECell*)cell lblTime] andDict:dict];
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            NSLog(@"Sport ReloadData");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SportCell" owner:self options:nil] objectAtIndex:0];
            [self setCellLbl:[(SportCell*)cell lblDis] andKey:@"dist" andDict:dict];
            [self setCellLbl:[(SportCell*)cell lblStep] andKey:@"step" andDict:dict];
            [self setLblTimeFormatter:[(SportCell*)cell lblTime] andDict:dict];
            break;
            
        default:
            break;
    }
    [(UITableViewCell*)cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float height = 0.0;
    switch (type) {
        case 1://血壓
            NSLog(@"BP ReloadData");

            height = BPCellHeight;
            
            break;
            
        case 2://血糖
            NSLog(@"BS ReloadData");
            //                [self BSReloadData];
            height = BGCellHeight;
            break;
            
        case 3://血氧
            //                [self BOReloadData];
            height = BGCellHeight;
            break;
            
        case 4://體重
            //                [self WeightReload];
            height = BGCellHeight;
            break;
            
        case 5://計步器
            //                [self StepReloadDate];
            height = BGCellHeight;
            break;
            
        default:
            height = 0;
            break;
    }

    return height;
}

#pragma mark - initrange
- (void)initRange:(NSString *)key
{
    if ([key isEqualToString:@"systolic"]) {
        limitGreen = systolicGreen;
        limitOrange = systolicOrange;
        limitRed = systolicRed;
        limitYellow = systolicYellow;
    }
    else if ([key isEqualToString:@"diastolic"]){
        limitGreen = diastolicGreen;
        limitOrange = diastolicOrange;
        limitRed = diastolicRed;
        limitYellow = diastolicYellow;
    }
    
    if ([key isEqualToString:@"bloodglucose"]) {
        NSLog(@"%@",remindDic);
        [self handleUnitBG];
    }
    if ([key isEqualToString:@"step"]) {
        NSLog(@"%@",remindDic);
        goalStep = [[remindDic objectForKey:@"StepCount"]intValue];
        goalDis = [[remindDic objectForKey:@"Distance"]intValue];
    }
}

- (void)setCellLbl:(UILabel*)lbl andKey:(NSString*)key andDict:(NSDictionary*) dict
{
    UIColor *color = nil;
    [self initRange:key];
    double tmp = [[dict objectForKey:key] doubleValue];
    double tmpS;
    NSLog(@"setCellLbl key:%@, %@",key,[dict objectForKey:key]);

    switch (type) {
        case 1://血壓
            NSLog(@"BP ReloadData");
            if ( tmp <= limitGreen) {
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            else if ( (tmp > limitGreen) &&
                     (tmp <= limitYellow)){
                color = [UIColor yellowColor];
            }
            else if ( (tmp > limitYellow) &&
                     (tmp <= limitOrange)){
                color = [UIColor orangeColor];
            }
            else{
                color = [UIColor redColor];
            }
            break;
            
        case 2://血糖
            NSLog(@"BS ReloadData");
            if (tmp <= limitBG) {
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            else{
                color = [UIColor redColor];
            }
            break;
            
        case 3://血氧
            if ([key isEqualToString:@"oxygen"]) {
                if (tmp >= 90 ) {
                    color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
                }
                else{
                    color = [UIColor redColor];
                }
            }
            else{
                color = [UIColor blackColor];
            }
            break;
            
        case 4://體重
            //                [self WeightReload];
            if ([key isEqualToString:@"bmiCal"]) {
                tmp = [[dict objectForKey:@"bmiCal"] doubleValue];
                if ( tmp <= 18.5) {
                    weColor = [UIColor blueColor];
                }
                else if( tmp > 18.5 && tmp <= 24.9){
                    weColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
                }
                else if( tmp > 24.9 && tmp <= 29.9){
                    weColor = [UIColor yellowColor];
                }
                else{
                    weColor = [UIColor redColor];
                }
            }
            color = weColor;
            break;
            
        case 5://計步器
            tmpS = 0.0;
            if (goalDis == 0 && goalStep == 0) {
                tmpS = 0;
            }
            else if (goalDis == 0 && goalStep != 0){
                tmpS = [[dict objectForKey:@"step"] doubleValue]/goalStep;
            }
            else if (goalDis != 0 && goalStep == 0){
                tmpS = [[dict objectForKey:@"dist"] doubleValue]/goalDis;
            }
            else{
                tmpS = [[dict objectForKey:@"dist"] doubleValue]/goalDis + [[dict objectForKey:@"step"] doubleValue]/goalStep;
            }
            NSLog(@"tmpST %f",tmpS);
            if (tmpS < 0.25) {
                //red
                color = [UIColor redColor];
            }
            else if(tmpS >= 0.25 && tmpS < 0.99){
                //orange
                color = [UIColor orangeColor];
            }
            else{
                //green
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            break;
            
        default:
            break;
    }

    lbl.text =[NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    if ([key isEqualToString:@"weight"] || [key isEqualToString:@"body_fat"]) {
        lbl.text =[NSString stringWithFormat:@"%.1f",tmp/10.0];
    }

    if ([key isEqualToString:@"dist"]) {
        lbl.text = [dict objectForKey:@"dist"] ;
    }
    
    [lbl setBackgroundColor:color];
}

- (void)setLblTimeFormatter:(UILabel*)lbl andDict:(NSDictionary*)dict{
    NSString *strTime;// = [dict objectForKey:@"time"];
    if (type != 5) {
        strTime = [dict objectForKey:@"time"];
    }
    else{
        strTime = [dict objectForKey:@"start"];
    }

    NSLog(@"strTime = %@",strTime);
    lbl.text = strTime;
}

//設定小提醒
-(void)Set_RemindInit:(NSDictionary *)dic withType:(int) m_type
{
    remindDic = dic;
    NSLog(@"remindDic %@",remindDic);
    
    _limitLineDict = dic;
}
@end
