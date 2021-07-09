//
//  AppDelegate.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/4/30.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ScanViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ScanViewController * mainVC = [[ScanViewController alloc] init];
//    MainViewController * mainVC = [[MainViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [self.window makeKeyAndVisible];
        
//    UInt8 v1 = 0x34;
//    UInt8 v2 = 0x84;
//    const char binary[] = {v1, v2};
//    NSData * data = [NSData dataWithBytes:binary length:2];
//    NSLog(@"%@", data);
//    
////    NSUInteger len = [data length];
////    Byte *byteData = (Byte*)malloc(len);
////    memcpy(byteData, [data bytes], len);
//    Byte * byteData = (Byte *)[data bytes];
//    NSLog(@"%d", byteData[0]);
//    NSLog(@"%d", byteData[1]);
//    
    
//    NSLog(@"%@", &bytes);
//    NSLog(@"%d", bytes[0]);
//    NSLog(@"%d", bytes[1]);

    
    
    
    return YES;
}


@end
