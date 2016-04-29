//
//  XCFRecipeCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

/// 首页cell
#import <UIKit/UIKit.h>
@class XCFItems, XCFRecipe, XCFCreateRecipe;

@interface XCFRecipeCell : UITableViewCell
/**  */
@property (nonatomic, strong) XCFItems *item;
/** 菜谱数据 */
@property (nonatomic, strong) XCFRecipe *recipe;

/** 事件block */
@property (nonatomic, copy) void (^authorIconClickedBlock)();

@end
