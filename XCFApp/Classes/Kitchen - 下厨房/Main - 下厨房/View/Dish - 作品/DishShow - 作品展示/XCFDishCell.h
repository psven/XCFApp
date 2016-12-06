//
//  XCFDishCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFDish, XCFReview;

@interface XCFDishCell : UICollectionViewCell

/** 模型数据 */
@property (nonatomic, strong) XCFDish *dish;
/** 模型数据 */
@property (nonatomic, strong) XCFReview *review;
/** 点赞按钮点击block */
@property (nonatomic, copy) void (^diggsButtonClickedBlock)(id sender);

@end
