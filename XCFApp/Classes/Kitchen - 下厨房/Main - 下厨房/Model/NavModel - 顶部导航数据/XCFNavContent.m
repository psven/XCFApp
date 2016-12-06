//
//  XCFNavContent.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFNavContent.h"
#import "XCFNav.h"

@implementation XCFNavContent

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"navs" : [XCFNav class]};
}

@end
