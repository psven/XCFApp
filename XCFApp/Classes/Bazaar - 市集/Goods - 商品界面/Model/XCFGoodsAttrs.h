//
//  XCFGoodsAttrs.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFGoodsAttrs : NSObject 
/** 下标 */
@property (nonatomic, assign) NSInteger index;
/** 说明 */
@property (nonatomic, copy) NSString *value;
/** 属性 */
@property (nonatomic, copy) NSString *name;

/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

@end
