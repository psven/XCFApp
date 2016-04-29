//
//  XCFSearchKeywordsTool.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSearchKeywordsTool.h"

@implementation XCFSearchKeywordsTool

static NSMutableArray *_kWordsArray;

+ (void)update {
    NSArray *saveArray = [NSArray arrayWithArray:_kWordsArray];
    [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:@"kWords"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)totalWords {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"kWords"];
    _kWordsArray = [NSMutableArray arrayWithArray:array];
    if (!_kWordsArray.count) {
        _kWordsArray = [NSMutableArray array];
    }
    return _kWordsArray;
}

+ (void)addNewWord:(NSString *)newWord {
    for (NSInteger index=0; index<_kWordsArray.count; index++) {
        NSString *existWord = _kWordsArray[index];
        if ([existWord isEqualToString:newWord]) {
            [_kWordsArray removeObjectAtIndex:index]; // 如果新搜索词与存在的词相同，就删除旧词
            break;
        }
    }
    [_kWordsArray insertObject:newWord atIndex:0]; // 不管有无旧词，都直接添加到最顶的位置
    [self update];
}

+ (void)removeAllWords {
    [_kWordsArray removeAllObjects];
    [self update];
}

@end
