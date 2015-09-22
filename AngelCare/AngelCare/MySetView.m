//
//  MySetView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MySetView.h"
#import "MainClass.h"


@implementation MySetView


-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if( scrollView.contentOffset.y <0)
    {
        [scrollView setContentOffset:CGPointZero
                            animated:NO];        
        
    }
    else
    {
        if( scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height ) )
        {
            [scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height - scrollView.frame.size.height)
                                animated:NO];   
        }  
    }
    
    
    
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
    }
    return self;
}

//跳出提醒alert 的 確定與取消mousedown觸發
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   
{
    if (buttonIndex == 0)
        return; //Cancel

    if(alertView.tag ==2)
    {
       
        [ (MainClass *)MainObj Del_User:[Array_UserDate objectAtIndex:DelNum] ];
        
    }
    else
    {
        
        NSLog(@"send");
        
        [ (MainClass *)MainObj Add_User: [[alertView textFieldAtIndex:0] text]: [[alertView textFieldAtIndex:1] text] ];    
    }
    

 
    
}

-(void)awakeFromNib
{
    
    
   
    Array_UserDate = [[NSMutableArray alloc] init];
    Array_UserDate = [NSMutableArray arrayWithCapacity:100];
    
    
    myScrollView.delegate = self;
    
    
    
    CGRect  NewRect2;
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        NewRect2 = CGRectMake(0, 0, 320, 201);
        myListScrollView.contentSize  =  NewRect2.size;
    }
    else
    {
        NewRect2 = CGRectMake(0, 0, 641, 441);
        myListScrollView.contentSize  =  NewRect2.size;
    }
    
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateDisabled];
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
    
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateDisabled];
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
    
    
}

-(IBAction)Set_Google:(id)sender
{
    NSLog(@"set 0");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:0 forKey:@"MAP_TYPE"];
    [defaults synchronize];
    

    
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateDisabled];
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
    
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateDisabled];
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
    
    
    [(MainClass *) MainObj Set_Google:0];
    
    
}


-(IBAction)Set_Baduio:(id)sender
{
    
    NSLog(@"set 1");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:1 forKey:@"MAP_TYPE"];
    [defaults synchronize];
    
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateDisabled];
    [Bu_Google setImage:[UIImage imageNamed:@"my_bu_1.png"] forState:UIControlStateNormal];
    
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateDisabled];
    [Bu_Ba setImage:[UIImage imageNamed:@"my_bu_2.png"] forState:UIControlStateNormal];
    
     [(MainClass *) MainObj Set_Google:1];
    
}


//設定佩帶者Input Alert 提示
-(IBAction)Set_MouseDown:(id)sender
{
    
    MyalertView = [[UIAlertView alloc] initWithTitle: @" "
                                             message:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_TITLE_INPUT]
                                            delegate:self
                                   cancelButtonTitle:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_CANCEL]
                                   otherButtonTitles:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_OK], nil];
    
    MyalertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    MyalertView.tag = 1;
    
    
    [MyalertView show];  
    
    
}


//使用者 mousedown觸發
-(void)displayvalue:(id)sender
{       
    
    UIButton *tmpBu;
    
    tmpBu= (UIButton *)sender;
    
    
    int DataNum = tmpBu.tag;
    
    if(DataNum>=100)
    {
        NSLog(@"Down %d",1+DataNum%100);
        
        
        [ (MainClass *)MainObj Set_Go:DataNum%100 ];
        [(MainClass *)MainObj Send_UpdateUserName];
    }
    else
    {
        
        //確定使用者是否要刪除使用者
        
        MyalertView = [[UIAlertView alloc] initWithTitle: [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_TITLE]
                                                 message:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_DELUSER]
                                                delegate:self
                                       cancelButtonTitle:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_CANCEL]
                                       otherButtonTitles:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_OK], nil];
        
        MyalertView.alertViewStyle = UIAlertViewStyleDefault;
        
        MyalertView.tag = 2;
        
        UIButton *downit;  
        downit = (UIButton *  )sender;
        
        //預計刪除的使用者
        DelNum = downit.tag-7;
        
        
        [MyalertView show];  
        
        
      
        
       
        
    }
    
    


}

//設定提示目前在哪位使用者的勾選提示在哪個位置
-(void)Set_Go:(int)SetNum
{
    if( [ (MainClass *)MainObj CheckTotal ] == true)
    {
        [MyGo setHidden:YES];
    }
    else {
        [MyGo setHidden:NO];
    }
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        MyGo.frame = CGRectMake(288, (SetNum)*40+15, 12, 12); //設定出現在螢幕上的位置跟物件大小 （X,Y,寬,高)
    }
    else
    {
        MyGo.frame = CGRectMake(598, (SetNum)*82+28, 24, 23); //設定出現在螢幕上的位置跟物件大小 （X,Y,寬,高)      
    }
}

