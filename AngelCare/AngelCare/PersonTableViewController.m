//
//  PersonTableViewController.m
//  angelcare
//
//  Created by macmini on 13/4/1.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "PersonTableViewController.h"

@interface PersonTableViewController ()

@end

@implementation PersonTableViewController
@synthesize personArray;

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
    self.title = NSLocalizedStringFromTable(@"Header_Personal", INFOPLIST, nil);
    self.tableView.separatorColor = [UIColor blackColor];
    NSLog(@"did load");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSArray *)returnArray
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"有新版軟體可供更新。",@"title",@"1小時15分鐘 前",@"subtitle",@"有新版軟體可供更新。",@"title",@"1小時30分鐘 前",@"subtitle", nil];
    
    NSArray *list = [[NSArray alloc] initWithObjects:dic,dic1,dic2,dic3,dic4,dic5, nil];
    
    return list;
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
//    NSLog(@"person count = %i",[personArray count]-1);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personArray count];
    // Return the number of rows in the section.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"personCell";
    personCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[personCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"personCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"personCell" owner:self options:nil] objectAtIndex:0];
    }
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(202/255.0) blue:(239/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    NSString *servie = [[personArray objectAtIndex:indexPath.row] objectForKey:@"service"];
    NSString *tousername = [[personArray objectAtIndex:indexPath.row] objectForKey:@"tousername"];
    NSString *time = [[personArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    cell.serviceLbl.text = [NSString stringWithFormat:@"%@ %@ %@",servie,NSLocalizedStringFromTable(@"Person_Send", INFOPLIST, nil),tousername];
    
    cell.titleLbl.text = [[personArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    cell.timeLbl.text = time;
    
    cell.contentLbl.font = [UIFont systemFontOfSize:17.0f];  //UILabel的字体大小
    cell.contentLbl.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
    cell.contentLbl.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    
    NSString *str = [[personArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
        //iOS 6 work
        size = [str sizeWithFont:cell.contentLbl.font constrainedToSize:CGSizeMake(cell.contentLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    }
    else{
        //iOS 7 related work
        //ios7 modify
        NSDictionary *attributes = @{NSFontAttributeName: cell.contentLbl.font};
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        CGRect rect = [str boundingRectWithSize:CGSizeMake(cell.contentLbl.frame.size.width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
        size = rect.size;
    }

    
    //根据计算结果重新设置UILabel的尺寸
    [cell.contentLbl setFrame:CGRectMake(cell.contentLbl.frame.origin.x, cell.contentLbl.frame.origin.y, cell.contentLbl.frame.size.width, size.height)];
    cell.contentLbl.text = str;
    
    
    int isread = [[[personArray  objectAtIndex:indexPath.row] objectForKey:@"viewstatus"] integerValue];
    
    
    if (isread == 1)
    {
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.984 green:0.913 blue:0.56 alpha:0.8];
    }else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[personArray objectAtIndex:indexPath.row] objectForKey:@"content"];
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
    
//    NSLog(@"size height = %f",size.height);
    
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
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSLog(@"Select %i",indexPath.row);
}

-(void)reloadData
{
    nowDate = [NSDate date];
    [self.tableView reloadData];
}

@end
