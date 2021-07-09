//
//  CBPeripheral+Tag.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (Tag)

@property (nonatomic, weak) DeviceModel * device;

@end

NS_ASSUME_NONNULL_END
