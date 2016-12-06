//
//  XCFGoodsHeaderView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFGoods;

@interface XCFGoodsHeaderView : UIView
/** 模型数据 */
@property (nonatomic, strong) XCFGoods *goods;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
/** 图片点击回调 */
@property (nonatomic, copy) void (^showImageBlock)(NSUInteger, CGRect);

@end
