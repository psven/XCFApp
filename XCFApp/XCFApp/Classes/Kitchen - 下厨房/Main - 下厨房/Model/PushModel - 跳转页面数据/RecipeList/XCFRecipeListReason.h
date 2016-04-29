//
//  XCFRecipeListReason.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜单内菜谱理由数据
 */
#import <Foundation/Foundation.h>

@interface XCFRecipeListReason : NSObject
/** 理由 */
@property (nonatomic, copy) NSString *reason;
/** 被评论的菜谱id */
@property (nonatomic, copy) NSString *recipe_id;

@end
