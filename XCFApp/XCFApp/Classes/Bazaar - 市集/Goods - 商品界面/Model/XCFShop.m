//
//  XCFShop.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFShop.h"

@implementation XCFShop

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"shop_logo_url" : @"shop_logo.url",
             @"shop_icon_url" : @"shop_icon.url",
             @"ID" : @"id"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"promotion_text_list" : [NSString class]};
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_announcement              forKey:@"announcement"];
    [aCoder encodeObject:_shop_logo_url             forKey:@"shop_logo_url"];
    [aCoder encodeObject:_name                      forKey:@"name"];
    [aCoder encodeObject:_goods_count               forKey:@"goods_count"];
    [aCoder encodeObject:_url                       forKey:@"url"];
    [aCoder encodeObject:_promotion_text_list       forKey:@"promotion_text_list"];
    [aCoder encodeObject:_free_delivery_desc        forKey:@"free_delivery_desc"];
    [aCoder encodeObject:_phone                     forKey:@"phone"];
    [aCoder encodeObject:_shop_icon_url             forKey:@"shop_icon_url"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.announcement               = [decoder decodeObjectForKey:@"announcement"];
        self.shop_logo_url              = [decoder decodeObjectForKey:@"shop_logo_url"];
        self.name                       = [decoder decodeObjectForKey:@"name"];
        self.goods_count                = [decoder decodeObjectForKey:@"goods_count"];
        self.url                        = [decoder decodeObjectForKey:@"url"];
        self.promotion_text_list        = [decoder decodeObjectForKey:@"promotion_text_list"];
        self.free_delivery_desc         = [decoder decodeObjectForKey:@"free_delivery_desc"];
        self.phone                      = [decoder decodeObjectForKey:@"phone"];
        self.shop_icon_url              = [decoder decodeObjectForKey:@"shop_icon_url"];
    }
    return self;
}

@end
