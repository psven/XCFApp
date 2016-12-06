//
//  XCFGoodsShopPromotionView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsShopPromotionView.h"
#import "XCFGoods.h"
#import "XCFShop.h"
#import <Masonry.h>

@interface XCFGoodsShopPromotionView ()
@property (weak, nonatomic) IBOutlet UIView *shopPromotionView;     // 店铺优惠信息view
@property (weak, nonatomic) IBOutlet UILabel *announcementLabel;    // 店铺公告
@property (weak, nonatomic) IBOutlet UILabel *goodsDescLabel;       // 商品描述
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;            // “店铺”
@end

@implementation XCFGoodsShopPromotionView

- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    XCFShop *shop = goods.shop;
    
    // 测试
//    NSMutableArray *array = [NSMutableArray arrayWithArray:shop.promotion_text_list];
//    [array addObject:@"最后一天，挥泪甩卖"];
//    [array addObject:@"不要钱"];
//    shop.promotion_text_list = array;
    
    // 店铺优惠
    if (shop.promotion_text_list.count) { // 如果有店铺优惠
        self.shopPromotionView.hidden = NO;
        for (NSInteger index=0; index<shop.promotion_text_list.count; index++) {
            NSString *promotionString = shop.promotion_text_list[index];
            UIButton *promotionButton = [UIButton buttonWithBackgroundColor:[UIColor orangeColor]
                                                                      title:promotionString
                                                             titleLabelFont:[UIFont systemFontOfSize:12]
                                                                 titleColor:XCFLabelColorWhite
                                                                     target:nil action:nil clipsToBounds:NO];
            CGFloat buttonWidth = [promotionString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 20)
                                                              fontSize:12].width + 20;
            if (index == 0) { // 第一个促销信息
                [self.shopPromotionView addSubview:promotionButton];
                [promotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.shopLabel.mas_right).offset(10);
                    make.top.equalTo(self.mas_top).offset(10);
                    make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
                }];
                
            } else { // 如果有一个以上促销信息
                NSMutableArray *buttonArray = [NSMutableArray array];
                for (UIView *subview in self.shopPromotionView.subviews) {
                    if ([subview isKindOfClass:[UIButton class]]) [buttonArray addObject:subview]; // 取出所有button
                }
                UIButton *lastPromotionButton = [buttonArray lastObject]; // 取出最后加入的button
                [self.shopPromotionView addSubview:promotionButton];
                [promotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastPromotionButton.mas_right).offset(10);
                    make.top.equalTo(lastPromotionButton);
                    make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
                }];
            }
        }
    }
    // 店铺公告
    if (shop.announcement.length) self.announcementLabel.text = shop.announcement;
    // 商品描述
    self.goodsDescLabel.text = goods.desc;
    
//    // 测试
//    shop.promotion_text_list = nil;
//    shop.announcement = @"";
    
    // 调整布局
    if (!shop.promotion_text_list.count && shop.announcement.length) {          // 如果没有店铺优惠 有店铺公告
        self.shopPromotionView.hidden = YES;
        [self.announcementLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
        }];
        
    } else if (shop.promotion_text_list.count && !shop.announcement.length) {   // 如果有店铺优惠 没有店铺公告
        self.announcementLabel.hidden = YES;
        [self.goodsDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopPromotionView.mas_bottom).offset(15);
        }];
        
    } else if (!shop.promotion_text_list.count && !shop.announcement.length) {  // 如果两个都没
        self.shopPromotionView.hidden = YES;
        self.announcementLabel.hidden = YES;
        [self.goodsDescLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
        }];
    }
    
    
}

@end
