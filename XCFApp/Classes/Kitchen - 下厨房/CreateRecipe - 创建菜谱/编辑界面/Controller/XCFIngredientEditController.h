//
//  XCFIngredientEditController.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateIngredient;

@interface XCFIngredientEditController : UITableViewController
@property (nonatomic, strong) NSMutableArray <XCFCreateIngredient *> *ingredientArray;
@property (nonatomic, copy) void (^doneEditBlock)(NSArray *ingredientArray);
@end
