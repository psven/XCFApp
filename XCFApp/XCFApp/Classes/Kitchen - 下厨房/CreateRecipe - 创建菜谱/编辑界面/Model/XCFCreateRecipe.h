//
//  XCFCreateRecipe.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFCreateInstruction, XCFCreateIngredient, XCFAuthorDetail;

@interface XCFCreateRecipe : NSObject <NSCoding>

/** 大图 */
@property (nonatomic, strong) UIImage *image;
/** 菜谱标题 */
@property (nonatomic, copy) NSString *name;
/** 菜谱描述 */
@property (nonatomic, copy) NSString *desc;
/** 菜谱作者 */
@property (nonatomic, strong) XCFAuthorDetail *author;
/** 创建时间 */
@property (nonatomic, copy) NSString *create_time;
/** 菜谱制作步骤介绍数组 */
@property (nonatomic, strong) NSArray<XCFCreateInstruction *> *instruction;
/** 菜谱用料数组 */
@property (nonatomic, strong) NSArray<XCFCreateIngredient *> *ingredient;
/** 小贴士(有则显示) */
@property (nonatomic, copy) NSString *tips;

/** 菜谱headerHeight */
@property (nonatomic, assign) CGFloat headerHeight;

@end
