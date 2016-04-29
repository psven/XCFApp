//
//  XCFRecipeStats.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜谱状态
 */
#import <Foundation/Foundation.h>

@interface XCFRecipeStats : NSObject
/** 被收藏次数 */
@property (nonatomic, copy) NSString *n_collects;
/** 评论数 */
@property (nonatomic, copy) NSString *n_comments;
/** 做过的人数 */
@property (nonatomic, copy) NSString *n_cooked;
/** 作品数 */
@property (nonatomic, copy) NSString *n_dishes;
/** 最近7天做过人数 */
@property (nonatomic, copy) NSString *n_cooked_last_week;
/** 是否由我制作（作用未知） */
@property (nonatomic, assign) BOOL cooked_by_me;
/** 未知 */
@property (nonatomic, copy) NSString *n_pv;

@end
