// SHLineGraphView.m
//
// Copyright (c) 2014 Shan Ul Haq (http://grevolution.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "SHLineGraphView.h"
#import "PopoverView.h"
#import "SHPlot.h"
#import <math.h>
#import <objc/runtime.h>
#import "define.h"
#import "ColorHex.h"

#define BOTTOM_MARGIN_TO_LEAVE 50.0
#define TOP_MARGIN_TO_LEAVE 30.0
#define INTERVAL_COUNT 8
#define PLOT_WIDTH (self.bounds.size.width - _leftMarginToLeave)

#define kAssociatedPlotObject @"kAssociatedPlotObject"


#define systolicRed 180
#define systolicOrange 180
#define systolicYellow 160
#define systolicGreen 140


#define diastolicRed 110
#define diastolicOrange 110
#define diastolicYellow 100
#define diastolicGreen 90

#define bp 0

#define stepRange 20
@implementation SHLineGraphView
{
    float _leftMarginToLeave;
    int limitRed;
    int limitOrange;
    int limitYellow;
    int limitGreen;
    UITapGestureRecognizer *tap;
    NSInteger idxForPlot;
    
    int unitDef;
    
    int bpdUplimit;
    int bpsUplimit;
    
    //
    float beta;
    float afa;
    //
    float mmm;
    
    //
    int overX;
    //
    NSString *g_Key;
}
- (instancetype)init {
    if((self = [super init])) {
        [self loadDefaultTheme];
    }
    return self;
}

- (void)awakeFromNib
{
    [self loadDefaultTheme];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefaultTheme];
    }
    return self;
}

- (void)loadDefaultTheme
{
    overX = 0;
    _themeAttributes = @{
                         kXAxisLabelColorKey : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                         kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                         kYAxisLabelColorKey : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0],
                         kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                         kYAxisLabelSideMarginsKey : @10,
                         kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
                         };
}

- (void)addPlot:(SHPlot *)newPlot;
{
    if(nil == newPlot) {
        return;
    }
    
    if(_plots == nil){
        _plots = [NSMutableArray array];
    }
    [_plots addObject:newPlot];
}

- (void)setupTheView
{
    [self showLastData];// and set bmi
    
    NSMutableArray *tmpPlots = [NSMutableArray new];
    idxForPlot = 0;
    for(SHPlot *plot in _plots) {
        NSMutableArray *m_arrays = [NSMutableArray new];
        if (_graphType == 1) {
            [m_arrays addObject:[_limitLineDict objectForKey:@"bpsUplimit"]];
            [m_arrays addObject:[_limitLineDict objectForKey:@"bpdUplimit"]];
            bpdUplimit = [[_limitLineDict objectForKey:@"bpdUplimit"] intValue];
            bpsUplimit = [[_limitLineDict objectForKey:@"bpsUplimit"] intValue];
        }

        if (idxForPlot == 0) {
            [self drawPlotWithPlotFirst:plot];
        }

        //Set limit value

        //draw the up down limit
        if (self.currentPage == 0) {
            if (_graphType == 1) {
                [self drawLimitLinesWithDict:_limitLineDict andLimitArray:m_arrays];
            }
            else if (_graphType == 2){
                [self drawLimitLinesWithValue:_limitBG];
            }
            else if (_graphType == 5){

            }
        }
        else{
            
        }

        [self initRange:_keys[idxForPlot]];
        [self drawPlotWithPlot:plot];
        [tmpPlots addObject:plot];
        idxForPlot++;
    }

    for(SHPlot *plot in _plots) {
        [tmpPlots addObject:plot];
    }
}

#pragma mark - Actual Plot Drawing Methods

#pragma mark 设置健康等级Label
- (void)drawPlotWithPlot:(SHPlot *)plot
{
    //draw y-axis labels. this has to be done first, so that we can determine the left margin to leave according to the
    //y-axis lables.
    [self drawYLabels:plot];

    //draw x-labels
    [self drawXLabels:plot];

    if (self.currentPage == 0) {
        [self drawPlot:plot];
    }
    else if (self.currentPage == 1){
        [self drawWhitePlot:plot];
        //add advice
        UILabel *title;
        UILabel *subtitle ;
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        if (screenHeight == 480.0) {
            title = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height + 2, self.frame.size.width, 10)];
            subtitle = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height + 2 + 10, self.frame.size.width, 50)];
            [title setFont:[UIFont systemFontOfSize:14]];
            [subtitle setFont:[UIFont systemFontOfSize:14]];
        }
        else{
            title = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height + 2, self.frame.size.width, 20)];
            subtitle = [[UILabel alloc]initWithFrame:CGRectMake(5, self.frame.size.height + 2 + 20, self.frame.size.width, 50)];
        }

        title.text = @"";
        subtitle.text = @"";
        NSArray *m_array = [[NSArray alloc]initWithArray:[self returnAdvice]];
        title.text = [NSString stringWithFormat:@"%@",[m_array objectAtIndex:0]];
        subtitle.numberOfLines = 0;
        subtitle.text = [NSString stringWithFormat:@"%@",[m_array objectAtIndex:1]];
        
        if ((_graphType == 1) && [g_Key isEqualToString:@"systolic"]) {
            [self addSubview:title];
            [self addSubview:subtitle];
        }
        else if (_graphType == 2){
            [self addSubview:title];
            [self addSubview:subtitle];
        }
        
        [title setTextColor:[UIColor blackColor]];
        [subtitle setTextColor:[UIColor blackColor]];
    }
}

- (NSString *)overXType
{
    NSString *m_warningType;

    if ((overX > 3) && (beta > 0)) {
        m_warningType = @"1";
    }
    else if ((overX > 0) && (overX <= 3) && (beta > 0)) {
        m_warningType = @"2";
    }
    else if ((overX > 3) && (beta < 0)) {
        m_warningType = @"3";
    }
    else if ((overX > 0) && (overX <= 3) && (beta < 0)) {
        m_warningType = @"4";
    }
    else if ((overX == 0) && (beta > 0)) {
        m_warningType = @"A";
    }
    else if ((overX == 0) && (beta <= 0)) {
        m_warningType = @"B";
    }
    else {
        m_warningType = @"";
    }

    return m_warningType;
}

