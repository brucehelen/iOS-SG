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
@property (nonatomic, strong) NSMutableArray *enDataArray;

@end

@implementation KMFreqQuestionView

- (void)awakeFromNib
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self initEnData];
    [self initData];
}

// 初始化中文常见问题列表
- (void)initData
{
    _dataArray = [NSMutableArray array];

    // 问题1
    KMFAQModel *model = [[KMFAQModel alloc] init];
    model.question = @"为何在APP上设置\"紧急号码\"和\"亲情号码\"后，并没有上传或同步至智慧手表上？";
    model.answer = @"为求省电和节省封包费用，原始设定每整点时资料才会上传并于服务器同步，若您希望每次设定完成后立即更新，请设定完成后，将智慧手表主动关机，静置5分钟后再次开启，开启后先前所变更之号码可立即更新。";
    [_dataArray addObject:model];
    
    // 问题2
    model = [[KMFAQModel alloc] init];
    model.question = @"为何在按下\"紧急求救按键\"，定位资料并没有出现在地图中？";
    model.answer = @"即时定位的信息传出后，需在信息确认传送成功后才会更新，会开启GPS,GSM 多基站定位，依据不同的定位方式，有不同的准确度显示。";
    [_dataArray addObject:model];
    
    // 问题3
    model = [[KMFAQModel alloc] init];
    model.question = @"为何开启\"跌倒侦测\"后，有时没有跌倒也会报警？有保证跌倒时一定会有报警吗？";
    model.answer = @"跌倒侦测为辅助功能，因光靠手的行为模式是无法百分之百判断是否跌倒，本功能仅供参考，使用者可以决定是否开启。跌倒时，还是可以通过随身的手表按下红色求救键，达到求救目的。";
    [_dataArray addObject:model];

    // Q4
    model = [[KMFAQModel alloc] init];
    model.question = @"智慧手表每月的GPRS 数据传输封包使用量约为多少？";
    model.answer = @"正常待机，每月最大上网封包流量大约为 2-3M ，但仍依据实际使用情况及频率而定。";
    [_dataArray addObject:model];
    
    // Q5
    model = [[KMFAQModel alloc] init];
    model.question = @"紧急号码若设定一组以上，将于何种状态下执行轮拨？";
    model.answer = @"若设定一组以上的紧急号码，则在第一组号码拨通30秒无人接听的情况下，轮拨下一组号码，直至拨通或您主动挂断。";
    [_dataArray addObject:model];
    
    // Q6
    model = [[KMFAQModel alloc] init];
    model.question = @"按下 \"紧急号码\"和\"亲情号码\" 有何不同？";
    model.answer = @"按“紧急号码”将立即拨号，并做即时A-GPS 定位，按下亲情号码，将立即拨号但并不支持即时定位功能。";
    [_dataArray addObject:model];
    
    // Q7
    model = [[KMFAQModel alloc] init];
    model.question = @"如何设定及配对智慧手表的蓝牙量测设备？";
    model.answer = @"在设置界面，4.通讯设置，点选（1）蓝牙，激活蓝牙在3我的装置，选择要配对的量测设备，即可进行自动配对。";
    [_dataArray addObject:model];
}

// 初始化英文常见问题
- (void)initEnData
{
    _enDataArray = [NSMutableArray array];
    
    KMFAQModel *model = [[KMFAQModel alloc] init];
    
    model.question = @"When set up the 'emergency number' and 'family number' in the APP, why not sync to the smart watch immediately?";
    model.answer = @"In order to save energy,the data will be uploaded to the server per hour, if you want to upload data immediately after the completion of the update, please shut down the smart watch for 5  minutes,pown on again,the number can be updated immediately.";
    [_enDataArray addObject:model];
    
    // 问题2
    model = [[KMFAQModel alloc] init];
    model.question = @"Why press the 'emergency button', positioning information is not there in the map？";
    model.answer = @"The information will be updated when the GPS, GSM positioning data delivery to server successed, according to the different positioning type, different accuracy showed.";
    [_enDataArray addObject:model];
    
    // 问题3
    model = [[KMFAQModel alloc] init];
    model.question = @"Why enable 'fall detection' function, sometimes it still a warning when you not fall down？";
    model.answer = @"Fall detection as an auxiliary function，This function is for reference only，Users can decide whether to enable。when Fall，you can press the red button for help.";
    [_enDataArray addObject:model];
    
    // Q4
    model = [[KMFAQModel alloc] init];
    model.question = @"How much for Smart watch GPRS data transmission per month？";
    model.answer = @"Normal standby, the maximum monthly Internet packet usage is about 2-3M, but is still based on the actual use and frequency.";
    [_enDataArray addObject:model];
    
    // Q5
    model = [[KMFAQModel alloc] init];
    model.question = @"If the emergency number is set up more than one, it will be in what kind of state loop calls?";
    model.answer = @"The first number dialed 30 seconds no answer, then the next set of number, until dial or hang up.";
    [_enDataArray addObject:model];
    
    // Q6
    model = [[KMFAQModel alloc] init];
    model.question = @"What's the difference about  'emergency number' and 'family number' ?";
    model.answer = @"Press the 'emergency number' will dial immediately, and do A-GPS positioning immediately ,press the 'family number', the number will be immediately dialed but does not support real-time  positioning function.";
    [_enDataArray addObject:model];
    
    // Q7
    model = [[KMFAQModel alloc] init];
    model.question = @"How to set up the smart watch's Bluetooth measurement equipment ?";
    model.answer = @"n the setup screen , 4 Wireless settings, click (1) Bluetooth, Power Bluetooth 3 my device, select the  measurement equipment to match,can automatically match.";
    [_enDataArray addObject:model];
}

- (void)do_init:(id)sender
{
    self.mainClass = sender;
}

// 检测是否是中文
- (BOOL)checkUserLangaueSetting
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* arrayLanguages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [arrayLanguages objectAtIndex:0];

    if ([currentLanguage hasPrefix:@"zh-"]) return YES;
    
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self checkUserLangaueSetting]) {
        return _dataArray.count;
    } else {
        return _enDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    KMFAQModel *model = nil;

    if ([self checkUserLangaueSetting]) {
        model = _dataArray[indexPath.row];
    } else {
        model = _enDataArray[indexPath.row];
    }

    cell.textLabel.text = model.question;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KMFAQModel *model = nil;
    
    if ([self checkUserLangaueSetting]) {
        model = _dataArray[indexPath.row];
    } else {
        model = _enDataArray[indexPath.row];
    }

    [self.mainClass pushFreqQuestionDetailViewWithModel:model];
}

@end
