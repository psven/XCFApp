//
//  XCFCartSettlementView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

// 购物车编辑类型
typedef NS_ENUM(NSInteger, XCFCartEditStyle) {
    XCFCartEditStyleSettlement, // 结算
    XCFCartEditStyleDelete      // 删除
};

#import <UIKit/UIKit.h>
@class XCFCartItem;

@interface XCFCartSettlementView : UIView

@property (nonatomic, assign) XCFCartEditStyle style;
@property (nonatomic, assign) XCFCartItemState state; // 全选状态
@property (nonatomic, strong) NSArray<XCFCartItem *> *totalItemsArray; // 所有商品数据
@property (nonatomic, copy) void (^selectedAllItemBlock)(XCFCartItemState);      // 选中全部商品回调
@property (nonatomic, copy) void (^settleOrDeleteBlock)();       // 结算/删除回调

@end
