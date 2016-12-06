//
//  XCFDetailLocation.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDetailLocation.h"
#import "XCFDetailCity.h"

@implementation XCFDetailLocation

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = dict[@"id"];
        _provinceName = dict[@"provinceName"];
        
        NSArray *citiesArray = [NSMutableArray arrayWithArray:dict[@"citylist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in citiesArray) {
            XCFDetailCity *city = [XCFDetailCity detailCityWithDict:dict];
            [newArray addObject:city];
        }
        _citylist = newArray;
        
    }
    return self;
}

+ (instancetype)detailLocationWithDict:(NSDictionary *)dict {
    return [[XCFDetailLocation alloc] initWithDict:dict];
}

@end
