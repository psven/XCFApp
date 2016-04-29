//
//  XCFGoodsBottomView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsBottomView.h"
#import <Masonry.h>

@interface XCFGoodsBottomView ()

/** 店铺icon */
@property (nonatomic, strong) UIView *shopIcon;
/** 左边按钮 */
@property (nonatomic, strong) UIButton *leftButton;
/** 右边按钮 */
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation XCFGoodsBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _shopIcon = [[UIView alloc] init];
        _shopIcon.backgroundColor = [UIColor whiteColor];
        [self addSubview:_shopIcon];
        [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 44));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToShop)];
        [_shopIcon addGestureRecognizer:tap];
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"shopIcon"];
        [self.shopIcon addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.shopIcon);
            make.top.equalTo(self.shopIcon).offset(5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = XCFLabelColorGray;
        label.text = @"店铺";
        [self.shopIcon addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.shopIcon);
            make.top.equalTo(icon.mas_bottom).offset(5);
        }];
        
        
        _leftButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                    title:@"加入购物车"
                                           titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                               titleColor:XCFLabelColorWhite
                                                   target:self
                                                   action:@selector(leftButtonClicked:)
                                            clipsToBounds:NO];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.shopIcon.mas_right);
            make.size.mas_equalTo(CGSizeMake((XCFScreenWidth-60-1)*0.5, 44));
        }];
        
        _rightButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                     title:@"立即购买"
                                            titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                titleColor:XCFLabelColorWhite
                                                    target:self
                                                    action:@selector(rightButtonClicked:)
                                             clipsToBounds:NO];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self);
            make.size.equalTo(self.leftButton);
        }];
        
    }
    return self;
}

- (void)goToShop {
    !self.actionBlock ? : self.actionBlock(BottomViewClickedGoToShop);
}

- (void)leftButtonClicked:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(BottomViewClickedAddToShoppingCart);
}

- (void)rightButtonClicked:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(BottomViewClickedBuyNow);
}

@end
