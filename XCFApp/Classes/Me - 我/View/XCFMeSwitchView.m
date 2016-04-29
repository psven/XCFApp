//
//  XCFMeSwitchView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMeSwitchView.h"
#import "XCFNavButton.h"

@implementation XCFMeSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        NSArray *imageArray = @[@"myFavourite", @"myVoucher", @"myFavourite", @"myVoucher"];
        NSArray *titleArray = @[@"收藏", @"订单", @"优惠", @"积分"];
        
        // 添加4个导航按钮
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat buttonWidth = XCFScreenWidth / 4;
        for (NSInteger index = 0; index<4; index++) {
            XCFNavButton *button = [XCFNavButton buttonWithImageName:imageArray[index]
                                                               title:titleArray[index]
                                                              target:self
                                                              action:@selector(navButtonClicked:)];
            x = index * buttonWidth;
            button.frame = CGRectMake(x, y, buttonWidth, buttonWidth);
            button.tag = index;
            [self addSubview:button];
        }
        
    }
    return self;
}

- (void)navButtonClicked:(UIButton *)sender {
    !self.MyNavButtonDidClicked ? : self.MyNavButtonDidClicked(sender.tag);
}

@end
