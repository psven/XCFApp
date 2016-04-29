//
//  XCFNavContent.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFNavContent.h"
#import "XCFNav.h"

@implementation XCFNavContent

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"navs" : [XCFNav class]};
}

@end
