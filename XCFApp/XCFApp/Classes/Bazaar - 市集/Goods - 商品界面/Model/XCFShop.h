//
//  XCFShop.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFShop : NSObject <NSCoding>

/** 公告 */
@property (nonatomic, copy) NSString *announcement;
/** 店铺logoURL */
@property (nonatomic, copy) NSString *shop_logo_url;
/** 店铺名称 */
@property (nonatomic, copy) NSString *name;
/** 商品数 */
@property (nonatomic, copy) NSString *goods_count;
/** 店铺url 直接跳转 */
@property (nonatomic, copy) NSString *url;
/** 店铺促销活动 */
@property (nonatomic, strong) NSArray<NSString *> *promotion_text_list;
/** 包邮描述 */
@property (nonatomic, copy) NSString *free_delivery_desc;
/** 电话 */
@property (nonatomic, copy) NSString *phone;
/** 店铺ID */
@property (nonatomic, copy) NSString *ID;
/** 店铺iconURL */
@property (nonatomic, copy) NSString *shop_icon_url;

@end
