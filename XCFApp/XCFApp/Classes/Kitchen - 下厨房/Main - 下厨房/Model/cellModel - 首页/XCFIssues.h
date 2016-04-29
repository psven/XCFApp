//
//  XCFIssues.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//


#import <Foundation/Foundation.h>
@class XCFItems;

@interface XCFIssues : NSObject
/** 菜谱数量 */
@property (nonatomic, assign) NSUInteger items_count;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 菜谱数组 */
@property (nonatomic, strong) NSArray<XCFItems *> *items;
/** 当天菜谱id */
@property (nonatomic, copy) NSString *issue_id;
/** 菜谱发布日期 */
@property (nonatomic, copy) NSString *publish_date;

@end
