//
//  XCFGoodsImageTextView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFGoods;

@interface XCFGoodsImageTextView : UIView
/** 模型数据 */
@property (nonatomic, strong) XCFGoods *goods;
/** 隐藏图文详情界面 */
@property (nonatomic, copy) void (^viewWillDismissBlock)();

@end

