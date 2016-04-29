//
//  XCFRecipeIngredient.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

// 菜篮子中用料购买状态
typedef NS_ENUM(NSInteger, XCFIngredientState) {
    XCFIngredientStateNone,
    XCFIngredientStatePurchased // 已购买
};

/**
 *  菜谱用料
 */
#import <Foundation/Foundation.h>

@interface XCFRecipeIngredient : NSObject <NSCoding>
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 用量 */
@property (nonatomic, copy) NSString *amount;
/** 未知 */
@property (nonatomic, copy) NSString *cat;
/** 选中状态 */
@property (nonatomic, assign) XCFIngredientState state;

/** 用料cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
