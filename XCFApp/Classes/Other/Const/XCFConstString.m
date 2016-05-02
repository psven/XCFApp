//
//  XCFConstString.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 菜篮子数据key */
NSString *const XCFBasketKey = @"XCFBasketKey";

/** 实心star */
NSString *const enabledStar = @"yellowStar13Enabled";
/** 空心star */
NSString *const disabledStar = @"yellowStar13Disabled";
/** 半个star */
NSString *const halfStar = @"yellowStar13Half";

/** 加入菜篮子通知 */
NSString *const XCFBasketListDidAddIngredientNotification = @"XCFBasketListDidAddIngredientNotification";
/** 加入购物车通知 */
NSString *const XCFCartItemTotalNumberDidChangedNotification = @"XCFCartItemTotalNumberDidChangedNotification";