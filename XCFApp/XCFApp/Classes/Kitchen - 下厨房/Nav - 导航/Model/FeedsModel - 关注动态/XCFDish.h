//
//  XCFDish.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

 /// 模板4：作品

#import <Foundation/Foundation.h>
@class XCFComment, XCFAuthor, XCFPicture, XCFDiggUsers, XCFEvents;

@interface XCFDish : NSObject

/** 最后评论 */
@property (nonatomic, strong) NSArray<XCFComment *> *latest_comments;
/** 分享才有的数据 */
@property (nonatomic, strong) NSArray<XCFEvents *> *events;
/** 附加图 */
@property (nonatomic, strong) NSArray<XCFPicture *> *extra_pics;
///** 附加图 */
//@property (nonatomic, strong) NSArray<XCFPicture *> *pic_tags;
///** 附加图 */
//@property (nonatomic, strong) NSArray<XCFAuthor *> *at_users;

/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;
/** 图片地址（尺寸600） */
@property (nonatomic, copy) NSString *photo;
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail;
/** 缩略图（尺寸160） */
@property (nonatomic, copy) NSString *thumbnail_160;
/** 缩略图（尺寸280） */
@property (nonatomic, copy) NSString *thumbnail_280;

/** 显示时间 */
@property (nonatomic, copy) NSString *friendly_create_time;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 图片总数 */
@property (nonatomic, assign) NSInteger npics;
/** 评论数 */
@property (nonatomic, assign) NSInteger ncomments;
/** 发表动态的作者 */
@property (nonatomic, strong) XCFAuthor *author;
/** 菜谱名称\要显示的标题 */
@property (nonatomic, copy) NSString *name;
/** 文字描述 */
@property (nonatomic, copy) NSString *desc;
/** 主图 */
@property (nonatomic, strong) XCFPicture *main_pic;
/** 菜谱id */
@property (nonatomic, copy) NSString *ID;

/** 点赞数 */
@property (nonatomic, copy) NSString *ndiggs;
/** 点赞用户 */
@property (nonatomic, strong) XCFDiggUsers *digg_users;
/** 菜谱id 返回值一直是0 作用未知*/
@property (nonatomic, copy) NSString *recipe_id;
/** 是否为分享的内容 */
@property (nonatomic, assign) BOOL is_orphan;
/** 未知 */
@property (nonatomic, assign) BOOL digged_by_me;

/** 作品cellHeight */
@property (nonatomic, assign) CGFloat dishCellHeight;
/** 作品commentViewHeight */
@property (nonatomic, assign) CGFloat commentViewHeight;

@end
