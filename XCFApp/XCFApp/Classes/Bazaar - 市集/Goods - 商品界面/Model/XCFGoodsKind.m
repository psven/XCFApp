//
//  XCFGoodsKind.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsKind.h"

@implementation XCFGoodsKind

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_original_price       forKey:@"original_price"];
    [aCoder encodeDouble:_price                 forKey:@"price"];
    [aCoder encodeObject:_name                  forKey:@"name"];
    [aCoder encodeInteger:_stock                forKey:@"stock"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.original_price         = [decoder decodeIntegerForKey:@"original_price"];
        self.price                  = [decoder decodeDoubleForKey:@"price"];
        self.name                   = [decoder decodeObjectForKey:@"name"];
        self.stock                  = [decoder decodeIntegerForKey:@"stock"];
    }
    return self;
}

@end
