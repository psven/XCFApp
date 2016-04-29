//
//  XCFGoodsShopCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsShopCell.h"
#import "XCFShop.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFGoodsShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoView;             // 店铺icon
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;                // 店铺名称
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsLabel;          // 商品总数
@property (weak, nonatomic) IBOutlet UILabel *freeDeliveryDescLabel;    // 包邮描述
@property (nonatomic, strong) UIButton *goShoppingButton;               // 去逛逛
@end

@implementation XCFGoodsShopCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _goShoppingButton = [UIButton borderButtonWithBackgroundColor:XCFLabelColorWhite
                                                            title:@"去逛逛"
                                                   titleLabelFont:[UIFont systemFontOfSize:16]
                                                       titleColor:XCFThemeColor
                                                           target:self
                                                           action:@selector(goShopping)
                                                    clipsToBounds:YES];
    [self.contentView addSubview:_goShoppingButton];
    [_goShoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.logoView.mas_bottom).offset(15);
        make.height.equalTo(@(40));
    }];
}

- (void)setShop:(XCFShop *)shop {
    _shop = shop;
    
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:shop.shop_logo_url]];
    self.nameLabel.text = shop.name;
    self.totalGoodsLabel.text = [NSString stringWithFormat:@"商品数:%@",shop.goods_count];
    self.freeDeliveryDescLabel.text = shop.free_delivery_desc;
}


- (void)goShopping {

}

@end
