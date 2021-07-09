//
//  Provision.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Provision : NSObject

- (void)provisionWithDevice:(DeviceModel *)device
                    success:(ProvisionSuccess)success
                       fail:(ProvisionFail)fail;


@end

NS_ASSUME_NONNULL_END
