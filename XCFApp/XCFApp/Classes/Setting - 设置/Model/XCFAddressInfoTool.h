//
//  XCFAddressInfoTool.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAddressInfo;

@interface XCFAddressInfoTool : NSObject

/**
 *  全部地址
 *
 */
+ (NSArray *)totalAddressInfo;

/**
 *  当前选中地址
 *
 */
+ (XCFAddressInfo *)currentSelectedAddress;

+ (void)update;

/**
 *  通过刷新整个数组来更新收货地址中选中使用的收货地址
 *
 *  @param infoArray 新的数组
 */
+ (void)setSelectedAddressInfoByNewInfoArray:(NSArray *)infoArray;
+ (void)addInfo:(XCFAddressInfo *)info;
+ (void)removeInfoAtIndex:(NSUInteger)index;
+ (void)updateInfoAtIndex:(NSUInteger)index withInfo:(XCFAddressInfo *)info;

@end
