//
//  RouteList.m
//  AngelBaby
//
//  Created by macmini on 13/6/4.
//  Copyright (c) 2013年 Bill Lin. All rights reserved.
//

#import "RouteList.h"

@implementation RouteList


- (IBAction)onMainButton:(id)sender
{
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
    return _routeListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RouteListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;

    cell.textLabel.text = [NSString stringWithFormat:@"%i. %@",
                           (int)(indexPath.row+1),
                           [_routeListArr[indexPath.row] objectForKey:@"time"]];

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
        [self.delegate didselectCellNum:(int)indexPath.row];
    }
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    CGRect routetableframe = _routeTable.frame;
    CGRect frame = self.frame;
    if (iOSDeviceScreenSize.height == 480)
    {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.frame.size.height);
        _routeTable.frame = CGRectMake(routetableframe.origin.x, routetableframe.origin.y, routetableframe.size.width, routetableframe.size.height);
    }
    
    if (iOSDeviceScreenSize.height == 568)
    {
        self.frame = frame;
       _routeTable.frame = routetableframe;
    }
}

@end
