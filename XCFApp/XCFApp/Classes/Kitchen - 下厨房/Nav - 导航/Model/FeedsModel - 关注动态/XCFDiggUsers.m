//
//  XCFDiggUsers.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDiggUsers.h"
#import "XCFAuthor.h"

@implementation XCFDiggUsers

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"users" : [XCFAuthor class]};
}

@end
