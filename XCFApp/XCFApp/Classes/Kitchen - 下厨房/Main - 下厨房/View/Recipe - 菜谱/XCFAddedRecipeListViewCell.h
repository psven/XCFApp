//
//  XCFAddedRecipeListViewCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFRecipeList;

@interface XCFAddedRecipeListViewCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) XCFRecipeList *addedList;
@end
