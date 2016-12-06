//
//  XCFConst.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  cell模板
 */
typedef enum {
    XCFCellTemplateTopic = 1,           // 帖子
    XCFCellTemplateRecipeList = 2,      // 菜单
    XCFCellTemplateUnknow = 3,          // 未知
    XCFCellTemplateDish = 4,            // 作品
    XCFCellTemplateRecipe = 5,          // 菜谱
    XCFCellTemplateWeeklyMagazine = 6   // 周刊
} XCFCellTemplate;


/**
 *  下厨房 - 菜谱cell中控件的字体大小
 */
typedef enum {
    XCFRecipeCellFontSizeTitle = 16,        // 标题
    XCFRecipeCellFontSizeDesc = 12,         // 描述
    XCFRecipeCellFontSizeFirstTitle = 20,   // 大标题
    XCFRecipeCellFontSizeSecondTitle = 14   // 小标题
} XCFRecipeCellFontSize;

/**
 *  图片展示类型
 */
typedef NS_ENUM(NSInteger, XCFShowViewType) {
    XCFShowViewTypeDish,    // 作品
    XCFShowViewTypeReview,  // 评价
    XCFShowViewTypeGoods,   // 商品
    XCFShowViewTypeDetail   // 详细展示
};

/**
 *  垂直cell类型
 */
typedef NS_ENUM(NSInteger, XCFVerticalCellType) {
    XCFVerticalCellTypeDish,    // 作品
    XCFVerticalCellTypeReview   // 评价
};

/**
 *  底部工具view点击事件类型
 */
typedef NS_ENUM(NSInteger, BottomViewClicked) {
    BottomViewClickedCollect,           // 收藏
    BottomViewClickedAddToList,         // 加入菜篮子
    BottomViewClickedAddToShoppingCart, // 加入购物车
    BottomViewClickedBuyNow,            // 现在购买
    BottomViewClickedGoToShop           // 店铺
};

/**
 *  购物车view子控件的类型：购物车/订单
 */
typedef NS_ENUM(NSUInteger, XCFCartViewChildControlStyle) {
    XCFCartViewChildControlStyleCart,
    XCFCartViewChildControlStyleOrder
};

/**
 *  购物车商品选中状态
 */
typedef NS_ENUM(NSUInteger, XCFCartItemState) {
    XCFCartItemStateNone,       
    XCFCartItemStateSelected
};

/**
 *  商品分类弹框类型
 */
typedef NS_ENUM(NSUInteger, XCFKindsViewType) {
    XCFKindsViewTypeCart,   // 购物车
    XCFKindsViewTypeOrder   // 下订单
};



/** 下厨房 - 标题距离屏幕左边的间距 */
UIKIT_EXTERN CGFloat const XCFRecipeCellMarginTitle;
/** 下厨房 - 大标题距离屏幕左边的间距 */
UIKIT_EXTERN CGFloat const XCFRecipeCellMarginFirstTitle;
/** 下厨房 - 描述与标题之间的间距 */
UIKIT_EXTERN CGFloat const XCFRecipeCellMarginTitle2Desc;
/** 下厨房 - 菜单 - 标题距离顶部导航的间距 */
UIKIT_EXTERN CGFloat const XCFRecipeListViewMarginHeadTitle;
/** 下厨房 - 菜单 - 标题距离作者名字的间距 */
UIKIT_EXTERN CGFloat const XCFRecipeListViewMarginHeadTitle2Name;

/** 下厨房 - 头像宽高 */
UIKIT_EXTERN CGFloat const XCFAuthorHeaderWidth;
/** 下厨房 - 顶部导航视图高度（流行菜谱、关注动态） */
UIKIT_EXTERN CGFloat const XCFKitchenViewHeightTopNav;
/** 下厨房 - 导航按钮高度（排行榜、看视频、买买买、菜谱分类） */
UIKIT_EXTERN CGFloat const XCFKitchenViewHeightNavButton;

/** 下厨房 - 菜单 - 作者名字高度 */
UIKIT_EXTERN CGFloat const XCFRecipeListViewHeightAuthorName;
/** 下厨房 - 菜单 - “收藏按钮”高度 */
UIKIT_EXTERN CGFloat const XCFRecipeListViewHeightCollectButton;
/** 下厨房 - 菜单 - 专家图标宽高 */
UIKIT_EXTERN CGFloat const XCFRecipeListViewHeightExpertIcon;

/** 商品界面 - 加入购物车 - 商品分类最小高度 */
UIKIT_EXTERN CGFloat const XCFGoodsKindsCategoryViewMinusHeight;