- (NSArray*)returnAdvice
{
    NSArray *m_array = [[NSArray alloc]init];
    NSString *m_title = @"";
    NSString *m_subTitle = @"";
    NSString *m_key = @"";
    NSString *m_warningType = @"";
    if ((overX > 3) && (beta > 0)) {
        m_warningType = @"1";
    }
    else if ((overX > 0) && (overX <= 3) && (beta > 0)) {
        m_warningType = @"2";
    }
    else if ((overX > 3) && (beta < 0)) {
        m_warningType = @"3";
    }
    else if ((overX > 0) && (overX <= 3) && (beta < 0)) {
        m_warningType = @"4";
    }
    else if ((overX == 0) && (beta > 0)) {
        m_warningType = @"A";
    }
    else if ((overX == 0) && (beta <= 0)) {
        m_warningType = @"B";
    }
    else{
        return @[@"",@""];
    }
    if ((_graphType == 1) && [g_Key isEqualToString:@"systolic"]) {
        m_key = [NSString stringWithFormat:@"%@_%@",@"SYSTOLIC",m_warningType];
    }
    else if((_graphType == 1) && [g_Key isEqualToString:@"diastolic"]){
        m_key = [NSString stringWithFormat:@"%@_%@",@"DIASTOLIC",m_warningType];
    }
    else if(_graphType == 2){
        m_key = [NSString stringWithFormat:@"%@_%@",@"BLOODSUGAR",m_warningType];
    }
    else{
        m_key = @"";
    }
    
    NSString *m_TK = [NSString stringWithFormat:@"%@_T",m_key];
    m_title = NSLocalizedStringFromTable(m_TK, INFOPLIST, nil);
    m_TK = [NSString stringWithFormat:@"%@_SUBT",m_key];
    m_subTitle = NSLocalizedStringFromTable(m_TK, INFOPLIST, nil);
    m_array = @[m_title,m_subTitle];
    return m_array;
}
- (void)drawPlotWithPlotFirst:(SHPlot *)plot {
    //draw y-axis labels. this has to be done first, so that we can determine the left margin to leave according to the
    //y-axis lables.
    [self drawYLabels:plot];
    
    //draw x-labels
    [self drawXLabels:plot];
    
    //draw the grey lines
//    [self drawLines:plot];
    
    /*
     actual plot drawing
     */
//    [self drawPlot:plot];
    
    //
    //    [self drawVerticalLine:plot];
}

- (int)getIndexForValue:(NSNumber *)value forPlot:(SHPlot *)plot
{
    for(int i=0; i< _xAxisValues.count; i++) {
        NSDictionary *d = [_xAxisValues objectAtIndex:i];
        __block BOOL foundValue = NO;
        [d enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSNumber *k = (NSNumber *)key;
            if([k doubleValue] == [value doubleValue]) {
                foundValue = YES;
                *stop = foundValue;
            }
        }];
        if(foundValue){
            return i;
        }
    }
    return -1;
}

- (CAShapeLayer*)setLayerWithColor:(UIColor*)color andTheme:(NSDictionary*)theme
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = self.bounds;
    circleLayer.fillColor = color.CGColor;//更改填滿的顏色

    circleLayer.backgroundColor = [UIColor clearColor].CGColor;
    [circleLayer setStrokeColor:color.CGColor];//點的顏色

    [circleLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    return circleLayer;
}

