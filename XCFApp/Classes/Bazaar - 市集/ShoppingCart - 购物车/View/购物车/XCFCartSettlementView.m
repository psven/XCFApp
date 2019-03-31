//
//  XCFCartSettlementView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartSettlementView.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"

@interface XCFCartSettlementView ()
@property (weak, nonatomic) IBOutlet UIButton *yesMark;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (weak, nonatomic) IBOutlet UIButton *settlementButton;

@end

@implementation XCFCartSettlementView

- (void)awakeFromNib {
    [self.yesMark addTarget:self
                     action:@selector(selectedAllItem:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.settlementButton addTarget:self
                              action:@selector(settleOrDelete:)
                    forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件处理
- (void)selectedAllItem:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    !self.selectedAllItemBlock ? : self.selectedAllItemBlock(sender.isSelected);
}

- (void)settleOrDelete:(UIButton *)sender {
    !self.settleOrDeleteBlock ? : self.settleOrDeleteBlock();
}


#pragma mark - 构造方法

- (void)setTotalItemsArray:(NSArray<XCFCartItem *> *)totalItemsArray {
    _totalItemsArray = totalItemsArray;
    
    double totalPrice = 0;      // 总价格
    NSUInteger totalNumber = 0; // 总购买数量（结算时显示）
    NSUInteger totalGoods = 0;  // 总商品数  （删除时显示）
    for (NSArray *shopArray in totalItemsArray) {
        for (XCFCartItem *item in shopArray) {
            if (item.state == XCFCartItemStateSelected) {
                totalPrice += item.displayPrice * item.number;
                totalNumber += item.number;
                totalGoods++;
            }
        }
    }
    
    if (self.style == XCFCartEditStyleSettlement) { // 结算模式
        if (totalPrice) {
            self.totalLabel.text = [NSString stringWithFormat:@"合计：¥%.1f0", totalPrice];
            [self.settlementButton setTitle:[NSString stringWithFormat:@"总数(%zd)", totalNumber] forState:UIControlStateNormal];
        } else {
            self.totalLabel.text = [NSString stringWithFormat:@"合计：¥0.00"];
            [self.settlementButton setTitle:@"总数(0)" forState:UIControlStateNormal];
        }
        
    } else if (self.style == XCFCartEditStyleDelete) { // 删除模式
        [self.settlementButton setTitle:[NSString stringWithFormat:@"删除(%zd)", totalGoods] forState:UIControlStateNormal];
    }
}

- (void)setStyle:(XCFCartEditStyle)style {
    _style = style;
    
    if (style == XCFCartEditStyleDelete) {
        self.totalLabel.hidden = YES;
        self.freightLabel.hidden = YES;
    } else {
        self.totalLabel.hidden = NO;
        self.freightLabel.hidden = NO;
    }
}

- (void)setState:(XCFCartItemState)state {
    _state = state;
    self.yesMark.selected = state;
}



@end
