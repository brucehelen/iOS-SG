//
//  GeoFenceShow.m
//  mCareWatch
//
//  Created by Roger on 2014/5/29.
//
//

#import "GeoFenceShow.h"
#import "GeoCell.h"
#import "MainClass.h"
#import "CGeoCell.h"

@implementation GeoFenceShow
{
    BOOL _haveGeoFence;
    NSMutableArray *pointA;
    MKPointAnnotation *personLocation;
    id  MainObj;
    //for demo
    NSArray *tmpAA;
    
    NSMutableArray *geo;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)do_initWithSender:(id)sender
{
    _table.dataSource = self;
    _table.delegate = self;
    MainObj = sender;
    pointA = [NSMutableArray new];

    tmpAA = @[@"YES",@"NO"];
}

- (void)do_initWithArray:(NSArray *)array
{
    geo = [[NSMutableArray alloc] initWithArray:array];
    [_table reloadData];
    [self doClean];

    if ([geo count] != 0) {
        NSString *strPoints = [[geo objectAtIndex:0]objectForKey:@"points"];
        strPoints = [strPoints stringByReplacingOccurrencesOfString:@"(" withString:@""];
        strPoints = [strPoints stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray *tmp = [strPoints componentsSeparatedByString:@","];
        for (int i = 0; i < [tmp count]/2; i++) {
            NSDictionary *tmpD = @{@"lat": [tmp objectAtIndex:i*2],@"lon": [tmp objectAtIndex:i*2+1]};
            [pointA addObject:tmpD];
        }

        if ([pointA count]>=3) {
            [self do_init];
        }
    }
}

- (void)doClean
{
    [_map removeAnnotations:_map.annotations];
    [_map removeOverlays:_map.overlays];
    [pointA removeAllObjects];
}

- (void)do_init
{
    _map.delegate = self;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    NSDictionary *tmpD = [pointA objectAtIndex:0];
    coor.latitude = [[tmpD objectForKey:@"lat"]doubleValue];//25.040875;
    coor.longitude = [[tmpD objectForKey:@"lon"]doubleValue];

    point.coordinate = coor;

    MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(coor, 1500, 1500)];
    [_map setRegion:adjustedRegion animated:YES];

    [self makeData];
    //配置記憶體
    CLLocationCoordinate2D *commuterLotCoords = calloc([pointA count], sizeof(CLLocationCoordinate2D));

    for (int i = 0;  i < [pointA count]; i ++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        commuterLotCoords[i] = CLLocationCoordinate2DMake(lat , lon);
    }
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:commuterLotCoords count:[pointA count]];
    [_map addOverlay:poly];

    //show all annotations
    [_map showAnnotations:_map.annotations animated:YES];
}

- (void)makeData
{
    for (int i = 0;  i < pointA.count; i++) {
        NSDictionary *dict = [pointA objectAtIndex:i];
        double lat = [[dict objectForKey:@"lat"]doubleValue];
        double lon = [[dict objectForKey:@"lon"]doubleValue];
        NSLog(@"%f,%f",lat,lon);
        [self doAddPinWithLat:lat andLon:lon ];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonRenderer *view = [[MKPolygonRenderer alloc] initWithOverlay:overlay] ;
        view.lineWidth=1;
        view.strokeColor=[UIColor blueColor];
        view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
        return view;
    }
    return nil;
}

- (void)doAddPinWithLat:(double)lat andLon:(double)lon
{
    CLLocationCoordinate2D coor;
    coor.latitude = lat;
    coor.longitude = lon;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coor;
    [_map addAnnotation:point];
}

#pragma mark - tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"geo select = %ld", (long)indexPath.row);
    //update by Bill 取no與點擊的indexPath.row不一樣
//    if (geo.count == 0) {
//        return;
//    }
    NSDictionary *dictT;
    
    if (geo.count > indexPath.row) {
        dictT = [geo objectAtIndex:indexPath.row];
    }
    else{
        return;
    }
    [self doClean];
    NSString *strPoints = [dictT objectForKey:@"points"];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@"(" withString:@""];
    strPoints = [strPoints stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *tmp = [strPoints componentsSeparatedByString:@","];
    for (int i = 0; i < [tmp count]/2; i++) {
        NSDictionary *tmpD = @{@"lat": [tmp objectAtIndex:i*2],@"lon": [tmp objectAtIndex:i*2+1]};
        [pointA addObject:tmpD];
    }
    if ([pointA count]>=3) {
        [self do_init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"GeoCell";
    //產生手勢
    UITableViewCell *cell;
    
//    if ([[tmpAA objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
    NSDictionary *dict;
    BOOL test = NO;
    int tmpNo = [[dict objectForKey:@"no"]intValue];
    int idx = -1;
    for (int i = 0;  i < [geo count]; i++) {
        @try {
            dict = [geo objectAtIndex:i];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            if (dict) {
                tmpNo = [[dict objectForKey:@"no"]intValue];
            }
        }
        if (indexPath.row+1 == tmpNo) {
            test = YES;
            idx = i;
            break;
        }
    }
    
    
    if(test ){
        //have geo fence
//        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
            //        cell = [[GeoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GeoCell" owner:self options:nil] objectAtIndex:0];
//        }
        [(GeoCell*)cell addGes];
        [(GeoCell*)cell setNo:indexPath.row];
        //update by Bill 修正此no為api 回傳的number
//        [(GeoCell*)cell setNo:tmpNo];
        
        [(GeoCell*)cell setMainObj:MainObj];
        NSDictionary *dict = [geo objectAtIndex:idx];
//        NSDictionary *dict = [geo objectAtIndex:indexPath.row];

        [(GeoCell*)cell do_initWithDict:dict];
    }
    else{
//        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (cell == nil) {
            //        cell = [[GeoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CGeoCell" owner:self options:nil] objectAtIndex:0];
//        }
        //update by Bill 修正此no為api 回傳的number
        [(CGeoCell*)cell setNo:indexPath.row];
        [(CGeoCell*)cell setMainObj:MainObj];
    }

    //選取無顏色
    [(UITableViewCell*)cell setSelectionStyle:UITableViewCellSelectionStyleNone];// = UITableViewCellSelectionStyleNone;
    return cell;
}

//設定地圖模式
-(void)MapMoushDown:(int)type
{
    NSInteger mapType = [[NSUserDefaults standardUserDefaults] integerForKey:@"MAP_TYPE"];
    //判斷百度地圖或是GoogleMap
    if (mapType == 1) {
        //百度地圖
        //再判斷type類型為一般地圖或是衛星地圖
//        if (_map.mapType == BMKMapTypeStandard)
//        {
//            _map.mapType = BMKMapTypeSatellite;//衛星地圖
//        }else
//        {
//            _map.mapType = BMKMapTypeStandard;
//        }
    }else
    {
        //Google Map
        //再判斷type類型為一般地圖或是衛星地圖
        if (_map.mapType == MKMapTypeStandard)
        {
            _map.mapType = MKMapTypeSatellite;//衛星地圖
        }else
        {
            _map.mapType = MKMapTypeStandard;
        }
    }
}

- (id)getMainObj
{
    return MainObj;
}

@end
