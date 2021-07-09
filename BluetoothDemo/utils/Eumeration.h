//
//  Eumeration.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import <UIKit/UIKit.h>

#ifndef Eumeration_h
#define Eumeration_h


typedef NS_ENUM(UInt8, ProvisionProcess) {
    //初始化阶段
    ProvisionPrepare         = 0x10,
    //邀请设备入网 app执行
    ProvisionInvite          = 0x00,
    //设备返回设备的capability
    ProvisionCapabilities    = 0x01,
    //开始配网 app执行
    ProvisionStart           = 0x02,
    //交换publickey app执行
    ProvisionPublicKey       = 0x03,
    //暂不需要
    ProvisionInputComplete   = 0x04,
    //交换comfirmationVlua app执行
    ProvisionConfirmation    = 0x05,
    //交换random app执行
    ProvisionRandom          = 0x06,
    //发送配网数据包 app执行
    ProvsionData    = 0x07,
    //配网成功
    ProvisionComplete        = 0x08,
    //配网失败
    ProvisionFailed          = 0x09
};

typedef NS_ENUM(UInt8, BindProcess) {
    //初始化阶段
    Bindprepare         = 0x10,
    //收到设备上报的ivindex
    BindStart           = 0x00,
    //获取compositionData
    BindCompositionData = 0x01,
    //添加appKey
    BindAddKey          = 0x02,
    //绑定model
    BindBind            = 0x03
} ;

typedef  NS_ENUM(UInt8, SAR) {
    //完整数据包，小于20个字节
    SAR_completeMessage = 0b00,
    //分包的第一个包
    SAR_firstSegment    = 0b01,
    //分包的中间包
    SAR_continuation    = 0b10,
    //分包的尾包
    SAR_lastSegment     = 0b11,
};


/**
 * 目前用到SigPduType_provisioningPdu，再组网阶段
 */
typedef NS_ENUM(NSUInteger, SigPduType) {
    /// - seeAlso: 3.4.4 Network PDU of Mesh_v1.0.pdf  (page.43)
    SigPduType_networkPdu           = 0,
    /// - seeAlso: 3.9 Mesh beacons of Mesh_v1.0.pdf  (page.117)
    SigPduType_meshBeacon           = 1,
    /// - seeAlso: 6.5 Proxy configuration messages of Mesh_v1.0.pdf  (page.262)
    SigPduType_proxyConfiguration   = 2,
    /// - seeAlso: 5.4.1 Provisioning PDUs of Mesh_v1.0.pdf  (page.237)
    SigPduType_provisioningPdu      = 3,
};

/** nonce 类型*/
typedef NS_ENUM(NSUInteger, NonceType) {
    netNonce    = 0x00,
    appNonce    = 0x01,
    devNonce    = 0x02,
    proxyNonce  = 0x03,
};

/** payload type pdu是access 还是control，
 * CTL的值 0是AccessMsg 1是ControlMsg (这个时候可能就需要高安全策略64位的MIC)
 * AKF 和 AID都由这个决定
 * acess
 * control 只有SigPduType_proxyConfiguration 属于Control。剩下都是access message（此处的control不是控制包的意思）
 */
typedef NS_ENUM(NSUInteger, PayloadType) {
    PayloadType_access  = 0,
    PayloadType_control = 1,
};


/** 配置包还是命令包 配置指令使用 DevKey, 控制命令使用AppKey*/
typedef NS_ENUM(NSUInteger, AccessType) {
    AccessType_setting = 0,
    AccessType_control = 1,
};

/** 加密的安全测试 low 表示TransMic位32位  high表示TransMic是64位，基本默认使用low，有要求高策略的地方才使用high*/
typedef NS_ENUM(NSUInteger, SigMeshMessageSecurity) {
    low     = 0,
    high    = 1,
};

/** 设备当前处于的阶段,前两个阶段的命令属于access payload  control 属于 control payload*/
typedef NS_ENUM(NSUInteger, DeivceState) {
    DeivceState_provision   = 0,
    DeivceState_bind        = 1,
    DeivceState_control     = 2,
    DeivceState_unprovision = 3,
};

/** 发送networkPDU 类型，目前分为正常和bind，正常的包超过1个networkpdu就需要记录，并且补发，但是bind就只有一个，也是需要补发的*/
typedef NS_ENUM(NSUInteger, SendPDUType) {
    SendPDUType_normal  = 0,
    SendPDUType_bind    = 1
};

/** compositionData model id类型*/
typedef NS_ENUM(NSUInteger, SigModelType)  {
    Sig     = 0,
    Vendor  = 1
};

#endif /* Eumeration_h */
