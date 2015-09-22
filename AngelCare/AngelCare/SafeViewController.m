//
//  SafeViewController.m
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "SafeViewController.h"
#import "ViewController.h"

#define DAYS NSLocalizedStringFromTable(@"Header_Days", INFOPLIST, nil)
#define HOURS NSLocalizedStringFromTable(@"Header_Hours", INFOPLIST, nil)
#define MINUTES NSLocalizedStringFromTable(@"Header_Mins", INFOPLIST, nil)
#define DAY NSLocalizedStringFromTable(@"Header_Days", INFOPLIST, nil)
#define HOUR NSLocalizedStringFromTable(@"Header_Hours", INFOPLIST, nil)
#define MINUTE NSLocalizedStringFromTable(@"Header_Mins", INFOPLIST, nil)
@interface SafeViewController ()

@end

@implementation SafeViewController
@synthesize safeArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedStringFromTable(@"Header_Safe", INFOPLIST, nil);
    nowDate = [NSDate date];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    nowDateInt = [nowDate timeIntervalSince1970]*1;
    
    NSLog(@"now date = %i",nowDateInt);
    
//    safeArray = [self returnArray];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [safeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SafeCell";
    SafeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[SafeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SafeCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SafeCell" owner:self options:nil] objectAtIndex:0];
    }
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(202/255.0) blue:(239/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    // Configure the cell...
//    cell.textLabel.text = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.titleLbl.text = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    CGSize size;
    NSString *str = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
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

        
    }else
    {
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
    /*
     CGSize size = [str sizeWithFont:cell.titleLbl.font constrainedToSize:CGSizeMake(cell.titleLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
     */
    
    
    [cell.titleLbl setFrame:CGRectMake(cell.titleLbl.frame.origin.x, cell.titleLbl.frame.origin.y, cell.titleLbl.frame.size.width, size.height+30)];
    
    [cell.subtitleLbl setFrame:CGRectMake(cell.titleLbl.frame.origin.x, size.height+20, cell.subtitleLbl.frame.size.width, cell.subtitleLbl.frame.size.height)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [cell.titleLbl setFrame:CGRectMake(cell.titleLbl.frame.origin.x, cell.titleLbl.frame.origin.y, cell.titleLbl.frame.size.width, size.height)];
    }
    //根据计算结果重新设置UILabel的尺寸

    
    NSString *msgTime = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"datatime"];
    NSDate *msgDate = [formatter dateFromString:msgTime];
    int msgInt = [msgDate timeIntervalSince1970]*1;
    
    NSLog(@"date time %i - %i = %i",nowDateInt ,msgInt,nowDateInt-msgInt);
    
    int dayInt;
    int hoursInt;
    int minutesInt;
    
    dayInt = (nowDateInt - msgInt)/60/60/24;
    hoursInt = ((nowDateInt -msgInt) - (dayInt*60*60*24))/60/60;
    minutesInt = ((nowDateInt -msgInt) - (dayInt*60*60*24) - (hoursInt*60*60))/60;
    
    NSString *detailStr;
    if (dayInt != 0)
    {
        if (dayInt > 7) {
            
            detailStr = [NSString stringWithFormat:@"%@",msgTime];
            
        }else if (dayInt > 1) {
            detailStr = [NSString stringWithFormat:@"%i %@",dayInt,DAYS];
        }else
        {
            detailStr = [NSString stringWithFormat:@"%i %@",dayInt,DAY];
        }
//        detailStr = [NSString stringWithFormat:@"%i %@ %i %@ %i %@",dayInt,DAYS,hoursInt,HOURS,minutesInt,MINUTES];
        
    }else if (hoursInt != 0)
    {
        if (hoursInt >1) {
            detailStr = [NSString stringWithFormat:@"%i %@",hoursInt,HOURS];
        }else
        {
            detailStr = [NSString stringWithFormat:@"%i %@",hoursInt,HOUR];
        }

    }else
    {
        if (minutesInt > 1) {
            detailStr = [NSString stringWithFormat:@"%i %@",minutesInt,MINUTES];
        }else
        {
            detailStr = [NSString stringWithFormat:@"%i %@",minutesInt,MINUTE];
        }
        
    }
    
    cell.subtitleLbl.text = detailStr;
    cell.subtitleLbl.backgroundColor = [UIColor clearColor];
    cell.titleLbl.backgroundColor = [UIColor clearColor];
    
    /*
    cell.detailTextLabel.text = detailStr;
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
     */
    
    NSString *isRead = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"read"];
    
    if ([isRead isEqualToString:@"1"]) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.984 green:0.913 blue:0.56 alpha:0.8];
    }else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[safeArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    CGSize size;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize BOLIVIASize = CGSizeMake(207, MAXFLOAT);
        
        
        CGRect textRect;
        
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            textRect = [str boundingRectWithSize:BOLIVIASize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
                                         context:nil];
            size = textRect.size;
        }

        
        
        
        //ios7 modify
        
        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        {
//            size = [str boundingRectWithSiz:BOLIVIASize
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}
//                                     context:nil].size;
//            return size.height+20;
//        }
    }else
    {
        //ios7 modify
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};

        
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            CGRect rect = [str boundingRectWithSize:CGSizeMake(207, MAXFLOAT)
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
        return size.height+40;
    }
    
    return size.height+40;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"MainObj = %@",MainObj);
    
    //判斷定位失敗
    NSLog(@"判斷定位失敗");
    NSDictionary *dict = [safeArray objectAtIndex:indexPath.row] ;
    NSString *lat = [NSString stringWithFormat:@"%@",[dict objectForKey:@"latitude"]];
    NSString *lon = [NSString stringWithFormat:@"%@",[dict objectForKey:@"longitude"]];
    if ( ( (!lat.length && !lon.length) )) {
        [self showNoLocationData];
    }
    else{
        [(ViewController *)MainObj ShowSafe:[safeArray objectAtIndex:indexPath.row]];
    }
}

- (void)showNoLocationData{
//    if ([UIAlertController class]) {
////        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedStringFromTable(@"Reminder", INFOPLIST, nil) message:@"No Location Data" preferredStyle:UIAlertControllerStyleAlert];
////        
////        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
////            
////        }];
////        
////        [alert addAction:okAction];
////        
////        UIViewController *tmp = (UIViewController*)[[self nextResponder]nextResponder];
////        [tmp presentViewController:alert animated:YES completion:nil];
//        
//    }
//    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Reminder", INFOPLIST, nil) message:@"No Location Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
//    }
}

-(void)Do_Init:(id)sender
{
    MainObj = sender;
}


-(void)reloadData
{
    nowDate = [NSDate date];
    nowDateInt = [nowDate timeIntervalSince1970]*1;
    [self.tableView reloadData];
}


@end
