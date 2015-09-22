//
//  RouteList.m
//  AngelBaby
//
//  Created by macmini on 13/6/4.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "RouteList.h"

@implementation RouteList
@synthesize routeListArr,routeTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onMainButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(mainButtonWasPressed:)]) {
        [self.delegate mainButtonWasPressed:self];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [routeListArr count];
//    return 10;
    // Return the number of rows in the section.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RouteListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    // Configure the cell...
    /*
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    */
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1,[[routeListArr objectAtIndex:indexPath.row] objectForKey:@"time"]];
//    //修正日期格式
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSDateFormatter *dateFormatNew = [[NSDateFormatter alloc]init];
//    [dateFormatNew setDateFormat:@"dd/MM/yyyy HH:mm"];
//    NSDate *tmp = [dateFormat dateFromString:[[routeListArr objectAtIndex:indexPath.row] objectForKey:@"time"]];
//    cell.textLabel.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1,[dateFormatNew stringFromDate:tmp]];
    
    
//    tmp = [dateFormat dateFromString:watch_time];
//    watch_time = [dateFormatNew stringFromDate:tmp];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0f;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didselectCellNum:)]) {
        [self.delegate didselectCellNum:indexPath.row];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    CGRect routetableframe = routeTable.frame;
    CGRect frame = self.frame;
    if (iOSDeviceScreenSize.height == 480)
    {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.frame.size.height);
        routeTable.frame = CGRectMake(routetableframe.origin.x, routetableframe.origin.y, routetableframe.size.width, routetableframe.size.height);
    }
    
    if (iOSDeviceScreenSize.height == 568)
    {
        self.frame = frame;
       routeTable.frame = routetableframe;
    }
}


@end
