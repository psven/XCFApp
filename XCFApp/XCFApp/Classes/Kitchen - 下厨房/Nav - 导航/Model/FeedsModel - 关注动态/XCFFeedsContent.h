//
//  XCFFeedsContent.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFFeeds;

@interface XCFFeedsContent : NSObject
/** 菜谱详情 */
@property (nonatomic, strong) NSArray<XCFFeeds *> *feeds;
/** 类型 */
@property (nonatomic, assign) NSInteger count;

@end
