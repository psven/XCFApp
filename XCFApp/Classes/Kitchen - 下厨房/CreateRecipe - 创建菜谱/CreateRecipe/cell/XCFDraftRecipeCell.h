//
//  XCFDraftRecipeCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateRecipe;

@interface XCFDraftRecipeCell : UITableViewCell
/** 草稿数据 */
@property (nonatomic, strong) XCFCreateRecipe *recipeDraft;

@end
