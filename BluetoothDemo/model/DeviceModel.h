//
//  DeviceModel.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import <Foundation/Foundation.h>
#import "Eumeration.h"
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface DeviceModel : NSObject

/** */
@property (nonatomic, strong) CBPeripheral * peripheral;
/** 读特征*/
@property (nonatomic, strong) CBCharacteristic * reciveCB;
/** 写入特征*/
@property (nonatomic, strong) CBCharacteristic * writeCB;

/** provision invite*/
@property(nonatomic, strong) NSData * invite;
   /** device CapabilityPDU*/
@property(nonatomic, strong) NSData * deviceCapalibities;
   /** provision start*/
@property(nonatomic, strong) NSData * start;
   /** provision privateKey*/
@property(nonatomic, strong) NSData * privateKey;
   /** provision publicKey*/
@property(nonatomic, strong) NSData * publicKey;
   /**  device publicKey*/
@property(nonatomic, strong) NSData * devicePublicKey;
   /** provision ComfirmationValue*/
@property(nonatomic, strong) NSData * confirmationValue;
   /** device ComfirmationValue*/
@property(nonatomic, strong) NSData * deviceConfirmationValue;
   /** provision Random*/
@property(nonatomic, strong) NSData * random;
   /** device Random*/
@property(nonatomic, strong) NSData * deviceRandom;
   /** provision salt*/
@property(nonatomic, strong) NSData * salt;
   /** provision ECDHSecret*/
@property(nonatomic, strong) NSData * ecdhSecret;
   /** 设备id*/
@property(nonatomic, strong) NSData * deviceId;

   /** 设备是否离线*/
@property(nonatomic, assign) bool online;

   /** 需要上传到云端的数据*/
   /** deviceKey*/
@property(nonatomic, strong) NSData * deviceKey;

///** 设备所在阶段，开始处于provision */
//@property (nonatomic, assign) DeivceState deviceState;
//   /** 组网流程*/
//@property (nonatomic, assign) ProvisionProcess provisionningProcess;
//   /** key绑定流程*/
//@property (nonatomic, assign) BindProcess bindProcess;
//   /** 开关地址,用于进行设备控制*/
//@property (nonatomic, strong) NSMutableArray<NSString *> * onOffAddress;
//   /** 颜色控制地址*/
//@property (nonatomic, strong) NSMutableArray<NSString *> * colorAddress;
//   /** 亮度控制地址*/
//@property (nonatomic, strong) NSMutableArray<NSString *> * lightnessAddress;
//   /** 色温调节地址*/
//@property (nonatomic, strong) NSMutableArray<NSString *> * temperatureAddress;
//   //发送控制命令，防止重复每次自增1
//@property (nonatomic, assign) UInt8 TID;
//   /** 设备分配的地址, 暂时写死*/
//@property (nonatomic, strong) NSMutableArray<NSString *> * addressList;
//
//@property (nonatomic, strong) CompositionDataModel * compositionDataModel;
//
//@property (nonatomic, assign) int spectrumRGB;
//   /** 是否打开了1828的notify，重连的时候会用到*/
//
//@property (nonatomic, assign) BOOL registerNotify;

//   currentServiceUUID = ServiceUuid.PRIMARY0000
   

@end

NS_ASSUME_NONNULL_END
