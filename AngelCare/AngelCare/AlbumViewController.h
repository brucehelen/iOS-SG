//
//  AlbumViewController.h
//  AngelCare
//
//  Created by macmini on 13/7/4.
//
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,strong) IBOutlet UIImageView *photoPickImg;

-(void)setPhoto:(UIImage *)image;
@end