- (void)drawWhitePlot:(SHPlot *)plot
{
    NSDictionary *theme = plot.plotThemeAttributes;
    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }

    NSMutableArray *mX_arrays = [NSMutableArray new];
    NSMutableArray *mY_arrays = [NSMutableArray new];
    
    //logic to fill the graph path, ciricle path, background path.
    [plot.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot];
        NSLog(@"xIndex = %d, yV = %f",xIndex,[_value doubleValue]);
        [mX_arrays addObject:@(ceil((plot.xPoints[xIndex]).x))];
        [mY_arrays addObject:_value];
        
        
        //x value
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
        
        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
        //        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
        //計算點在螢幕上的位置 point position
        double tmpy = ([_value doubleValue] - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        //intYF
        if (_graphType == 4) {
            tmpy = ([_value doubleValue] - _initYF)/yIntervalValue * intervalInPx;
        }
        
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
        (plot.xPoints[xIndex]).x = ceil((plot.xPoints[xIndex]).x);
        (plot.xPoints[xIndex]).y = ceil(y);
    }];
    
    //設定畫面顏色
    //backgroundPath
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = ((UIColor *)theme[kPlotFillColorKey]).CGColor;
    backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backgroundLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    CGMutablePathRef backgroundPath = CGPathCreateMutable();

    //graphPath
    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = self.bounds;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;

    [graphLayer setLineWidth:4.0];
    CGMutablePathRef graphPath = CGPathCreateMutable();

    //1 green
    CAShapeLayer *circleLayer = [self setLayerWithColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0] andTheme:theme];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    //2 yellow
    CAShapeLayer *circleLayer2 = [self setLayerWithColor:[UIColor yellowColor] andTheme:theme];
    CGMutablePathRef circlePath2 = CGPathCreateMutable();
    //3 orange
    CAShapeLayer *circleLayer3 = [self setLayerWithColor:[UIColor orangeColor] andTheme:theme];
    CGMutablePathRef circlePath3 = CGPathCreateMutable();
    //4 red
    CAShapeLayer *circleLayer4 = [self setLayerWithColor:[UIColor redColor] andTheme:theme];
    CGMutablePathRef circlePath4 = CGPathCreateMutable();
    //5 blue
    CAShapeLayer *circleLayer5 = [self setLayerWithColor:[UIColor blueColor] andTheme:theme];
    CGMutablePathRef circlePath5 = CGPathCreateMutable();
    //whiete
    CAShapeLayer *circleLayerW = [self setLayerWithColor:[UIColor whiteColor] andTheme:theme];
    CGMutablePathRef circlePathW = CGPathCreateMutable();

    NSInteger count = _xAxisValues.count;
    double tmpS = 0.0;
    for(int i = 0; i < count; i++){
        CGPoint point = plot.xPoints[i];
        double tmp = [[plot.plottingValues[i] objectForKey:@(i+1)] doubleValue];
        NSDictionary *dict = _datas[i];
        switch (_graphType) {
            case 1://血壓
                if ( tmp < limitGreen) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                    overX = overX + 1;
                }
                break;
                
            case 2://血糖
                if ( tmp <= _limitBG) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                    
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                    overX = overX + 1;
                }
                break;
                
            case 3://血氧
                //                [self BOReloadData];
                if ( tmp >= 90) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                break;
                
            case 4://體重
                //                [self WeightReload];
                //                bmi = 23;
                if ( _bmi <= 18.5) {
                    CGPathAddEllipseInRect(circlePath5, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if( _bmi > 18.5 && _bmi <= 24.9){
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if( _bmi > 24.9 && _bmi <= 29.9){
                    CGPathAddEllipseInRect(circlePath2, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                }
                break;
            case 5://計步器
                //                [self StepReloadDate];
                if (_goalDis == 0 && _goalStep == 0) {
                    tmpS = 0;
                }
                else if (_goalDis == 0 && _goalStep != 0){
                    tmpS = [[dict objectForKey:@"step"] doubleValue]/_goalStep;
                }
                else if (_goalDis != 0 && _goalStep == 0){
                    tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis;
                }
                else{
                    tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis + [[dict objectForKey:@"step"] doubleValue]/_goalStep;
                }
                NSLog(@"tmpSC %f",tmpS);
                if (tmpS < 0.25) {
                    //red
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if(tmpS >= 0.25 && tmpS < 0.99){
                    //orange
                    CGPathAddEllipseInRect(circlePath3, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    //green
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                
                break;
                
            default:
                
                break;
        }
    }

    //cal regression
    [self calFunctionWithX:mX_arrays andY:mY_arrays];

    NSArray *regressionY = [[NSArray alloc]initWithArray:[self returnRegression:mX_arrays]];
    NSMutableArray *rY = [NSMutableArray new];
    for (int i = 0; i < regressionY.count; i++) {
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
        
        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
        //        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
        //計算點在螢幕上的位置 point position
        double tmpy = ([[regressionY objectAtIndex:i ] doubleValue] - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        //intYF
        if (_graphType == 4) {
            tmpy = ([[regressionY objectAtIndex:i ] doubleValue] - _initYF)/yIntervalValue * intervalInPx;
        }

        double y = height - tmpy;
        [rY addObject:@(y)];
    }
    if (rY.count >= 2) {
        CGPathMoveToPoint(graphPath, NULL, _leftMarginToLeave, [[rY firstObject]floatValue]);
        CGPathMoveToPoint(backgroundPath, NULL, _leftMarginToLeave, [[rY firstObject]floatValue]);
        

        CGPathAddLineToPoint(graphPath, NULL, _leftMarginToLeave + PLOT_WIDTH, [[rY lastObject]floatValue]);
        CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH, [[rY lastObject]floatValue]);
        mmm = ([[rY lastObject]floatValue]-[[rY firstObject]floatValue])/(_leftMarginToLeave-(_leftMarginToLeave + PLOT_WIDTH));
        NSLog(@"mmm = %f",mmm);
        
    }
    if (mmm > 0) {
        [graphLayer setStrokeColor:[UIColor orangeColor].CGColor];
    }
    else if (mmm == 0){
        [graphLayer setStrokeColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0].CGColor];
    }
    else{
        [graphLayer setStrokeColor:[UIColor orangeColor].CGColor];
    }
    

    backgroundLayer.path = backgroundPath;
    graphLayer.path = graphPath;
    circleLayer.path = circlePath;
    circleLayer.path = circlePath;
    circleLayer2.path = circlePath2;
    circleLayer3.path = circlePath3;
    circleLayer4.path = circlePath4;
    circleLayer5.path = circlePath5;
    circleLayerW.path = circlePathW;
    
    //animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [graphLayer addAnimation:animation forKey:@"strokeEnd"];
    
    backgroundLayer.zPosition = 0;
    graphLayer.zPosition = 1;
    circleLayer.zPosition = 2;
    circleLayer2.zPosition = 3;
    circleLayer3.zPosition = 4;
    circleLayer4.zPosition = 5;
    circleLayer5.zPosition = 6;
    circleLayerW.zPosition = 7;
    
    [self.layer addSublayer:graphLayer];
    [self.layer addSublayer:circleLayer];
    [self.layer addSublayer:circleLayer2];
    [self.layer addSublayer:circleLayer3];
    [self.layer addSublayer:circleLayer4];
    [self.layer addSublayer:circleLayer5];
    [self.layer addSublayer:circleLayerW];
}

- (void)drawPlot:(SHPlot *)plot
{
    NSDictionary *theme = plot.plotThemeAttributes;

    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = ((UIColor *)theme[kPlotFillColorKey]).CGColor;
    backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    [backgroundLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    //1 green
    CAShapeLayer *circleLayer = [self setLayerWithColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0] andTheme:theme];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    //2 yellow
    CAShapeLayer *circleLayer2 = [self setLayerWithColor:[UIColor yellowColor] andTheme:theme];
    CGMutablePathRef circlePath2 = CGPathCreateMutable();
    //3 orange
    CAShapeLayer *circleLayer3 = [self setLayerWithColor:[UIColor orangeColor] andTheme:theme];
    CGMutablePathRef circlePath3 = CGPathCreateMutable();
    //4 red
    CAShapeLayer *circleLayer4 = [self setLayerWithColor:[UIColor redColor] andTheme:theme];
    CGMutablePathRef circlePath4 = CGPathCreateMutable();
    //5 blue
    CAShapeLayer *circleLayer5 = [self setLayerWithColor:[UIColor blueColor] andTheme:theme];
    CGMutablePathRef circlePath5 = CGPathCreateMutable();
    //whiete
    CAShapeLayer *circleLayerW = [self setLayerWithColor:[UIColor whiteColor] andTheme:theme];
    CGMutablePathRef circlePathW = CGPathCreateMutable();

    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = self.bounds;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;
    [graphLayer setStrokeColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0].CGColor];
    [graphLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
    CGMutablePathRef graphPath = CGPathCreateMutable();

    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }

    //logic to fill the graph path, ciricle path, background path.
    [plot.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot];
        
        //x value
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;

        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
//        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
        //計算點在螢幕上的位置 point position
        double tmpy = ([_value doubleValue] - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        //intYF
        if (_graphType == 4) {
            tmpy = ([_value doubleValue] - _initYF)/yIntervalValue * intervalInPx;
        }
        
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
        (plot.xPoints[xIndex]).x = ceil((plot.xPoints[xIndex]).x);
        (plot.xPoints[xIndex]).y = ceil(y);
    }];
//    x軸的數值要調整！
    //move to initial point for path and background.
    CGPathMoveToPoint(graphPath, NULL, _leftMarginToLeave, plot.xPoints[0].y);
    CGPathMoveToPoint(backgroundPath, NULL, _leftMarginToLeave, plot.xPoints[0].y);
    
    NSInteger count = _xAxisValues.count;
    double tmpS = 0.0;
    for(int i=0; i< count; i++){
        CGPoint point = plot.xPoints[i];
        CGPathAddLineToPoint(graphPath, NULL, point.x, point.y);
        CGPathAddLineToPoint(backgroundPath, NULL, point.x, point.y);
        double tmp = [[plot.plottingValues[i] objectForKey:@(i+1)] doubleValue];
        NSDictionary *dict = _datas[i];
        switch (_graphType) {
            case 1://血壓
                if ( tmp < limitGreen) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{ // 超標
                    
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                    
                }
                break;
                
            case 2://血糖
                if ( tmp <= _limitBG) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                break;
                
            case 3://血氧
                //                [self BOReloadData];
                if ( tmp >= 90) {
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                break;
                
            case 4://體重
                //                [self WeightReload];
//                bmi = 23;
                if ( _bmi <= 18.5) {
                    CGPathAddEllipseInRect(circlePath5, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if( _bmi > 18.5 && _bmi <= 24.9){
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if( _bmi > 24.9 && _bmi <= 29.9){
                    CGPathAddEllipseInRect(circlePath2, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                break;
            case 5://計步器
                //                [self StepReloadDate];
                if (_goalDis == 0 && _goalStep == 0) {
                    tmpS = 0;
                }
                else if (_goalDis == 0 && _goalStep != 0){
                    tmpS = [[dict objectForKey:@"step"] doubleValue]/_goalStep;
                }
                else if (_goalDis != 0 && _goalStep == 0){
                    tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis;
                }
                else{
                    tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis + [[dict objectForKey:@"step"] doubleValue]/_goalStep;
                }
                NSLog(@"tmpSC %f",tmpS);
                if (tmpS < 0.25) {
                    //red
                    CGPathAddEllipseInRect(circlePath4, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else if(tmpS >= 0.25 && tmpS < 0.99){
                    //orange
                    CGPathAddEllipseInRect(circlePath3, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }
                else{
                    //green
                    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
                    CGPathAddEllipseInRect(circlePathW, NULL, CGRectMake(point.x - 4, point.y - 4, 8, 8));
                }

                break;
                
            default:
                
                break;
        }
        
        //
        CGPoint m_point = plot.xPoints[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blackColor];
        btn.tag = i;
        btn.frame = CGRectMake(m_point.x - 20, m_point.y - 20, 40, 40);
//        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(btn, kAssociatedPlotObject, plot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self clicked:btn];
        [self addSubview:btn];
        //
    }
    
    //move to initial point for path and background.
    CGPathAddLineToPoint(graphPath, NULL, _leftMarginToLeave + PLOT_WIDTH, plot.xPoints[count -1].y);
    CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH, plot.xPoints[count - 1].y);
    
    //additional points for background.
    CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
    CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
    CGPathCloseSubpath(backgroundPath);
    
    backgroundLayer.path = backgroundPath;
    graphLayer.path = graphPath;
    circleLayer.path = circlePath;
    circleLayer2.path = circlePath2;
    circleLayer3.path = circlePath3;
    circleLayer4.path = circlePath4;
    circleLayer5.path = circlePath5;
    circleLayerW.path = circlePathW;
    //animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [graphLayer addAnimation:animation forKey:@"strokeEnd"];
    
    backgroundLayer.zPosition = 0;
    graphLayer.zPosition = 0;
    circleLayer.zPosition = 0;
    circleLayer2.zPosition = 0;
    circleLayer3.zPosition = 0;
    circleLayer4.zPosition = 0;
    circleLayer5.zPosition = 0;
    circleLayerW.zPosition = 0;
    [self.layer addSublayer:graphLayer];
    [self.layer addSublayer:circleLayer];
    [self.layer addSublayer:circleLayer2];
    [self.layer addSublayer:circleLayer3];
    [self.layer addSublayer:circleLayer4];
    [self.layer addSublayer:circleLayer5];
    [self.layer addSublayer:circleLayerW];
}
- (void)drawXYAxis:(SHPlot*)plot{
//    [self drawXLabels:<#(SHPlot *)#>]
    [self drawYLabels:plot];
    [self drawLines:plot];
}

- (void)drawXLabels:(SHPlot *)plot {
    NSInteger xIntervalCount = _xAxisValues.count;
    double xIntervalInPx = PLOT_WIDTH / _xAxisValues.count;
    
    //initialize actual x points values where the circle will be
    plot.xPoints = calloc(sizeof(CGPoint), xIntervalCount);
    
    for(int i=0; i < xIntervalCount; i++){
        CGPoint currentLabelPoint = CGPointMake((xIntervalInPx * i) + _leftMarginToLeave, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
        CGRect xLabelFrame = CGRectMake(currentLabelPoint.x , currentLabelPoint.y + 10, xIntervalInPx, BOTTOM_MARGIN_TO_LEAVE);
        
        plot.xPoints[i] = CGPointMake((int) xLabelFrame.origin.x + (xLabelFrame.size.width /2) , (int) 0);
        
        UILabel *xAxisLabel = [[UILabel alloc] initWithFrame:xLabelFrame];
        xAxisLabel.numberOfLines = 0;
        xAxisLabel.backgroundColor = [UIColor clearColor];
        xAxisLabel.font = (UIFont *)_themeAttributes[kXAxisLabelFontKey];
        
        xAxisLabel.textColor = [UIColor blackColor];
        xAxisLabel.textAlignment = NSTextAlignmentCenter;
        
        NSDictionary *dic = [_xAxisValues objectAtIndex:i];
        __block NSString *xLabel = nil;
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            xLabel = (NSString *)obj;
        }];
        
        xAxisLabel.text = [NSString stringWithFormat:@"%@", xLabel];
        
        
        if (self.currentPage == 0) {
            [self addSubview:xAxisLabel];
        }
        
        
        
        if (i != xIntervalCount-1) {
            //xBetweenLbl
            CGRect xBFrame = CGRectMake(currentLabelPoint.x + xAxisLabel.frame.size.width/2 , currentLabelPoint.y - 15, xIntervalInPx, BOTTOM_MARGIN_TO_LEAVE);
            UILabel *xBetweenLbl = [[UILabel alloc] initWithFrame:xBFrame];
            xBetweenLbl.numberOfLines = 0;
            xBetweenLbl.backgroundColor = [UIColor clearColor];
            xBetweenLbl.font = (UIFont *)_themeAttributes[kXAxisLabelFontKey];
            
            xBetweenLbl.textColor = [UIColor blackColor];
            xBetweenLbl.textAlignment = NSTextAlignmentCenter;
            
            NSDictionary *m_dic = [_xAxisValues objectAtIndex:i+1];
            __block NSString *xNew = nil;
            [m_dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                xNew = (NSString *)obj;
            }];
            m_dic = [_xAxisValues objectAtIndex:i];
            __block NSString *xOld = nil;
            [m_dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                xOld = (NSString *)obj;
            }];
            
            NSLog(@"xNew = %@, xOld = %@",xNew,xOld);
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"MM-DD HH:mm"];
            NSDate *m_new = [formatter dateFromString:xNew];
            NSDate *m_old = [formatter dateFromString:xOld];
            NSTimeInterval m_i_new = [m_new timeIntervalSince1970];
            NSTimeInterval m_i_old = [m_old timeIntervalSince1970];
            NSLog(@"new = %.0f, old = %.0f n-o = %.0f",m_i_new,m_i_old,m_i_new-m_i_old);
            NSString *m_res = @"";
            NSString *m_dayOrHr = @"Days";
            double m_subHR = (m_i_new - m_i_old) / 86400; //天
            if (m_subHR < 1) {
                m_subHR = m_subHR * 24; //小時
                m_dayOrHr = @"Hours";
            }
            m_res = [NSString stringWithFormat:@"%.1f%@",m_subHR,m_dayOrHr];
            xBetweenLbl.text = m_res;
            //        [xBetweenLbl setBackgroundColor:[UIColor redColor]];
            
            if (self.currentPage == 0) {
                [self addSubview:xBetweenLbl];
            }
        }
    }
}

- (void)drawYLabels:(SHPlot *)plot {

    double yIntervalValue = _initStep;//確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }

    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE ) / (INTERVAL_COUNT +1);
    
    NSMutableArray *labelArray = [NSMutableArray array];
    float maxWidth = 0;
    
    for(int i= INTERVAL_COUNT + 1; i >= 0; i--){
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, i * intervalInPx);
        CGRect lableFrame = CGRectMake(0, currentLinePoint.y - (intervalInPx / 2), 100, intervalInPx);
        
        if(i != 0) {
            UILabel *yAxisLabel = [[UILabel alloc] initWithFrame:lableFrame];
            yAxisLabel.backgroundColor = [UIColor clearColor];
            yAxisLabel.font = (UIFont *)_themeAttributes[kYAxisLabelFontKey];
            yAxisLabel.textColor = [UIColor blackColor];
            yAxisLabel.textAlignment = NSTextAlignmentCenter;
            float val = (yIntervalValue * (INTERVAL_COUNT+1 - i)) + _initY;//從40開始
//            if (_graphType == 4) {
//                val = val/10;
//            }
            //initYF
            if (_graphType == 4) {
                val = (yIntervalValue * (INTERVAL_COUNT+1 - i)) + _initYF;//從40開始
            }
            

            NSLog(@"val = %f",val);
//            float val = yRange/10 * (10 - i -1 );
            if(val > 0){
                yAxisLabel.text = [NSString stringWithFormat:@"%.0f%@", val, _yAxisSuffix];
//                yAxisLabel.text = [NSString stringWithFormat:@"%.1f", val, _yAxisSuffix];
            } else {
                yAxisLabel.text = [NSString stringWithFormat:@"%.0f", val];
            }
            if (_graphType == 4) {
                yAxisLabel.text = [NSString stringWithFormat:@"%.1f", val];
            }
            [yAxisLabel sizeToFit];
            CGRect newLabelFrame = CGRectMake(0, currentLinePoint.y - (yAxisLabel.layer.frame.size.height / 2), yAxisLabel.frame.size.width, yAxisLabel.layer.frame.size.height);
            yAxisLabel.frame = newLabelFrame;
            
            if(newLabelFrame.size.width > maxWidth) {
                maxWidth = newLabelFrame.size.width;
            }
            
            [labelArray addObject:yAxisLabel];
            [self addSubview:yAxisLabel];
        }
    }
    
    _leftMarginToLeave = maxWidth + [_themeAttributes[kYAxisLabelSideMarginsKey] doubleValue];
    
    for( UILabel *l in labelArray) {
        CGSize newSize = CGSizeMake(_leftMarginToLeave, l.frame.size.height);
        CGRect newFrame = l.frame;
        newFrame.size = newSize;
        l.frame = newFrame;
    }
}

- (void)drawLines:(SHPlot *)plot {
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor clearColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = ((UIColor *)_themeAttributes[kPlotBackgroundLineColorKye]).CGColor;
    linesLayer.lineWidth = 0.5;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
    
    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    for(int i= INTERVAL_COUNT + 1; i > 0; i--){
        
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, (i * intervalInPx));
        NSLog(@"%f",currentLinePoint.y);
        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, currentLinePoint.y);
        CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + PLOT_WIDTH, currentLinePoint.y);
    }
    
    linesLayer.path = linesPath;
    [self.layer addSublayer:linesLayer];
}



