//
//  XCFPopEvent.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFPopEvent : NSObject

/** 作品数 */
@property (nonatomic, copy) NSString *n_dishes;
/** 导航id */
@property (nonatomic, copy) NSString *ID;
/** 导航标题 */
@property (nonatomic, copy) NSString *name;
/** 图片地址 */
@property (nonatomic, copy) NSString *thumbnail_280;

@end
