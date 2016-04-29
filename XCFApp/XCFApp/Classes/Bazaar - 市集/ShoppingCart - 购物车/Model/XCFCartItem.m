//
//  XCFCartItem.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartItem.h"
#import "XCFGoods.h"
#import "XCFGoodsKind.h"

@implementation XCFCartItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"goods"     : @"commodity.goods",
             @"kind_name" : @"commodity.kind_name",
             @"number"    : @"commodity.number"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_state      forKey:@"state"];
    [aCoder encodeObject:_goods       forKey:@"goods"];
    [aCoder encodeObject:_kind_name   forKey:@"kind_name"];
    [aCoder encodeInteger:_number     forKey:@"number"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.state       = [decoder decodeIntegerForKey:@"state"];
        self.goods       = [decoder decodeObjectForKey:@"goods"];
        self.kind_name   = [decoder decodeObjectForKey:@"kind_name"];
        self.number      = [decoder decodeIntegerForKey:@"number"];
    }
    return self;
}

- (double)displayPrice {
    for (XCFGoodsKind *kind in self.goods.kinds) {
        if ([kind.name isEqualToString:self.kind_name]) _displayPrice = kind.price;
    }
    return _displayPrice;
}

- (double)displayOriginPrice {
    for (XCFGoodsKind *kind in self.goods.kinds) {
        if ([kind.name isEqualToString:self.kind_name]) _displayOriginPrice = kind.original_price;
    }
    return _displayOriginPrice;
}

@end
