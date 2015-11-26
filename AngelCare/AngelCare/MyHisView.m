//
//  MyHisView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/10/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyHisView.h"
#import "MainClass.h"

#define His_SOSTitle NSLocalizedStringFromTable(@"His_SOSTitle", INFOPLIST, nil)

#define His_FalldownTitle NSLocalizedStringFromTable(@"His_FalldownTitle", INFOPLIST, nil)

#define His_LeaveTitle NSLocalizedStringFromTable(@"His_LeaveTitle", INFOPLIST, nil)

#define His_CallTitle NSLocalizedStringFromTable(@"His_CallTitle", INFOPLIST, nil)


#define SOSTitle NSLocalizedStringFromTable(@"His_SOS", INFOPLIST, nil)

#define FalldownTitle NSLocalizedStringFromTable(@"His_Falldown", INFOPLIST, nil)

#define LeaveTitle NSLocalizedStringFromTable(@"His_Leave", INFOPLIST, nil)

#define CallTitle NSLocalizedStringFromTable(@"His_Call", INFOPLIST, nil)

#define GeoFence NSLocalizedStringFromTable(@"HS_GeoFence", INFOPLIST, nil)

#define TimeAlert NSLocalizedStringFromTable(@"HS_TimerAlert", INFOPLIST, nil)

#define NonActivity NSLocalizedStringFromTable(@"HS_NonActivity", INFOPLIST, nil)

@implementation MyHisView
{
    NSMutableArray *places;
}
@synthesize list,nowSelect;

