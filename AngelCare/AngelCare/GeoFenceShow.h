//
//  GeoFenceShow.h
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GeoFenceShow : UIView
<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableView *table;

- (void)do_init;
- (void)do_initWithSender:(id)sender;
- (void)do_initWithArray:(NSArray*)array;
- (void)MapMoushDown:(int)type;
- (id)getMainObj;
@end
