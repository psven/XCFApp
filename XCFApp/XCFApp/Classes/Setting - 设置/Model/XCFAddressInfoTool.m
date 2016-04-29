//
//  XCFAddressInfoTool.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddressInfoTool.h"
#import "XCFAddressInfo.h"

#define XCFAddressInfosPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"addressInfo.data"]

@implementation XCFAddressInfoTool

static NSMutableArray *_addressInfos;

+ (NSArray *)totalAddressInfo {
    _addressInfos = [NSKeyedUnarchiver unarchiveObjectWithFile:XCFAddressInfosPath];
    if (!_addressInfos) _addressInfos = [NSMutableArray array];
    return _addressInfos;
}

+ (XCFAddressInfo *)currentSelectedAddress {
    XCFAddressInfo *currentAddress;
    if ([self totalAddressInfo].count) {
        for (XCFAddressInfo *info in _addressInfos) {
            if (info.state == XCFAddressInfoCellStateSelected) currentAddress = info;
        }
    } else {
        currentAddress = nil;
    }
    return currentAddress;
}

+ (void)update {
    [NSKeyedArchiver archiveRootObject:_addressInfos toFile:XCFAddressInfosPath];
}

+ (void)setSelectedAddressInfoByNewInfoArray:(NSArray *)infoArray {
    [NSKeyedArchiver archiveRootObject:infoArray toFile:XCFAddressInfosPath];
}

+ (void)addInfo:(XCFAddressInfo *)info {
    if (!_addressInfos.count) _addressInfos = [NSMutableArray array];
    for (XCFAddressInfo *oldInfo in _addressInfos) { // 添加了新地址 默认使用新地址，那么在这里将之前所有的地址设置为不使用
        oldInfo.state = XCFAddressInfoCellStateNone;
    }
    [_addressInfos addObject:info];
    [self update];
}

+ (void)removeInfoAtIndex:(NSUInteger)index {
    [_addressInfos removeObjectAtIndex:index];
    [self update];
}

+ (void)updateInfoAtIndex:(NSUInteger)index withInfo:(XCFAddressInfo *)info {
    [_addressInfos replaceObjectAtIndex:index withObject:info];
    [self update];
}

@end
