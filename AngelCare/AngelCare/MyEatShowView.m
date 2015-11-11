//
//  MyEatShowView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyEatShowView.h"
#import "MainClass.h"

@implementation MyEatShowView
{
    NSMutableArray *weekOn;
}
@synthesize listView;

#define MON NSLocalizedStringFromTable(@"Mon", INFOPLIST, nil)
#define TUE NSLocalizedStringFromTable(@"Tue", INFOPLIST, nil)
#define WED NSLocalizedStringFromTable(@"Wed", INFOPLIST, nil)
#define THE NSLocalizedStringFromTable(@"The", INFOPLIST, nil)
#define FRI NSLocalizedStringFromTable(@"Fri", INFOPLIST, nil)
#define SAT NSLocalizedStringFromTable(@"Sat", INFOPLIST, nil)
#define SUN NSLocalizedStringFromTable(@"Sun", INFOPLIST, nil)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//吃藥提醒
-(void)setMedRemind:(NSArray *)arr
{
    medRemindArr = arr;
    weekArr = [[NSMutableArray alloc] init];
    weekOn = [NSMutableArray new];
    
    NSMutableArray *newMedArr = [[NSMutableArray alloc] init];
    NSString *countStr = [NSString stringWithFormat:@"0%i",[medRemindArr count]+1];
    medcount = [medRemindArr count];
    for (int i =0; i<5; i++) {
        NSString * on1 = @"NO";
        NSString * on2 = @"NO";
        NSString * on3 = @"NO";
        NSString * on4 = @"NO";
        NSString * on5 = @"NO";
        NSString * on6 = @"NO";
        NSString * on7 = @"NO";
        if ([medRemindArr count]>i) {
            [newMedArr addObject:[medRemindArr objectAtIndex:i]];
            NSString *weekStr = @"";
            NSArray *weeks = [NSArray new];;
            for (int j=1; j<=7; j++) {
                if ([[[medRemindArr objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"week%i",j]] isEqualToString:@"1"])
                {
                    
                    NSString *week;
                    switch (j) {
                        case 1:
                            week = MON;
                            on1 = @"YES";
                            break;
                            
                        case 2:
                            week = TUE;
                            on2 = @"YES";
                            break;
                            
                        case 3:
                            week = WED;
                            on3 = @"YES";
                            break;
                            
                        case 4:
                            week = THE;
                            on4 = @"YES";
                            break;
                            
                        case 5:
                            week = FRI;
                            on5 = @"YES";
                            break;
                            
                        case 6:
                            week = SAT;
                            on6 = @"YES";
                            break;
                            
                        case 7:
                            week = SUN;
                            on7 = @"YES";
                            break;
                            
                    }
                    
                    weekStr = [weekStr stringByAppendingString:week];
                    weeks = @[on1,on2,on3,on4,on5,on6,on7];
                    
                }
            }
            [weekArr addObject:weekStr];
            [weekOn addObject:weeks];
        }else
        {
            NSDictionary *defaultDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"----",@"year",@"--",@"mon",@"--",@"day",@"--",@"hour",@"--",@"min",@"N",@"on_off",countStr,@"team", nil];
            [newMedArr addObject:defaultDic];
            NSString *defaultweek = @"-------";
            [weekArr addObject:defaultweek];
            //
            NSArray *weeks = @[on1,on2,on3,on4,on5,on6,on7];
            [weekOn addObject:weeks];
        }
    }
    
    medRemindArr = newMedArr;
    
}

