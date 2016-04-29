//
//  XCFDiggUsers.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFDiggUsers : NSObject

/** 显示的点赞用户数 默认返回5个 */
@property (nonatomic, assign) NSInteger count;
/** 点赞总人数 */
@property (nonatomic, copy) NSString *total;
/** 点赞用户数组 */
@property (nonatomic, strong) NSArray<XCFAuthor *> *users;

@end
