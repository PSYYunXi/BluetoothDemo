//
//  SigManager.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/6/7.
//

#import "SigManager.h"
#import "DeviceModel.h"

@interface SigManager ()

@end

@implementation SigManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static SigManager * manager = nil;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (void)initializedProperty {
    self.netKeyIndex = 0b000000000000;
    self.appKeyIndex = 0b000000000000;
    self.sequenceNumber = 0x000000;
    self.ivIndex = 0x00000000;
    self.SRC = 0x0001;
    self.TTL = 0x0a;
}

- (NSString *)getNetKeyValue {
    if (self.netKey == nil || self.netKey.length == 0) {
//        self.netKey = 
    }
    return self.netKey ;
}

@end