- (void)drawLimitLinesWithDict:(NSDictionary *)dict andLimitArray:(NSArray*)m_arrays {
    //setting lines property
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor clearColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = [UIColor redColor].CGColor;//((UIColor *)_themeAttributes[kPlotBackgroundLineColorKye]).CGColor;
    linesLayer.lineWidth = 1;
    CGMutablePathRef linesPath = CGPathCreateMutable();
    //
    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }
    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
    for(int i = 0; i < m_arrays.count; i++){
        
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, [[m_arrays objectAtIndex:i]integerValue]);
        NSLog(@"currentLinePoint.y %f",currentLinePoint.y);
        //計算點在螢幕上的位置 point position
        double tmpy = (currentLinePoint.y - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        if (_graphType == 4) {
            tmpy = (currentLinePoint.y - _initYF)/yIntervalValue * intervalInPx;
        }
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
//        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, y);
//        CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + PLOT_WIDTH, y);
        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, y);
        double scale = PLOT_WIDTH / 9;
        for (int i = 1; i <= 9; i++) {
            CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + scale*i - 10, y);
            CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x + scale*i, y);
        }
    }
    
    linesLayer.path = linesPath;
    [self.layer addSublayer:linesLayer];
}

- (void)drawLimitLines{
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor clearColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = [UIColor redColor].CGColor;//((UIColor *)_themeAttributes[kPlotBackgroundLineColorKye]).CGColor;
    linesLayer.lineWidth = 1;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();

    
    //    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }

    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
//    for(int i = 0; i < 2; i++){
    
        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, _goalDis);
        NSLog(@"%f",currentLinePoint.y);
        //計算點在螢幕上的位置 point position
        double tmpy = (currentLinePoint.y - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        if (_graphType == 4) {
            tmpy = (currentLinePoint.y - _initYF)/yIntervalValue * intervalInPx;
        }
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, y);
        CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + PLOT_WIDTH, y);
