//
//  XCFConstString.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 菜篮子数据key */
UIKIT_EXTERN NSString *const XCFBasketKey;

/** 实心star */
UIKIT_EXTERN NSString *const enabledStar;
/** 空心star */
UIKIT_EXTERN NSString *const disabledStar;
/** 半个star */
UIKIT_EXTERN NSString *const halfStar;

/** 加入菜篮子通知 */
UIKIT_EXTERN NSString *const XCFBasketListDidAddIngredientNotification;
/** 加入购物车通知 */
UIKIT_EXTERN NSString *const XCFCartDidAddedGoodsNotification;