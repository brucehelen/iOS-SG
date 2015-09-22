//
//  My_ShowView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import  "My_ShowView.h"
#import  "MainClass.h"

#define PIC_R_Up NSLocalizedStringFromTable(@"Icon_redUp", PICPLIST, nil)
#define PIC_G_Down NSLocalizedStringFromTable(@"Icon_greenDown", PICPLIST, nil)
#define PIC_Y_Normal NSLocalizedStringFromTable(@"Icon_yellowE", PICPLIST, nil)

#define DIASTOLIC NSLocalizedStringFromTable(@"DIASTOLIC", INFOPLIST, nil)
#define SYSTOLIC NSLocalizedStringFromTable(@"SYSTOLIC", INFOPLIST, nil)
#define HEARTBEAT NSLocalizedStringFromTable(@"HEARTBEAT", INFOPLIST, nil)
#define NODATA NSLocalizedStringFromTable(@"NODATA", INFOPLIST, nil)

#define STEP NSLocalizedStringFromTable(@"STEP", INFOPLIST, nil)
#define DISTANCE NSLocalizedStringFromTable(@"DISTANCE", INFOPLIST, nil)
#define CAL NSLocalizedStringFromTable(@"CAL", INFOPLIST, nil)

#define List NSLocalizedStringFromTable(@"isList", INFOPLIST, nil)
#define Chart NSLocalizedStringFromTable(@"isChart", INFOPLIST, nil)

#define Day NSLocalizedStringFromTable(@"DayBtn", INFOPLIST, nil)
#define Week NSLocalizedStringFromTable(@"WeekBtn", INFOPLIST, nil)
#define Month NSLocalizedStringFromTable(@"MonthBtn", INFOPLIST, nil)
#define Interval NSLocalizedStringFromTable(@"IntervalBtn", INFOPLIST, nil)

#define BLOODGLUCOSE NSLocalizedStringFromTable(@"BLOODGLUCOSE", INFOPLIST, nil)
#define OXYGEN NSLocalizedStringFromTable(@"OXYGEN", INFOPLIST, nil)

#define WEIGHT NSLocalizedStringFromTable(@"WEIGHT", INFOPLIST, nil)
#define BODY_FAT NSLocalizedStringFromTable(@"BODY_FAT", INFOPLIST, nil)

@implementation My_ShowView

@synthesize listView,graphView,scrollView,isChart;



//  初始化Ｖiew 上的設定
-(void)Do_Init:(int)nowtype :(id)SetObj
{
    NSLog(@"Do_Init");
    type = nowtype;
    NSLog(@"type = %i",type);
    
    if (isChart) {
        [listView removeFromSuperview];
    }else
    {
        [graphView removeFromSuperview];
    }
    
    if (nowtype ==3) {
        listView.allowsSelection = YES;
        
    }else
    {
        listView.allowsSelection = NO;
    }
    
//    scrollView.contentSize = CGSizeMake(320, 500);
    
    
    [self.scrollView addSubview:listView];
}


//ios xib init
-(void)awakeFromNib
{
    isChart = NO;
}



