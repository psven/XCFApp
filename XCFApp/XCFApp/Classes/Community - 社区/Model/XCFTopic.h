//
//  XCFTopic.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFTopic : NSObject
@property (nonatomic, copy) NSString *ID;                   // id
@property (nonatomic, strong) XCFAuthor *author;            // 作者
@property (nonatomic, copy) NSString *content;              // 标题
@property (nonatomic, copy) NSString *update_time;          // 更新时间
@property (nonatomic, copy) NSString *latest_comment_time;  // 最后回应时间
@property (nonatomic, copy) NSString *create_time;          // 创建时间
@property (nonatomic, copy) NSString *n_comments;           // 评论数
@property (nonatomic, assign) BOOL is_sticked;              // 是否置顶

@property (nonatomic, assign) CGFloat cellHeight; 

@end
