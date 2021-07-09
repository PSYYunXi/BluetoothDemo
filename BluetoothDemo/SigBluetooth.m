//
//  SigBluetooth.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#import "SigBluetooth.h"

@interface SigBluetooth () <CBPeripheralDelegate, CBCentralManagerDelegate>

/** 扫描结束代理*/
@property (nonatomic, copy) ScanCallBack scanFinish;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;




@end

@implementation SigBluetooth

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static SigBluetooth * bluetooth;
    dispatch_once(&onceToken, ^{
        bluetooth = [[SigBluetooth alloc] init];
        CBCentralManager * _manager = [[CBCentralManager alloc] init];
        _manager.delegate = bluetooth;
        bluetooth.manager = _manager;
        bluetooth.semaphore = dispatch_semaphore_create(0);
    });
    return bluetooth;
}

/** 扫描设备*/
- (void)scanDevice:(ScanCallBack)scanFinish{
    self.scanFinish = scanFinish;
    CBUUID * uuid = [CBUUID UUIDWithString:@"1827"];
    NSArray<CBUUID *> * uuids = @[uuid];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        [self.manager scanForPeripheralsWithServices:uuids options:nil];
    });
}

/** */
- (void)changeNotifyState:(CBPeripheral *)peripheral withCharacteristic:(CBCharacteristic *)characteristic block:(OpenNotifyFinish)notifyFinish {
    self.openNotifyFinish = notifyFinish;
    if (peripheral.state != CBPeripheralStateConnected) {
        if (self.openNotifyFinish) {
            self.openNotifyFinish(peripheral, characteristic, NO);
        }
        return;
    }
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}

#pragma mark - CBDelegate
/** 初始化CBCentralManager*/
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (self.scanFinish) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            dispatch_semaphore_signal(self.semaphore);
        }
    }
}

/** 扫描设备的回调*/
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
    BOOL provisionAble = [suuidString isEqualToString:ServiceUUID1827];
    //已经入网
    BOOL unProvisionAble = [suuidString isEqualToString:ServiceUUID1828];
    if (!provisionAble && !unProvisionAble) {
        return;
    }
    NSData * manufactureData = advertisementData[CBAdvertisementDataManufacturerDataKey];
    UInt32 targetInt = 0x123408b4;
    UInt32 bigDian = CFSwapInt32HostToBig(targetInt);
    NSData * targetData = [Tools dataFormUint32:bigDian];
    if ([targetData isEqualToData:manufactureData] && provisionAble) {
        self.scanFinish(peripheral);
    }
}

/** 连接设备*/
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功");
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

/** 连接设备失败*/
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"连接失败");
}

/** 断开设备*/
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"断开连接");
}

#pragma mark -服务代理
/** 发现服务*/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    for (CBService * sevice in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:sevice];
    }
}

/** 发现服务下的特征*/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    for (CBCharacteristic * c in service.characteristics) {
        [peripheral discoverDescriptorsForCharacteristic:c];
         if ([c.UUID.UUIDString isEqualToString:Characteristic2ADC]){
            self.PBGATT_OutCharacteristic = c;
        }else if ([c.UUID.UUIDString isEqualToString:Characteristic2ADB]){
            self.PBGATT_InCharacteristic = c;
        }else if ([c.UUID.UUIDString isEqualToString:Characteristic2ADD]){
            self.PROXY_OutCharacteristic = c;
        }else if ([c.UUID.UUIDString isEqualToString:Characteristic2ADE]){
            self.PROXY_InCharacteristic = c;
        }
    }
}

/***/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
}

/** 打开notify的回调*/
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"打开notify");
    if (self.openNotifyFinish) {
        self.openNotifyFinish(peripheral, characteristic, YES);
    }
}

/** 读取数据*/
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSData * data = [NSData dataWithBytes:characteristic.value.bytes length:characteristic.value.length];
    NSLog(@"%@", data);
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"读取之后触发");
}

/** 写入数据*/
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSData * data = [NSData dataWithBytes:characteristic.value.bytes length:characteristic.value.length];
    NSLog(@"%@", data);
    
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"写之后触发的方法");
}

@end

