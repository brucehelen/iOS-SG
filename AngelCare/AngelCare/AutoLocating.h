//
//  AutoLocating.h
//  3GSW
//
//  Created by Roger on 2015/3/30.
//
//

#import <UIKit/UIKit.h>

@interface AutoLocating : UIView
<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *locatingTableView;
@property (strong, nonatomic) NSArray *data;

-(void)Do_init:(id)sender;

@end
