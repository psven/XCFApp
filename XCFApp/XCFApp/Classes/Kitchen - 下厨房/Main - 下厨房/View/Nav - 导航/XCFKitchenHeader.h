//
//  XCFKitchenHeader.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  顶部导航视图点击事件
 */
typedef NS_ENUM(NSInteger, viewDidClickedAction) {
    viewDidClickedActionPopRecipeView = 0,          // 流行菜谱点击事件
    viewDidClickedActionFeedsView = 1,              // 关注动态点击事件
    
    viewDidClickedActionTopListButton = 2,          // 排行榜
    viewDidClickedActionVideoButton = 3,            // 看视频
    viewDidClickedActionBuyButton = 4,              // 买买买
    viewDidClickedActionRecipeCategoryButton = 5,   // 菜谱分类
    
    viewDidClickedActionBreakfast = 6,              // 早餐
    viewDidClickedActionLunch = 7,                  // 午餐
    viewDidClickedActionSupper = 8                  // 晚餐
    
};

/**
 *  事件点击Block
 */
typedef void (^viewDidClickedBlock)();


#import <UIKit/UIKit.h>
@class XCFNavContent, XCFDish;

@interface XCFKitchenHeader : UIView
/** 导航模型数据 */
@property (nonatomic, strong) XCFNavContent *navContent;
/** 动态模型数据 */
@property (nonatomic, strong) XCFDish *dish;
/** viewDidClickedBlock */
@property (nonatomic, copy) viewDidClickedBlock clickBlock;

@end
