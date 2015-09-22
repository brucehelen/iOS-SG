//
//  personCell.m
//  AngelCare
//
//  Created by macmini on 13/8/15.
//
//

#import "personCell.h"

@implementation personCell
@synthesize titleLbl,contentLbl,serviceLbl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForMessage:(NSString *)message andLabel:(UILabel *)contentLbl
{
    contentLbl.font = [UIFont systemFontOfSize:17.0f];  //UILabel的字体大小
    contentLbl.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
    contentLbl.textColor = [UIColor whiteColor];
    contentLbl.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    
    
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion]intValue] < 7){
        //iOS 6 work
        size = [message sizeWithFont:contentLbl.font constrainedToSize:CGSizeMake(contentLbl.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
    else{
        //iOS 7 related work
        //ios7 modify
        NSDictionary *attributes = @{NSFontAttributeName: contentLbl.font};
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        CGRect rect = [message boundingRectWithSize:CGSizeMake(contentLbl.frame.size.width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        
        
        size = rect.size;
        
    }
    
    return size.height;
}

@end
