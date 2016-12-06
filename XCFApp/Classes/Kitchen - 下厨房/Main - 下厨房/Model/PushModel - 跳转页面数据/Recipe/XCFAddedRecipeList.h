//
//  XCFAddedRecipeList.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  被加入的菜单数据
 */
#import <Foundation/Foundation.h>
@class XCFRecipeList;

@interface XCFAddedRecipeList : NSObject
/** 当前显示的“被加入的菜单”数量 */
@property (nonatomic, assign) NSUInteger count;
/** “被加入的菜单”总数量  */
@property (nonatomic, assign) NSUInteger total;
/** 菜单数组 */
@property (nonatomic, strong) NSArray<XCFRecipeList *> *recipe_lists;

@end
