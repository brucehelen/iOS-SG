//
//  UserSetView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/10/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserSetView.h"
#import "MainClass.h"
#include <stdlib.h>

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

- (void)Set_Init:(id)sender SetDic:(NSDictionary *)dic
{
    MainObj = sender;

    NSLog(@"dic = %@", dic);

    // 运作中
    NSString *TValue1 = [dic objectForKey:@"time_on"];
    TValue1 = TValue1 ? TValue1 : @"";

    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedStringFromTable(@"Device_Time_on", INFOPLIST, nil), @"Name",
                          TValue1, @"Value", nil];
    
    // 关机
    NSString *powerOffTime = [dic objectForKey:@"time_off"];
    powerOffTime = powerOffTime ? powerOffTime : @"";
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedStringFromTable(@"Device_Time_off", INFOPLIST, nil), @"Name",
                          powerOffTime, @"Value", nil];

    // 关机原因
    NSInteger powerOffType = [[dic objectForKey:@"off_type"] integerValue];
    // 1, 2, 3, 4
    NSDictionary *dic3;
    if (powerOffType == 1 ||
        powerOffType == 2 ||
        powerOffType == 3 ||
        powerOffType == 4) {
        NSString *str = [NSString stringWithFormat:@"Device_Data%ld", (long)powerOffType];
        dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                NSLocalizedStringFromTable(@"Device_OffType", INFOPLIST, nil), @"Name",
                NSLocalizedStringFromTable(str, INFOPLIST, nil), @"Value", nil];
    } else {
        dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                NSLocalizedStringFromTable(@"Device_OffType", INFOPLIST, nil), @"Name",
                @"", @"Value", nil];
    }

    //同步時間
    NSString *TValue4 = [dic objectForKey:@"time_sync"];
    TValue4 = TValue4 ? TValue4 : @"";

    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedStringFromTable(@"Device_Time_sync", INFOPLIST, nil),@"Name",
                          TValue4, @"Value", nil];

    //電量
    NSString *TValue5 = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"electricity"]];
    TValue5 = TValue5 ? TValue5 : @"";

    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedStringFromTable(@"Device_Electricity", INFOPLIST, nil), @"Name",
                          TValue5, @"Value", nil];

    //手錶版本
    NSString *TValue8 = [dic objectForKey:@"FW"];
    TValue8 = TValue8 ? TValue8 : @"";

    NSDictionary *dic8 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          NSLocalizedStringFromTable(@"Device_FW", INFOPLIST, nil), @"Name",
                          TValue8, @"Value", nil];

    userSetArr = [[NSMutableArray alloc] initWithObjects:dic1, dic2, dic3, dic4, dic5, dic8, nil];

    [userSetTableView reloadData];
}

- (void)findAddressUseLat:(double)lat andLon:(double)lon
{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userSetArr count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"UserSetCell";
    UserSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UserSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSetCell_iPad" owner:self options:nil] objectAtIndex:0];
    } else {
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
    } else {
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
    [cell.lineView setFrame:CGRectMake(cell.lineView.frame.origin.x, cell.lineView.frame.origin.y, cell.lineView.frame.size.width, size.height + 20)];

    NSLog(@"%@ %@",cell.titleLbl.text,cell.infoLbl.text);
    return cell;
}

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
    } else {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(180, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            
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
    }
    
    if (size.height  < 30) {
        return size.height+30;
    }

    return size.height+30;
}

@end