- (void)Do_Init:(id)sender
{
    MainObj = sender;

    [[list layer] setCornerRadius:8.0f];
    [[list layer] setMasksToBounds:YES];

#ifdef PROGRAM_VER_ML
    [scrTitle setContentSize:CGSizeMake(641 - 107 * 2, 51)];
#else
    [scrTitle setContentSize:CGSizeMake(641 - 107 * 3, 51)];
#endif /* PROGRAM_VER_ML */

    //call record
    [img1 setFrame:CGRectMake(0, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn1 setFrame:CGRectMake(0, 0, btn1.frame.size.width, btn1.frame.size.height)];
    //fall detection
    [img2 setFrame:CGRectMake(img1.frame.origin.x+107, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn2 setFrame:CGRectMake(btn1.frame.origin.x+107, 0, btn1.frame.size.width, btn1.frame.size.height)];
    //sos call
    [img4 setFrame:CGRectMake(img2.frame.origin.x+107, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn4 setFrame:CGRectMake(btn2.frame.origin.x+107, 0, btn1.frame.size.width, btn1.frame.size.height)];
    //non activity
    [img5 setFrame:CGRectMake(img4.frame.origin.x+107, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn5 setFrame:CGRectMake(btn4.frame.origin.x+107, 0, btn1.frame.size.width, btn1.frame.size.height)];
    [img5 setHidden:YES];
    [btn5 setHidden:YES];
    //geofence
    [img6 setFrame:CGRectMake(img4.frame.origin.x+107, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn6 setFrame:CGRectMake(btn4.frame.origin.x+107, 0, btn1.frame.size.width, btn1.frame.size.height)];
    //Timer alert
    [img7 setFrame:CGRectMake(img6.frame.origin.x+107, 0, img1.frame.size.width, img1.frame.size.height)];
    [btn7 setFrame:CGRectMake(btn6.frame.origin.x+107, 0, btn1.frame.size.width, btn1.frame.size.height)];
    [img7 setHidden:YES];
    [btn7 setHidden:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (nowSelect == 5) {
        return 60;
    }

    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        titleLbl.frame = CGRectMake(0, 0, 768, 50);
    }

    NSLog(@"now select %i",nowSelect);

    switch (nowSelect) {
        default:
        case 1:
            titleLbl.text = [NSString stringWithFormat:@" %@",NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil)];
            break;
            
        case 2:
            titleLbl.text = [NSString stringWithFormat:@" %@",NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil)];
            break;
            
        case 3:
            titleLbl.text = [NSString stringWithFormat:His_LeaveTitle,NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil),NSLocalizedStringFromTable(@"His_ADDR", INFOPLIST, nil)];
            break;
            
        case 4:
            titleLbl.text = [NSString stringWithFormat:His_CallTitle,NSLocalizedStringFromTable(@"His_STARTTIME", INFOPLIST, nil),NSLocalizedStringFromTable(@"His_ENDTIME", INFOPLIST, nil),NSLocalizedStringFromTable(@"His_TELLENGTH", INFOPLIST, nil)];
            break;
        case 5:
            titleLbl.text = [NSString stringWithFormat:@" Wearer has no activity detected for\n specific time period. Time reported:"];
            break;
        case 6:
            titleLbl.text = [NSString stringWithFormat:@" %@",NSLocalizedStringFromTable(@"His_TIME", INFOPLIST, nil)];
            break;
    }

    titleLbl.layer.cornerRadius = 8.0f;
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.backgroundColor = [ColorHex colorWithHexString:@"3c3c3c"];
    titleLbl.numberOfLines = 0;
    return titleLbl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str;
    
    if (nowSelect == 4) {
        return 50;
    }
    else if ((nowSelect == 5)||(nowSelect == 6)){
        return 50;
    }
    else if (nowSelect == 3)
    {
        str = [[listArr objectAtIndex:indexPath.row] objectForKey:@"address"];
    }
    else
    {
        str = [places objectAtIndex:indexPath.row];//[[listArr objectAtIndex:indexPath.row] objectForKey:@"place"];
    }
    CGSize size;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            CGSize BOLIVIASize = CGSizeMake(207, MAXFLOAT);
            CGRect textRect = [str boundingRectWithSize:BOLIVIASize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                context:nil];
            size = textRect.size;
        }
    } else {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            //ios7 modify
            CGRect rect = [str boundingRectWithSize:CGSizeMake(207, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
            size = rect.size;
        }
    }

    if (size.height  < 30)
    {
        return size.height+30;
    }
    
    return size.height+40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    //init places mutableArray
    if (!places || ([places count] != [listArr count])) {
        NSLog(@"new places");
        places = [NSMutableArray new];
        for (int i = 0;  i < [listArr count]; i++) {
            [places addObject:@"點擊後將顯示地址"];
        }
    }
    return [listArr count];
}

- (NSString*)returnDDMMHHmm:(NSString*)string
{
    NSString *result = string;

    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nowSelect < 4) {
        NSString *cellIdentifier = @"MyHisCell";
        MyHisCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MyHisCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            NSLog(@"My His Cell iPad");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHisCell_iPad" owner:self options:nil] objectAtIndex:0];
        }
        else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHisCell" owner:self options:nil] objectAtIndex:0];
            NSLog(@"My His Cell iPhone");
        }
        
        
        if (nowSelect == 3) {
            CGSize size;
            NSString *str = [NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row] objectForKey:@"address"]];
            //iOS 7 related work
            CGSize BOLIVIASize = CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT);
            CGRect textRect = [str boundingRectWithSize:BOLIVIASize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                context:nil];
            size = textRect.size;

            //根据计算结果重新设置UILabel的尺寸
            [cell.titleLbl setFrame:CGRectMake(105, 0, 207, size.height)];
            //            [cell.viewBg setFrame:CGRectMake(105, 0, 207, size.height)];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [cell.titleLbl setFrame:CGRectMake(105, 0, 623, size.height)];
            }
            cell.titleLbl.text = str;
        }else
        {
            //求救 20140811 點擊查詢地址
            //            cell.titleLbl.userInteractionEnabled = YES;
            //            UITapGestureRecognizer *tapGesture =
            //            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findAddress:)] ;
            //            [cell.titleLbl addGestureRecognizer:tapGesture];
            
            NSString *str = [places objectAtIndex:indexPath.row];
            CGSize size;

            if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
            {
                if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
                    //iOS 6 work
                    size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                }
                else{
                    //iOS 7 related work
                    CGSize BOLIVIASize = CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT);
                    
                    CGRect textRect = [str boundingRectWithSize:BOLIVIASize
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                        context:nil];
                    
                    size = textRect.size;
                }
            } else {
                if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
                    //iOS 6 work
                    size = [str sizeWithFont:cell.titleLbl.font constrainedToSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                }
                else{
                    //iOS 7 related work
                    //ios7 modify
                    NSDictionary *attributes = @{NSFontAttributeName: cell.titleLbl.font};
                    
                    CGRect rect = [str boundingRectWithSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributes
                                                    context:nil];
                    size = rect.size;
                }
            }
            
            [cell.titleLbl setFrame:CGRectMake(cell.titleLbl.frame.origin.x, cell.titleLbl.frame.origin.y, cell.titleLbl.frame.size.width, size.height+30)];
            [cell.viewBg setFrame:CGRectMake(cell.titleLbl.frame.origin.x, cell.titleLbl.frame.origin.y + 2, cell.titleLbl.frame.size.width, size.height+24)];
            [cell.timeLbl setFrame:CGRectMake(cell.timeLbl.frame.origin.x, cell.timeLbl.frame.origin.y, cell.timeLbl.frame.size.width, size.height+30)];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [cell.titleLbl setFrame:CGRectMake(105, 0, cell.titleLbl.frame.size.width, size.height)];
            }
            //根据计算结果重新设置UILabel的尺寸
            
            cell.titleLbl.text = str;
        }
        //修正日期格式
        cell.timeLbl.text = [[listArr objectAtIndex:indexPath.row] objectForKey:@"datatime"];
        return cell;
    } else {
        NSString *cellIdentifier = @"MyHisCell2";
        MyHisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MyHisCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            NSLog(@"My His Cell2 iPad");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHisCell2_iPad" owner:self options:nil] objectAtIndex:0];
        }else
        {
            NSLog(@"My His Cell2 iPhone");
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyHisCell2" owner:self options:nil] objectAtIndex:0];
        }
        
        //        cell.startTimeLbl.text = [self returnDDMMHHmm:[[listArr objectAtIndex:indexPath.row] objectForKey:@"startTime"]];
        cell.startTimeLbl.text = [NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row] objectForKey:@"startTime"]];
        
        //        cell.endTimeLbl.text = [self returnDDMMHHmm:[[listArr objectAtIndex:indexPath.row] objectForKey:@"endTime"]];
        cell.endTimeLbl.text = [NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row] objectForKey:@"endTime"] ];
        cell.lengthLbl.text = [NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row] objectForKey:@"timeCount"]];
        if (nowSelect == 5) {
//            cell.startTimeLbl.text = [self returnDDMMHHmm:[[listArr objectAtIndex:indexPath.row] objectForKey:@"startTime"]];
            NSString *createTime = [NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row]objectForKey:@"createTime"]];
            cell.startTimeLbl.text = [NSString stringWithFormat:@" %@",createTime];
            //        cell.endTimeLbl.text = [self returnDDMMHHmm:[[listArr objectAtIndex:indexPath.row] objectForKey:@"endTime"]];
            cell.endTimeLbl.text = @"";//[[NSString stringWithFormat:@"%@",[_dict objectForKey:@"To"]] substringToIndex:5];
            cell.lengthLbl.text = @"";//[[NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row]objectForKey:@"createTime"]]substringToIndex:11];
            [cell.startTimeLbl setFrame:CGRectMake(cell.startTimeLbl.frame.origin.x+10, cell.startTimeLbl.frame.origin.y, 300, cell.startTimeLbl.frame.size.height)];
        }
        if (nowSelect == 6) {
            //GeoFence
            NSString *createTime = [[NSString stringWithFormat:@"%@",[[listArr objectAtIndex:indexPath.row]objectForKey:@"time"]]substringToIndex:19];
            cell.startTimeLbl.text = [NSString stringWithFormat:@" %@",createTime];
            cell.endTimeLbl.text = @"";
            cell.lengthLbl.text = @"";
            [cell.startTimeLbl setFrame:CGRectMake(cell.startTimeLbl.frame.origin.x+10, cell.startTimeLbl.frame.origin.y, 300, cell.startTimeLbl.frame.size.height)];
            
        }
        if (nowSelect == 7) {
            NSDictionary *dict = [listArr objectAtIndex:indexPath.row];
            NSDictionary *data = [dict objectForKey:@"alarm"];
            
            NSString *createTime = [data objectForKey:@"voice_emg_date2"];
            cell.startTimeLbl.text = [NSString stringWithFormat:@" %@",createTime];
            cell.endTimeLbl.text = @"";
            cell.lengthLbl.text = @"";
            [cell.startTimeLbl setFrame:CGRectMake(cell.startTimeLbl.frame.origin.x+10, cell.startTimeLbl.frame.origin.y, 300, cell.startTimeLbl.frame.size.height)];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test %li",(long)indexPath.row);
    NSLog(@"list = %@",[listArr objectAtIndex:indexPath.row]);

    if (nowSelect == 7) {
        NSDictionary *dict = [listArr objectAtIndex:indexPath.row];
        NSDictionary *station = [dict objectForKey:@"station"];
        NSDictionary *mark = [dict objectForKey:@"mark"];
        NSDictionary *alarm = [dict objectForKey:@"alarm"];
        NSDictionary *m_data = [dict objectForKey:@"data"];
        NSString *longitude = @"";
        NSString *latitude = @"";
        NSString *station_radius = @"0";
        NSString *time = [alarm objectForKey:@"voice_emg_date2"];
        NSMutableDictionary *res = [NSMutableDictionary new];
        NSString *location_type = [m_data objectForKey:@"location_type"];
        if (location_type) {
            [res setObject:location_type forKey:@"location_type"];
        }

        //gsm
        NSString *gsmL = @"";
        if ([station objectForKey:@"longitude"]) {
            gsmL = [NSString stringWithFormat:@"%@",[station objectForKey:@"longitude"] ];
        }
        if ([gsmL  length] != 0) {
            longitude = [NSString stringWithFormat:@"%@",[station objectForKey:@"longitude"]];
            latitude = [NSString stringWithFormat:@"%@",[station objectForKey:@"latitude"]];
            station_radius = [NSString stringWithFormat:@"%@",[station objectForKey:@"radius"]];
        }

        if (longitude.length != 0)
            [res setObject:longitude forKey:@"longitude"];
        if (latitude.length != 0)
            [res setObject:latitude forKey:@"latitude"];
        if (station_radius.length != 0)
            [res setObject:station_radius forKey:@"station_radius"];

        //gps
        NSString *gpsL = @"";
        if ([mark objectForKey:@"longitude"]) {
            gpsL = [NSString stringWithFormat:@"%@",[mark objectForKey:@"longitude"] ];
        }
        if ([gpsL  length] != 0){
            longitude = [NSString stringWithFormat:@"%@",[mark objectForKey:@"longitude"]];
            latitude = [NSString stringWithFormat:@"%@",[mark objectForKey:@"latitude"]];
        }
        if (longitude.length != 0)
            [res setObject:longitude forKey:@"longitude"];
        if (latitude.length != 0)
            [res setObject:latitude forKey:@"latitude"];
        if (station_radius.length != 0)
            [res setObject:@"0" forKey:@"station_radius"];
        
        //判斷定位失敗
        if (((longitude.length != 0) && (latitude.length != 0)) || m_data) {
            [res setObject:time forKey:@"datatime"];
            [(MainClass *)MainObj Send_HisMapdata:res];
        }
        else{
            [self showNoLocationData];
        }
    } else {
        //判斷定位失敗
        NSLog(@"判斷定位失敗");
        NSDictionary *dict = [listArr objectAtIndex:indexPath.row] ;
        NSString *lat = [NSString stringWithFormat:@"%@",[dict objectForKey:@"latitude"]];
        NSString *lon = [NSString stringWithFormat:@"%@",[dict objectForKey:@"longitude"]];
        if ( ( (!lat.length && !lon.length) )) {
            [self showNoLocationData];
        }
        else{
            [(MainClass *)MainObj Send_HisMapdata:[listArr objectAtIndex:indexPath.row]];
        }
    }
}

