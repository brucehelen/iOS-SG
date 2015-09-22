//
//  HealthSteps.m
//  3GSW
//
//  Created by Roger on 2014/12/3.
//
//

#import "HealthSteps.h"
#import "NQBarGraph.h"
#import "NQData.h"
#import "HttpHelper.h"
#import "CustomIOS7AlertView.h"
#import "MainClass.h"
#define Dday     0
#define Mmonth   1
#define Hhour    2
#define GKey @"AAAAAAAAZZZZZZZZZZZZ999999999"

@interface HealthSteps ()
<CustomIOS7AlertViewDelegate>
{
    NSArray *steps;
    NSDate *firstDate;
    NSDate *lastDate;
    
    NSString *type;
    
    NSString *startM;
    NSThread *endM;
    
    UIButton *btn;
    UIButton *btnHour;
    UIButton *btnStart;
    UIButton *btnEnd;
    
    NQBarGraph * barGraph;
    
    //api
    NSString *startTime;
    NSString *endTime;
    
    
    CustomIOS7AlertView *timeView;
    UIButton *SearchstartBtn;
    UIButton *SearchendBtn;
    UIDatePicker *datePicker;
    NSString *searchStart;
    NSString *searchEnd;
    
    int nowuser;
    MainClass *main;
}
@end

@implementation HealthSteps

- (void)Do_init:(int)nowU {
    nowuser = nowU+1;
    if (barGraph) {
        [barGraph removeFromSuperview];
    }
    [self setBackgroundColor:[UIColor blackColor]];
    type = @"day";
    startTime = @"";
    endTime = @"";
    
    int y = 115;
    int height = 40;
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(150, y, 100, height)];
    [self addSubview:btn];
    type = @"day";
    [btn setTitle:@"Day" forState:UIControlStateNormal];
    //    [btn sizeToFit];
//    btn.center = CGPointMake(160 , y);
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    // Create the request.
    
    
    btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnStart setFrame:CGRectMake(150, y, 100, height)];
    [self addSubview:btnStart];
    [btnStart setTitle:@"Interval" forState:UIControlStateNormal];
    //    [btn sizeToFit];
//    btnStart.center = CGPointMake(55 , y);
    [btnStart addTarget:self action:@selector(useAlertViewcontroller:) forControlEvents:UIControlEventTouchUpInside];
    [btnStart setTag:0];
    
    btnHour = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnHour setFrame:CGRectMake(150, y, 100, height)];
    [self addSubview:btnHour];
    [btnHour setTitle:@"Hour" forState:UIControlStateNormal];
    //    [btn sizeToFit];
//    btnHour.center = CGPointMake(265 , y);
    [btnHour addTarget:self action:@selector(changeToHour) forControlEvents:UIControlEventTouchUpInside];

    btn.center = CGPointMake(160 , y);
    btnStart.center = CGPointMake(265 , y);
    btnHour.center = CGPointMake(55 , y);
    
    
    UIColor *bgCol = [UIColor colorWithRed:252/255.0 green:206/255.0 blue:2/255.0 alpha:1];
    
    [btnStart setBackgroundColor:bgCol];
    [btn setBackgroundColor:bgCol];
    [btnHour setBackgroundColor:bgCol];
    
    
    
    [btnStart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnHour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    [self getData];
    [self GcareUploadWalkDate];

}

- (NSTimeInterval)returnCurrentTime{
    //get time
    NSDate *now = [NSDate date];
    
    
    return [now timeIntervalSince1970];
}

