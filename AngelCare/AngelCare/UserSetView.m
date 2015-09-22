//
//  UserSetView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/10/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserSetView.h"
#import "MainClass.h"

@implementation UserSetView
{
    NSString *address;
    NSDictionary *tmpDict;
}
@synthesize userSetTableView;


-(void)Do_Init:(id)sender
{
    MainObj = sender;
}


//  初始化Ｖiew 上的設定
-(void)Set_Init:(id)sender SetDic:(NSDictionary *)dic
{
    MainObj = sender;
    
    NSLog(@"dic = %@",dic);
    
    
    //開機
    NSString *TValue1 = [dic objectForKey:@"time_on"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm
    //HH:mm dd-MM-yyyy
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSDate *date2 = [dateFormatter dateFromString:TValue1];
    
    
    NSTimeInterval late1=[date2 timeIntervalSince1970]*1;
    
    NSTimeInterval late2=[now timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *dy=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    // min = [min substringToIndex:min.length-7];
    // 秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    // min = [min substringToIndex:min.length-7];
    // 分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    // 小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600%24];
    // house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    dy = [NSString stringWithFormat:@"%d", (int)cha/86400];
    // house = [house substringToIndex:house.length-7];
    dy=[NSString stringWithFormat:@"%@", dy];
    
    
    timeString=[NSString stringWithFormat:@"%@day %@hour %@min",dy,house,min];
    
    
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Time_on", INFOPLIST, nil),@"Name",timeString,@"Value", nil];
    
    //關機
    NSString *TValue2 = [dic objectForKey:@"time_off"];
    
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Time_off", INFOPLIST, nil),@"Name",TValue2,@"Value", nil];
    
    
    //關機原因
    NSString *TValue3 = [dic objectForKey:@"off_type"];
    
    if (TValue3.length >0) {
        int int3 = [[dic objectForKey:@"off_type"] integerValue];
        
        if(int3>0 && int3 <4)
        {
            switch (int3)
            {
                case 1:
                    TValue3 = NSLocalizedStringFromTable(@"Device_Data1", INFOPLIST, nil);
                    break;
                    
                case 2:
                    TValue3 = NSLocalizedStringFromTable(@"Device_Data2", INFOPLIST, nil);
                    break;
                    
                case 3:
                    TValue3 = NSLocalizedStringFromTable(@"Device_Data3", INFOPLIST, nil);
                    break;
                    
            }
        }
        else
        {
            TValue3 = [ NSString stringWithFormat:@"%@(%d)",NSLocalizedStringFromTable(@"Device_Data4", INFOPLIST, nil), [TValue3 intValue] ];
            
        }
    }else
    {
        TValue3 = @"";
    }
    
    
    
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_OffType", INFOPLIST, nil),@"Name",TValue3,@"Value", nil];
    
    //同步時間
    NSString *TValue4 = [dic objectForKey:@"time_sync"];
    
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Time_sync", INFOPLIST, nil),@"Name",TValue4,@"Value", nil];
    
    
    
    
    //電量
    NSString *TValue5 = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"electricity"]];
    /*
    if(TValue5.length > 0)
    {
        TValue5 = [(MainClass *)MainObj changeElectricityValue:[dic objectForKey:@"electricity"]];
    }
     */
//    NSString *TValue5 = [NSString stringWithFormat:@"%.2f V",[[dic objectForKey:@"electricity"] floatValue]/1000];
    
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Electricity", INFOPLIST, nil),@"Name",TValue5,@"Value", nil];
    
    /*
    //體表溫度
    NSString *TValue6 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"psr_temp"] ];
    
    if (TValue6.length >0) {
        TValue6 = [NSString stringWithFormat:@"%@ ℃",[dic objectForKey:@"psr_temp"] ];
    }else
    {
        TValue6 = @"";
    }
    
    NSDictionary *dic6 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Psr_temp", INFOPLIST, nil),@"Name",TValue6,@"Value", nil];
    */
     
    //基地台位置
    NSString *TValue7 = @"";
    //關閉自動找地址
//    if ([address length] == 0) {
//        TValue7 = @"";
//        [self findAddressUseLat:[[dic objectForKey:@"location_lat"]doubleValue] andLon:[[dic objectForKey:@"location_lon"]doubleValue]];
//    }
//    else{
//        TValue7 = address;
//    }
    NSDictionary *dic7 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_Location", INFOPLIST, nil),@"Name",TValue7,@"Value", nil];
    
    //手錶版本
    NSString *TValue8 = [dic objectForKey:@"FW"];
    
    NSDictionary *dic8 = [[NSDictionary alloc] initWithObjectsAndKeys:NSLocalizedStringFromTable(@"Device_FW", INFOPLIST, nil),@"Name",TValue8,@"Value", nil];
    
    
    
    
//    userSetArr = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic7,dic8, nil];
    //拿掉地址
//    userSetArr = [[NSMutableArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic8, nil];
    //拿掉關機原因
    userSetArr = [[NSMutableArray alloc] initWithObjects:dic1,dic4,dic5,dic8, nil];
    
    [userSetTableView reloadData];
    
    
}

