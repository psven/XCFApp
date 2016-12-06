//
//  XCFCreateIngredient.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFCreateIngredient : NSObject <NSCoding>

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 用量 */
@property (nonatomic, copy) NSString *amount;

/** 用料cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
