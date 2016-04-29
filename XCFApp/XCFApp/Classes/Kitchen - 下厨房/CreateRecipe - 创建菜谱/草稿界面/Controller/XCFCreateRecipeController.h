//
//  XCFCreateRecipeController.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateRecipe;

@interface XCFCreateRecipeController : UITableViewController

@property (nonatomic, strong) XCFCreateRecipe *createRecipe;

@property (nonatomic, assign) NSUInteger draftIndex; // 草稿数据在数组中的下标

@end
