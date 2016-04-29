//
//  XCFIngredientTool.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientTool.h"
#import "XCFRecipe.h"
#import "XCFRecipeIngredient.h"
#import <MJExtension.h>

#define XCFRecipeIngredientPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recipeIngredients.data"]

@implementation XCFIngredientTool

static NSMutableArray *_recipeArray;
static NSMutableArray *_statArray;


+ (void)update {
    [NSKeyedArchiver archiveRootObject:_recipeArray toFile:XCFRecipeIngredientPath];
}

// 界面1
+ (NSArray *)totalRecipeIngredients {
    _recipeArray = [NSKeyedUnarchiver unarchiveObjectWithFile:XCFRecipeIngredientPath];
    if (!_recipeArray.count) {
        _recipeArray = [NSMutableArray array];
        _recipeArray = [XCFRecipe mj_objectArrayWithFilename:@"Ingredient.plist"];
    }
    return _recipeArray;
}

+ (void)updateSingleIngredientWithRecipe:(XCFRecipe *)recipe index:(NSUInteger)index {
    for (XCFRecipe *originRecipe in _recipeArray) {
        if ([originRecipe.name isEqualToString:recipe.name]) {
            XCFRecipeIngredient *ingredient = originRecipe.ingredient[index];
            ingredient.state = !ingredient.state;
        }
//        for (XCFRecipeIngredient *originIng in originRecipe.ingredient) {
//            if ([originIng.name isEqualToString:ingredient.name]
//                && [originIng.amount isEqualToString:ingredient.amount]) { // 完全符合才更新界面
//                originIng.state = !originIng.state;
//                break;
//            }
//        }
    }
    [self update];
}

// 界面2
+ (NSArray *)totalIngredients {
    if (!_statArray.count) {
        NSArray *totalRecipeArray = [self totalRecipeIngredients];
        NSMutableArray *totalIngredientArray = [NSMutableArray array];
        
        for (XCFRecipe *recipe in totalRecipeArray) {
            
            BOOL hasSameIngredient = NO; // 记录是否存在相同原料
            for (XCFRecipeIngredient *ingredient in recipe.ingredient) {
                
                for (XCFRecipeIngredient *existIngredient in totalIngredientArray) {
                    if ([ingredient.name isEqualToString:existIngredient.name]) { // 如果存在相同的原料，就只将原料用量拼接起来，不新增原料
                        existIngredient.amount = [NSString stringWithFormat:@"%@+%@", existIngredient.amount, ingredient.amount];
                        hasSameIngredient = YES;
                        break;
                    }
                }
                if (hasSameIngredient == NO) [totalIngredientArray addObject:ingredient]; // 如果不存在相同原料，就新增进数组
            }
        }
        _statArray = totalIngredientArray;
    }
    return _statArray;
}

+ (void)updateIngredient:(XCFRecipeIngredient *)ingredient {
    for (XCFRecipe *recipe in _recipeArray) {
        for (XCFRecipeIngredient *originIng in recipe.ingredient) {
            if ([originIng.name isEqualToString:ingredient.name]) { // 匹配总数组内所有原料，只要相同就更新为已购买状态(只更新状态)
                originIng.state = ingredient.state;
            }
        }
    }
    [self update];
}

+ (void)removeRecipeAtIndex:(NSUInteger)index {
    [_recipeArray removeObjectAtIndex:index];
    [self update];
}

+ (void)removeAllIngredient {
    [_recipeArray removeAllObjects];
    [self update];
}

@end
