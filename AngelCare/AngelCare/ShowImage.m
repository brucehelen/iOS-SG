//
//  ShowImage.m
//  AngelCare
//
//  Created by macmini on 2013/12/26.
//
//

#import "ShowImage.h"
#import "ShowImageCell.h"
#import "MainClass.h"

@implementation ShowImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)Set_Init:(NSDictionary *)dic
{
    titleLbl.text = NSLocalizedStringFromTable(@"HS_ShowImage", INFOPLIST, nil);
    [titleLbl setBackgroundColor:[ColorHex colorWithHexString:@"3c3c3c"]];
    [titleLbl setTextColor:[UIColor whiteColor]];
    [showImageTable reloadData];
    if ([dic objectForKey:@"other_pic1_url"])
    {
        img_url1 = [dic objectForKey:@"other_pic1_url"];
    }
    
    if ([dic objectForKey:@"other_pic2_url"])
    {
        img_url2 = [dic objectForKey:@"other_pic2_url"];
    }
    
    if ([dic objectForKey:@"other_pic3_url"])
    {
        img_url3 = [dic objectForKey:@"other_pic3_url"];
    }
    
    if ([dic objectForKey:@"other_pic4_url"])
    {
        img_url4 = [dic objectForKey:@"other_pic4_url"];
    }
    
    imgUrlArr = [[NSArray alloc] initWithObjects:img_url1,img_url2,img_url3,img_url4, nil];
    
    NSLog(@"imgUrlArr = %@",imgUrlArr);
}




-(void)Do_Init
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ShowImageCell";
    ShowImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ShowImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    /*
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShowImageCell" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShowImageCell" owner:self options:nil] objectAtIndex:0];
    }
    */
    
    [self downloadImageWithURL:[NSURL URLWithString:[imgUrlArr objectAtIndex:indexPath.row]] completionBlock:^(BOOL succeeded, UIImage *image) {
        
        if (succeeded) {
            cell.showImageView.image = image;
        }else
        {
            cell.showImageView.image = [UIImage imageNamed:@"icon_people"];
        }
        
    }];
    
    [cell.changeBtn setTag:indexPath.row+1];
    [cell.changeBtn setTitle:NSLocalizedStringFromTable(@"HS_ShowImage_upload", INFOPLIST, nil) forState:UIControlStateNormal];
    [cell.changeBtn addTarget:self action:@selector(uploadShowPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


-(IBAction)uploadShowPhoto:(id)sender
{
    //isTestAcc
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"userAccount"]);
    if ([[defaults objectForKey:@"userAccount"] isEqualToString:@"test"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"Remind", INFOPLIST, nil) message:NSLocalizedStringFromTable(@"IsTestAcc", INFOPLIST, nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"OK", INFOPLIST, nil) otherButtonTitles: nil];
        [alert show];
        return;
    }

    NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    if ([self.delegate respondsToSelector:@selector(ShowImgClick:)])
    {
        [self.delegate ShowImgClick:[(UIView*)sender tag]];
        NSLog(@"sender tag = %i",[(UIView*)sender tag]);
    }
}


//異步下載圖片
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.cachePolicy=NSURLRequestReloadIgnoringCacheData;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   
                                   NSLog(@"return image = %@",[image description]);
                                   
                                   if (image) {
                                       completionBlock(YES,image);
                                   }else
                                   {
                                       image = [UIImage imageNamed:@"icon_user.png"];
                                       completionBlock(NO,image);
                                   }
                                   
                               } else{
                                   UIImage *image = [UIImage imageNamed:@"icon_user.png"];
                                   completionBlock(NO,image);
                               }
                           }];
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
