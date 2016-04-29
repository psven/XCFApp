//
//  XCFContent.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFIssues;

@interface XCFContent : NSObject
/** 菜谱组数 */
@property (nonatomic, assign) NSUInteger count;
/** 菜谱数据 */
@property (nonatomic, strong) NSArray<XCFIssues *> *issues;
@end
