//
//  Block.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#ifndef Block_h
#define Block_h
#import <UIKit/UIKit.h>

/** 扫描设备回调*/
typedef void(^ScanCallBack)(CBPeripheral * peripheral);

/** 整个组网成功还是失败回调*/
typedef void(^ProvisionSuccess) (void);

/**整个组网失败*/
typedef void(^ProvisionFail)(void);

/** 打开通知*/
typedef void(^OpenNotifyFinish)(CBPeripheral * peripheral, CBCharacteristic * characteristic, bool success);

/**  配网成功*/
typedef void(^ConfigurationFinsh)(void);
typedef void(^ConfigurationFail)(void);

#endif /* Block_h */
