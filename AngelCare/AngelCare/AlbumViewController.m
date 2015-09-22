//
//  AlbumViewController.m
//  AngelCare
//
//  Created by macmini on 13/7/4.
//
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController
@synthesize picker,photoPickImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        //設定圖片來源為照相機
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.navigationBarHidden = YES;
        //設定要顯示預設的相機界面
        //        picker.showsCameraControls = YES;
        [self presentViewController:picker animated:YES completion:nil];
        
    }
     */
	// Do any additional setup after loading the view.
}


-(void)setPhoto:(UIImage *)image
{
    NSLog(@"YES");
    photoPickImg.image = image;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