//新增資料
-(void)Insert_Data:(NSString*)TimeDate
{
    NSString *deviceType = [UIDevice currentDevice].model;

    
    if([deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {  
        UIImageView   *imageView =[ [UIImageView alloc] initWithFrame:CGRectMake(0, TotalHei, 320, 40) ];
        
        
        [Array_UserDate addObject:TimeDate ];
        
        
        
        
        
        
        UILabel * label_1; //宣告一個UILabel ，命名為label_1
        
        label_1 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_1.frame = CGRectMake(45, TotalHei+10, 450/2, 22); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)
        label_1.text = TimeDate; //設定label_1 的顯示文字
        //ios7 modify
        label_1.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_1 setBackgroundColor:[UIColor clearColor]];
        label_1.font = [UIFont systemFontOfSize:20];
        
        label_1.tag = 7;
        
        //  [myScrollView addSubview:label_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:label_1 atIndex:0];
        
        
        
        
        
        
        
        UIButton * bu_1;
        bu_1 = [[UIButton alloc]init]; //將剛剛宣告的label_1 初始化
        bu_1.frame = CGRectMake(15, TotalHei+10, 42/2, 45/2); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y
        
        [bu_1 setBackgroundImage:[UIImage imageNamed:@"set_del_1.png"]
                        forState:UIControlStateNormal];
        
        bu_1.tag = 7+TotalHei/40;
        
        
        [bu_1 addTarget:self  
                 action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside]; 
        
        
        //[myScrollView addSubview:bu_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:bu_1 atIndex:0];
        
        UIButton * bu_2;
        bu_2 = [[UIButton alloc]init]; //將剛剛宣告的label_1 初始化
        bu_2.frame = CGRectMake(0, TotalHei, 320, 40); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y
        
        bu_2.backgroundColor = [UIColor clearColor];
        
        
        bu_2.tag = 100+TotalHei/40;
        
        NSLog(@"tag = %i",bu_2.tag);
        
        [bu_2 addTarget:self  
                 action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside];
        
        
        //[myScrollView addSubview:bu_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:bu_2 atIndex:0];
        
        
        imageView.tag = 7;
        
        imageView.image = [UIImage imageNamed:@"set_table_base.png"];
        // [myScrollView addSubview:imageView];
        [myScrollView insertSubview:imageView atIndex:0];
        
        
        
        
        
        
        TotalHei+=40;
        
        
//        CGRect  NewRect =  CGRectMake(0, 0, 320, TotalHei);
//        NSLog(@"total height = %i",TotalHei);
//        myScrollView.contentSize = NewRect.size;
        TotalUser = [MainObj countAllUser];
        NSLog(@"total = %i",TotalHei);
        myScrollView.contentSize = CGSizeMake(320, TotalUser*40);
      
        
    }
    else
    {
        UIImageView   *imageView =[ [UIImageView alloc] initWithFrame:CGRectMake(0, TotalHei, 641, 82) ];
        
        
        [Array_UserDate addObject:TimeDate ];
        
        
        
        
        
        
        UILabel * label_1; //宣告一個UILabel ，命名為label_1
        
        label_1 = [[UILabel alloc]init]; //將剛剛宣告的label_1 初始化
        label_1.frame = CGRectMake(98, TotalHei+28, 550, 30); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y,寬,高)
        label_1.text = TimeDate; //設定label_1 的顯示文字
        //ios7 modify
        label_1.textAlignment = NSTextAlignmentLeft;//UITextAlignmentLeft; //設定label_2 文字對齊方式，預設為靠左對齊
        [label_1 setBackgroundColor:[UIColor clearColor]];
        label_1.font = [UIFont systemFontOfSize:28];
        
        label_1.tag = 7;
        
        //  [myScrollView addSubview:label_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:label_1 atIndex:0];
        
        
        
        
        
        
        
        UIButton * bu_1;
        bu_1 = [[UIButton alloc]init]; //將剛剛宣告的label_1 初始化
        bu_1.frame = CGRectMake(28, TotalHei+20, 42, 45); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y
        
        [bu_1 setBackgroundImage:[UIImage imageNamed:@"set_del_1.png"]
                        forState:UIControlStateNormal];
        
        bu_1.tag = 7+TotalHei/82;
        
        
        [bu_1 addTarget:self  
                 action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside]; 
        
        
        //[myScrollView addSubview:bu_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:bu_1 atIndex:0];
        
        UIButton * bu_2;
        bu_2 = [[UIButton alloc]init]; //將剛剛宣告的label_1 初始化
        bu_2.frame = CGRectMake(0, TotalHei, 641    , 82); //設定label_1 出現在螢幕上的位置跟物件大小 （X,Y
        
        bu_2.backgroundColor = [UIColor clearColor];
        
        
        bu_2.tag = 100+TotalHei/82;
        
        
        
        [bu_2 addTarget:self  
                 action:@selector(displayvalue:)forControlEvents:UIControlEventTouchUpInside]; 
        
        
        //[myScrollView addSubview:bu_1]; //將label_1貼到self.view上
        [myScrollView insertSubview:bu_2 atIndex:0];
        
        
        imageView.tag = 7;
        
        imageView.image = [UIImage imageNamed:@"set_table_base.png"];
        // [myScrollView addSubview:imageView];
        [myScrollView insertSubview:imageView atIndex:0];
        
        
        
        
        
        
        TotalHei+=82;
        
        
//        CGRect  NewRect =  CGRectMake(0, 0, 641, TotalHei);
//        myScrollView.contentSize = NewRect.size;
        
        TotalUser = [MainObj countAllUser];
        NSLog(@"total = %i",TotalHei);
        myScrollView.contentSize = CGSizeMake(641, TotalUser*82);

    }
    
    
      
}

