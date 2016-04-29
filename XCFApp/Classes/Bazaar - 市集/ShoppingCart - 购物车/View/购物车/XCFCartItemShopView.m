//
//  XCFCartItemShopView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartItemShopView.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"
#import "XCFShop.h"
#import <Masonry.h>

@interface XCFCartItemShopView ()
@property (weak, nonatomic) IBOutlet UIButton *yesMark;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;

@end

@implementation XCFCartItemShopView

- (void)awakeFromNib {
    [self.yesMark addTarget:self action:@selector(selectedShopItems:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectedShopItems:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    !self.selectedShopItemsBlock ? : self.selectedShopItemsBlock(sender.isSelected);
}


- (void)setStyle:(XCFCartViewChildControlStyle)style {
    _style = style;
    if (style == XCFCartViewChildControlStyleCart) {
        self.yesMark.hidden = NO;
        
    } else if (style == XCFCartViewChildControlStyleOrder) {
        [self.yesMark removeFromSuperview];
        [self.shopIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
        }];
    }
}

- (void)setCartItem:(XCFCartItem *)cartItem {
    _cartItem = cartItem;
    self.shopName.text = cartItem.goods.shop.name;
}

- (void)setState:(XCFCartShopState)state {
    _state = state;
    self.yesMark.selected = state;
}

@end
