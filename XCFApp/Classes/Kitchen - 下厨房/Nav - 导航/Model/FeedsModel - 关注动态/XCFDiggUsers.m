//
//  XCFDiggUsers.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDiggUsers.h"
#import "XCFAuthor.h"

@implementation XCFDiggUsers

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"users" : [XCFAuthor class]};
}

@end
