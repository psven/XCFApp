//
//  XCFDishViewCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/10.
//  Copyright © 2016年 Joey. All rights reserved.
//


typedef NS_ENUM(NSInteger, DishViewAction) {
    DishViewActionName,
    DishViewActionDigg,
    DishViewActionCommment,
    DishViewActionMore
};

#import <UIKit/UIKit.h>
@class XCFDish, XCFReview;

@interface XCFDishViewCell : UITableViewCell

/** cell类型 */
@property (nonatomic, assign) XCFShowViewType type;
/** 模型数据 */
@property (nonatomic, strong) XCFDish *dish;
/** 模型数据 */
@property (nonatomic, strong) XCFReview *review;

/** 图片数据 */
@property (nonatomic, strong) NSArray *imageArray;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
/** cell滚动回调 */
@property (nonatomic, copy) void (^imageViewDidScrolledBlock)();
/** 评论button事件回调 */
@property (nonatomic, copy) void (^actionBlock)();

@end
