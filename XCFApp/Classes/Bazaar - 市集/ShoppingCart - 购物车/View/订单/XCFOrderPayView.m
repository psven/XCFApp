//
//  XCFOrderPayView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFOrderPayView.h"
#import "XCFCartItemTool.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"

@interface XCFOrderPayView ()
@property (weak, nonatomic) IBOutlet UILabel *totalPayPrice;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation XCFOrderPayView

- (void)awakeFromNib {
    NSArray *totalItemsArray = [XCFCartItemTool totalItems];
    double totalPrice = 0;   // 总价格
    double totalFreight = 0; // 总运费
    for (NSArray *shopArray in totalItemsArray) {
        totalFreight += [[[shopArray[0] goods] freight] doubleValue];
        for (XCFCartItem *item in shopArray) {
            if (item.state == XCFCartItemStateSelected) {
                totalPrice += item.displayPrice * item.number;
            }
        }
    }
    self.totalPayPrice.text = [NSString stringWithFormat:@"实付款：¥%.1f0", totalPrice+totalFreight];
    
    [self.payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pay {
    // 付款
}

@end
