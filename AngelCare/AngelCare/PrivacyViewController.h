//
//  PrivacyViewController.h
//  AngelCare
//
//  Created by macmini on 2013/12/9.
//
//

#import <UIKit/UIKit.h>

@interface PrivacyViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UIScrollView *myScrollView;
}

-(IBAction)cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
