//
//  XCFMeSwitchView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.


typedef NS_ENUM(NSInteger, MyNavButtonDidClicked) {
    MyNavButtonDidClickedFav,       // 收藏
    MyNavButtonDidClickedOrder,     // 订单
    MyNavButtonDidClickedVoucher,   // 优惠
    MyNavButtonDidClickedCredit     // 积分
};

#import <UIKit/UIKit.h>

@class XCFAuthorDetail;

@interface XCFMeSwitchView : UIView

@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@property (nonatomic, copy) void (^MyNavButtonDidClicked)();

@end