- (void)showNoLocationData
{
    if ([UIAlertController class]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"Reminder", INFOPLIST, nil) message:@"No Location Data" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];

        [alert addAction:okAction];

        UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
        [tmp presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Reminder", INFOPLIST, nil) message:@"No Location Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

//  設定此Ｖiew
- (void)Set_Init:(NSArray *)arr
{
    listArr = arr;
    NSLog(@"list arr = %@",listArr);
    NSLog(@"now select %i",nowSelect);
    lbl1.text = SOSTitle;
    lbl2.text = FalldownTitle;
    lbl3.text = LeaveTitle;
    lbl4.text = CallTitle;

    img1.image = [UIImage imageNamed:@"icon_his_off.png"];
    img2.image = [UIImage imageNamed:@"icon_his_off.png"];
    img3.image = [UIImage imageNamed:@"icon_his_off.png"];
    img4.image = [UIImage imageNamed:@"icon_his_off.png"];
    img5.image = [UIImage imageNamed:@"icon_his_off.png"];
    img6.image = [UIImage imageNamed:@"icon_his_off.png"];//電子圍籬
    img7.image = [UIImage imageNamed:@"icon_his_off.png"];//電子圍籬

    UIColor *m_color = [UIColor whiteColor];
    [btn1 setTitleColor:m_color forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1 setTitle:SOSTitle forState:UIControlStateNormal];

    [btn2 setTitleColor:m_color forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 setTitle:FalldownTitle forState:UIControlStateNormal];

    [btn3 setTitleColor:m_color forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn3 setTitle:LeaveTitle forState:UIControlStateNormal];

    [btn4 setTitleColor:m_color forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn4 setTitle:CallTitle forState:UIControlStateNormal];

    [btn5 setTitleColor:m_color forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn5 setTitle:NonActivity forState:UIControlStateNormal];

    [btn6 setTitleColor:m_color forState:UIControlStateNormal];
    btn6.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn6 setTitle:GeoFence forState:UIControlStateNormal];

    [btn7 setTitleColor:m_color forState:UIControlStateNormal];
    btn7.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn7 setTitle:TimeAlert forState:UIControlStateNormal];

    switch (nowSelect) {
        case 2:
            img2.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
            
        case 3:
            img3.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
            
        case 4:
            img4.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 5:
            img5.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 6://電子圍籬
            img6.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 7://電子圍籬
            img7.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 1:
        default:
            img1.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
    }

    [list reloadData];
}


