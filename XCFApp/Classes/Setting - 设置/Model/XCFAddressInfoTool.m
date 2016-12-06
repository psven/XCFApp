//
//  XCFAddressInfoTool.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
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
    BOOL hasSelectedAddress = NO;
    if ([self totalAddressInfo].count) {
        for (XCFAddressInfo *info in _addressInfos) {
            // 遍历数组内的收货地址数据，是选中就返回
            if (info.state == XCFAddressInfoCellStateSelected) {
                currentAddress = info;
                hasSelectedAddress = YES;
                break;
            }
        }
    } else if ([self totalAddressInfo].count == 0 || hasSelectedAddress) {
        currentAddress = nil;
    }
    return currentAddress;
}

+ (void)update {
    [NSKeyedArchiver archiveRootObject:_addressInfos toFile:XCFAddressInfosPath];
}

+ (void)updateInfoAfterDeleted {
    // 如果当前没有选中的收货地址，就设置第0个为选中的收货地址
    if (_addressInfos.count) {
        if (![self currentSelectedAddress]) {
            XCFAddressInfo *info = [XCFAddressInfoTool totalAddressInfo][0];
            info.state = XCFAddressInfoCellStateSelected;
            [XCFAddressInfoTool updateInfoAtIndex:0 withInfo:info];
        }
    }
}

+ (void)setSelectedAddressInfoByNewInfoArray:(NSArray *)infoArray {
    [NSKeyedArchiver archiveRootObject:infoArray toFile:XCFAddressInfosPath];
}

+ (void)addInfo:(XCFAddressInfo *)info {
    if (!_addressInfos.count) _addressInfos = [NSMutableArray array];
    // 添加了新地址 默认添加到第一位，并使用新地址，那么在这里将之前所有的地址设置为不使用
    for (XCFAddressInfo *oldInfo in _addressInfos) {
        oldInfo.state = XCFAddressInfoCellStateNone;
    }
    [_addressInfos insertObject:info atIndex:0];
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
