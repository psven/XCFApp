//
//  XCFCity.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCity.h"

@implementation XCFCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[XCFCity alloc] initWithDict:dict];
}

@end
