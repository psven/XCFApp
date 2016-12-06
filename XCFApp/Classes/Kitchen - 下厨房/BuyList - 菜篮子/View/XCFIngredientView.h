//
//  XCFIngredientView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFRecipe;

@interface XCFIngredientView : UITableViewHeaderFooterView
@property (nonatomic, strong) XCFRecipe *recipe; // 菜谱
@end
