//
//  XCFFeeds.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFRecipe, XCFDish;

@interface XCFFeeds : NSObject
/** 菜单详情 */
@property (nonatomic, strong) XCFDish *dish;
/** 菜谱详情 */
//@property (nonatomic, strong) XCFRecipe *recipe;
/** 类型 */
@property (nonatomic, assign) NSInteger kind;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 评论数 */
@property (nonatomic, assign) NSInteger ncomment;

@end