- (void)findAddressUseLat:(double)lat andLon:(double)lon{
    NSLog(@"%@,findAddressUseLat ",self);
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:lat  longitude:lon];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *tmp;
            tmp = [NSString stringWithFormat:@"%@ ,%@ ,%@ ,%@ ,%@",
                   placemark.thoroughfare,
                   placemark.subThoroughfare,
                   placemark.postalCode,
                   placemark.locality,
                   placemark.country];
            NSLog(@"address:%@",tmp);
            address = tmp;
            [self Set_Init:MainObj SetDic:tmpDict];

        }
        
        if (error) {
            NSLog(@"%@,error %@, DoAgain!",[self class],error);
            [self findAddressUseLat:lat andLon:lon];
        }
        
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //    NSLog(@"person count = %i",[personArray count]-1);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userSetArr count] ;
    // Return the number of rows in the section.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 5) {
//        return nil;
//    }
    NSString *cellIdentifier = @"UserSetCell";
    UserSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UserSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSetCell_iPad" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSetCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    CGSize size;
    CGSize namesize;
    NSString *str = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Value"];
    NSString *titlestr = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Name"];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            namesize = [titlestr sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            CGSize BOLIVIASize = CGSizeMake(cell.infoLbl.frame.size.width, MAXFLOAT);
            CGRect textRect = [str boundingRectWithSize:BOLIVIASize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                context:nil];
            
            CGSize BOLIVIANAMESize = CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT);
            CGRect nametextRect = [titlestr boundingRectWithSize:BOLIVIANAMESize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                         context:nil];
            size = textRect.size;
            namesize = nametextRect.size;
            
        }

        
        
    }else
    {
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:cell.infoLbl.font constrainedToSize:CGSizeMake(cell.infoLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            //ios7 modify
            NSDictionary *attributes = @{NSFontAttributeName: cell.infoLbl.font};
            CGRect rect = [str boundingRectWithSize:CGSizeMake(cell.infoLbl.frame.size.width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
            size = rect.size;
            
        }

        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            namesize = [titlestr sizeWithFont:cell.titleLbl.font constrainedToSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            //ios7 modify
            NSDictionary *attributes2 = @{NSFontAttributeName:cell.titleLbl.font};
            // NSString class method: boundingRectWithSize:options:attributes:context is
            // available only on ios7.0 sdk.
            CGRect rect2 = [str boundingRectWithSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes2
                                             context:nil];
            namesize = rect2.size;
            
        }

        
    }
    /*
     CGSize size = [str sizeWithFont:cell.titleLbl.font constrainedToSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
     */
    
    
    [cell.titleLbl setFrame:CGRectMake(cell.titleLbl.frame.origin.x, cell.titleLbl.frame.origin.y, cell.titleLbl.frame.size.width, size.height+30)];
    
    NSLog(@"cell infoLbl = %f size.height =%f",cell.infoLbl.frame.origin.y,size.height);
    
    [cell.infoLbl setFrame:CGRectMake(cell.infoLbl.frame.origin.x, cell.infoLbl.frame.origin.y, cell.infoLbl.frame.size.width, size.height+30)];
    
    cell.titleLbl.text = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.infoLbl.text = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Value"];
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6) {
        cell.infoLbl.text = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Value"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    [cell.bgView setFrame:CGRectMake(cell.bgView.frame.origin.x, cell.bgView.frame.origin.y, cell.bgView.frame.size.width, size.height + 20)];
//    [cell.bgView setBackgroundColor:[UIColor redColor]];
    [cell.lineView setFrame:CGRectMake(cell.lineView.frame.origin.x, cell.lineView.frame.origin.y, cell.lineView.frame.size.width, size.height + 20)];
    
    NSLog(@"%@ %@",cell.titleLbl.text,cell.infoLbl.text);
    return cell;
}
//- (NSString*)changeDateFormatWithString:(NSString*) stringDate{
//    NSString *result = @"";
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDateFormatter *dateFormatNew = [[NSDateFormatter alloc]init];
//    [dateFormatNew setDateFormat:@"dd/MM/yyyy HH:mm"];
//    NSDate *tmp = [dateFormat dateFromString:stringDate];
//    result = [dateFormatNew stringFromDate:tmp];
//    return result;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[userSetArr objectAtIndex:indexPath.row] objectForKey:@"Value"];
    
    CGSize size;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize BOLIVIASize = CGSizeMake(180, MAXFLOAT);
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            CGRect textRect = [str boundingRectWithSize:BOLIVIASize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                                context:nil];
            size = textRect.size;
            
        }

        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        {
//            size = [str boundingRectWithSize:BOLIVIASize
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
//                                     context:nil].size;
//            return size.height+45;
//        }
    }else
    {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(180, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            //ios7 modify
            
            CGRect rect = [str boundingRectWithSize:CGSizeMake(180, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
            size = rect.size;
            
        }

        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
                //iOS 6 work
                size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(607, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            else{
                //iOS 7 related work
                CGRect tmp = [str boundingRectWithSize:CGSizeMake(607, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attributes
                                               context:nil];
                size = tmp.size;
                
            }

            
            
        }
        //        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    }
    
    //NSLog(@"size height = %f",size.height);
    
    if (size.height  < 30)
    {
        return size.height+30;
    }
    
    return size.height+30;
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