//  設定此Ｖiew
-(void)Set_Init:(NSArray *)arr;
{
    if (isChart) {
//        [changeViewBtn setTitle:List forState:UIControlStateNormal];
        [changeViewBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_list.png"] forState:UIControlStateNormal];
    }else
    {
//        [changeViewBtn setTitle:Chart forState:UIControlStateNormal];
        [changeViewBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_chart.png"] forState:UIControlStateNormal];
    }
    
    
    [dayBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_day.png"] forState:UIControlStateNormal];
    [weekBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_week.png"] forState:UIControlStateNormal];
    [monthBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_month.png"] forState:UIControlStateNormal];
    [IntervalBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_up_interval.png"] forState:UIControlStateNormal];
    
    [dayBtn setTitle:@"" forState:UIControlStateNormal];
    [weekBtn setTitle:@"" forState:UIControlStateNormal];
    [monthBtn setTitle:@"" forState:UIControlStateNormal];
    [IntervalBtn setTitle:@"" forState:UIControlStateNormal];
    [changeViewBtn setTitle:@"" forState:UIControlStateNormal];
    dataArr = arr;
    NSLog(@"data arr = %@",dataArr);
    [self set_RemindTxt];
}

//設定貼心提醒字樣
-(void)set_RemindTxt
{
    if (type == 1) {
        
        remindView.text = NSLocalizedStringFromTable(@"ForHealth", INFOPLIST, nil);
    }
    
    if (type == 2) {
        remindView.text = NSLocalizedStringFromTable(@"ForHealth", INFOPLIST, nil);
    }
    
    if (type == 3) {
        remindView.text = NSLocalizedStringFromTable(@"ForHealth", INFOPLIST, nil);
    }
    
    if (type == 4) {
        remindView.text = NSLocalizedStringFromTable(@"ForHealth", INFOPLIST, nil);
    }
    
    if (type == 5) {
        
        remindView.text = NSLocalizedStringFromTable(@"ForHealth", INFOPLIST, nil);
    }
}


//計算搜尋時間差
-(int)searchStartTime:(NSString *)start andEndTime:(NSString *)end
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy/MM/dd"];
    NSDate *startd=[date dateFromString:start];
    NSDate *endd=[date dateFromString:end];
    
    NSTimeInterval startsec=[startd timeIntervalSince1970]*1;
    NSTimeInterval endsec=[endd timeIntervalSince1970]*1;
    
    
    NSTimeInterval cha =endsec-startsec;
    
    //計算幾天
    int countday = cha/60/60/24;
    
    return countday+1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    int datacount = [dataArr count] - indexPath.row-1;
    switch (type)
    {
        case 1://血壓
            if ([[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"] integerValue] !=0) {
                cellHeight = 87.0f;
            }else
            {
                cellHeight = 50.0f;
            }
            break;
        
        case 2://血糖
            if ([[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"] integerValue] !=0) {
                cellHeight = 87.0f;
            }else
            {
                cellHeight = 50.0f;
            }
            break;
        
        case 3://血氧
            if ([[[dataArr objectAtIndex:datacount] objectForKey:@"oxygen"] integerValue] !=0) {
                cellHeight = 87.0f;
            }else
            {
                cellHeight = 50.0f;
            }
            break;
        
        case 4://體重
            if ([[[dataArr objectAtIndex:datacount] objectForKey:@"body_fat"] integerValue] !=0) {
                cellHeight = 87.0f;
            }else
            {
                cellHeight = 50.0f;
            }
            break;
            
        case 5://計步器
            if ([[[dataArr objectAtIndex:datacount] objectForKey:@"step"] integerValue] !=0) {
                cellHeight = 110.0f;
            }else
            {
                cellHeight = 50.0f;
            }

    }
    return cellHeight;
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [dataArr count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"type = %i",type);
    int datacount = [dataArr count] - indexPath.row -1;
    
    NSLog(@"datacount =%i",datacount);
    
    //血壓
    if (type == 1) {
        if ([[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"] integerValue] !=0)
        {
            NSString *cellIdentifier = @"Measure1Cell";
            Measure1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Measure1Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
        
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure1Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure1Cell" owner:self options:nil] objectAtIndex:0];
            }
            
            
//            cell.dateLbl.text = [NSString stringWithFormat:@"%@",[self changeDateFormaterString:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ]];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.firstNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"]];
            
            cell.firstNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"]];
            
            cell.secondNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:datacount] objectForKey:@"systolic"]];
            
            cell.pulseNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:datacount] objectForKey:@"heartbeat"]];
            
            NSLog(@"cell = %@",[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"]);
            
            if (indexPath.row == [dataArr count]-1) {
                cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                cell.secondImg.image = [UIImage imageNamed:PIC_Y_Normal];
                cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
                cell.secondCountLbl.text = [NSString stringWithFormat:@"%i",0];
            }else if ((indexPath.row >= 0) && (indexPath.row <= [dataArr count]-1))
            {
                if ([[[dataArr objectAtIndex:datacount] objectForKey:@"heartbeat"] integerValue] == 0) {
                    cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    cell.secondImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
                    cell.secondCountLbl.text = [NSString stringWithFormat:@"%i",0];
                }else
                {
                    //右邊舒張壓
                    int firstminusNum = [[[dataArr objectAtIndex:datacount] objectForKey:@"diastolic"] integerValue] - [[[dataArr objectAtIndex:datacount-1] objectForKey:@"diastolic"] integerValue];
                    //左邊收縮壓
                    int secondminusNum = [[[dataArr objectAtIndex:datacount] objectForKey:@"systolic"] integerValue] - [[[dataArr objectAtIndex:datacount-1] objectForKey:@"systolic"] integerValue];
                    
                    NSLog(@"First %i Second %i",firstminusNum,secondminusNum);
                    
                    if (secondminusNum > 0) {
                        cell.secondImg.image = [UIImage imageNamed:PIC_R_Up];
                    }else if (secondminusNum == 0)
                    {
                        cell.secondImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    }else
                    {
                        cell.secondImg.image = [UIImage imageNamed:PIC_G_Down];
                    }
                    cell.secondCountLbl.text = [NSString stringWithFormat:@"%i",secondminusNum];
                    
                    
                    
                    NSLog(@"secondminusNum = %i",secondminusNum);
                    
                    if (firstminusNum > 0) {
                        cell.firstImg.image = [UIImage imageNamed:PIC_R_Up];
                    }else if (firstminusNum == 0)
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    }else
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_G_Down];
                    }
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",firstminusNum];
                }
            }
            cell.firstName.text = DIASTOLIC;
            cell.secondName.text = SYSTOLIC;
            cell.pulseLbl.text = HEARTBEAT;
            
            
            return cell;
            
        }else
        {
            NSString *cellIdentifier = @"MeasureNoCell";
            MeasureNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MeasureNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [self changeDateFormaterString2:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
//            NSLog(@"date lbl = %@",[self changeDateFormaterString2:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ]);
            
            cell.nodataLbl.text = NODATA;
            return cell;
        }
     }else if (type == 2)//血糖
     {
         
         if ([[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"] integerValue] !=0)
         {
             NSString *cellIdentifier = @"Measure2Cell";
             Measure2Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             if (cell == nil) {
                 cell = [[Measure2Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
             }
             
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure2Cell_iPad" owner:self options:nil] objectAtIndex:0];
             }else
             {
                 cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure2Cell" owner:self options:nil] objectAtIndex:0];
             }
             
//             cell.dateLbl.text = [NSString stringWithFormat:@"%@",[self changeDateFormaterString:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ]];
             cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
             
             cell.bsLbl.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"]];
             
             
             NSLog(@"cell = %@",[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"]);
             
             if (indexPath.row == [dataArr count]-1) {
                 cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                 cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
             }else if ((indexPath.row >= 0) && (indexPath.row <= [dataArr count]-1))
             {
                 if ([[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"] integerValue] == 0) {
                     cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];

                     cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];

                 }else
                 {
                     
                     int firstminusNum = [[[dataArr objectAtIndex:datacount] objectForKey:@"bloodglucose"] integerValue] - [[[dataArr objectAtIndex:datacount-1] objectForKey:@"bloodglucose"] integerValue];
                     
                     if (firstminusNum > 0) {
                         cell.firstImg.image = [UIImage imageNamed:PIC_R_Up];
                     }else if (firstminusNum == 0)
                     {
                         cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                     }else
                     {
                         cell.firstImg.image = [UIImage imageNamed:PIC_G_Down];
                     }
                     cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",firstminusNum];
                     
                     
                 }
             }
             cell.firstName.text = BLOODGLUCOSE;
             
             
             return cell;
             
         }else
         {
             NSString *cellIdentifier = @"MeasureNoCell";
             MeasureNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             if (cell == nil) {
                 cell = [[MeasureNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
             }
             
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
             {
                 cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell_iPad" owner:self options:nil] objectAtIndex:0];
             }else
             {
                 cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell" owner:self options:nil] objectAtIndex:0];
             }
             
//             cell.dateLbl.text = [self changeDateFormaterString2:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
             cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
             cell.nodataLbl.text = NODATA;
             return cell;
         }
        
        
    }else if (type == 3)//血氧
    {
        if ([[dataArr objectAtIndex:datacount] objectForKey:@"oxygen"])
        {
            NSString *cellIdentifier = @"Measure3Cell";
            Measure3Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Measure3Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure3Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure3Cell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [NSString stringWithFormat:@"%@",[self changeDateFormaterString:[[dataArr objectAtIndex:indexPath.row] objectForKey:@"time"] ]];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.firstNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"oxygen"]];
            
            cell.secondNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"heartbeat"]];
            
            
            NSLog(@"cell = %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"oxygen"]);
            
            if (indexPath.row == 0) {
                cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
            }else if ((indexPath.row > 0) && (indexPath.row <= [dataArr count]-1))
            {
                if ([[[dataArr objectAtIndex:indexPath.row-1] objectForKey:@"oxygen"] integerValue] == 0) {
                    cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
                }else
                {
                    
                    int firstminusNum = [[[dataArr objectAtIndex:indexPath.row] objectForKey:@"oxygen"] integerValue] - [[[dataArr objectAtIndex:indexPath.row-1] objectForKey:@"oxygen"] integerValue];
                    
                    if (firstminusNum > 0) {
                        cell.firstImg.image = [UIImage imageNamed:PIC_R_Up];
                    }else if (firstminusNum == 0)
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    }else
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_G_Down];
                    }
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",firstminusNum];
                    
                }
            }
            cell.firstName.text = OXYGEN;
            cell.secondName.text = HEARTBEAT;
            
            
            return cell;
            
        }else
        {
            NSString *cellIdentifier = @"MeasureNoCell";
            MeasureNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MeasureNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [self changeDateFormaterString2:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.nodataLbl.text = NODATA;
            return cell;
        }
    }else if (type == 4)//體重
    {
        NSLog(@"is 4");
        
        if ([[[dataArr objectAtIndex:datacount] objectForKey:@"body_fat"] integerValue] !=0)
        {
            NSString *cellIdentifier = @"Measure4Cell";
            Measure4Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Measure4Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure4Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure4Cell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [NSString stringWithFormat:@"%@",[self changeDateFormaterString:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ]];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            
            cell.firstNum.text = [NSString stringWithFormat:@"%.1f",[[[dataArr objectAtIndex:datacount] objectForKey:@"weight"] floatValue]/10];
            
            cell.secondNum.text = [NSString stringWithFormat:@"%.1f",[[[dataArr objectAtIndex:datacount] objectForKey:@"body_fat"] floatValue]/10];
            
//            cell.pulseNum.text = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"heartbeat"]];
            
            NSLog(@"cell = %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"body_fat"]);
            
            if (indexPath.row == [dataArr count] -1) {
                cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
//                cell.secondImg.image = [UIImage imageNamed:PIC_Y_Normal];
                cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
//                cell.secondCountLbl.text = [NSString stringWithFormat:@"%i",0];
            }else if ((indexPath.row >= 0) && (indexPath.row <= [dataArr count]-1))
            {
                if ([[[dataArr objectAtIndex:datacount] objectForKey:@"weight"] integerValue] == 0) {
                    cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
//                    cell.secondImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%i",0];
//                    cell.secondCountLbl.text = [NSString stringWithFormat:@"%i",0];
                }else
                {
                    
                    float firstminusNum = [[[dataArr objectAtIndex:datacount] objectForKey:@"weight"] floatValue]/10 - [[[dataArr objectAtIndex:datacount-1] objectForKey:@"weight"] floatValue]/10;
                    
//                    int firstminusNum = [[[dataArr objectAtIndex:indexPath.row] objectForKey:@"weight"] integerValue] - [[[dataArr objectAtIndex:indexPath.row-1] objectForKey:@"weight"] integerValue];
                    
                    if (firstminusNum > 0) {
                        cell.firstImg.image = [UIImage imageNamed:PIC_R_Up];
                    }else if (firstminusNum == 0)
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_Y_Normal];
                    }else
                    {
                        cell.firstImg.image = [UIImage imageNamed:PIC_G_Down];
                    }
                    cell.firstCountLbl.text = [NSString stringWithFormat:@"%.1f",firstminusNum];
                }
            }
            cell.firstName.text = WEIGHT;
            cell.secondName.text = BODY_FAT;
            
            
            return cell;
            
        }else
        {
            NSString *cellIdentifier = @"MeasureNoCell";
            MeasureNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MeasureNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [self changeDateFormaterString2:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.nodataLbl.text = NODATA;
            return cell;
        }
    }
     else if (type == 5)//計步器
    {
        if ([[[dataArr objectAtIndex:datacount] objectForKey:@"step"] integerValue] !=0)
        {
            NSString *cellIdentifier = @"Measure5Cell";
            Measure5Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[Measure5Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure5Cell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Measure5Cell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [self changeDateFormaterStringMMddYYYY:[[dataArr objectAtIndex:datacount] objectForKey:@"start"] ];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"start"] ];
            
            NSLog(@"start111 = %@",[[dataArr objectAtIndex:datacount] objectForKey:@"start"]);
            
            cell.stepNum.text = [[dataArr objectAtIndex:datacount] objectForKey:@"step"];
            cell.distanceNum.text = [[dataArr objectAtIndex:datacount] objectForKey:@"dist"];
            cell.calNum.text = [[dataArr objectAtIndex:datacount] objectForKey:@"cal"];
            
            
            if (indexPath.row == [dataArr count]-1) {
                cell.pic.image = [UIImage imageNamed:PIC_Y_Normal];
                cell.picNum.text = [NSString stringWithFormat:@"%i",0];
            }else if ((indexPath.row >= 0) && (indexPath.row <= [dataArr count]-1))
            {
                if ([[[dataArr objectAtIndex:datacount] objectForKey:@"step"] integerValue] == 0) {
                    cell.pic.image = [UIImage imageNamed:PIC_Y_Normal];
                    cell.picNum.text = [NSString stringWithFormat:@"%i",0];
                }else
                {
                    
                    int firstminusNum = [[[dataArr objectAtIndex:datacount] objectForKey:@"step"] integerValue] - [[[dataArr objectAtIndex:datacount-1] objectForKey:@"step"] integerValue];
                    
                    if (firstminusNum > 0) {
                        cell.pic.image = [UIImage imageNamed:PIC_R_Up];
                    }else if (firstminusNum == 0)
                    {
                        cell.pic.image = [UIImage imageNamed:PIC_Y_Normal];
                    }else
                    {
                        cell.pic.image = [UIImage imageNamed:PIC_G_Down];
                    }
                    cell.picNum.text = [NSString stringWithFormat:@"%i",firstminusNum];
                    
                    
                }
            }
            cell.stepLbl.text = STEP;
            cell.distanceLbl.text = DISTANCE;
            cell.calLbl.text = CAL;
            
            
            return cell;
            
        }else
        {
            NSString *cellIdentifier = @"MeasureNoCell";
            MeasureNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[MeasureNoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeasureNoCell" owner:self options:nil] objectAtIndex:0];
            }
            
//            cell.dateLbl.text = [self changeDateFormaterString2:[[[dataArr objectAtIndex:datacount] objectForKey:@"time"] substringWithRange:NSMakeRange(0, 10)] ];
            cell.dateLbl.text = [self changeDateformatter:[[dataArr objectAtIndex:datacount] objectForKey:@"time"] ];
            cell.nodataLbl.text = NODATA;
            return cell;
        }
    }
    

    
    return NULL;
}

//圖表列表切換
-(IBAction)changeChart:(id)sender
{
    NSLog(@"change chart");
    
    if (!isChart) {

        [listView removeFromSuperview];
        isChart = YES;
        [graphView removeFromSuperview];
        
        
        graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 37, 300, 265)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 70, 748, 457)];
        }
        
        CGRect frame = graphView.frame;
        [graphView Set_initFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        graphView.LeftWhiteWidth = 40.0f;
        graphView.RightWhiteWidth = 20.0f;
        graphView.UpWhiteHeight = 20.0f;
        graphView.DownWhiteHeight = 20.0f;
        graphView.Ynumber = 12;
        graphView.Xnumber = 10;
        graphView.dateFormatter = DEFAULTDATE;
        graphView.ChartWidth = 3;
        graphView.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"data arr = %@",dataArr);
        
//        if ([dataArr count]>0) {
        
            NSLog(@"dataArr = %i",[dataArr count]);
        
        switch (type) {
            case 1://血壓
                [self BPReloadData];
                break;
                
            case 2://血糖
                [self BSReloadData];
                break;
                
            case 3://血氧
                [self BOReloadData];
                break;
                
            case 4://體重體指
                [self WeightReload];
                break;
                
            case 5://計步器
                [self StepReloadDate];
                break;
                
            default:
                break;
        }
        
//        } 
        [self.scrollView addSubview:graphView];
            
        
//        [(UIButton *)sender setTitle:List forState:UIControlStateNormal];
        [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_record_up_list.png"] forState:UIControlStateNormal];
        
    }else
    {
        [self.scrollView addSubview:listView];
        [graphView removeFromSuperview];
        [listView reloadData];
        isChart = NO;
        [(UIButton *)sender setBackgroundImage:[UIImage imageNamed:@"icon_record_up_chart.png"] forState:UIControlStateNormal];
//        [(UIButton *)sender setTitle:Chart forState:UIControlStateNormal];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"index.path = %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"]);
    if (type == 3) {
        
        [listView removeFromSuperview];
        [graphView removeFromSuperview];
        CGRect frame = graphView.frame;
        
        
        
        graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 37, 300, 265)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 70, 748, 457)];
        }
        
        [graphView Set_initFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        graphView.LeftWhiteWidth = 40.0f;
        graphView.RightWhiteWidth = 20.0f;
        graphView.UpWhiteHeight = 20.0f;
        graphView.DownWhiteHeight = 20.0f;
        graphView.Ynumber = 12;
        graphView.dateFormatter = @"yyyy-MM-dd HH:mm:ss";
        graphView.ChartWidth = 3;
        graphView.backgroundColor = [UIColor whiteColor];
        isChart = YES;
//        [changeViewBtn setTitle:List forState:UIControlStateNormal];
        NSMutableArray *oxygenArr = [[NSMutableArray alloc] init];
        NSMutableArray *hearbeatArr = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] count]; i++) {
            
            
            if ([[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"oxygen"])
            {
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"oxygen"],@"value",[[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"time"],@"date", nil];
                [oxygenArr addObject:dic];
            }
            
            if ([[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"heartbeat"])
            {
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"heartbeat"],@"value",[[[[dataArr objectAtIndex:indexPath.row] objectForKey:@"list"] objectAtIndex:i] objectForKey:@"time"],@"date", nil];
                [hearbeatArr addObject:dic];
            }
        }
        [graphView addChart:oxygenArr withName:OXYGEN];
        [graphView addLineWithArray:hearbeatArr withName:HEARTBEAT];
        [self.scrollView addSubview:graphView];
         
    }
    
    
}


