//
//  XCFRecipeListHeader.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/6.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFRecipeList;

@interface XCFRecipeListHeader : UIView

/** 模型数据 */
@property (nonatomic, strong) XCFRecipeList *recipeList;
/** 收藏按钮点击事件 */
@property (nonatomic, copy) void (^collectActionBlock)();

@end
