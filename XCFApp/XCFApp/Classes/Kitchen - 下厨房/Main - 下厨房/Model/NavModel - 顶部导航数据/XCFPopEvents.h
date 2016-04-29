//
//  XCFPopEvents.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFPopEvent;

@interface XCFPopEvents : NSObject
/** 导航个数 */
@property (nonatomic, assign) NSInteger count;
/** 导航数据 */
@property (nonatomic, strong) NSArray<XCFPopEvent *> *events;

@end