//回診提醒
-(void)setHosRemind:(NSArray *)arr
{
    
    hosRemindArr = arr;
    NSMutableArray *newHosArr = [[NSMutableArray alloc] init];
    NSString *countStr = [NSString stringWithFormat:@"0%i",[hosRemindArr count]+1];
    hoscount = [hosRemindArr count];
    
    for (int i =0; i<2; i++) {
        if (i<[hosRemindArr count]) {
            [newHosArr addObject:[hosRemindArr objectAtIndex:i]];
        }else
        {
            NSDictionary *defaultDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"----",@"year",@"--",@"mon",@"--",@"day",@"--",@"hour",@"--",@"min",@"N",@"on_off",countStr,@"team",@"0",@"week1",@"0",@"week2",@"0",@"week3",@"0",@"week4",@"0",@"week5",@"0",@"week6",@"0",@"week7", nil];
            [newHosArr addObject:defaultDic];
        }
    }
    hosRemindArr = newHosArr;
    NSLog(@"new Hou Arr = %@",newHosArr);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [[dataArr objectAtIndex:section] count];
    if (section == 0) {
        return [medRemindArr count];
    }else
    {
        return [hosRemindArr count];
    }
    // Return the number of rows in the section.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //    NSLog(@"person count = %i",[personArray count]-1);

    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        static NSString *CellIdentifier = @"EatRemindCell";
        EatRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (cell == nil) {
            cell = [[EatRemindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        }

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EatRemindCell_iPad" owner:self options:nil] objectAtIndex:0];
        } else {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EatRemindCell" owner:self options:nil] objectAtIndex:0];
        }

        //開啓狀態

        if ([[[medRemindArr objectAtIndex:indexPath.row] objectForKey:@"on_off"] isEqualToString:@"Y"]) {
            [cell.clockBtn setTag:[[NSString stringWithFormat:@"%i1",indexPath.row+1] integerValue]];
            [cell.clockBtn setImage:[UIImage imageNamed:@"Medicine-Pill_120_green.png"] forState:UIControlStateNormal];
            [cell.clockBtn addTarget:self action:@selector(medRemind:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [cell.clockBtn setTag:[[NSString stringWithFormat:@"%i0",indexPath.row+1] integerValue]];
            [cell.clockBtn setImage:[UIImage imageNamed:@"Medicine-Pill_120_black.png"] forState:UIControlStateNormal];
            [cell.clockBtn addTarget:self action:@selector(medRemind:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.timeLbl.text = [NSString stringWithFormat:@"%@:%@",[[medRemindArr objectAtIndex:indexPath.row] objectForKey:@"hour"],[[medRemindArr objectAtIndex:indexPath.row] objectForKey:@"min" ] ];

        cell.weekLbl.text = [weekArr objectAtIndex:indexPath.row];
        //
        NSMutableArray *weeks = [weekOn objectAtIndex:indexPath.row];
        NSArray *lbls = @[cell.lbl1,cell.lbl2,cell.lbl3,cell.lbl4,cell.lbl5,cell.lbl6,cell.lbl7];
        NSArray *txt = @[MON,TUE,WED,THE,FRI,SAT,SUN];
        for (int i = 0;  i < 7; i++) {
            UILabel *lbl = [lbls objectAtIndex:i];
            lbl.text = [txt objectAtIndex:i];
            [lbl setBackgroundColor:[UIColor lightGrayColor]];
            [[lbl layer] setCornerRadius:5.0f];
            [[lbl layer] setMasksToBounds:YES];
        }
        for (int i = 0;  i < weeks.count; i++) {
            NSString *on = [weeks objectAtIndex:i];
            UILabel *lbl = [lbls objectAtIndex:i];

            if ([on isEqualToString:@"YES"]) {
                [lbl setBackgroundColor:[UIColor colorWithRed:254/255.0 green:204/255.0 blue:79/255.0 alpha:1.0]];
            } else {
                [lbl setBackgroundColor:[UIColor lightGrayColor]];
            }
            [[lbl layer] setCornerRadius:5.0f];
            [[lbl layer] setMasksToBounds:YES];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    } else {
        if ([hosRemindArr objectAtIndex:indexPath.row]) {
            
            NSLog(@"Have hosRemindArr");
            static NSString *CellIdentifier = @"DateRemindCell";
            DateRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[DateRemindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DateRemindCell_iPad" owner:self options:nil] objectAtIndex:0];
            }else
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DateRemindCell" owner:self options:nil] objectAtIndex:0];
            }
            
            //開啓狀態
            if ([[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"on_off"] isEqualToString:@"Y"]) {
                [cell.clockBtn setTag:[[NSString stringWithFormat:@"%i1",indexPath.row+1] integerValue]];
                [cell.clockBtn setImage:[UIImage imageNamed:@"nurse_120_orange.png"] forState:UIControlStateNormal];
                [cell.clockBtn addTarget:self action:@selector(hosRemind:) forControlEvents:UIControlEventTouchUpInside];
                
            }else
            {
                [cell.clockBtn setTag:[[NSString stringWithFormat:@"%i0",indexPath.row+1] integerValue]];
                [cell.clockBtn setImage:[UIImage imageNamed:@"nurse_120_black.png"] forState:UIControlStateNormal];
                [cell.clockBtn addTarget:self action:@selector(hosRemind:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            cell.timeLbl.text = [NSString stringWithFormat:@"%@:%@",[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"hour"],[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"min" ] ];
            
            cell.dateLbl.text = [NSString stringWithFormat:@"%@/%@/%@",[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"day"],[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"mon"],[[hosRemindArr objectAtIndex:indexPath.row] objectForKey:@"year"]];
            
            
            return cell;
        }
    }

    return NULL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 40;
    }else
    {
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    
    if (section ==0) {
        titleLbl.text = NSLocalizedStringFromTable(@"EatRemind", INFOPLIST, nil);
    }else
    {
        titleLbl.text = NSLocalizedStringFromTable(@"DateRemind", INFOPLIST, nil);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        titleLbl.font = [UIFont systemFontOfSize:20];
        titleLbl.frame = CGRectMake(0, 0, 768, 40);
    }
    
//    titleLbl.backgroundColor = [UIColor colorWithRed:1 green:0.686 blue:0.1686 alpha:1];
    [titleLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    return titleLbl;
}

//吃藥提醒 開啓or關閉
//第1組關閉
//110
-(IBAction)medRemind:(id)sender
{
    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    
    int i = [[[NSString stringWithFormat:@"%i",[(UIView*)sender tag]] substringToIndex:1] integerValue]-1;
    
    if (![[[medRemindArr objectAtIndex:i] objectForKey:@"hour"]isEqualToString:@"--"]) {
        int enable = [[[NSString stringWithFormat:@"%i",[(UIView*)sender tag]] substringFromIndex:1] integerValue];
        NSLog(@"i = %i",i);
        NSLog(@"enable = %i",enable);
        NSString *enableStr;
        if (enable == 0) {
            enableStr = @"Y";
        }else
        {
            enableStr = @"N";
        }
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[medRemindArr objectAtIndex:i] objectForKey:@"hour"],@"hour",[[medRemindArr objectAtIndex:i] objectForKey:@"min"] ,@"min",[[medRemindArr objectAtIndex:i] objectForKey:@"week1"] ,@"week1",[[medRemindArr objectAtIndex:i] objectForKey:@"week2"] ,@"week2",[[medRemindArr objectAtIndex:i] objectForKey:@"week3"] ,@"week3",[[medRemindArr objectAtIndex:i] objectForKey:@"week4"] ,@"week4",[[medRemindArr objectAtIndex:i] objectForKey:@"week5"] ,@"week5",[[medRemindArr objectAtIndex:i] objectForKey:@"week6"] ,@"week6",[[medRemindArr objectAtIndex:i] objectForKey:@"week7"] ,@"week7",[[medRemindArr objectAtIndex:i] objectForKey:@"team"] ,@"s_team",enableStr ,@"on_off", nil];
        
        NSLog(@"dic = %@",dic);
        
        [(MainClass *)MainObj Send_MedRemindUpdateWith:dic];
    }else
    {
        [(MainClass *)MainObj setEatMedDic:[medRemindArr objectAtIndex:medcount]];
    }
    
    
    
}


//回診提醒 開啓or關閉
//第1組 關閉
//210
-(IBAction)hosRemind:(id)sender
{
    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    
    int i = [[[NSString stringWithFormat:@"%i",[(UIView*)sender tag]] substringToIndex:1] integerValue]-1;
    
    if (![[[hosRemindArr objectAtIndex:i] objectForKey:@"year"]isEqualToString:@"----"])
    {
        
        int enable = [[[NSString stringWithFormat:@"%i",[(UIView*)sender tag]] substringFromIndex:1] integerValue];
        NSLog(@"i = %i",i);
        NSLog(@"enable = %i",enable);
        NSString *enableStr;
        if (enable == 0) {
            enableStr = @"Y";
        }else
        {
            enableStr = @"N";
        }
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[hosRemindArr objectAtIndex:i] objectForKey:@"year"],@"year",[[hosRemindArr objectAtIndex:i] objectForKey:@"mon"],@"mon",[[hosRemindArr objectAtIndex:i] objectForKey:@"day"],@"day",[[hosRemindArr objectAtIndex:i] objectForKey:@"hour"],@"hour",[[hosRemindArr objectAtIndex:i] objectForKey:@"min"] ,@"min",[[hosRemindArr objectAtIndex:i] objectForKey:@"week1"] ,@"week1",[[hosRemindArr objectAtIndex:i] objectForKey:@"week2"] ,@"week2",[[hosRemindArr objectAtIndex:i] objectForKey:@"week3"] ,@"week3",[[hosRemindArr objectAtIndex:i] objectForKey:@"week4"] ,@"week4",[[hosRemindArr objectAtIndex:i] objectForKey:@"week5"] ,@"week5",[[hosRemindArr objectAtIndex:i] objectForKey:@"week6"] ,@"week6",[[hosRemindArr objectAtIndex:i] objectForKey:@"week7"] ,@"week7",[[hosRemindArr objectAtIndex:i] objectForKey:@"team"] ,@"s_team",enableStr ,@"on_off", nil];
        
        NSLog(@"dic = %@",dic);
        
        [(MainClass *)MainObj Send_HosRemindUpdateWith:dic];
        
    }else
    {
//        [(MainClass *)MainObj Send_HosRemindUpdateWith:dic];
    }
    
    
    
}


//update
-(void)UpdateData
{
    [listView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [(MainClass *)MainObj setEatMedDic:[medRemindArr objectAtIndex:indexPath.row]];
    } else {
        [(MainClass *)MainObj setHosDic:[hosRemindArr objectAtIndex:indexPath.row]];
    }
}


- (void)Do_Init:(id)sender
{
    MainObj = sender;
}

@end
