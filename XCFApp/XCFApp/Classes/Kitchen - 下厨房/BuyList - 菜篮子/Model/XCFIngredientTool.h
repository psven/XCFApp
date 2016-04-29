//
//  XCFIngredientTool.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFRecipe, XCFRecipeIngredient;

@interface XCFIngredientTool : NSObject

/**
 *  更新数据
 */
+ (void)update;

/**
 *  获取所有菜谱及原料
 */
+ (NSArray *)totalRecipeIngredients;

/**
 *  点选单个原料后调用：更新原料购买状态（是否购买）
 *
 *  @param indexPath 原料所在indexPath
 *  @param item  用来更新的原料
 */
+ (void)updateSingleIngredientWithRecipe:(XCFRecipe *)recipe index:(NSUInteger)index;

/**
 *  获取所有原料
 */
+ (NSArray *)totalIngredients;

/**
 *  点选单个原料后调用：更新原料购买状态（是否购买）
 *
 *  @param indexPath 原料所在indexPath
 *  @param item  用来更新的原料
 */
+ (void)updateIngredient:(XCFRecipeIngredient *)ingredient;

/**
 *  删除一个菜谱的所有原料
 */
+ (void)removeRecipeAtIndex:(NSUInteger)index;

/**
 *  清空所有原料
 */
+ (void)removeAllIngredient;

@end