//重新讀取資料
-(void)reloadData
{
    NSLog(@"reloadData");
    NSLog(@"isChart %i",isChart);
    if (isChart) {
         NSLog(@"isChart %i",isChart);
        [listView removeFromSuperview];
        [graphView removeFromSuperview];
        CGRect frame = graphView.frame;
        graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 37, 300, 265)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            graphView = [[GraphView alloc] initWithFrame:CGRectMake(10, 70, 748, 457)];
        }
        
        [graphView Set_initFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        graphView.LeftWhiteWidth = 40.0f;
        graphView.RightWhiteWidth = 20.0f;
        graphView.UpWhiteHeight = 20.0f;
        graphView.DownWhiteHeight = 20.0f;
        graphView.Ynumber = 12;
        graphView.dateFormatter = DEFAULTDATE;
        graphView.ChartWidth = 3;
        graphView.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"data arr = %@",dataArr);
        
        switch (type) {
            case 1://血壓
                NSLog(@"BP ReloadData");
                [self BPReloadData];
                break;
                
            case 2://血糖
                NSLog(@"BS ReloadData");
                [self BSReloadData];
                break;
                
            case 3://血氧
                [self BOReloadData];
                break;
            
            case 4://體重
                [self WeightReload];
                break;
                
            case 5://計步器
                [self StepReloadDate];
                break;
                
            default:
                break;
        }
        [self.scrollView addSubview:graphView];
        
    }else
    {
        [listView reloadData];
        [graphView removeFromSuperview];
    }
}

