//
//  KMFreqQuestionDetailView.m
//  3GSW
//
//  Created by bruce-zhu on 15/11/5.
//
//

#import "KMFreqQuestionDetailView.h"
#import "MainClass.h"
#import "KMFAQModel.h"

#define EDGE_OFFSET 10

@interface KMFreqQuestionDetailView()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UILabel *answerLabel;

@end

@implementation KMFreqQuestionDetailView

- (void)awakeFromNib
{
    self.questionLabel = [[UILabel alloc] init];
    [self.scrollView addSubview:self.questionLabel];
    self.questionLabel.textAlignment = NSTextAlignmentCenter;
    self.questionLabel.font = [UIFont boldSystemFontOfSize:15];
    self.questionLabel.numberOfLines = 0;
    
    self.answerLabel = [[UILabel alloc] init];
    [self.scrollView addSubview:self.answerLabel];
}

- (void)do_init:(KMFAQModel *)model
{
    self.questionLabel.text = model.question;

    CGRect rect = [model.question boundingRectWithSize:CGSizeMake(self.scrollView.bounds.size.width - 2*EDGE_OFFSET, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]}
                                               context:nil];
    self.questionLabel.frame = CGRectMake(EDGE_OFFSET, EDGE_OFFSET*3, ceil(rect.size.width) + 5, ceil(rect.size.height));

    rect = [model.answer boundingRectWithSize:CGSizeMake(self.scrollView.bounds.size.width - 2*EDGE_OFFSET, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                      context:nil];
    self.answerLabel.frame = CGRectMake(EDGE_OFFSET,
                                        EDGE_OFFSET*3 + self.questionLabel.frame.size.height + 10,
                                        rect.size.width,
                                        ceil(rect.size.height));
    self.answerLabel.font = [UIFont systemFontOfSize:14];
    self.answerLabel.text = model.answer;
    self.answerLabel.numberOfLines = 0;

    self.scrollView.contentSize = CGSizeMake(0, EDGE_OFFSET*4 + 10 + self.answerLabel.frame.size.height + EDGE_OFFSET);
}

@end
