//
//  XCFPopEvent.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFPopEvent.h"

@implementation XCFPopEvent

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id",
             @"thumbnail_280" : @"dishes.dishes[0].thumbnail_280"};
}

@end
