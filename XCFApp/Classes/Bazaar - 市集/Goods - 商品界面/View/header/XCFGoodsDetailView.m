//
//  XCFGoodsDetailView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsDetailView.h"
#import "XCFGoods.h"
#import <Masonry.h>

@interface XCFGoodsDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *averageRateLabel;     // 评分
@property (weak, nonatomic) IBOutlet UILabel *monthSaleLabel;       // 月销
@property (weak, nonatomic) IBOutlet UILabel *totalSaleLabel;       // 总销量
@property (weak, nonatomic) IBOutlet UILabel *forewordLabel;        // 前置文字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;            // 标题
@property (weak, nonatomic) IBOutlet UILabel *displayPriceLabel;    // 显示价格
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;     // 原价格
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;         // 运费
@end

@implementation XCFGoodsDetailView


- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    
    [self.averageRateLabel setAttributeTextWithString:[NSString stringWithFormat:@"评分 %@", goods.average_rate]
                                                range:NSMakeRange(3, goods.average_rate.length)];
    [self.monthSaleLabel setAttributeTextWithString:[NSString stringWithFormat:@"月销 %@件", goods.recent_30days_sales_volume]
                                              range:NSMakeRange(3, goods.recent_30days_sales_volume.length+1)];
    [self.totalSaleLabel setAttributeTextWithString:[NSString stringWithFormat:@"总销量 %@件", goods.total_sales_volume]
                                              range:NSMakeRange(4, goods.total_sales_volume.length+1)];
    
    self.forewordLabel.text = goods.foreword;
    self.nameLabel.text = goods.name;
    self.displayPriceLabel.text = [NSString stringWithFormat:@"¥ %@0", goods.display_price];
    self.freightLabel.text = goods.display_freight;
    
    NSString *originPriceString = [NSString stringWithFormat:@"¥ %@0", goods.display_original_price];
    NSMutableAttributedString *originPriceAttrsStr = [[NSMutableAttributedString alloc] initWithString:originPriceString];
    [originPriceAttrsStr addAttribute:NSStrikethroughStyleAttributeName value:@(1)
                                range:NSMakeRange(0, originPriceString.length)];
    self.originPriceLabel.attributedText = originPriceAttrsStr;
    
    
    // 测试
    NSMutableArray *array = [NSMutableArray arrayWithArray:goods.promotion_text_list];
    [array addObject:@"新品上新"];
    [array addObject:@"品质优选"];
    goods.promotion_text_list = array;
    
    // 如果有商品优惠信息
    if (goods.promotion_text_list.count) {
        for (NSInteger index=0; index<goods.promotion_text_list.count; index++) {
            NSString *promotionString = goods.promotion_text_list[index];
            UIButton *promotionButton = [UIButton borderButtonWithBackgroundColor:XCFLabelColorWhite
                                                                            title:promotionString
                                                                   titleLabelFont:[UIFont systemFontOfSize:12]
                                                                       titleColor:XCFThemeColor
                                                                           target:nil action:nil clipsToBounds:NO];
            CGFloat buttonWidth = [promotionString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 20) fontSize:12].width + 20;
            
            if (index == 0) { // 第一个促销信息
                [self addSubview:promotionButton];
                [promotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self).offset(15);
                    make.top.equalTo(self.displayPriceLabel.mas_bottom).offset(15);
                    make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
                }];
            } else { // 如果有一个以上促销信息
                NSMutableArray *buttonArray = [NSMutableArray array];
                for (UIView *subview in self.subviews) {
                    if ([subview isKindOfClass:[UIButton class]]) [buttonArray addObject:subview]; // 取出所有button
                }
                [self addSubview:promotionButton];
                UIButton *lastPromotionButton = [buttonArray lastObject];
                [promotionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastPromotionButton.mas_right).offset(10);
                    make.bottom.equalTo(lastPromotionButton);
                    make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
                }];
            }
            
        }
    }
}


@end
