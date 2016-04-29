//
//  XCFComment.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFComment : NSObject
/** 作者 */
@property (nonatomic, strong) XCFAuthor *author;
/** 未知 */
@property (nonatomic, strong) NSArray<XCFAuthor *> *at_users;
/** 事件id */
@property (nonatomic, copy) NSString *target_id;
/** 评论创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 评论内容 */
@property (nonatomic, copy) NSString *txt;
/** id */
@property (nonatomic, copy) NSString *ID;

@end