//血壓重整資料
-(void)BPReloadData
{
    NSLog(@"reload BP");
    
    NSMutableArray *disatolicArr = [[NSMutableArray alloc] init];
    NSMutableArray *systolicArr = [[NSMutableArray alloc] init];
    NSMutableArray *hearbeatArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[dataArr count]; i++) {
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"diastolic"])
        {
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"diastolic"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [disatolicArr addObject:dic];
        }
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"systolic"])
        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"systolic"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [systolicArr addObject:dic];
        }
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"heartbeat"])
        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"heartbeat"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [hearbeatArr addObject:dic];
        }
    }
    [graphView addChart:systolicArr withName:SYSTOLIC];
    [graphView addChart:disatolicArr withName:DIASTOLIC];
    [graphView addLineWithArray:hearbeatArr withName:HEARTBEAT];
}

//血糖
-(void)BSReloadData
{
    NSMutableArray *bloodglucose = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[dataArr count]; i++) {
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"bloodglucose"])
        {
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"bloodglucose"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [bloodglucose addObject:dic];
        }
        
    }
    [graphView addChart:bloodglucose withName:BLOODGLUCOSE];
}

- (NSString*) changeDateformatter:(NSString*)strDate{
    NSString *strRes = @"";
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    NSDateFormatter *formatter2 =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm dd-MM-yyyy"];
    [formatter2 setDateFormat:@"HH:mm dd/MM eee"];
    NSDate *tmp = [formatter dateFromString:strDate];
    NSLog(@"time '%@'",strDate);
    strRes = [formatter2 stringFromDate:tmp];
    NSLog(@"strTmp %@",strRes);
    return strRes;
}


