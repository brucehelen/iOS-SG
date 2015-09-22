//
//  GeoCell.m
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import "GeoCell.h"
#import "ViewController.h"
#import "vcGeoFenceEdit.h"
#import "GeoFenceShow.h"
@implementation GeoCell
{
    CGPoint _originalCenter;
	BOOL _deleteOnDragRelease;
    BOOL _isLeft;
    NSDictionary *tmpD;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addGes{
    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [self addGestureRecognizer:recognizer];
}
#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation;// = [gestureRecognizer translationInView:[self superview]];
    @try {
        translation = [gestureRecognizer translationInView:[self superview]];
    }
    @catch (NSException *exception) {
        NSLog(@"error %@",exception);
    }
    @finally {
//        return  NO;
    }
    if (translation.x <0) {
        NSLog(@"Left");
        _isLeft = YES;
    }
    else{
        NSLog(@"Right");
        _isLeft = NO;
    }
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    
    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        _originalCenter = self.center;
    }
    
    // 2
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        _deleteOnDragRelease = self.frame.origin.x < 0;//self.frame.size.width * (1/2);
        
    }
    
    // 3
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (!_isLeft) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = originalFrame;
                             }
             ];
        }
        CGRect RoriginalFrame = CGRectMake(-140, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (_isLeft) {
//            UIButton *tmp = [UIButton buttonWithType:UIButtonTypeSystem];
//            [tmp addTarget:self action:@selector(ibaDelete:) forControlEvents:UIControlEventTouchUpInside];
//            [tmp setTitle:@"View" forState:UIControlStateNormal];
//            tmp.frame = CGRectMake(384, 13, 40, 40);
//            [self addSubview:tmp];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.frame = RoriginalFrame;
                             }
             ];
        }
        NSLog(@"%@",self);
    }
//    NSLog(@"cell move");
}

- (IBAction)ibaEdit:(id)sender {
    NSLog(@"ibaEdit");
    NSLog(@"create a new geofence");
    ViewController *vc = (ViewController*)[[[[[[self nextResponder]nextResponder]nextResponder]nextResponder]nextResponder]nextResponder];
    UIStoryboard *mainStoryboard = vc.storyboard;
    
    vcGeoFenceEdit *tmp = (vcGeoFenceEdit*)[mainStoryboard
                                            instantiateViewControllerWithIdentifier: @"vcGeoFenceEdit"];
    tmp.no = self.no;
    tmp.mainObj = self.mainObj;
    tmp.dict = tmpD;
    [vc presentViewController:tmp animated:YES completion:^{
        
    }];
}
- (IBAction)ibaDelete:(id)sender {
    NSLog(@"ibaDelete");

    NSDictionary *dict = @{@"no": @(self.no+1)};
    [(MainClass*)_mainObj Delete_GEO_WithDict:dict withSender:self];

}
- (void)setFrame:(CGRect)frame {
    frame.size.width = 450;
    if (_isLeft) {
        frame.origin.x = -140;
        
        [super setFrame:frame];
    }
    else{
        frame.origin.x = 0;

        [super setFrame:frame];
    }
    
}
- (void)do_initWithDict:(NSDictionary*)dict{
    tmpD = dict;
    [_btnSwitch setOnTintColor:[ColorHex  colorWithHexString:@"FCCE01"]];
    
//    [_btnSwitch setTintColor:[UIColor whiteColor]];
    //set off tint color
    _btnSwitch.backgroundColor = [UIColor lightGrayColor];
    _btnSwitch.layer.cornerRadius = 16.0;
    
    [_btnSwitch setThumbTintColor:[UIColor whiteColor]];//可設定圓鈕顏色
//    [_btnSwitch setTintColor:[ColorHex  colorWithHexString:@"FCCE01"]];
    [_btnSwitch setTintColor:[UIColor lightGrayColor]];
    // init color
    UIColor *bgColor = [UIColor lightGrayColor];//[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1];
    [_lblw1 setBackgroundColor:bgColor];
    [_lblw2 setBackgroundColor:bgColor];
    [_lblw3 setBackgroundColor:bgColor];
    [_lblw4 setBackgroundColor:bgColor];
    [_lblw5 setBackgroundColor:bgColor];
    [_lblw6 setBackgroundColor:bgColor];
    [_lblw7 setBackgroundColor:bgColor];
//    //selected color
//    [_lblw3 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:193/255.0 blue:65/255.0 alpha:1]];
//    [_lblw4 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:193/255.0 blue:65/255.0 alpha:1]];
//    [_lblw5 setBackgroundColor:[UIColor colorWithRed:86/255.0 green:193/255.0 blue:65/255.0 alpha:1]];
    
//    NSString *keyNo = @"no";
    NSString *keyName = @"title";
    NSString *keyS = @"fromtime";
    NSString *keyE = @"totime";
    NSString *keyW = @"week";
//    NSString *keyP = @"points";
    NSString *keyOn = @"enable";
    _lblName.text = [dict objectForKey:keyName];
    _lblST.text = [dict objectForKey:keyS];
    _lblET.text = [dict objectForKey:keyE];
    int enable = [[dict objectForKey:keyOn]intValue];
    if (enable == 1) {
        [_btnSwitch setOn:YES];
    }
    else{
        [_btnSwitch setOn:NO];
    }
    //set week
    NSString *week = [dict objectForKey:keyW];
    week = [week stringByReplacingOccurrencesOfString:@"," withString:@""];
    for (int i = 0; i < week.length; i++) {
        int tmp = [[week substringWithRange:NSMakeRange(i, 1)]intValue];
        [self setWeek:tmp];
    }
}
- (void)setWeek:(int)which{
    UIColor *bgColor = [UIColor blackColor];//[UIColor colorWithRed:252/255.0 green:204/255.0 blue:37/255.0 alpha:1];
    switch (which) {
        case 1:
            [_lblw1 setBackgroundColor:bgColor];
            break;
        case 2:
            [_lblw2 setBackgroundColor:bgColor];
            break;
        case 3:
            [_lblw3 setBackgroundColor:bgColor];
            break;
        case 4:
            [_lblw4 setBackgroundColor:bgColor];
            break;
        case 5:
            [_lblw5 setBackgroundColor:bgColor];
            break;
        case 6:
            [_lblw6 setBackgroundColor:bgColor];
            break;
        case 7:
            [_lblw7 setBackgroundColor:bgColor];
            break;
            
        default:
            break;
    }
}
- (IBAction)ibaSwitch:(id)sender {
    NSMutableDictionary *dictTmp = [[NSMutableDictionary alloc]initWithDictionary:tmpD];
    if(_btnSwitch.on){
        NSLog(@"on!");
        [dictTmp setObject:@"1" forKey:@"enable"];
        [(MainClass*)_mainObj Save_GEO_WithDict_fromSwitch:dictTmp];
    }
    else{
        NSLog(@"off!");
        [dictTmp setObject:@"0" forKey:@"enable"];
        [(MainClass*)_mainObj Save_GEO_WithDict_fromSwitch:dictTmp];
    }
}
@end
