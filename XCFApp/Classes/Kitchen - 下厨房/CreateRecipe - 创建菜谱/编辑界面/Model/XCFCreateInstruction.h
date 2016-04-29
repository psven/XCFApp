//
//  XCFCreateInstruction.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFCreateInstruction : NSObject <NSCoding>

/** 步骤图 */
@property (nonatomic, strong) UIImage *image;
/** 文字描述 */
@property (nonatomic, copy) NSString *text;
/** 步骤 */
@property (nonatomic, assign) NSUInteger step;
/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;

/** 步骤cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
