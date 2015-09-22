//
//  MemberViewController.h
//  AngelCare
//
//  Created by macmini on 2013/12/9.
//
//

#import <UIKit/UIKit.h>

@interface MemberViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UIScrollView *myScrollView;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
-(IBAction)cancel:(id)sender;
@end
