//
//  XCFRecipe.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIssues.h"
#import "XCFItems.h"

@implementation XCFIssues

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items" : [XCFItems class]};
}

@end
