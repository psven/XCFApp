//
//  XCFAddedRecipeList.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddedRecipeList.h"
#import "XCFRecipeList.h"

@implementation XCFAddedRecipeList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"recipe_lists" : [XCFRecipeList class]};
}

@end
