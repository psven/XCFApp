//
//  XCFRecipeIngredientCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

/// 用料cell
#import <UIKit/UIKit.h>
@class XCFRecipeIngredient, XCFCreateIngredient;

@interface XCFRecipeIngredientCell : UITableViewCell
@property (nonatomic, strong) XCFRecipeIngredient *ingredient;
@property (nonatomic, strong) XCFCreateIngredient *createIngredient;
@property (nonatomic, copy) void (^cellDidClickedBlock)(); // cell被点击的回调
@end