//    }
    
    linesLayer.path = linesPath;
    [self.layer addSublayer:linesLayer];
}


- (void)drawLimitLinesWithValue:(float
                                 ) limitValue{
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];
    linesLayer.frame = self.bounds;
    linesLayer.fillColor = [UIColor clearColor].CGColor;
    linesLayer.backgroundColor = [UIColor clearColor].CGColor;
    linesLayer.strokeColor = [UIColor redColor].CGColor;//((UIColor *)_themeAttributes[kPlotBackgroundLineColorKye]).CGColor;
    linesLayer.lineWidth = 1;
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
    
    
    //    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }
    
    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
    //    for(int i = 0; i < 2; i++){
    
    CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, limitValue);
    NSLog(@"%f",currentLinePoint.y);
    //計算點在螢幕上的位置 point position
    double tmpy = (currentLinePoint.y - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
    if (_graphType == 4) {
        tmpy = (currentLinePoint.y - _initYF)/yIntervalValue * intervalInPx;
    }
    //線之間的間距 => intervalInPx
    double y = height - tmpy;
    CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x, y);
    double scale = PLOT_WIDTH / 9;
    for (int i = 1; i <= 9; i++) {
        CGPathAddLineToPoint(linesPath, NULL, currentLinePoint.x + scale*i - 10, y);
        CGPathMoveToPoint(linesPath, NULL, currentLinePoint.x + scale*i, y);
    }

    
    linesLayer.path = linesPath;
    [self.layer addSublayer:linesLayer];
}

