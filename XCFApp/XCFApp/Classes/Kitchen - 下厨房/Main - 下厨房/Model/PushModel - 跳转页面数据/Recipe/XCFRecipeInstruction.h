//
//  XCFRecipeInstruction.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜谱制作步骤
 */
#import <Foundation/Foundation.h>

@interface XCFRecipeInstruction : NSObject
/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 文字描述 */
@property (nonatomic, copy) NSString *text;
/** 步骤 */
@property (nonatomic, assign) NSUInteger step;
/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;

/** 步骤cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
