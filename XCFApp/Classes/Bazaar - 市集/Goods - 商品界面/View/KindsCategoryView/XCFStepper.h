//
//  XCFStepper.h
//  XCFApp
//
//  Created by 彭世朋 on 16/5/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFStepper : UIView
@property (nonatomic, assign) BOOL enabled;                                 // 是否激活
@property (nonatomic, assign) NSUInteger stock;                             // 商品库存
@property (nonatomic, copy) void (^goodsNumberChangedBlock)(NSUInteger);    // 商品数量变化回调
@end
