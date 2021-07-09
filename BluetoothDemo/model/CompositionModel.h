//
//  CompositionModel.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import <Foundation/Foundation.h>
#import "ElementModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CompositionModel : NSObject
/** 已经绑定成功的model数量*/
@property (nonatomic, assign) int bindCount;
/** 当前数据都是大端保存，到accessLayer可能需要小端发送*/
/** page 1个字节16进制字符串, 目前应该是00 如果是其他数值，设备可能有问题*/
@property (nonatomic, copy) NSString * page;
/** CID 2个字节16进制字符串*/
@property (nonatomic, copy) NSString * CID;
/** PID 2个字节16进制字符串*/
@property (nonatomic, copy) NSString * PID;
/** VID 2个字节16进制字符串*/
@property (nonatomic, copy) NSString * VID;
/** CRPL 2个字节16进制字符串*/
@property (nonatomic, copy) NSString * CRPL;
/** Feature 2个字节16进制字符串*/
@property (nonatomic, copy) NSString * Feature;
/** element集合*/
@property (nonatomic, strong) NSMutableArray<ElementModel *> * elements;

@end

NS_ASSUME_NONNULL_END
