//
//  XCFKindsCategoryView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/5/1.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCartItem;

@interface XCFKindsCategoryView : UIView
@property (nonatomic, assign) XCFKindsViewType type;    // 弹框类型
@property (nonatomic, strong) XCFCartItem *item;        // 商品数据
@property (nonatomic, copy) void (^cancelBlock)();
@property (nonatomic, copy) void (^confirmBlock)(XCFCartItem *); // 确定回调，回传选择好的商品属性
@end
