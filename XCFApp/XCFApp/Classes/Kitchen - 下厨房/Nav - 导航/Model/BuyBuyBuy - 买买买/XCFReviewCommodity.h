//
//  XCFReviewCommodity.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFGoods;

@interface XCFReviewCommodity : NSObject
/** 商品 */
@property (nonatomic, strong) XCFGoods *goods;
/** 种类 */
@property (nonatomic, copy) NSString *kind_name;
/** 数量 */
@property (nonatomic, copy) NSString *number;

@end
