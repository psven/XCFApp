//
//  XCFCommentTool.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCommentTool.h"
#import "XCFTopicComment.h"
#import "XCFAuthor.h"
#import <MJExtension.h>

#define XCFCommentPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"comment.data"]

@implementation XCFCommentTool

static NSMutableArray *_commentArray;

+ (NSArray *)totalComments {
    _commentArray = [NSKeyedUnarchiver unarchiveObjectWithFile:XCFCommentPath];
    if (!_commentArray.count) {
        _commentArray = [NSMutableArray array];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                         pathForResource:@"comment.plist"
                                                                         ofType:nil]];
        _commentArray = [XCFTopicComment mj_objectArrayWithKeyValuesArray:dict[@"content"][@"comments"]];
    }
    return _commentArray;
}

+ (NSArray *)totalAuthors {
    NSMutableArray *authorArray = [NSMutableArray array];

    for (XCFTopicComment *cmt in _commentArray) {
        BOOL hasSameAuthor = NO;
        for (XCFAuthor *author in authorArray) {
            if ([cmt.author.name isEqualToString:author.name]) hasSameAuthor = YES;
        }
        if (hasSameAuthor == NO) [authorArray addObject:cmt.author];
    }
    return authorArray;
}


+ (void)addComment:(XCFTopicComment *)comment {
    [_commentArray addObject:comment];
    [NSKeyedArchiver archiveRootObject:_commentArray toFile:XCFCommentPath];
}

+ (void)recovery {
    [_commentArray removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_commentArray toFile:XCFCommentPath];
}

@end
