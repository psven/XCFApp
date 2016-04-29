//
//  XCFSearchKeywordsTool.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFSearchKeywordsTool : NSObject

+ (void)update;
+ (NSArray *)totalWords;
+ (void)addNewWord:(NSString *)newWord;
+ (void)removeAllWords;

@end
