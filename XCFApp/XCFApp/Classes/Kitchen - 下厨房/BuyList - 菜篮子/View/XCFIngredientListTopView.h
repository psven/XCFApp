//
//  XCFIngredientListTopView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, XCFBuyListStyle) {
    XCFBuyListStyleRecipe, // 菜谱
    XCFBuyListStyleStat    // 主料
};

#import <UIKit/UIKit.h>

@interface XCFIngredientListTopView : UIView
@property (nonatomic, assign) XCFBuyListStyle style;   // 显示类型
@property (nonatomic, assign) NSUInteger count;        // 菜谱个数
@property (nonatomic, copy) void (^changeViewBlock)(); // 切换界面回调
@end
