//
//  XCFRecipeDraftTool.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFCreateRecipe;

@interface XCFRecipeDraftTool : NSObject

+ (NSArray *)totalRecipeDrafts;
+ (void)update;
+ (void)addRecipeDraft:(XCFCreateRecipe *)recipe;
+ (void)removeRecipeDraftAtIndex:(NSUInteger)index;
+ (void)updateRecipeDraftAtIndex:(NSUInteger)index withRecipeDraft:(XCFCreateRecipe *)draft;

@end
