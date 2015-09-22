//
//  NewsView.m
//  AngelCare
//
//  Created by macmini on 13/8/1.
//
//

#import "NewsView.h"
#import "MainClass.h"
#import "NewsContentView.h"

@implementation NewsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)Do_Init:(id)sender
{
    MainObj = sender;
    newsArr = [[NSArray alloc] init];
}

-(void)Set_Init:(NSArray *)arr
{
    NSLog(@"dic %@",arr);
    newsArr = arr;
    /*
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://www.guidertech.com:8081/picWeb/angelcare/member/Guider-11.png",@"logo",@"標題",@"name",@"測試內文",@"drtail",@"2013-07-31",@"infoReleaseTime",@"開始時間",@"startTime",@"結束時間",@"endTime", nil];
    
    
    NSArray *tempArr = [[NSArray alloc] initWithObjects:dic, nil];
    
    
    newsArr = tempArr;
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell_iPad" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[newsArr objectAtIndex:indexPath.row] objectForKey:@"logo"]]]];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select %@",[newsArr objectAtIndex:indexPath.row]);
    [(MainClass *)MainObj NewsContent:[newsArr objectAtIndex:indexPath.row]];
    [(MainClass *)MainObj Other_MouseDown:1005];
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
