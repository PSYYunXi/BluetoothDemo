//
//  MainViewController.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/4/30.
//

#import "MainViewController.h"
#import "ScanViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Demo";
    [self initializedUI];
    
    UIBarButtonItem * scanBtn = [[UIBarButtonItem alloc] initWithTitle:@"scan" style:UIBarButtonItemStyleDone target:self action:@selector(scanAction)];
    self.navigationItem.rightBarButtonItems = @[scanBtn];
    
}
 
- (void)initializedUI {
    
}

- (void)scanAction {
    ScanViewController * scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}

@end
