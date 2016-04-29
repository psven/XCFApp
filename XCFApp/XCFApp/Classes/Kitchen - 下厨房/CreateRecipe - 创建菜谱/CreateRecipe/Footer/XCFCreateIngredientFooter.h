//
//  XCFCreateIngredientFooter.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFCreateIngredientFooter : UITableViewHeaderFooterView

@property (nonatomic, copy) void (^addIngredientBlock)();

@end
