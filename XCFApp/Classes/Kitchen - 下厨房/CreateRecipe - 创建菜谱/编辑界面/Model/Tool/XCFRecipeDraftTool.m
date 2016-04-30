//
//  XCFRecipeDraftTool.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeDraftTool.h"
#import "XCFCreateRecipe.h"

#define XCFRecipeDraftsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recipeDrafts.data"]

@implementation XCFRecipeDraftTool

static NSMutableArray *_recipeDrafts;

+ (NSArray *)totalRecipeDrafts {
    _recipeDrafts = [NSKeyedUnarchiver unarchiveObjectWithFile:XCFRecipeDraftsPath];
    if (!_recipeDrafts) _recipeDrafts = [NSMutableArray array];
    return _recipeDrafts;
}

+ (void)update {
    [NSKeyedArchiver archiveRootObject:_recipeDrafts toFile:XCFRecipeDraftsPath];
}

+ (void)addRecipeDraft:(XCFCreateRecipe *)recipe {
    if (!_recipeDrafts.count) _recipeDrafts = [NSMutableArray array];
    [_recipeDrafts addObject:recipe];
    [self update];
}

+ (void)removeRecipeDraftAtIndex:(NSUInteger)index {
    [_recipeDrafts removeObjectAtIndex:index];
    [self update];
}

+ (void)updateRecipeDraftAtIndex:(NSUInteger)index
                 withRecipeDraft:(XCFCreateRecipe *)draft {
    [_recipeDrafts replaceObjectAtIndex:index withObject:draft];
    [self update];
}

@end