-(IBAction)searchBtnClick:(id)sender
{
    
    if ([UIAlertController class]) {
        [self useAlerController:sender];
    }
    else {
        // use UIAlertView
        //        [self useActionSheet:sender];
    }
}
- (void)useAlerController:(id)sender{
    [timeView setHidden:YES];
    // use UIAlertController
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"SelectRange\n", INFOPLIST, nil) message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SelectRange\n\n\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   ////todo
                                   NSDateFormatter *pickdate = [[NSDateFormatter alloc] init];
                                   [pickdate setDateFormat:@"yyyy-MM-dd"];
                                   if ([(UIView*)sender tag] == 501) {
                                       [SearchstartBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                                   }else
                                   {
                                       [SearchendBtn setTitle:[pickdate stringFromDate:[datePicker date]] forState:UIControlStateNormal];
                                   }
                                   [timeView setHidden:NO];
                               }];
    
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                   {
                                       [timeView setHidden:NO];
                                   }];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 320, 320)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.maximumDate = [NSDate date];
    
    NSLog(@"start %@",SearchstartBtn.titleLabel.text);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:SearchstartBtn.titleLabel.text];
    
    if ([(UIView*)sender tag]==502) {
        datePicker.minimumDate = startDate;
        datePicker.maximumDate = [NSDate date];
    }
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
    [tmp presentViewController:alert animated:YES completion:nil];
}

- (void)useAlertViewcontroller:(id)sender{
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    timeView = alertView;
    [alertView setDelegate:self];
    [alertView setTag:101];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [formatter stringFromDate:nowDate];
    
    UILabel *startLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 100, 20)];
    startLbl.text = @"StartTime";
    //    startLbl.text = NSLocalizedStringFromTable(@"StartTime", INFOPLIST, nil);
    startLbl.backgroundColor = [UIColor clearColor];
    startLbl.textColor = [UIColor blackColor];
    
    SearchstartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SearchstartBtn.frame = CGRectMake(115, 50, 100, 20);
    [SearchstartBtn setTitle:nowString forState:UIControlStateNormal];
    SearchstartBtn.tag = 501;
    [SearchstartBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *endlbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 93, 100, 20)];
    endlbl.text = @"EndTime";
    //    endlbl.text = NSLocalizedStringFromTable(@"EndTime", INFOPLIST, nil);
    endlbl.backgroundColor = [UIColor clearColor];
    endlbl.textColor = [UIColor blackColor];
    
    SearchendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SearchendBtn.frame = CGRectMake(115, 93, 100, 20);
    [SearchendBtn setTitle:nowString forState:UIControlStateNormal];
    SearchendBtn.tag = 502;
    [SearchendBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *showAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    [showAlertView addSubview:startLbl];
    [showAlertView addSubview:SearchstartBtn];
    [showAlertView addSubview:SearchendBtn];
    [showAlertView addSubview:endlbl];
    [alertView setContainerView:showAlertView];
    //        [alertView addSubview:startLbl];
    //        [alertView addSubview:SearchstartBtn];
    //        [alertView addSubview:SearchendBtn];
    //        [alertView addSubview:endlbl];
    
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel",@"OK", nil]];
    //    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:NSLocalizedStringFromTable(@"ALERT_MESSAGE_CANCEL", INFOPLIST, nil),NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil]];
    [alertView show];
    
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"customIOS7dialogButtonTouchUpInside %li",(long)buttonIndex);
    [alertView close];
    
    
    if (buttonIndex == 1) {
        
        NSLog(@"alertView touch %@ %@",SearchstartBtn.titleLabel.text,SearchendBtn.titleLabel.text);
        
        //        searchStart = [NSString stringWithFormat:@"%@ 00:00",SearchstartBtn.titleLabel.text];
        //        searchEnd = [NSString stringWithFormat:@"%@ 23:59",SearchendBtn.titleLabel.text];
        searchStart = [NSString stringWithFormat:@"%@ 00:00:00",SearchstartBtn.titleLabel.text];
        searchEnd = [NSString stringWithFormat:@"%@ 23:59:00",SearchendBtn.titleLabel.text];
        
//        //
//        NSDateFormatter *formatterEn = [[NSDateFormatter alloc]init];
//        [formatterEn setDateFormat:@"dd-MM-yyyy"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy-MM-dd"];
//        NSDate *dateStart = [formatter dateFromString:SearchstartBtn.titleLabel.text];
//        NSDate *dateEnd = [formatter dateFromString:SearchendBtn.titleLabel.text];
//        
//        
//        searchStart = [NSString stringWithFormat:@"00:00 %@",[formatterEn stringFromDate:dateStart]];
//        searchEnd = [NSString stringWithFormat:@"23:59 %@",[formatterEn stringFromDate:dateEnd]];
//        //
        startTime = searchStart;
        endTime = searchEnd;
        
        NSLog(@"search Start = %@",searchStart);
        
        [self GcareUploadWalkDate];
        
        
        //            [self MyTest:userAccount AndHash:userHash StartTime:SearchstartBtn.titleLabel.text andEndTime:SearchendBtn.titleLabel.text];
        //        [self Send_UserRemind:userAccount andHash:userHash];
    }
}