//血氧
-(void)BOReloadData
{
    NSLog(@"reload BO");
    
    NSMutableArray *oxygenArr = [[NSMutableArray alloc] init];
    NSMutableArray *hearbeatArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[dataArr count]; i++) {
        
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"oxygen"])
        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"oxygen"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [oxygenArr addObject:dic];
        }
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"heartbeat"])
        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"heartbeat"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [hearbeatArr addObject:dic];
        }
    }
    [graphView addChart:oxygenArr withName:OXYGEN];
    [graphView addLineWithArray:hearbeatArr withName:HEARTBEAT];
}

//體重
-(void)WeightReload
{
    NSMutableArray *body_fat = [[NSMutableArray alloc] init];
    NSMutableArray *weight = [[NSMutableArray alloc] init];
    
    
    
    
    for (int i=0; i<[dataArr count]; i++) {
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"body_fat"])
        {
            
            int body_fat_int = [[[dataArr objectAtIndex:i] objectForKey:@"body_fat"] integerValue]/100;
            
            
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%i",body_fat_int],@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [body_fat addObject:dic];
        }
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"weight"])
        {
            NSString *weightstr = [NSString stringWithFormat:@"%f",[[[dataArr objectAtIndex:i] objectForKey:@"weight"] floatValue]/10 ];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:weightstr,@"value",[[dataArr objectAtIndex:i] objectForKey:@"time"],@"date", nil];
            [weight addObject:dic];
        }
    }
    
//    NSLog(@"weight = %@",weight);
    
    [graphView addChart:weight withName:WEIGHT];
    [graphView addChart:body_fat withName:BODY_FAT];
}




//計步器
-(void)StepReloadDate
{
    NSLog(@"reload Step");
    NSMutableArray *stepArr = [[NSMutableArray alloc] init];
    for (int i=0; i<[dataArr count]; i++) {
        
        if ([[dataArr objectAtIndex:i] objectForKey:@"step"])
        {
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[dataArr objectAtIndex:i] objectForKey:@"step"],@"value",[[dataArr objectAtIndex:i] objectForKey:@"start"],@"date", nil];
            [stepArr addObject:dic];
        }
    }
    
    [graphView addChart:stepArr withName:STEP];
}


//設定小提醒
-(void)Set_RemindInit:(NSDictionary *)dic
{
    remindDic = dic;
    NSLog(@"remindDic %@",remindDic);
}

@end
