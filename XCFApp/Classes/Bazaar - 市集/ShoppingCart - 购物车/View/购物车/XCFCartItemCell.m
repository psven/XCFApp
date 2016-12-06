//
//  XCFCartItemCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartItemCell.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"
#import "XCFShop.h"
#import "XCFGoodsKind.h"
#import "XCFReviewPhoto.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface XCFCartItemCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *yesMark;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsKindName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;                          // 订单中商品的数量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsNameWidthCon;         // 商品名称宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsKindnameWidthCon;     // 商品种类宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImageHeight;          // 商品图片高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImageWidth;           // 商品图片宽度约束

@end

@implementation XCFCartItemCell

- (void)awakeFromNib {
    [self.yesMark addTarget:self action:@selector(selectedShopItem:) forControlEvents:UIControlEventTouchUpInside];
    self.number.delegate = self;
    self.number.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.number.layer.borderWidth = 1.0f;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 44)];
    toolbar.backgroundColor = XCFDishViewBackgroundColor;
    UIBarButtonItem *doneButton = [UIBarButtonItem barButtonItemWithTitle:@"完成" target:self action:@selector(done)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    toolbar.items = @[flexible, doneButton];
    self.number.inputAccessoryView = toolbar;

}


#pragma mark - 事件处理
- (void)done {
    NSUInteger number = [self.number.text integerValue];
    if (number < 1) { // 如果购买数量小于1，就默认显示1
        self.number.text = @"1";
        number = 1;
    }
    !self.itemNumberChangeBlock ? : self.itemNumberChangeBlock(number);
    [self endEditing:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSUInteger number = [self.number.text integerValue];
    if (number < 1) {
        self.number.text = @"1";
        number = 1;
    }
    !self.itemNumberChangeBlock ? : self.itemNumberChangeBlock(number);
    return YES;
}

- (void)selectedShopItem:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    !self.selectedItemBlock ? : self.selectedItemBlock(sender.isSelected);
}


#pragma mark - 构造方法
// 根据类型调整布局
- (void)setStyle:(XCFCartViewChildControlStyle)style {
    _style = style;
    if (style == XCFCartViewChildControlStyleCart) { // 购物车
        self.yesMark.hidden = NO;
        self.orderNumber.hidden = YES;
        
    } else if (style == XCFCartViewChildControlStyleOrder) { // 订单
        [self.yesMark removeFromSuperview];
        self.number.hidden = YES;
        self.orderNumber.hidden = NO;
        
        self.goodsImageHeight.constant = 60;
        self.goodsImageWidth.constant = 60;
        self.goodsNameWidthCon.constant = 210;
        self.goodsKindnameWidthCon.constant = 180;
        
        self.goodsPrice.font = [UIFont systemFontOfSize:13];
        
        [self.goodsImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
        }];
    }
}

- (void)setCartItem:(XCFCartItem *)cartItem {
    _cartItem = cartItem;
    
    self.yesMark.selected = cartItem.state;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:cartItem.goods.main_pic.url]];
    self.goodsName.text = cartItem.goods.name;
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%.1f0", cartItem.displayPrice];
    self.number.text = [NSString stringWithFormat:@"%zd", cartItem.number];
    if (self.style == XCFCartViewChildControlStyleOrder) {
        self.goodsPrice.text = [NSString stringWithFormat:@"¥%.1f0", cartItem.displayOriginPrice];
        self.orderNumber.text = [NSString stringWithFormat:@"x%zd", cartItem.number];
    }
    
    // 如果商品有多种类型，就显示商品类型
    if (cartItem.goods.kinds.count > 1) {
        self.goodsKindName.hidden = NO;
        self.goodsKindName.text = cartItem.kind_name;
    } else {
        self.goodsKindName.hidden = YES;
    }
}


@end
