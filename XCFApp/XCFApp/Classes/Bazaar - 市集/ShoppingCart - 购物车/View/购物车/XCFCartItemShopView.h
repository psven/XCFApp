//
//  XCFCartItemShopView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XCFCartShopState) {
    XCFCartShopStateNone,
    XCFCartShopStateSelected
};

#import <UIKit/UIKit.h>

@class XCFCartItem;

@interface XCFCartItemShopView : UITableViewHeaderFooterView

@property (nonatomic, assign) XCFCartViewChildControlStyle style;            // 控件类型
@property (nonatomic, assign) XCFCartShopState state;                        // 店铺点选状态
@property (nonatomic, strong) XCFCartItem *cartItem;                         // 模型数据
@property (nonatomic, copy) void (^selectedShopItemsBlock)(NSUInteger);      // 选中该店铺所有商品回调

@end
