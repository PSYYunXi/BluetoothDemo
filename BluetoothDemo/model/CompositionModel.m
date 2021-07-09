//
//  CompositionModel.m
//  BluetoothDemo
//
//  Created by yunxi on 2021/7/6.
//

#import "CompositionModel.h"

@implementation CompositionModel

- (NSMutableArray<ElementModel *> *)elements {
    if (!_elements) {
        _elements = [NSMutableArray new];
    }
    return _elements;
}

@end
