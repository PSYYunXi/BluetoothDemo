//
//  ProvisionManager.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import "ProvisionManager.h"

@interface ProvisionManager ()

@property (nonatomic, copy) ConfigurationFinsh configFinish;
@property (nonatomic, copy) ConfigurationFail configFail;
@property (nonatomic, strong) DeviceModel * device;
@property (nonatomic, strong) CBCharacteristic * characteristic;

@end


@implementation ProvisionManager

- (void)provisionWithDevice:(DeviceModel *)device success:(ConfigurationFinsh)success fail:(ConfigurationFail)fail {
    self.configFinish = success;
    self.configFail = fail;
    self.device = device;
    [self registerNotify];
}

- (void)registerNotify {
    SigBluetooth * manager = SigBluetooth.share;
    
    __weak typeof(self)weakSelf = self;
    [manager changeNotifyState:self.device.peripheral withCharacteristic:manager.PBGATT_OutCharacteristic block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, bool success) {
        if (success) {
            [weakSelf inviteAction];
        }
    }];
}

- (void)inviteAction {
    const char bytes[] = {0x03, 0x00, 0x00};
    NSLog(@"希尔数据");
    NSData * data = [NSData dataWithBytes:bytes length:3];
    [self.device.peripheral writeValue:data forCharacteristic:SigBluetooth.share.PBGATT_InCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)startAction {
    
}

- (void)publicKeyAction {
    
}

- (void)comfirmationValueAction {
    
}

- (void)randomAction {
    
}

- (void)provisionDataAction {
    
}


@end
