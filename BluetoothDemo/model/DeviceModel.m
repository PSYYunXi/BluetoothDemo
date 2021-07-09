//
//  DeviceModel.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import "DeviceModel.h"
#import "Algorithm.h"
@implementation DeviceModel

- (id)init {
    self = [super init];
    if (self) {
        self.deviceKey = [[Algorithm shareInstance] generateRandom];
//        self.TID = 0x00;
    }
    return self;
}


//- (UInt8)fetchTid {
//    self.TID = self.TID >= 0xFF ? 0x00 : self.TID + 1;
//    return self.TID;
//}

//初始化地址
- (void)allocationAddress {
//    var buffer = Buffer.from(this.deviceCapalibities, 'hex')
//    var element = parseInt(buffer.slice(0, 1).toString('hex'), 16)
//    if (this.addressList.length == element) {
//        return
//    }
//    var start = SigManager.share.addressIndex
//    this.addressList = []
//    for (var i = 0; i < element; i++) {
//        var address = Tools.hexToString(start + i, 2)
//        this.addressList.push(address)
//    }
//    SigManager.share.addressIndex = start + element
}

@end