- (void)changeToHour{
    type = @"hr";
//    [btn setTitle:@"Hour" forState:UIControlStateNormal];
    [barGraph removeFromSuperview];
    [self drawGraph];
}
- (void)change{
    type = @"day";
//    if([type isEqualToString:@"day"]){
//        type = @"hr";
//        [btn setTitle:@"Hour" forState:UIControlStateNormal];
//    }
//    else{
//        type = @"day";
//        [btn setTitle:@"Day" forState:UIControlStateNormal];
//    }
    [barGraph removeFromSuperview];
    [self drawGraph];
}

- (NSDate*)returnDate:(NSString*)strDate{
    //    NSLog(@"strDate = %@",strDate);
    NSDate *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-d"];
    date = [formatter dateFromString:strDate];
    
    return date;
}


- (void)drawGraph{
    int base = 88 + 80;
    barGraph=[[NQBarGraph alloc] initWithFrame:CGRectMake(10, 140 - 5, self.bounds.size.width-20, self.bounds.size.height-base)];
    if (self.bounds.size.height < 500) {
        barGraph.verticale_data_space = 22.5;
    }
    else{
        barGraph.verticale_data_space = 32.5;
    }
    barGraph.type = type;
    
    barGraph.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    //set backgroundcolor
    barGraph.backgroundColor =  [UIColor blackColor];
    [self addSubview:barGraph];
    NSMutableArray * dataArray=[NSMutableArray array];

    firstDate = [self returnDate:[[steps firstObject]objectForKey:@"date_time"]];
    lastDate = [self returnDate:[[steps lastObject]objectForKey:@"date_time"]];
    int start = [firstDate timeIntervalSince1970];
    int end = [lastDate timeIntervalSince1970];
    
    
    
    if ([type isEqualToString:@"hr"]) {
        //hour
        for (int j = start; j <= end; j += 86400 ) {
            NSDate *thisDate = [NSDate dateWithTimeIntervalSince1970:j];
            int h = 0;
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:steps];
            BOOL noData = YES;
            for (int i = 0; i < tmpArr.count; i++) {
                NSDictionary *dict = [tmpArr objectAtIndex:i];
                NSDate *date = [self returnDate:[dict objectForKey:@"date_time"]];
                if (j == [date timeIntervalSince1970]){
                    for (int i = 0; i < 24; i++) {
                        //計算一天的總和
                        NSString *key;
                        if (i < 10) {
                            key = [NSString stringWithFormat:@"h0%d",i];
                        }
                        else{
                            key = [NSString stringWithFormat:@"h%d",i];
                        }
                        NSString *v = [dict objectForKey:key];
                        h = [v intValue];
                        NQData * data=[NQData dataWithDate:thisDate andNumber:@(h) andHr:[NSString stringWithFormat:@"%d",i]];
                        [dataArray addObject:data];
                    }
                    [tmpArr removeObjectAtIndex:i];
                    noData = NO;
                    break;
                }
                else{
                    //                break;
                }
            }
            if (noData) {
                for (int i = 0; i < 24; i++) {
                    NQData * data=[NQData dataWithDate:thisDate andNumber:@(0) andHr:[NSString stringWithFormat:@"%d",i]];
                    [dataArray addObject:data];
                }
            }
        }
    }
    else{
        for (int j = start; j <= end; j += 86400 ) {
            NSDate *thisDate = [NSDate dateWithTimeIntervalSince1970:j];
            int h = 0;
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:steps];
            for (int i = 0; i < tmpArr.count; i++) {
                NSDictionary *dict = [tmpArr objectAtIndex:i];
                NSDate *date = [self returnDate:[dict objectForKey:@"date_time"]];
                
                if (j == [date timeIntervalSince1970]) {
                    for (int i = 0; i < 24; i++) {
                        //計算一天的總和
                        NSString *key;
                        if (i < 10) {
                            key = [NSString stringWithFormat:@"h0%d",i];
                        }
                        else{
                            key = [NSString stringWithFormat:@"h%d",i];
                        }
                        NSString *v = [dict objectForKey:key];
                        h = h + [v intValue];
                        
                    }
                    [tmpArr removeObjectAtIndex:i];
                    break;
                }
                else{
                    
                }
            }
            //        NSLog(@"date = %@,total = %d",thisDate,h);
            NQData * data=[NQData dataWithDate:thisDate andNumber:@(h)];
            [dataArray addObject:data];
        }
    }
    
    
    barGraph.dataSource=dataArray;
}


