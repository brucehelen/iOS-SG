//
//  MyDatePickerView.m
//  Project_OldAngel
//
//  Created by Lion User on 12/9/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyDatePickerView.h"
#import "MainClass.h"

@implementation MyDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetDate:(NSString *)DateStr
{
    
    
}



//跳出提醒alert 的 確定與取消mousedown觸發
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   
{
    
    if (buttonIndex == 0) 
    {
        NSLog(@"Cancel Tapped.");
    }
    else if (buttonIndex == 1) 
    {
        [(MainClass *) MainObj Send_SaveData:SaveNum:SaveMessage:IsOn];
    }
    
    
}

//確定與取消mousedown觸發
- (IBAction)Main_MouseDown:(id)sender
{
    
    
    if(sender == MyOk)
    {
      //  [(MainClass *) MainObj Other_MouseDown:71];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss "];
        NSString *dateString = [dateFormat stringFromDate:MyPick.date];
        
        
        double tmpSub = 0;
        
        //只採用最新筆資料前6天
        tmpSub = [MyPick.date timeIntervalSince1970] - [ [NSDate date] timeIntervalSince1970]; 

        UIAlertView *alert;

        if (tmpSub < 0) {
            alert = [[UIAlertView alloc] initWithTitle:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_TITLE]
                                               message: [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_ERRORSET]
                                              delegate: self
                                     cancelButtonTitle:[(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_CLOSE]
                                     otherButtonTitles: nil];
            [alert show];
            return;
        }

        NSArray *arr = [dateString componentsSeparatedByString:@" "];
        
        NSArray *arr2 = [ [arr objectAtIndex:1] componentsSeparatedByString:@":"];

         //時間提醒 以免設定 晚上9～早上6會吵到人
        if(  ( [[arr2 objectAtIndex:0] intValue] < 6 ) || ( [[arr2 objectAtIndex:0] intValue] > 21 ))
        {
            SaveMessage = [NSString stringWithFormat:@"%@",dateString];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                  [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_TITLE]
                                                            message:
                                  [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_PICK]
                                  delegate
                                                                   : self cancelButtonTitle:
                                  [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_CANCEL]
                                                  otherButtonTitles:  [(MainClass *) MainObj Get_DefineString:ALERT_MESSAGE_OK], nil];
            
            
            
            [alert show];
            
        }
        else
        {
            [(MainClass *) MainObj Send_SaveData:SaveNum:dateString:IsOn];
        
        }

        
        
    }
    else if( sender == MyCancel )
    {
        [(MainClass *) MainObj Other_MouseDown:72];
        
    }
    
    
}

//  初始化Ｖiew 上的設定
-(void)Do_Init:(id)sender
{
    MainObj = sender;
    MyPick.minuteInterval = 5;
    
}

//設定提示欄內容

-(void)Set_Label:(int)SetNum:(NSString *)DateStr:(BOOL)On
{
    SaveNum =SetNum;
    
    IsOn = On;
    
    
   // if(DateStr.length >4)
    if(FALSE)
    {
        
        NSDateFormatter *tempFormatter;
 
        tempFormatter =  [[NSDateFormatter alloc]init] ;
        [tempFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *startdate2 = [tempFormatter dateFromString:DateStr];
        
        
        [MyPick setDate:startdate2];

    }
    else
    {
        [MyPick setDate:[NSDate date] ];
    }
    
    
    switch (SetNum) 
    {
        case 1:
            
            [MyLabel setText:[(MainClass *) MainObj Get_DefineString:MESSAGE_DATA_SEL1]];

            break;
            
        case 2:
            
            [MyLabel setText:[(MainClass *) MainObj Get_DefineString:MESSAGE_DATA_SEL2]];
            
            break;            
            
        default:
            break;
    }
    
    
}

@end
