//
//  Provision.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#import "Provision.h"
#import "ProvisionManager.h"
#import "BindManager.h"

@interface Provision ()

@property (nonatomic, copy) ProvisionSuccess provisionSuccess;
@property (nonatomic, copy) ProvisionFail provisionFail;
@property (nonatomic, strong) DeviceModel * device;

@property (nonatomic, strong) ProvisionManager * provisionManager;

@end

@implementation Provision

- (void)provisionWithDevice:(DeviceModel *)device
                    success:(ProvisionSuccess)success
                       fail:(ProvisionFail)fail {
    self.provisionSuccess = success;
    self.provisionFail = fail;
    self.device = device;
    [SigBluetooth.share.manager connectPeripheral:device.peripheral options:nil];
    [self provisionAction];
}

- (void)provisionAction {
    ProvisionManager * provisionManager = [[ProvisionManager alloc] init];
    self.provisionManager = provisionManager;
    [provisionManager provisionWithDevice:self.device success:^{
        
    } fail:^{
        
    }];
    
}

- (void)getCompositionData {
    
}

- (void)bindAction {
    
}

@end
