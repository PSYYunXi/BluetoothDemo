//
//  SigBluetooth.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SigBluetooth : NSObject

@property (nonatomic, strong) CBCentralManager * manager;

@property (nonatomic, copy) OpenNotifyFinish openNotifyFinish;

@property (nonatomic,strong) CBCharacteristic *PBGATT_OutCharacteristic;
@property (nonatomic,strong) CBCharacteristic *PBGATT_InCharacteristic;
@property (nonatomic,strong) CBCharacteristic *PROXY_OutCharacteristic;
@property (nonatomic,strong) CBCharacteristic *PROXY_InCharacteristic;

+ (instancetype)share;

- (void)scanDevice:(ScanCallBack)scanFinish;

- (void)changeNotifyState:(CBPeripheral *)peripheral withCharacteristic:(CBCharacteristic *)characteristic block:(OpenNotifyFinish)notifyFinish;

@end

NS_ASSUME_NONNULL_END
