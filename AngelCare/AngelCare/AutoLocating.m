//
//  AutoLocating.m
//  3GSW
//
//  Created by Roger on 2015/3/30.
//
//

#import "AutoLocating.h"
#import "AutoLocatingCell.h"
#import "MainClass.h"

@implementation AutoLocating
{
    id  MainObj;
}

- (void)Do_init:(id)sender
{
    MainObj = sender;

    self.locatingTableView.backgroundColor = [UIColor whiteColor];
    [self.locatingTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = @"Cell";
    AutoLocatingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell) {//無任何cell可以reuse
        cell = [[AutoLocatingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSLog(@"%@  xxx %d",[self.data objectAtIndex:indexPath.row],[self.data objectAtIndex:indexPath.row] != [NSNull null]);
    if ([self.data objectAtIndex:indexPath.row] != [NSNull null]) {//有資料
        NSDictionary *m_dict = [self.data objectAtIndex:indexPath.row];
        //set gray
        [cell.bgView setBackgroundColor:[UIColor lightGrayColor]];
        //hide creatLabel
        [cell.createTitleLabel setHidden:YES];

        //show name,address
        [cell.nameLabel setHidden:NO];
        [cell.nameTitleLabel setHidden:NO];
        cell.nameTitleLabel.text = @"名称：";
        [cell.addressLabel setHidden:NO];
        [cell.addressTitleLabel setHidden:NO];
        cell.addressTitleLabel.text = @"地址：";

        //
        cell.nameLabel.text = [m_dict objectForKey:@"title"];
        cell.addressLabel.text = [m_dict objectForKey:@"address"];
    }
    else
    {
        //set white
        [cell.bgView setBackgroundColor:[UIColor whiteColor]];
        //hide name,address
        [cell.nameLabel setHidden:YES];
        [cell.nameTitleLabel setHidden:YES];
        [cell.addressLabel setHidden:YES];
        [cell.addressTitleLabel setHidden:YES];
        //show creatLabel
        [cell.createTitleLabel setHidden:NO];
//        cell.createTitleLabel.text = @"建立定位点";
        cell.createTitleLabel.text = @"create";
        //make raduis of corner
        [[cell.createTitleLabel layer] setCornerRadius:10]; // THIS IS THE RELEVANT LINE
        [cell.createTitleLabel.layer setMasksToBounds:YES]; ///missing in your code
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    AutoLocatingCell *cell = (AutoLocatingCell*)[tableView cellForRowAtIndexPath:indexPath];
    [(MainClass*)MainObj setAutoLocatingName:cell.nameLabel.text];
    [(MainClass*)MainObj setLocatingEditIndex:[NSString stringWithFormat:@"%d",(int)indexPath.row+1]];
    [(MainClass*)MainObj Change_State:IF_LocatingEdit];
}

@end
