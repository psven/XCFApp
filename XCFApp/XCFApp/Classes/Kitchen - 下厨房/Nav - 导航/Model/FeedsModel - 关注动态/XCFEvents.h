//
//  XCFEvents.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFEvents : NSObject

/** 是否被推广 */
@property (nonatomic, assign) BOOL is_promoted;
/** （推广专题?）id */
@property (nonatomic, copy) NSString *ID;
/** （推广专题?）标题 */
@property (nonatomic, copy) NSString *name;
/** （推广专题?）作者 */
@property (nonatomic, strong) XCFAuthor *author;

@end
