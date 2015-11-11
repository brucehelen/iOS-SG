//
//  KMFreqQuestionView.m
//  3GSW
//
//  Created by bruce-zhu on 15/11/5.
//
//

#import "KMFreqQuestionView.h"
#import "MainClass.h"

@interface KMFreqQuestionView() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) MainClass *mainClass;

@end

@implementation KMFreqQuestionView

- (void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)do_init:(id)sender
{
    self.mainClass = sender;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"常见问题列表";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.mainClass pushFreqQuestionDetailViewWithQuestion:@"这是个大问题" Answers:@"让暴风雨来的更猛烈些吧"];
}

@end
