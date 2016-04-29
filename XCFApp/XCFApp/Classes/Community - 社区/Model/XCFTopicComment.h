//
//  XCFTopicComment.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFTopicComment : NSObject <NSCoding>

@property (nonatomic, strong) NSArray<XCFAuthor *> *at_users;   // @的用户数组
@property (nonatomic, strong) XCFAuthor *author;                // 作者
@property (nonatomic, copy) NSString *ID;                       // 评论id
@property (nonatomic, copy) NSString *txt;                      // 内容
@property (nonatomic, copy) NSString *target_id;                // 主题id
@property (nonatomic, copy) NSString *create_time;              // 创建时间

@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)commentWithContent:(NSString *)content
                           atUsers:(NSArray *)users
                          byAuthor:(XCFAuthor *)author;

@end