- (void)drawVerticalLineWithPlot1:(SHPlot *)plot1 andPlot2:(SHPlot *)plot2{
    
    NSLog(@"%@",plot1.plottingValues);
    double yIntervalValue = _initStep; //確定間距
    if (_graphType == 4) {
        yIntervalValue = _initStepF; //確定間距
    }

    [plot1.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot1];
        
//        //x value
//        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
//        
//        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
//        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
//        //線之間的間距 => intervalInPx
////        double y = height - tmpy;
//        double y = tmpy - 140;
//        (plot1.xPoints[xIndex]).x = ceil((plot1.xPoints[xIndex]).x);
//        (plot1.xPoints[xIndex]).y = ceil(y);
        //x value
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
        
        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
        //        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
        //計算點在螢幕上的位置 point position
        double tmpy = ([_value doubleValue] - _initY)/yIntervalValue * intervalInPx;// -intervalInPx *2;
        if (_graphType == 4) {
            tmpy = ([_value doubleValue] - _initYF)/yIntervalValue * intervalInPx;
        }
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
        (plot1.xPoints[xIndex]).x = ceil((plot1.xPoints[xIndex]).x);
        (plot1.xPoints[xIndex]).y = ceil(y);
    }];
    
    [plot2.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        
        int xIndex = [self getIndexForValue:_key forPlot:plot2];
        
//        //x value
//        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
//        
//        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
//        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
//        //線之間的間距 => intervalInPx
////        double y = height - tmpy;
//        double y = tmpy - 140;
//        (plot2.xPoints[xIndex]).x = ceil((plot2.xPoints[xIndex]).x);
//        (plot2.xPoints[xIndex]).y = ceil(y);
        //x value
        double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
        
        double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
        //        double tmpy = [_value doubleValue]/yIntervalValue * intervalInPx - intervalInPx *2;
        //計算點在螢幕上的位置 point position
        double tmpy = ([_value doubleValue] - _initY)/yIntervalValue * intervalInPx;// - intervalInPx *2;
        if (_graphType == 4) {
            tmpy = ([_value doubleValue] - _initYF)/yIntervalValue * intervalInPx;
        }
        //線之間的間距 => intervalInPx
        double y = height - tmpy;
        (plot2.xPoints[xIndex]).x = ceil((plot2.xPoints[xIndex]).x);
        (plot2.xPoints[xIndex]).y = ceil(y);
    }];
    
    CAShapeLayer *linesLayer = [CAShapeLayer layer];

    linesLayer.frame = self.bounds;
    [linesLayer setFillColor:[[UIColor clearColor] CGColor]];
    [linesLayer setStrokeColor:[[UIColor colorWithRed:84/255.0 green:101/255.0 blue:131/255.0 alpha:1.0] CGColor]];
    [linesLayer setLineWidth:3.0f];
    [linesLayer setLineJoin:kCALineJoinRound];
    [linesLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    
    CGMutablePathRef linesPath = CGPathCreateMutable();
    
//    double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
    for(int i= 0; i < plot1.plottingValues.count; i++){
//        CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, (i * intervalInPx));
//        NSLog(@"%f",currentLinePoint.y);
        CGPathMoveToPoint(linesPath, NULL, plot1.xPoints[i].x, plot1.xPoints[i].y);
        CGPathAddLineToPoint(linesPath, NULL, plot2.xPoints[i].x, plot2.xPoints[i].y);
    }
    
    linesLayer.path = linesPath;
    [self.layer addSublayer:linesLayer];
    
    
}
#pragma mark -
- (void)showLastData{
    NSDictionary *dict = [_datas lastObject];
    [self handleBottomLblWithDict:dict andType:_graphType];
}
#pragma mark - User Interaction
- (void)tapped:(UITapGestureRecognizer *)tmpTap
{

    UILabel *lbl = (UILabel*)[[[tmpTap view] subviews]firstObject];
    NSLog(@"lbl tag:%ld",(long)lbl.tag);
    NSLog(@"datas %@",_datas);
    NSLog(@"datas[] %@",_datas[lbl.tag]);
    [self handleBottomLblWithDict:_datas[lbl.tag] andType:_graphType];
    
}
- (void)handleBottomLblWithDict:(NSDictionary*)dict andType:(NSInteger) type{
    //get unit
    [self setUnitDef];
    //
    NSString *stringBP = @"";
    NSString *stringPulse = @"";
    NSString *stringTime = @"";
    NSString *stringFour = @"";
    UIColor *color;
    double tmp = 0.0;
    double tmpS = 0.0;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSString *unitBG = @"";
    switch (type) {
        case 1:
            stringBP = [NSString stringWithFormat:@"%@/%@ mmHg",[dict objectForKey:@"systolic"],[dict objectForKey:@"diastolic"]];
            stringPulse = [NSString stringWithFormat:@"%@ %@",NSLocalizedStringFromTable(@"Pulse", INFOPLIST, nil),[dict objectForKey:@"heartbeat"]];
            stringTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
            _first.text = stringBP;
            _second.text = stringPulse;
            _third.text = stringTime;
            [_second setHidden:NO];
            tmp = [[dict objectForKey:@"systolic"] doubleValue];
            
            [self initRange:@"systolic"];
            if ( tmp<= limitGreen) {
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
            [_first setBackgroundColor:color];
            break;
        case 2:
            
            if (unitDef == 0) {
                unitBG = @"mmol/L";
            }
            else if (unitDef == 1){
                unitBG = @"mg/dl";
            }
            else{
                unitBG = @"mg/L";
            }
            stringBP = [NSString stringWithFormat:@"%.1f %@",[[dict objectForKey:@"bloodglucose"] floatValue],unitBG];

            stringTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
            _first.text = stringBP;
//            _second.text = stringPulse;
            [_second setHidden:YES];
            _third.text = stringTime;
            tmp = [[dict objectForKey:@"bloodglucose"] doubleValue];
            if ( tmp <= _limitBG) {
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            else{
                color = [UIColor redColor];
            }
            [_first setBackgroundColor:color];
            break;
        case 3://血氧
            //                [self BOReloadData];
            tmp = [[dict objectForKey:@"oxygen"] doubleValue];
            if ( tmp >= 90) {
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            else{
                color = [UIColor redColor];
            }
            stringBP = [NSString stringWithFormat:@"%.1f%%",tmp];
            stringPulse = [NSString stringWithFormat:@"%@ %@",NSLocalizedStringFromTable(@"Pulse", INFOPLIST, nil),[dict objectForKey:@"heartbeat"]];
            stringTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
            [_first setBackgroundColor:color];
            _first.text = stringBP;
            _second.text = stringPulse;
            _third.text = stringTime;
            break;
            
        case 4://體重
            //                [self WeightReload];
            
            if (screenHeight == 480) {
                /*
                 15.7.15 Ms版修改  author：Keven
                 */
//                NSString *bw = NSLocalizedStringFromTable(@"HS_W_WEIGHT", INFOPLIST, nil);
                NSString *bw = NSLocalizedStringFromTable(@"WEIGHT", INFOPLIST, nil);
                NSString *bf = NSLocalizedStringFromTable(@"BODY_FAT", INFOPLIST, nil);
                stringBP = [NSString stringWithFormat:@"%@:%.1fKg",bw,[[dict objectForKey:@"weight"] doubleValue]/10.0];
                stringPulse = [NSString stringWithFormat:@"BMI:%@",[dict objectForKey:@"bmiCal"]];
                stringFour = [NSString stringWithFormat:@"%@:%.1f",bf,([[dict objectForKey:@"body_fat"]floatValue]*0.1)];
            }
            else{
//                NSString *bw = NSLocalizedStringFromTable(@"HS_W_WEIGHT", INFOPLIST, nil);
                NSString *bw = NSLocalizedStringFromTable(@"WEIGHT", INFOPLIST, nil);
                NSString *bf = NSLocalizedStringFromTable(@"BODY_FAT", INFOPLIST, nil);
                stringBP = [NSString stringWithFormat:@"%@\n%.1fKg",bw,[[dict objectForKey:@"weight"] doubleValue]/10.0];
                stringPulse = [NSString stringWithFormat:@"BMI\n%@",[dict objectForKey:@"bmiCal"]];
                stringFour = [NSString stringWithFormat:@"%@\n%.1f",bf,([[dict objectForKey:@"body_fat"]floatValue]*0.1)];
            }
            
            stringTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"time"]];
            _first.text = stringBP;
            _second.text = stringPulse;
            _third.text = stringTime;
            _four.text = stringFour;
            _bmi = [[dict objectForKey:@"bmiCal"]doubleValue];
            if ( _bmi <= 18.5) {
                color = [UIColor blueColor];
            }
            else if( _bmi > 18.5 && _bmi <= 24.9){
                color = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
            }
            else if( _bmi > 24.9 && _bmi <= 29.9){
                color = [UIColor yellowColor];
            }
            else{
                color = [UIColor redColor];
            }
            [_first setBackgroundColor:color];
            [_second setBackgroundColor:color];
            [_four setBackgroundColor:color];
            break;
        case 5:
            if (screenHeight == 480) {
                stringBP = [NSString stringWithFormat:@"%@:%@",NSLocalizedStringFromTable(@"STEP",INFOPLIST ,nil),[dict objectForKey:@"step"]];
                stringPulse = [NSString stringWithFormat:@"%@:%@m",NSLocalizedStringFromTable(@"DISTANCE",INFOPLIST ,nil),[dict objectForKey:@"dist"]];
            }
            else{
                stringBP = [NSString stringWithFormat:@"%@\n%@",NSLocalizedStringFromTable(@"STEP",INFOPLIST ,nil),[dict objectForKey:@"step"]];
                stringPulse = [NSString stringWithFormat:@"%@\n%@m",NSLocalizedStringFromTable(@"DISTANCE",INFOPLIST ,nil),[dict objectForKey:@"dist"]];
            }
            
            stringTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"start"]];
            tmpS = 0.0;
            _first.text = stringBP;
//            [_second setHidden:YES];
            _second.text = stringPulse;
            _third.text = stringTime;
            if (_goalDis == 0 && _goalStep == 0) {
                tmpS = 0;
            }
            else if (_goalDis == 0 && _goalStep != 0){
                tmpS = [[dict objectForKey:@"step"] doubleValue]/_goalStep;
            }
            else if (_goalDis != 0 && _goalStep == 0){
                tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis;
            }
            else{
                tmpS = [[dict objectForKey:@"dist"] doubleValue]/_goalDis + [[dict objectForKey:@"step"] doubleValue]/_goalStep;
            }
            NSLog(@"tmpS %f",tmpS);
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
            [_first setBackgroundColor:color];
            [_second setBackgroundColor:color];
            break;
            
        default:
            break;
    }
}
#pragma mark - UIButton event methods

