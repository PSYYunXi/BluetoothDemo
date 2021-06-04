//
//  MainViewController.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/4/30.
//

#import "MainViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <Masonry/Masonry.h>

@interface MainViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager * manager;

@property (nonatomic, strong) CBPeripheral * peripheral;

@property (nonatomic, strong) CBCharacteristic * reciveCB;

@property (nonatomic, strong) CBCharacteristic * writeCB;

@property (nonatomic, assign) BOOL isArchive;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Demo";
    [self initializedUI];
    // Do any additional setup after loading the view.
    
}
 
- (void)initializedUI {
    self.isArchive = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"连接" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"发送" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn1];
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"接收" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(reciveAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:btn2];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).offset(50);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.equalTo(btn1);
        make.top.equalTo(btn1.mas_bottom).offset(50);
    }];
}


//连接设备
- (void)connectAction:(UIButton *)btn {
    if (!self.isArchive) {
        NSLog(@"请稍等");
        if (self.manager == nil) {
            
        }
        return;
    }
    CBUUID * uuid = [CBUUID UUIDWithString:@"1827"];
    NSArray<CBUUID *> * uuids = @[uuid];
    [self.manager scanForPeripheralsWithServices:uuids options:nil];
}

//发送数据
- (void)sendAction:(UIButton *)btn {
//    NSString * string = @"030000";
    uint8_t buffer[3]={0x03, 0x00, 0x00};
    NSData *data = [NSData dataWithBytes:buffer length:3];
//    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self.peripheral writeValue:data forCharacteristic:self.writeCB type:CBCharacteristicWriteWithoutResponse];
}

//接收数据
- (void)reciveAction:(UIButton *)btn {
    if (self.reciveCB.isNotifying) {
        NSLog(@"打开了");
        [self.peripheral readValueForCharacteristic:self.reciveCB];
    }
}

#pragma mark - CBDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"did updateState");
    NSLog(@"%ld", (long)self.manager.state);
    self.isArchive = YES;
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    
    if(RSSI.intValue >=0 ) {
        return;
    }
    
    if (![advertisementData.allKeys containsObject:CBAdvertisementDataServiceDataKey]) {
        return;
    }
    
    NSMutableDictionary * suuids = advertisementData[CBAdvertisementDataServiceDataKey];
    if (!suuids || suuids.allKeys.count == 0) {
        return;
    }
    
    NSString * suuidString = ((CBUUID *)(suuids.allKeys.firstObject)).UUIDString;
    
    //没有入网
    BOOL provisionAble = [suuidString isEqualToString:@"1827"];
    //已经入网
    BOOL unProvisionAble = [suuidString isEqualToString:@"1828"];
    
    if (!provisionAble && !unProvisionAble) {
        return;
    }

    
    if ([peripheral.name isEqualToString:@"B11-U2E"]) {
        NSLog(@"发现设备");
        self.peripheral = peripheral;
        [self.manager connectPeripheral:self.peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功");
    self.peripheral.delegate = self;
    [self.peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"连接失败");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"断开连接");
}

#pragma mark -服务代理
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"发现服务");
    for (CBService *s in peripheral.services) {
        [self.peripheral discoverCharacteristics:nil forService:s];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"发现特征");
    for (CBCharacteristic * c in service.characteristics) {
        [peripheral discoverDescriptorsForCharacteristic:c];
        if ([c.UUID.UUIDString isEqualToString:@"2ADC"]) {
            self.reciveCB = c;
            [peripheral setNotifyValue:YES forCharacteristic:c];
        } else if ([c.UUID.UUIDString isEqualToString:@"2ADB"]) {
            self.writeCB = c;
        } else {}
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if ([peripheral isEqual:self.peripheral]) {
        CBCharacteristic *lastCharacteristic = nil;
        for (CBService *s in peripheral.services) {
            if (s.characteristics && s.characteristics.count > 0) {
                lastCharacteristic = s.characteristics.lastObject;
            }
        }
        if (lastCharacteristic == characteristic) {
//            [self discoverServicesFinish];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"打开notify");
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSData * data = [NSData dataWithBytes:characteristic.value.bytes length:characteristic.value.length];
    NSLog(@"%@", data);
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"读取之后触发");
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
    NSLog(@"写之后触发的方法");
}

- (CBCentralManager *)manager {
    if (!_manager) {
        _manager = [[CBCentralManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;;
}


@end
