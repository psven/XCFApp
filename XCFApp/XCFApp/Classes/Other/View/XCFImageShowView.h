//
//  XCFImageShowView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  图片展示 */

#import <UIKit/UIKit.h>

typedef void (^ShowImageBlock)(NSUInteger, CGRect);

@interface XCFImageShowView : UIView

/** cell类型 */
@property (nonatomic, assign) XCFShowViewType type;
/** 图片数据 */
@property (nonatomic, strong) NSArray *imageArray;

/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
@property (nonatomic, assign) NSUInteger currentIndex; // 当前图片下标
/** cell滚动回调 */
@property (nonatomic, copy) void (^imageViewDidScrolledBlock)(CGFloat);
/** 图片点击回调 */
@property (nonatomic, copy) ShowImageBlock showImageBlock;

+ (instancetype)imageShowViewWithShowImageBlock:(ShowImageBlock)block;

@end