#pragma mark - APIs area

- (void)GcareUploadWalkDate{
    //api url
    //    NSString *getUserApi = [NSString stringWithFormat:@"%@/GcareGetWalkData.html",@"http://210.242.50.125:7000/angelcare/APP/"];
    
    NSString *getUserApi = @"http://210.242.50.125:7000/angelcare/APP/GcareGetWalkData.html";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * nowuserStr = [NSString stringWithFormat:@"%d",nowuser];
    NSString *key = [NSString stringWithFormat:@"Acc%d",nowuser];
    NSString *acc = [defaults objectForKey:key];
    NSLog(@"acc = %@, key = %@, nowuser = %d",acc,key,nowuser);
    
    //    NSString *dataHash;
    NSString *account = acc;
    //    NSString *GKeyId = [NSString stringWithFormat:@"%d",1];
    NSTimeInterval timeStamp = [self returnCurrentTime];
    
    
    //hash(Gkey + TimeStampe + AppDataJson)
    
    NSDictionary *appDataJson = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 account ,@"account",
                                 startTime ,@"Start",
                                 endTime ,@"End",nil];
    NSString *timeS = [NSString stringWithFormat:@"%d",(int)timeStamp];
    NSDictionary *apiData = @{@"account" : account,
                              @"TimeStamp" : timeS,
                              @"AppDataJson" : appDataJson};
    [self runApiWithURL:getUserApi andData:apiData];
}

- (void)runApiWithURL:(NSString*)apiURL andData:(NSDictionary*)apiData{
    //call api
    
    // Need API, httpBody
    if([HttpHelper NetWorkIsOK]){
        //发送请求，并且得到返回的数据
        main = (MainClass*)[self nextResponder];
        [main AddLoadingView];
        [HttpHelper post:apiURL RequestBody:[HttpHelper returnHttpBody:apiData] FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(data){
                [self performSelectorOnMainThread:@selector(api_callBack:) withObject:data waitUntilDone:YES];
            }
            else{
                NSLog(@"无效的数据,%@",connectionError);
                [main LetHUDHide];
            }
        }];
    }
}

- (void)api_callBack:(NSData*)data{
    NSLog(@"api_callBack");
    NSError *error;
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *usersOne = [jsonArr  objectAtIndex:0] ;
    
    //    NSLog(@"Data = %@",[usersOne objectForKey:@"Data"]);
    NSString *status = [usersOne objectForKey:@"status"];
    //    NSString *str1 = [NSString stringWithFormat:@"%d",0];
    if ([status isEqualToString:@"0"]) {
        NSArray *arr = [usersOne objectForKey:@"Data"];
        NSLog(@"arr = %@",arr);
        //        NSDictionary *first = [arr firstObject];
        //        NSDictionary *last = [arr lastObject];
        if ([arr count] == 0) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Remind"
                                                  message:@"No Data"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            [alertController addAction:okAction];
            UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
            [tmp presentViewController:alertController animated:YES completion:nil];
        }
        steps = arr;
        
        [self drawGraph];
    }
    else{
        [barGraph removeFromSuperview];
        NSLog(@"msg: %@",[usersOne objectForKey:@"msg"]);
    }
    if (main) {
        [main LetHUDHide];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
