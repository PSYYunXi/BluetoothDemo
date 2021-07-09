//
//  SigManager.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SigManager : NSObject

@property (nonatomic, copy) NSString * netKey;

@property (nonatomic, assign) UInt8 netKeyIndex;

@property (nonatomic, copy) NSString * appKey;

@property (nonatomic, assign) UInt8 appKeyIndex;

@property (nonatomic, assign) UInt16 sequenceNumber;

@property (nonatomic, assign) UInt16 ivIndex;

@property (nonatomic, assign) int dtsIndex;

@property (nonatomic, strong) DeviceModel * device;

@property (nonatomic, assign) UInt16 SRC;

@property (nonatomic, assign) UInt16 TTL;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
