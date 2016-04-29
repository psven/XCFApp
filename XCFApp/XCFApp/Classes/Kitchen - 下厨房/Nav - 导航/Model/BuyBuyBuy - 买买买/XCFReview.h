//
//  XCFReview.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor, XCFComment, XCFReviewCommodity, XCFDiggUsers, XCFReviewPhoto;

@interface XCFReview : NSObject
/** 评价内容 */
@property (nonatomic, copy) NSString *review;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 显示的创建时间 */
@property (nonatomic, copy) NSString *friendly_create_time;
/** 追加评价 */
@property (nonatomic, copy) NSString *additional_review;
/** 追加评论的创建时间 */
@property (nonatomic, copy) NSString *additional_review_create_time;
/** 商家回复 */
@property (nonatomic, copy) NSString *shop_reply;
/** 评价图片数组 */
@property (nonatomic, strong) NSArray<XCFReviewPhoto *> *photos;
/** 追加评价的图片数组 */
@property (nonatomic, strong) NSArray<XCFReviewPhoto *> *additional_review_photos;
/** 评价分数 */
@property (nonatomic, assign) CGFloat rate;
/** 评论网页url */
@property (nonatomic, copy) NSString *url;
/** 是否为精华？ */
@property (nonatomic, assign) BOOL is_essential;
/** 是否公开 */
@property (nonatomic, assign) BOOL is_published;
/** 商品ID */
@property (nonatomic, copy) NSString *goods_id;
/** 商品 */
@property (nonatomic, strong) XCFReviewCommodity *commodity;


/** 作者 */
@property (nonatomic, strong) XCFAuthor *author;
/** 该评价的ID */
@property (nonatomic, strong) NSString *ID;
/** 该评价的评论数 */
@property (nonatomic, copy) NSString *ncomments;
/** ??类型 */
@property (nonatomic, assign) NSInteger type;
/** 点赞的用户 */
@property (nonatomic, strong) XCFDiggUsers *digg_users;
/** 点赞的数量 */
@property (nonatomic, copy) NSString *ndiggs;
/** 最后评论 */
@property (nonatomic, strong) NSArray<XCFComment *> *latest_comments;
/** 是否被我点赞 */
@property (nonatomic, assign) BOOL digged_by_me;

/** 买买买cellHeight */
@property (nonatomic, assign) CGFloat buyCellHeight;
/** 评价cellHeight */
@property (nonatomic, assign) CGFloat reviewCellHeight;

@end
