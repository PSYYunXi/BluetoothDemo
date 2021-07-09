//
//  ProvisionManager.h
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProvisionManager : NSObject

- (void)provisionWithDevice:(DeviceModel *)device success:(ConfigurationFinsh)success fail:(ConfigurationFail)fail;


@end

NS_ASSUME_NONNULL_END
