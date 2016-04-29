//
//  XCFCartItemTool.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFCartItem;

@interface XCFCartItemTool : NSObject

/**
 *  更新数据
 */
+ (void)update;

/**
 *  获取所有商品
 *
 *  @return 所有商品
 */
+ (NSArray *)totalItems;

/**
 *  所有商品数（同个商品多个数量也计算在内，例如：鸡蛋 2个 所有商品数为2）
 */
+ (NSUInteger)totalNumber;



/**********************添加**********************/

/**
 *  添加一个商品
 *
 *  @param item 商品
 */
+ (void)addItem:(XCFCartItem *)item;

/**
 *  随机添加一个商品
 *
 *  @param callback 返回添加商品的名称
 */
+ (void)addItemRandomly:(void (^)(NSString *))itemNameCallback;



/**********************更新**********************/

/**
 *  点选单个商品后调用：更新指定位置的商品信息，如：是否购买、购买数量
 *
 *  @param indexPath 商品所在indexPath
 *  @param item  用来更新的商品
 */
+ (void)updateItemAtIndexPath:(NSIndexPath *)indexPath
                     withItem:(XCFCartItem *)item;

/**
 *  全选一个店铺的所有商品后调用：更新一个店铺内所有商品的信息
 *
 *  @param index 店铺数组在总数组中的位置
 *  @param array 用来更新的店铺数组
 */
+ (void)updateShopArrayAtIndex:(NSUInteger)index
                 withShopArray:(NSArray<XCFCartItem *> *)array;

/**
 *  全选后调用：更新所有商品选中状态
 *
 *  @param state 状态：全选/全不选
 */
+ (void)updateAllItemState:(XCFCartItemState)state;



/**********************删除**********************/

/**
 *  删除选中的商品
 */
+ (void)removeSelectedItem;

/**
 *  删除一个或者同时删除多个商品
 *
 *  @param array 位置数组：包含了每个商品所在的indexPath
 */
//+ (void)removeItemByIndexPathArray:(NSArray<NSIndexPath *> *)array;

/**
 *  清空购物车
 */
+ (void)removeAllItem;


/**
 *  取消所有商品的选中(离开购物车界面，不保存选中状态)
 */
+ (void)resetItemState;


/**
 *  需要购买的商品(订单界面使用)
 */
+ (NSArray *)totalBuyItems;

@end
