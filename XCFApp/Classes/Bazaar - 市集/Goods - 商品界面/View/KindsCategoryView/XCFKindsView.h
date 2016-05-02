//
//  XCFKindsView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/5/1.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCartItem;

@interface XCFKindsView : UIView
@property (nonatomic, assign) XCFKindsViewType type;    // 弹框类型
@property (nonatomic, strong) XCFCartItem *item;        // 商品数据
@property (nonatomic, copy) void (^dismissBlock)();
@property (nonatomic, copy) void (^confirmBlock)(XCFCartItem *); // 确定回调，回传选择好的商品属性
@property (nonatomic, copy) void (^animationBlock)(UIImage *, CGRect); // 执行图片动画回调，动画要在上一层执行，回传图片以及frame
@end
