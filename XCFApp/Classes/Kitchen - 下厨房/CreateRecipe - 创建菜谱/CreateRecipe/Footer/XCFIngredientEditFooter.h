//
//  XCFIngredientEditFooter.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, tableViewAdjustStyle) {
    tableViewAdjustStyleNone,
    tableViewAdjustStyleAdjusting
};

#import <UIKit/UIKit.h>

@interface XCFIngredientEditFooter : UIView

@property (nonatomic, copy) void (^addLineBlock)();
@property (nonatomic, copy) void (^adjustBlock)();

@end
