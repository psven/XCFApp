//
//  XCFOrderSectionFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFOrderSectionFooter.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"
#import <Masonry.h>

@interface XCFOrderSectionFooter ()
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;         // 运费
@property (weak, nonatomic) IBOutlet UILabel *shopPromotionLabel;   // 店铺优惠
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;      // 合计
@property (weak, nonatomic) IBOutlet UITextField *leaveMsgField;    // 留言

@property (weak, nonatomic) IBOutlet UIView *shopPromotionView;              // 店铺优惠view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *promotionHeightCon; // 店铺优惠view高度约束
@end

@implementation XCFOrderSectionFooter

- (void)setShopArray:(NSArray<XCFCartItem *> *)shopArray {
    _shopArray = shopArray;
    
    NSString *freight = [[shopArray[0] goods] freight]; // 运费
    
    double totalOriginPrice = 0;      // 总原价格
    double totalPayPrice = 0;         // 总支付价格
    for (XCFCartItem *item in shopArray) {
        if (item.state == XCFCartItemStateSelected) {
            totalOriginPrice += item.displayOriginPrice * item.number;
            totalPayPrice    += item.displayPrice       * item.number;
        }
    }
    // 合计
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%.1f0", totalPayPrice + [freight doubleValue]];
    
    // 店铺优惠价格 = 原价 - 实付
    double promotionPrice = totalOriginPrice - totalPayPrice;
    if (promotionPrice > 0) { // 有店铺优惠
        self.shopPromotionView.hidden = NO;
        self.promotionHeightCon.constant = 40;
        self.shopPromotionLabel.text = [NSString stringWithFormat:@"店铺优惠：%.1f0 元", promotionPrice];
    } else {
        self.promotionHeightCon.constant = 0;
        self.shopPromotionView.hidden = YES;
    }
    
    // 运费
    if (![freight isEqualToString:@"0"]) { // 有运费
        self.freightLabel.text = [NSString stringWithFormat:@"%@.00", freight];
    } else {
        self.freightLabel.text = @"包邮";
    }
}

@end
