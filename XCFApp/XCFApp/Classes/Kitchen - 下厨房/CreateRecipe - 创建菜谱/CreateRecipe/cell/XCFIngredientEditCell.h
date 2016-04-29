//
//  XCFIngredientEditCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateIngredient;

@interface XCFIngredientEditCell : UITableViewCell

@property (nonatomic, strong) NSArray *placeholderArray;

@property (nonatomic, strong) XCFCreateIngredient *ingredient;

@property (nonatomic, copy) void (^editCallBackBlock)(XCFCreateIngredient *ingredient);

- (void)becomeFirstResponder;

@end
