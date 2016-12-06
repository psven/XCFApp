//
//  XCFRecipe.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/// 模板5：菜谱
#import <Foundation/Foundation.h>
@class XCFRecipeStats, XCFRecipeInstruction, XCFRecipeIngredient, XCFAuthor;

@interface XCFRecipe : NSObject <NSCoding>
/** 菜谱制作步骤介绍数组 */
@property (nonatomic, strong) NSArray<XCFRecipeInstruction *> *instruction;
/** 菜谱用料数组 */
@property (nonatomic, strong) NSMutableArray<XCFRecipeIngredient *> *ingredient;
/** 菜谱状态 */
@property (nonatomic, strong) XCFRecipeStats *stats;
/** 作品作者数组（未知） */
@property (nonatomic, strong) NSArray<XCFAuthor *> *dish_author;
/** 菜谱作者 */
@property (nonatomic, strong) XCFAuthor *author;

/** 视频地址 */
@property (nonatomic, copy) NSString *video_url;
/** 视频页面url */
@property (nonatomic, copy) NSString *video_page_url;
/** 创建时间 */
@property (nonatomic, copy) NSString *friendly_create_time;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 是否为独家 */
@property (nonatomic, assign) BOOL is_exclusive;
/** 菜谱id */
@property (nonatomic, copy) NSString *ID;
/** 分数 */
@property (nonatomic, copy) NSString *score;
/** 小贴士(有则显示) */
@property (nonatomic, copy) NSString *tips;
/** 一键购买url（直接跳转） */
@property (nonatomic, copy) NSString *purchase_url;
/** 菜谱url */
@property (nonatomic, copy) NSString *url;
/** 菜谱描述 */
@property (nonatomic, copy) NSString *desc;
/** 菜谱简述 */
@property (nonatomic, copy) NSString *summary;
/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;
/** 菜谱标题 */
@property (nonatomic, copy) NSString *name;

/** 缩略图 */
@property (nonatomic, copy) NSString *thumb;
/** 菜谱图片 */
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *photo80;
@property (nonatomic, copy) NSString *photo90;
@property (nonatomic, copy) NSString *photo140;
@property (nonatomic, copy) NSString *photo280;
@property (nonatomic, copy) NSString *photo340;
@property (nonatomic, copy) NSString *photo526;
@property (nonatomic, copy) NSString *photo580;
@property (nonatomic, copy) NSString *photo640;


/** 菜谱headerHeight */
@property (nonatomic, assign) CGFloat headerheight;
/** 菜谱评分、做过人数承载view宽度 */
@property (nonatomic, assign) CGFloat statsViewWidth;


@end
