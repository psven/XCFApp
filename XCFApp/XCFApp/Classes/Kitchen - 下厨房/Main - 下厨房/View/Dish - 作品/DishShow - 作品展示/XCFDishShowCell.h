//
//  XCFDishShowCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/8.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFRecipe, XCFDish, XCFGoods;

@interface XCFDishShowCell : UITableViewCell

/** cell类型 */
@property (nonatomic, assign) XCFVerticalCellType type;
/** 作品模型数据 */
@property (nonatomic, strong) NSMutableArray *dish;
/** 作品模型数据 */
@property (nonatomic, strong) XCFRecipe *recipe;
/** 评价模型数据 */
@property (nonatomic, strong) XCFGoods *goods;

/** CollectionViewCellClickedBlock */
@property (nonatomic, copy) void (^collectionViewCellClickedBlock)(NSInteger index);
/** 点赞按钮点击block */
@property (nonatomic, copy) void (^diggsButtonClickedBlock)(id sender);
/** 刷新回调 */
@property (nonatomic, copy) void (^refreshBlock)();
/** 查看所有作品、评价 */
@property (nonatomic, copy) void (^showAll)();

@end
