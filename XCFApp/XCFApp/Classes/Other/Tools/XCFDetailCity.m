//
//  XCFDetailCity.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDetailCity.h"
#import "XCFDetailArea.h"

@implementation XCFDetailCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = dict[@"id"];
        _cityName = dict[@"cityName"];
        
        NSArray *areaArray = [NSMutableArray arrayWithArray:dict[@"arealist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in areaArray) {
            XCFDetailArea *city = [XCFDetailArea detailAreaWithDict:dict];
            [newArray addObject:city];
        }
        _arealist = newArray;
        
    }
    return self;
}

+ (instancetype)detailCityWithDict:(NSDictionary *)dict {
    return [[XCFDetailCity alloc] initWithDict:dict];
}

@end
