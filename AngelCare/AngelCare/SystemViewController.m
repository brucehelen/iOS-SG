//
//  SystemViewController.m
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "SystemViewController.h"

#define DAYS NSLocalizedStringFromTable(@"Header_Days", INFOPLIST, nil)
#define HOURS NSLocalizedStringFromTable(@"Header_Hours", INFOPLIST, nil)
#define MINUTES NSLocalizedStringFromTable(@"Header_Mins", INFOPLIST, nil)
#define DAY NSLocalizedStringFromTable(@"Header_Day", INFOPLIST, nil)
#define HOUR NSLocalizedStringFromTable(@"Header_Hour", INFOPLIST, nil)
#define MINUTE NSLocalizedStringFromTable(@"Header_Min", INFOPLIST, nil)
@interface SystemViewController ()

@end

@implementation SystemViewController
@synthesize systemArray;

NSURLConnection *System_Connect;
NSMutableData *System_tempData;    //下載時暫存用的記憶體
long System_expectedLength;        //檔案大小


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
    self.title = NSLocalizedStringFromTable(@"Header_System", INFOPLIST, nil);
    
    nowDate = [NSDate date];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    nowDateInt = [nowDate timeIntervalSince1970]*1;
    [self.tableView reloadData];
//    systemArray = [self returnArray];
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
    return [systemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SystemCell";
    SystemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if(cell == nil)
    {
        cell = [[SystemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SystemCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SystemCell" owner:self options:nil] objectAtIndex:0];
    }
    
    // Configure the cell...
//    cell.textLabel.text = [self GetAllTitleEditorName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditorName"] AndAction:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Action"] integerValue] EditedName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditedName"] Function:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Function"] integerValue]];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(202/255.0) blue:(239/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    cell.titleLbl.text = [self GetAllTitleEditorName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditorName"] AndAction:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Action"] integerValue] EditedName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditedName"] Function:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Function"] integerValue]];
    
    NSString *msgTime = [[systemArray objectAtIndex:indexPath.row] objectForKey:@"Time"];
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
    
    CGSize size;
    NSString *str = [self GetAllTitleEditorName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditorName"] AndAction:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Action"] integerValue] EditedName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditedName"] Function:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Function"] integerValue]];
    
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
    
    
    cell.subtitleLbl.text = detailStr;
    cell.subtitleLbl.backgroundColor = [UIColor clearColor];
    cell.titleLbl.backgroundColor = [UIColor clearColor];
    
    if ([[[systemArray objectAtIndex:indexPath.row] objectForKey:@"read"] isEqualToString:@"1"]) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.984 green:0.913 blue:0.56 alpha:0.8];
    }else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    
    return cell;
}

-(void)reloadData
{
    nowDate = [NSDate date];
    nowDateInt = [nowDate timeIntervalSince1970]*1;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self GetAllTitleEditorName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditorName"] AndAction:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Action"] integerValue] EditedName:[[systemArray objectAtIndex:indexPath.row] objectForKey:@"EditedName"] Function:[[[systemArray objectAtIndex:indexPath.row] objectForKey:@"Function"] integerValue]];
    
    CGSize size;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        CGSize BOLIVIASize = CGSizeMake(207, MAXFLOAT);
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
//            return size.height+20;
//        }
    }else
    {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]};
        if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
            //iOS 6 work
            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(207, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        else{
            //iOS 7 related work
            //ios7 modify
            
            // NSString class method: boundingRectWithSize:options:attributes:context is
            // available only on ios7.0 sdk.
            CGRect rect = [str boundingRectWithSize:CGSizeMake(207, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
            size = rect.size;

            
        }

        
        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//        {
//            CGRect tmp = [str boundingRectWithSize:CGSizeMake(607, MAXFLOAT)
//                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                         attributes:attributes
//                                            context:nil];
//            size = tmp.size;
////            size = [str sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(607, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        }
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


-(NSString *)GetAllTitleEditorName:(NSString *)editorName AndAction:(int)act EditedName:(NSString *)editedName Function:(int)fun
{
    NSString *funStr;
    NSString *actStr;
    switch (fun) {
        case 0:
            funStr = NSLocalizedStringFromTable(@"System_Event0", INFOPLIST, nil);
            break;
        case 1:
            funStr = NSLocalizedStringFromTable(@"System_Event1", INFOPLIST, nil);
            break;
            
        case 2:
            funStr = NSLocalizedStringFromTable(@"System_Event2", INFOPLIST, nil);
            break;
            
        case 3:
            funStr = NSLocalizedStringFromTable(@"System_Event3", INFOPLIST, nil);
            break;
            
        case 4:
            funStr = NSLocalizedStringFromTable(@"System_Event4", INFOPLIST, nil);
            break;
            
        case 5:
            funStr = NSLocalizedStringFromTable(@"System_Event5", INFOPLIST, nil);
            break;
            
        case 6:
            funStr = NSLocalizedStringFromTable(@"System_Event6", INFOPLIST, nil);
            break;
            
        case 7:
            funStr = NSLocalizedStringFromTable(@"System_Event7", INFOPLIST, nil);
            break;
            
        case 8:
            funStr = NSLocalizedStringFromTable(@"System_Event8", INFOPLIST, nil);
            break;
            
        case 9:
            funStr = NSLocalizedStringFromTable(@"System_Event9", INFOPLIST, nil);
            break;
            
        case 10:
            funStr = NSLocalizedStringFromTable(@"System_Event10", INFOPLIST, nil);
            break;
            
        case 11:
            funStr = NSLocalizedStringFromTable(@"System_Event11", INFOPLIST, nil);
            break;
            
        case 12:
            funStr = NSLocalizedStringFromTable(@"System_Event12", INFOPLIST, nil);
            break;
    }
    
    switch (act) {
        case 0:
            actStr = NSLocalizedStringFromTable(@"System_Act0", INFOPLIST, nil);
            break;
        
        case 1:
            actStr = NSLocalizedStringFromTable(@"System_Act1", INFOPLIST, nil);
            break;
            
        case 2:
            actStr = NSLocalizedStringFromTable(@"System_Act2", INFOPLIST, nil);
    }
    
    if([NSLocalizedStringFromTable(@"LANGUAGE", INFOPLIST, nil) isEqualToString:@"0"])
    {
//        “X” has updated the hardware settings of “X” ‘s device
        return [NSString stringWithFormat:@"%@ %@%@ %@ %@%@",editorName,NSLocalizedStringFromTable(@"System_Msg0", INFOPLIST, nil),actStr,funStr,editedName,NSLocalizedStringFromTable(@"System_Msg1", INFOPLIST, nil)];
        
    }else
    {
       return [NSString stringWithFormat:@"%@ %@%@ %@ %@ %@",editorName,NSLocalizedStringFromTable(@"System_Msg0", INFOPLIST, nil),actStr,editedName,NSLocalizedStringFromTable(@"System_Msg1", INFOPLIST, nil),funStr];
    }
    
}





/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPathF
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
