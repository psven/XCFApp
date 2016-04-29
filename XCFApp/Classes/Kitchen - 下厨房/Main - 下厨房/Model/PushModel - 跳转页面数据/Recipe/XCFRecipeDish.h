//
//  XCFRecipeDish.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

/// 菜谱作品详细数据
#import <Foundation/Foundation.h>
@class XCFDish;

@interface XCFRecipeDish : NSObject
/** 作品数组 */
@property (nonatomic, strong) NSArray<XCFDish *> *dishes;

@end