- (void)clicked:(id)sender
{
	@try {
		UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		lbl.backgroundColor = [UIColor clearColor];
        UIButton *btn = (UIButton *)sender;
		NSUInteger tag = btn.tag;
        
        SHPlot *_plot = objc_getAssociatedObject(btn, kAssociatedPlotObject);

        double fortext = [[[_plot.plottingValues objectAtIndex:tag] objectForKey:@(tag+1)] doubleValue];
        [self initLblProperty:lbl];
//        sdfasdf
        lbl.textColor = [UIColor blackColor];
        switch (_graphType) {
            case 1://血壓
                if (fortext > limitGreen) {
                    fortext = fortext - limitGreen;
                    lbl.text = [NSString stringWithFormat:@"+%.0f",fortext];
                    lbl.textColor = [UIColor redColor];
                }
                else{
                    lbl.text = @"";
                }
                break;
                
            case 2://血糖
                if (fortext > _limitBG) {
                    fortext = fortext - _limitBG;
                    lbl.text = [NSString stringWithFormat:@"+%.1f",fortext];
                    lbl.textColor = [UIColor redColor];
                }
                else{
                    lbl.text = @"";
                }
                break;
                
            case 3://血氧
                lbl.text = [NSString stringWithFormat:@"%.0f",fortext];
                break;
                
            case 4://體重
                lbl.text = [NSString stringWithFormat:@"%.1f",fortext];
                break;
            case 5://計步器
                //                [self StepReloadDate];
                lbl.text = [NSString stringWithFormat:@"%.0f",fortext];
                
                break;
                
            default:
                
                break;
        }
        
		
//        if (_graphType == 4) {
//            lbl.text = [NSString stringWithFormat:@"%.1f",fortext];
//        }
		
//		[lbl sizeToFit];
//		lbl.frame = CGRectMake(0, 0, lbl.frame.size.width + 5, lbl.frame.size.height);
        
		CGPoint point =((UIButton *)sender).center;
        
        UIView *viewLbl = [self returnViewFromPointAndLblPos:point AndLbl:lbl];
        NSLog(@"viewLbl %@",viewLbl);
        //點擊區域 tap area
//        [viewLbl setBackgroundColor:[UIColor blackColor]];
        
        [self addCustomGestureWithView:viewLbl];
        
        lbl.frame = CGRectMake(-15, 0, 50, lbl.frame.size.height);
//        [lbl setBackgroundColor:[UIColor blackColor]];
        lbl.tag = [(UIView*)sender tag];
        if ([(UIButton*)sender backgroundColor] == [UIColor blackColor]) {
            [viewLbl addSubview:lbl];
//            [(UIButton*)sender backgroundColor] = [UIColor clearColor];
            [(UIButton*)sender setBackgroundColor:[UIColor clearColor]];
        }
        [self bringSubviewToFront:viewLbl];
        [self bringSubviewToFront:lbl];
		dispatch_async(dispatch_get_main_queue(), ^{
            [self addSubview:viewLbl];
            
		});
	}
	@catch (NSException *exception) {
		NSLog(@"plotting label is not available for this point");
	}
}
#pragma mark -
- (UIView*)returnViewFromPointAndLblPos:(CGPoint)tmpPoint AndLbl:(UILabel*)lbl{
    tmpPoint.y -= 20;
    lbl.frame = CGRectMake(tmpPoint.x - lbl.frame.size.width/2, tmpPoint.y, lbl.frame.size.width, lbl.frame.size.height);
    CGRect tmpFrame = CGRectMake(tmpPoint.x - lbl.frame.size.width/2, tmpPoint.y, lbl.frame.size.width, lbl.frame.size.height+25);
    
    UIView *viewLbl = [[UIView alloc]initWithFrame:tmpFrame];
    return viewLbl;
}
- (void)initLblProperty:(UILabel*)tmpLbl{
    tmpLbl.textColor = [UIColor whiteColor];//lbl text color
    tmpLbl.textAlignment = NSTextAlignmentCenter;
    tmpLbl.font = [UIFont systemFontOfSize:10];//(UIFont *)_plot.plotThemeAttributes[kPlotPointValueFontKey];
}
- (void)addCustomGestureWithView:(UIView*)tmpView{
    // add gestureRecognizer
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tmpView addGestureRecognizer:tap];
    [tmpView setUserInteractionEnabled:YES];
    //

}
#pragma mark - initrange
- (void)initRange:(NSString *)key{
    g_Key = key;
    if ([key isEqualToString:@"systolic"]) {
        limitGreen = bpsUplimit;

//        limitOrange = systolicOrange;
//        limitRed = systolicRed;
//        limitYellow = systolicYellow;
    }
    else if ([key isEqualToString:@"diastolic"]){
        limitGreen = bpdUplimit;
//        limitOrange = diastolicOrange;
//        limitRed = diastolicRed;
//        limitYellow = diastolicYellow;
    }
}

