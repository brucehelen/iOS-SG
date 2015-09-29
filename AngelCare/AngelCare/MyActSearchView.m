//
//  MyActSearchView.m
//  3GSW
//
//  Created by MissionHealth on 15/9/29.
//
//

#import "MyActSearchView.h"
#import "MainClass.h"

@interface MyActSearchView()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end


@implementation MyActSearchView

#pragma mark - 取消和确定
- (IBAction)btnDidClicked:(UIButton *)sender
{
    [self.mainClass searchResultButtonDidClicked:(int)sender.tag date:self.datePicker.date];
}


@end
