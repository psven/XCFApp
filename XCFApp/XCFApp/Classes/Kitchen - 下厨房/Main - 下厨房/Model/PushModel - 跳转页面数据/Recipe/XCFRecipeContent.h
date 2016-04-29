//
//  XCFRecipeContent.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFRecipeContent : NSObject
/** 显示的作品数量 */
@property (nonatomic, assign) NSUInteger count;
/** 所有作品总数 */
@property (nonatomic, assign) NSUInteger total;
/** 作品id数组 */
@property (nonatomic, strong) NSArray<NSString *> *dish_ids;

@end
