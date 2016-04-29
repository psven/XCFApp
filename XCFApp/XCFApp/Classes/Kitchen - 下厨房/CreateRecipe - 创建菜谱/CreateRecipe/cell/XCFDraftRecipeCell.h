//
//  XCFDraftRecipeCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateRecipe;

@interface XCFDraftRecipeCell : UITableViewCell
/** 草稿数据 */
@property (nonatomic, strong) XCFCreateRecipe *recipeDraft;

@end
