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

@property (nonatomic, strong) UIDatePicker *addDatePicker;

@end


@implementation MyActSearchView

- (void)awakeFromNib
{
    [super awakeFromNib];

    // 最新版的iOS必须使用代码添加UIDatePicker，否则会显示不正常
    self.addDatePicker = [[UIDatePicker alloc] init];
    self.addDatePicker.frame = CGRectMake(0, 92, 320, 216);
    self.addDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [self addSubview:self.addDatePicker];
}

#pragma mark - 取消和确定
- (IBAction)btnDidClicked:(UIButton *)sender
{
    [self.mainClass searchResultButtonDidClicked:(int)sender.tag
                                            date:self.addDatePicker.date];
}


@end
