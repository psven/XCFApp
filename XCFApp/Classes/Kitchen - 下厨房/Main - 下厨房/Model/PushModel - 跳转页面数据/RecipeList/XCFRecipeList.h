//
//  XCFRecipeList.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor, XCFRecipe;

@interface XCFRecipeList : NSObject
/** 菜单作者 */
@property (nonatomic, strong) XCFAuthor *author;
/** 菜谱id数组 */
@property (nonatomic, strong) NSArray<NSString *> *recipes;
/** 菜谱详情数组 */
@property (nonatomic, strong) NSArray<XCFRecipe *> *sample_recipes;
/** 第一个菜谱 */
@property (nonatomic, strong) XCFRecipe *first_recipe;

/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 更新时间 */
@property (nonatomic, copy) NSString *update_time;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 菜单id */
@property (nonatomic, copy) NSString *ID;
/** 菜单描述 */
@property (nonatomic, copy) NSString *desc;
/** 菜单网页url */
@property (nonatomic, copy) NSString *url;
/** 图片 */
@property (nonatomic, copy) NSString *photo;
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail;
/** 收藏此菜单的人数 */
@property (nonatomic, copy) NSString *ncollects;
/** 菜单内菜谱数 */
@property (nonatomic, copy) NSString *nrecipes;

/** 是否由我收集 */
@property (nonatomic, assign) BOOL collected_by_me;
/** 未知 */
@property (nonatomic, assign) NSInteger pv;


/** 菜单headerHeight */
@property (nonatomic, assign) CGFloat headerheight;
/** 菜单作者名字承载view宽度 */
@property (nonatomic, assign) CGFloat authorNameViewWidth;

@end
