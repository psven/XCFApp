//
//  XCFNavContent.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFPopEvents, XCFNav;

@interface XCFNavContent : NSObject
/** 早餐午餐晚餐数据 */
@property (nonatomic, strong) XCFPopEvents *pop_events;
/** 导航按钮数据 */
@property (nonatomic, strong) NSArray<XCFNav *> *navs;
/** 菜谱导航图片 */
@property (nonatomic, copy) NSString *pop_recipe_picurl;

@end
