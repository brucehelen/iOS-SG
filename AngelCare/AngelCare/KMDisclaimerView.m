//
//  KMDisclaimerView.m
//  3GSW
//
//  Created by bruce-zhu on 15/11/11.
//
//

#import "KMDisclaimerView.h"

#define EDGE_OFFSET 10

@interface KMDisclaimerView()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation KMDisclaimerView

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        [self.scrollView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:10];
        _contentLabel.numberOfLines = 0;
    }

    return _contentLabel;
}

- (void)do_init:(id)sender
{
    // 设置主题内容
    self.contentLabel.text = NSLocalizedStringFromTable(@"DisclaimerContent", INFOPLIST, nil);
    CGRect rect = [self.contentLabel.text boundingRectWithSize:CGSizeMake(self.scrollView.bounds.size.width - 2*EDGE_OFFSET, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}
                                                       context:nil];
    self.contentLabel.frame = CGRectMake(EDGE_OFFSET, EDGE_OFFSET*3, rect.size.width, ceil(rect.size.height));
    
    self.scrollView.contentSize = CGSizeMake(0, EDGE_OFFSET*3+self.contentLabel.frame.size.height + EDGE_OFFSET);
}

@end