- (void)setUnitDef{
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


#pragma mark - Linear regression
- (void)calFunctionWithX:(NSArray*)m_x andY:(NSArray *)m_y{
    float avgX = 0;
    float avgY = 0;
    for (int i = 0; i < m_x.count; i++) {
        avgX = avgX + [[m_x objectAtIndex:i] floatValue];
        avgY = avgY + [[m_y objectAtIndex:i] floatValue];
    }
    avgX = avgX / m_x.count;
    avgY = avgY / m_y.count;

    beta = 0;
    float beta_up = 0;
    float beta_down = 0;
    for (int i = 0;  i < m_x.count; i++) {
        float xi = [[m_x objectAtIndex:i] floatValue];
        float yi = [[m_y objectAtIndex:i] floatValue];
        beta_up += (xi - avgX)*(yi - avgY);
        beta_down += (xi - avgX)*(xi - avgX);
    }
    beta = beta_up / beta_down;
    afa = 0;
    afa = avgY - beta * avgX;
}

- (NSArray*)returnRegression:(NSArray*)m_x{
    NSMutableArray *m_res = [NSMutableArray new];
    for (int i = 0; i < m_x.count; i++) {
        float y = afa + beta *[[m_x objectAtIndex:i] floatValue];
        [m_res addObject:@(y)];
    }
    return m_res;
}
#pragma mark - Theme Key Extern Keys

NSString *const kXAxisLabelColorKey         = @"kXAxisLabelColorKey";
NSString *const kXAxisLabelFontKey          = @"kXAxisLabelFontKey";
NSString *const kYAxisLabelColorKey         = @"kYAxisLabelColorKey";
NSString *const kYAxisLabelFontKey          = @"kYAxisLabelFontKey";
NSString *const kYAxisLabelSideMarginsKey   = @"kYAxisLabelSideMarginsKey";
NSString *const kPlotBackgroundLineColorKye = @"kPlotBackgroundLineColorKye";

@end
