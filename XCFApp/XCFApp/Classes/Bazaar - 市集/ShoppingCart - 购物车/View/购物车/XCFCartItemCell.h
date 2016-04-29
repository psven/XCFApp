//
//  XCFCartItemCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCartItem;

@interface XCFCartItemCell : UITableViewCell

@property (nonatomic, assign) XCFCartViewChildControlStyle style;       // 控件类型
@property (nonatomic, strong) XCFCartItem *cartItem;
@property (nonatomic, copy) void (^selectedItemBlock)(NSUInteger);      // 选中商品回调
@property (nonatomic, copy) void (^itemNumberChangeBlock)(NSUInteger);  // 修改商品数量回调

@end
