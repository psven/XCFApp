//
//  XCFDetailArea.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDetailArea.h"

@implementation XCFDetailArea

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID       = dict[@"id"];
        _areaName = dict[@"areaName"];
    }
    return self;
}

+ (instancetype)detailAreaWithDict:(NSDictionary *)dict {
    return [[XCFDetailArea alloc] initWithDict:dict];
}

@end