//三個類別按鈕mousedown觸發
- (IBAction)His_MouseDown:(id)sender
{
    [btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    list.allowsSelection = YES;
    switch ([(UIView*)sender tag])
    {
        case 101://緊急求救
            img1.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [(MainClass *)MainObj Other_MouseDown:61];
            nowSelect = 1;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
            
        case 102://跌倒
            img2.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [(MainClass *)MainObj Other_MouseDown:62];
            nowSelect = 2;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
            
        case 103://離家紀錄
            img3.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [(MainClass *)MainObj Other_MouseDown:63];
            nowSelect = 3;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
            
        case 104://通話
            img4.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            list.allowsSelection = NO;
            [(MainClass *)MainObj Other_MouseDown:64];
            nowSelect = 4;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
        case 105://無動作
            img5.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            list.allowsSelection = NO;
            [(MainClass *)MainObj Other_MouseDown:65];
            nowSelect = 5;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
        case 106://電子圍籬
            img6.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            list.allowsSelection = NO;
            [(MainClass *)MainObj Other_MouseDown:66];
            nowSelect = 6;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
        case 107://電子圍籬
            img7.image = [UIImage imageNamed:@"icon_his_on.png"];
            [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            list.allowsSelection = YES;
            [(MainClass *)MainObj Other_MouseDown:67];
            nowSelect = 7;
            NSLog(@"select No. %li",(long)[(UIView*)sender tag]);
            break;
    }
}

//傳送已收到的Arr
- (void)sendListArr:(NSArray *)arr
{
    listArr = arr;
}


@end