//新增佩帶者提示
-(void)Show_Alert
{
    if( [ (MainClass *)MainObj CheckTotal ] == true)
    {
        [MyGo setHidden:YES];
        
        MyalertView = [[UIAlertView alloc] initWithTitle: @" "
                                                 message:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_TITLE_INPUT]
                                                delegate:self
                                       cancelButtonTitle:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_CANCEL]
                                       otherButtonTitles:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_OK], nil];
        
        MyalertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        
        MyalertView.tag = 1;
        
        [MyalertView show];          
    }  
    
}

//  設定此Ｖiew 
-(void)Do_Init:(id)sender
{
    
    TotalHei =0;
    
    [Array_UserDate removeAllObjects];
    
    
    NSArray *oo = [self subviews];
    
    NSLog(@"is %d", [oo count] );
    
    for (UIView *subview in [myScrollView subviews])
    {
        if (subview.tag >= 7)
        {
            //         NSLog(@"get is %d", 1 );
            [subview removeFromSuperview];
        }
    }
    
    
    MainObj =sender;
    

    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if( [deviceType isEqualToString:@"iPhone Simulator"] || [deviceType isEqualToString:@"iPhone"])
    {
        NSString *str1 = [NSString stringWithFormat:@"        %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_1]];
        NSString *str2 = [NSString stringWithFormat:@"        %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_2]];
        NSString *str3 = [NSString stringWithFormat:@"        %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_3]];
        NSString *str4 = [NSString stringWithFormat:@"        %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_4]];
        [Bu1 setTitle:str1 forState:UIControlStateNormal];
        
        
        [Bu2 setTitle:str2 forState:UIControlStateNormal];
        
        [Bu3 setTitle:str3 forState:UIControlStateNormal];
        
        [Bu4 setTitle:str4 forState:UIControlStateNormal];       
        
        [Bu1 setTitle:str1 forState:UIControlStateDisabled];
        
        
        
        [Bu2 setTitle:str2 forState:UIControlStateDisabled];
        
        [Bu3 setTitle:str3 forState:UIControlStateDisabled];
        
               
        
        [Bu4 setTitle:str4 forState:UIControlStateDisabled];
        
        
        Text1.text= [(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP1];
        Text2.text= [(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP2];
        Text3.text =[(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP3];;
        
    }
    else
    
    {
        NSString *str1 = [NSString stringWithFormat:@"    %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_1]];
        NSString *str2 = [NSString stringWithFormat:@"    %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_2]];
        NSString *str3 = [NSString stringWithFormat:@"    %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_3]];
        NSString *str4 = [NSString stringWithFormat:@"    %@",[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_4]];
        
        [Bu1 setTitle:str1 forState:UIControlStateNormal];
        
        
        
        [Bu2 setTitle:str2 forState:UIControlStateNormal];
        
        [Bu3 setTitle:str3 forState:UIControlStateNormal];
        
        [Bu4 setTitle:str4 forState:UIControlStateNormal];         
        
        
        [Bu1 setTitle:str1 forState:UIControlStateDisabled];
        
        
        
        [Bu2 setTitle:str2 forState:UIControlStateDisabled];
        
        [Bu3 setTitle:str3 forState:UIControlStateDisabled];
        
        [Bu4 setTitle:str4 forState:UIControlStateDisabled];         
        
        Text1.text= [(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP1];
        Text2.text= [(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP2];
        Text3.text =[(MainClass *) MainObj Get_DefineString:TITLE_SET_MAP3];;
        
    }
    
    
    [AddButton setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_5] forState:UIControlStateNormal];  
     [AddButton setTitle:[(MainClass *) MainObj Get_DefineString:TITLE_SET_BU_5] forState:UIControlStateDisabled];  
    
    [self Show_Alert];
    
    
    Title1.text = [(MainClass *) MainObj Get_DefineString:TITLE_SET_TITLE_1];
    
    Title2.text = [(MainClass *) MainObj Get_DefineString:TITLE_SET_TITLE_2];
    
    

    
    

 }

//版本檢查  MouseDown𧣈發
-(IBAction)B1_MouseDown:(id)sender
{
 //   NSLog(@"down");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/angelcare-lite/id586166628?ls=1&mt=8"]];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/tw/app/toca-tailor-fairy-tales/id569631758?l=zh&mt=8"]];
}

//隱私權政策 MouseDown𧣈發
-(IBAction)B2_MouseDown:(id)sender
{
    [ (MainClass *)MainObj InsertLaw2 ];
}

//服務條款 MouseDown𧣈發
-(IBAction)B3_MouseDown:(id)sender
{
   
    [ (MainClass *)MainObj InsertLaw ];
}

//版本   MouseDown𧣈發
-(IBAction)B4_MouseDown:(id)sender
{
    
}

@end
