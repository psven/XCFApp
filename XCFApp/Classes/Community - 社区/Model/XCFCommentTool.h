//
//  XCFCommentTool.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFTopicComment;

@interface XCFCommentTool : NSObject

+ (NSArray *)totalComments;
+ (NSArray *)totalAuthors;
+ (void)addComment:(XCFTopicComment *)comment;
+ (void)recovery;

@end
