//
//  GroupMemberView.m
//  AngelCare
//
//  Created by 林 益弘 on 13/7/17.
//
//

#import "GroupMemberView.h"
#import "GroupMemberCell.h"
#import "MainClass.h"

@implementation GroupMemberView

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
    memberArray = [[NSMutableArray alloc] init];
    isShowDelAlert = NO;
    addAccView.layer.borderWidth = 5.0f;
    addAccView.layer.cornerRadius = 8.0f;
    titleBgLbl.layer.cornerRadius = 8.0f;

    addAccView.layer.borderColor = [[UIColor whiteColor] CGColor];
    addAccView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    [addBgView removeFromSuperview];
    [addAccView removeFromSuperview];
}

-(void)Set_Init:(int)nowuser
{
    lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.5; //seconds
    lpgr.delegate = self;
    [list addGestureRecognizer:lpgr];
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    NSLog(@"defaults is = %@",[defaults objectForKey:@"Type1"]);
    
    for (int i=0; i < [[defaults objectForKey:@"totalcount"] integerValue]; i++) {
        
        
        NSString *nameStr =[defaults objectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        NSString *typeStr =[defaults objectForKey:[NSString stringWithFormat:@"Type%i",i+1]];
        NSString *isUser;
        if (i == nowuser) {
            isUser = @"1";
        }else
        {
            isUser = @"0";
        }
        
        
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nameStr,@"name" ,isUser,@"now",typeStr,@"type",nil];
//        [memberArray addObject:dic];
        //擋住使用者
        NSString *tmpType = [NSString stringWithFormat:@"%@",typeStr];
        if ([tmpType isEqualToString:UserDeviceType1]||
            [tmpType isEqualToString:UserDeviceType2]) {
            [memberArray addObject:dic];
        }
    }
    
    NSLog(@"nameStr is = %@",memberArray);
    
    [list reloadData];
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:list];
    
    NSIndexPath *indexPath = [list indexPathForRowAtPoint:p];
    if (indexPath == nil){
        NSLog(@"long press on table view but not on a row");
        return;
    }
    else{
        NSLog(@"long press on table view at row %d", indexPath.row);
    }
    
    if (lpgr.state == UIGestureRecognizerStateBegan) {
        delNum = indexPath.row;
        UIAlertView *addalertView = [[UIAlertView alloc] initWithTitle: NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                               message:NSLocalizedStringFromTable(@"Personal_WatcherManager_Alarm1", INFOPLIST, nil)
                                                              delegate:self
                                                     cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                                     otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
        
        
        addalertView.tag = 2;
        
        [addalertView show];
        isShowDelAlert = YES;
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [memberArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupMemberCell";
    GroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[GroupMemberCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupMemberCell_iPad" owner:self options:nil] objectAtIndex:0];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupMemberCell" owner:self options:nil] objectAtIndex:0];
    }

    [cell.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [cell.deleteBtn setTag:indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteMember:) forControlEvents:UIControlEventTouchUpInside];
    cell.NameLbl.text = [[memberArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    if ([[[memberArray objectAtIndex:indexPath.row] objectForKey:@"now"] integerValue]==1) {
        cell.isUserImg.image = [UIImage imageNamed:@"Red_Check_mark_1.png"];
    }else
    {
        cell.isUserImg.image = [UIImage imageNamed:@""];
    }

    switch ([[[memberArray objectAtIndex:indexPath.row] objectForKey:@"type"] integerValue]) {
//        case 0:
//            cell.typeImg.image = [UIImage imageNamed:@"type00.png"];
//            break;
//        
//        case 1:
//            cell.typeImg.image = [UIImage imageNamed:@"type01.png"];
//            break;
//            
//        case 2:
//            cell.typeImg.image = [UIImage imageNamed:@"type02.png"];
//            break;
//            
//        case 3:
//            cell.typeImg.image = [UIImage imageNamed:@"type03.png"];
//            break;
//            
//        case 4:
//            cell.typeImg.image = [UIImage imageNamed:@"type04.png"];
//            break;
        default:
            cell.typeImg.image = [UIImage imageNamed:@"icon_new"];
            break;

    }

    return cell;
}




//刪除使用者
-(IBAction)deleteMember:(id)sender
{
    delNum = [(UIView*)sender tag];
    UIAlertView *addalertView = [[UIAlertView alloc] initWithTitle: NSLocalizedStringFromTable(@"ALERT_MESSAGE_TITLE", INFOPLIST, nil)
                                                           message:NSLocalizedStringFromTable(@"Personal_WatcherManager_Alarm1", INFOPLIST, nil)
                                                          delegate:self
                                                 cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                                 otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];
    
    
    addalertView.tag = 2;
    
    [addalertView show];
}



//增加使用者
-(IBAction)addMember:(id)sender;
{
    UIAlertView *addalertView = [[UIAlertView alloc] initWithTitle: NSLocalizedStringFromTable(@"NewWearer", INFOPLIST, nil)
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:kLoadString(@"ALERT_MESSAGE_CANCEL")
                                                 otherButtonTitles:NSLocalizedStringFromTable(@"ALERT_MESSAGE_OK", INFOPLIST, nil), nil];

    addalertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [addalertView textFieldAtIndex:0].placeholder = @"Username";
    [addalertView textFieldAtIndex:1].placeholder = @"Password";
    addalertView.tag = 1;
    
    [addalertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button Index = %i",buttonIndex);
    
    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            //        NSLog(@"account %@ ",[[alertView textFieldAtIndex:0] text]);
            //        NSLog(@"pwd %@ ",[[alertView textFieldAtIndex:1] text]);
            
            NSString *accStr = [[alertView textFieldAtIndex:0] text];
            NSString *pwdStr = [[alertView textFieldAtIndex:1] text];
            
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:accStr,@"account",pwdStr,@"pwd", nil];
            
            [(MainClass *)MainObj Send_AddMemberdata:dic];
        }
    }
    
    if ([alertView tag] == 2) {
        if (buttonIndex == 1) {
            
            NSLog(@"test");
            NSUserDefaults *defaults;
            defaults = [NSUserDefaults standardUserDefaults];
            NSString *accNum = [NSString stringWithFormat:@"Acc%i",delNum+1];
            NSString *accStr = [defaults objectForKey:accNum];
            
            
            NSLog(@"accStr = %@",accStr);
            [(MainClass *)MainObj Send_DelMemberdata:accStr];
//            [self DeleteUserAccount:accStr];
            isShowDelAlert = NO;
        }
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"index.path = %i",indexPath.row);
    [(MainClass *)MainObj ChangeMemberList:indexPath.row];
}

