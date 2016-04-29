//
//  XCFLocation.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFLocation.h"
#import "XCFCity.h"

@implementation XCFLocation

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _province_id = dict[@"province_id"];
        _province_name = dict[@"province_name"];

        NSArray *citiesArray = [NSMutableArray arrayWithArray:dict[@"cities"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in citiesArray) {
            XCFCity *city = [XCFCity cityWithDict:dict];
            [newArray addObject:city];
        }
        _cities = newArray;
        
    }
    return self;
}

+ (instancetype)locationWithDict:(NSDictionary *)dict {
    return [[XCFLocation alloc] initWithDict:dict];
}
    
@end
