//
//  XCFFeedsContent.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFFeedsContent.h"
#import "XCFFeeds.h"

@implementation XCFFeedsContent

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"feeds" : [XCFFeeds class]};
}

@end
