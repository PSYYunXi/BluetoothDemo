//
//  ScanViewController.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import "ScanViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "Provision.h"

@interface ScanViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray<DeviceModel *> * deviceList;

@property (nonatomic, strong) Provision * provision;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializedUI];
}

- (void)initializedUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scanDevice];
}

//扫描未入网的设备
- (void)scanDevice {
    __weak typeof(self)weakSelf = self;
    [SigBluetooth.share scanDevice:^(CBPeripheral *peripheral) {
        DeviceModel * device = [[DeviceModel alloc] init];
        device.peripheral = peripheral;
        [weakSelf.deviceList addObject:device];
        [weakSelf.tableView reloadData];
    }];
}

//连接设备
- (void)provisisonDevice: (DeviceModel *)device {
    Provision * provision = [[Provision alloc] init];
    self.provision = provision;
    [provision provisionWithDevice:device success:^{
        
    } fail:^{
            
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceModel * device = self.deviceList[indexPath.row];
    [self provisisonDevice:device];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identify = @"identify";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    DeviceModel * device = self.deviceList[indexPath.row];
    cell.textLabel.text = device.peripheral.name;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;;
}


#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray<DeviceModel *> *)deviceList {
    if (!_deviceList) {
        _deviceList = [[NSMutableArray alloc] init];
    }
    return _deviceList;
}

@end