-(void)reloadData:(int)nowuser
{
    memberArray = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"totalcount is = %i",[[defaults objectForKey:@"totalcount"] integerValue]);
    
    for (int i=0; i < [[defaults objectForKey:@"totalcount"] integerValue]; i++) {
        
        
        NSString *nameStr =[defaults objectForKey:[NSString stringWithFormat:@"Name%i",i+1]];
        NSString *typeStr =[defaults objectForKey:[NSString stringWithFormat:@"Type%i",i+1]];
        NSString *isUser;
        if (i == nowuser) {
            isUser = @"1";
        }else
        {
            isUser = @"0";
        }
        
        
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:nameStr,@"name" ,isUser,@"now",typeStr,@"type",nil];
//        [memberArray addObject:dic];
        //擋住使用者
        if ([typeStr isEqualToString:UserDeviceType1]||
            [typeStr isEqualToString:UserDeviceType2]) {
            [memberArray addObject:dic];
        }

    }
    
    NSLog(@"nameStr is = %@",memberArray);
    
    [list reloadData];
}

//新增模式
-(void)addTypeSelect
{
    [self addSubview:addBgView];
    [self addSubview:addAccView];
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         addAccView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         addAccView.alpha = 0.5;
     }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
    
}

- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         addAccView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         addAccView.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}


- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         addAccView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         addAccView.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
}

- (void)animationStoped
{
    
}

//選擇新增帳號視窗關閉
-(IBAction)closeBtnClick:(id)sender
{
    addAccView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    [addAccView removeFromSuperview];
    [addBgView removeFromSuperview];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 60;
    }
    
    return 44;
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
