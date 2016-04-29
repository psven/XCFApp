//
//  XCFGoods.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoods.h"
#import "XCFShop.h"
#import "XCFGoodsAttrs.h"
#import "XCFReviewPhoto.h"
#import "XCFGoodsKind.h"
#import "XCFReview.h"
#import <MJExtension.h>

@implementation XCFGoods

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"attrs" : [XCFGoodsAttrs class],
             @"extra_pics" : [XCFReviewPhoto class],
             @"kinds" : [XCFGoodsKind class],
             @"promotion_text_list" : [NSString class],
             @"reviews" : [XCFReview class]};
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_main_pic                          forKey:@"main_pic"];
    [aCoder encodeObject:_average_rate                      forKey:@"average_rate"];
    [aCoder encodeObject:_recent_30days_sales_volume        forKey:@"recent_30days_sales_volume"];
    [aCoder encodeObject:_total_sales_volume                forKey:@"total_sales_volume"];
    [aCoder encodeObject:_name                              forKey:@"name"];
    [aCoder encodeObject:_foreword                          forKey:@"foreword"];
    [aCoder encodeObject:_freight                           forKey:@"freight"];
    [aCoder encodeObject:_display_freight                   forKey:@"display_freight"];
    [aCoder encodeObject:_display_original_price            forKey:@"display_original_price"];
    [aCoder encodeObject:_display_price                     forKey:@"display_price"];
    [aCoder encodeObject:_promotion_text_list               forKey:@"promotion_text_list"];
    [aCoder encodeObject:_desc                              forKey:@"desc"];
    [aCoder encodeObject:_shop                              forKey:@"shop"];
    [aCoder encodeObject:_n_reviews                         forKey:@"n_reviews"];
    [aCoder encodeObject:_img_txt_detail_url                forKey:@"img_txt_detail_url"];
    [aCoder encodeObject:_kinds                             forKey:@"kinds"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.main_pic                           = [decoder decodeObjectForKey:@"main_pic"];
        self.extra_pics                         = [decoder decodeObjectForKey:@"extra_pics"];
        self.average_rate                       = [decoder decodeObjectForKey:@"average_rate"];
        self.recent_30days_sales_volume         = [decoder decodeObjectForKey:@"recent_30days_sales_volume"];
        self.total_sales_volume                 = [decoder decodeObjectForKey:@"total_sales_volume"];
        self.name                               = [decoder decodeObjectForKey:@"name"];
        self.foreword                           = [decoder decodeObjectForKey:@"foreword"];
        self.freight                            = [decoder decodeObjectForKey:@"freight"];
        self.display_freight                    = [decoder decodeObjectForKey:@"display_freight"];
        self.display_original_price             = [decoder decodeObjectForKey:@"display_original_price"];
        self.display_price                      = [decoder decodeObjectForKey:@"display_price"];
        self.promotion_text_list                = [decoder decodeObjectForKey:@"promotion_text_list"];
        self.desc                               = [decoder decodeObjectForKey:@"desc"];
        self.shop                               = [decoder decodeObjectForKey:@"shop"];
        self.n_reviews                          = [decoder decodeObjectForKey:@"n_reviews"];
        self.reviews                            = [decoder decodeObjectForKey:@"reviews"];
        self.img_txt_detail_url                 = [decoder decodeObjectForKey:@"img_txt_detail_url"];
        self.attrs                              = [decoder decodeObjectForKey:@"attrs"];
        self.kinds                              = [decoder decodeObjectForKey:@"kinds"];
        self.goodsDetailViewHeight              = [decoder decodeFloatForKey:@"goodsDetailViewHeight"];
        self.shopPromotionViewHeight            = [decoder decodeFloatForKey:@"shopPromotionViewHeight"];
    }
    return self;
}

- (NSArray<XCFReviewPhoto *> *)totalPics {
    
    NSMutableArray *imageArray = [NSMutableArray array];
    [imageArray addObject:self.main_pic];
    if (self.extra_pics.count) {
        NSArray *photosArray = [XCFReviewPhoto mj_objectArrayWithKeyValuesArray:self.extra_pics];
        [imageArray addObjectsFromArray:photosArray];
    }
    return imageArray;
}

- (CGFloat)goodsDetailViewHeight {
    
    CGFloat totalMargin = 60;               // 总的间距和
    CGFloat saleViewHeight = 40;            // 顶部销量高度
    CGFloat displayPriceLabelHeight = 18;   // 价格Label高度 粗略
    
    CGFloat labelWidth = XCFScreenWidth - 30;
    CGFloat forewordLabelHeight = [self.foreword getSizeWithTextSize:CGSizeMake(labelWidth, MAXFLOAT) fontSize:14].height; // 前置文字
    CGFloat nameLabelHeight = [self.name getSizeWithTextSize:CGSizeMake(labelWidth, MAXFLOAT) fontSize:18].height;         // 标题
    
    _goodsDetailViewHeight = saleViewHeight + totalMargin + displayPriceLabelHeight + forewordLabelHeight + nameLabelHeight;
    
    if (self.promotion_text_list.count) _goodsDetailViewHeight += 20+20; // 促销信息+间距
    
    return _goodsDetailViewHeight;
}

- (CGFloat)shopPromotionViewHeight {
    CGFloat margin = 20;
    CGFloat labelWidth = XCFScreenWidth - 30;
    CGFloat goodsDescLabelHeight = [self.desc getSizeWithTextSize:CGSizeMake(labelWidth, MAXFLOAT) fontSize:14].height;
    _shopPromotionViewHeight = goodsDescLabelHeight + margin*2;
    
    if (self.shop.promotion_text_list.count) _shopPromotionViewHeight += 40; // 如果有店铺促销 +店铺促销信息view高度
    
    if (self.shop.announcement.length) { // 如果有店铺公告 +店铺公告labelHeight +margin
        CGFloat announcementLabelHeight = [self.shop.announcement getSizeWithTextSize:CGSizeMake(labelWidth, MAXFLOAT) fontSize:14].height;
        _shopPromotionViewHeight += announcementLabelHeight + margin;
    }
    return _shopPromotionViewHeight;
}

@end
