//
//  XCFGoods.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFShop, XCFGoodsAttrs, XCFReviewPhoto, XCFGoodsKind, XCFReview;

@interface XCFGoods : NSObject <NSCoding>

/** 主图 */
@property (nonatomic, strong) XCFReviewPhoto *main_pic;
/** 附加图片 */
@property (nonatomic, strong) NSArray<XCFReviewPhoto *> *extra_pics;
/** 所有图片 */
@property (nonatomic, strong) NSArray<XCFReviewPhoto *> *totalPics;


/** 平均评分 */
@property (nonatomic, copy) NSString *average_rate;
/** 月销量 */
@property (nonatomic, copy) NSString *recent_30days_sales_volume;
/** 总销量 */
@property (nonatomic, copy) NSString *total_sales_volume;
/** 商品id */
@property (nonatomic, copy) NSString *ID;
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 前置文字 */
@property (nonatomic, copy) NSString *foreword;
/** 运费 */
@property (nonatomic, copy) NSString *freight;
/** 显示的运费 */
@property (nonatomic, copy) NSString *display_freight;
/** 原价格 */
@property (nonatomic, copy) NSString *display_original_price;
/** 显示价格 */
@property (nonatomic, copy) NSString *display_price;
/** 商品促销信息 */
@property (nonatomic, strong) NSArray<NSString *> *promotion_text_list;


/** 商品描述 */
@property (nonatomic, copy) NSString *desc;
/** 店铺信息 */
@property (nonatomic, strong) XCFShop *shop;


/** 评价数量 */
@property (nonatomic, copy) NSString *n_reviews;
/** 评价 */
@property (nonatomic, strong) NSArray<XCFReview *> *reviews;


/** 图文详情url */
@property (nonatomic, copy) NSString *img_txt_detail_url;
/** 详细属性 */
@property (nonatomic, strong) NSArray<XCFGoodsAttrs *> *attrs;


/** 限制？ */
@property (nonatomic, assign) NSInteger limit;
/** 商品分类 */
@property (nonatomic, copy) NSString *category;
/** 商品url 直接跳转 */
@property (nonatomic, copy) NSString *desc_url;
/** 未知 */
@property (nonatomic, assign) NSInteger sale;
/** 我购买的数量？ */
@property (nonatomic, assign) NSInteger quantity_by_me;
/** 类型 */
@property (nonatomic, assign) NSInteger type;
/** 商品kind */
@property (nonatomic, strong) NSArray<XCFGoodsKind *> *kinds;


/** 商品信息viewHeight */
@property (nonatomic, assign) CGFloat goodsDetailViewHeight;
/** 店铺信息viewHeight */
@property (nonatomic, assign) CGFloat shopPromotionViewHeight;

@end
