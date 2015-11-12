//
//  KMFreqQuestionView.m
//  3GSW
//
//  Created by bruce-zhu on 15/11/5.
//
//

#import "KMFreqQuestionView.h"
#import "MainClass.h"
#import "KMFAQModel.h"

@interface KMFreqQuestionView() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) MainClass *mainClass;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KMFreqQuestionView

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self initData];
}

- (void)initData
{
    _dataArray = [NSMutableArray array];

    // 问题1
    KMFAQModel *model = [[KMFAQModel alloc] init];
    model.question = @"产品功能介绍";
    model.answer = @"健康表就像是一款智能手表，可以在手机上实时看到家人健康测量数据，它具有通话和处理移动数据功能，手表的GPS追踪和定位带来随时随地对家人的关怀对自己身体情况的及时了解，手表可以通过蓝牙感测其他康美医疗器械所量测的健康数据让您能最直观的掌握家人或自己的身体状况。同时，在遇到突发情况的时候手表可以采集生命指标数据作为监控和管理，查询智能手表的活动轨迹，接收到智能手表求救 。还可以设定家人智能手表提醒时间和事项，可拨打智能手表电话及发送短信。\n\
主要包括有记录佩戴者资料、检测设备状态、量测记录、定位救援、活动区域记录、服务记录、通话速拨、时间提醒、设定量测提醒、硬体设定、展示照片程序。\n\
佩戴者资料：您可以设定个人咨询、紧急电话、亲情电话等咨询\n\
检测设备状态：关于检测设备状态包括开关机咨询、电量、版本、定位地址、同步时间\n\
量测记录：在量测记录上可查询血压、血糖、血氧、体重体脂、活动量分析记录\n\
定位救援：遇到紧急情况的时候定位救援可提示SOS求救、跌倒求救即时定位地点、时间、讯息\n\
活动区域：：手机APP可查询佩戴手表者的历史活动区域、每小时会定时记录佩戴者所经历过的地点及基地台定位的位置\n\
服务记录：查询求救、跌倒、通话记录\n\
通话速拨：可直接拨号值佩戴者手表（个人资讯-->设定手机号码）\n\
时间提醒：可设定吃药提醒及回诊提醒，设定时间到时，手表会发出提醒及讯息\n\
贴心设定：可设定量测提醒、硬体设定、展示照片";
    [_dataArray addObject:model];
    
    // 问题2
    model = [[KMFAQModel alloc] init];
    model.question = @"手机下载APP连接手表方法";
    model.answer = @"您在手机APP首页输入手表的imei号（手表——拨号——拨号键中按向上箭头输入*#06*——出现imei号——将imei号输入到手机APP上），也可以在手表的外包装盒的侧面看到imei号";
    [_dataArray addObject:model];
    
    // 问题3
    model = [[KMFAQModel alloc] init];
    model.question = @"健康表调节声音大小的方式";
    model.answer = @"您需要在通话的时候同时操作手表右侧上下键调节音量大小";
    [_dataArray addObject:model];
    
    model = [[KMFAQModel alloc] init];
    model.question = @"没有sim卡的手表是否能正常操作";
    model.answer = @"可以使用手表的基本操作，但是不能进行数据上传。因为跟sim卡有关的不能操作（比如短信、通话），其他都能，在有WIFI的情况下所有操作后台或者app是也可以上传数据的（比如：侧心率、血压、计步器等）。手表自身无流量，无WIFI情况下是不可传输数据的";
    [_dataArray addObject:model];
}

- (void)do_init:(id)sender
{
    self.mainClass = sender;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    // TODO: 需要改成真正的数据模型
    KMFAQModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.question;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KMFAQModel *model = _dataArray[indexPath.row];
    [self.mainClass pushFreqQuestionDetailViewWithModel:model];
}

@end
