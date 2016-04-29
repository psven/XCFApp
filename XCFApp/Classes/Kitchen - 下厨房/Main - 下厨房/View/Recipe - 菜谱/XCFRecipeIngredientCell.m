//
//  XCFRecipeIngredientCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeIngredientCell.h"
#import "XCFRecipeIngredient.h"
#import "XCFCreateIngredient.h"
#import <Masonry.h>

@interface XCFRecipeIngredientCell ()
/** 用料名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 用量 */
@property (nonatomic, strong) UILabel *amountLabel;
/** 分割线 */
@property (nonatomic, strong) UIImageView *seperatorLine;
/** 购买状态虚线 */
@property (nonatomic, strong) UIImageView *purchasedLine;


@end

@implementation XCFRecipeIngredientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc]
//                                                initWithTarget:self
//                                                action:@selector(cellDidClicked)]];
        
        // 原料名称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(XCFScreenWidth*0.5 - XCFRecipeCellMarginTitle*2));
        }];
        
        
        // 用量
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _amountLabel.numberOfLines = 0;
        [self.contentView addSubview:_amountLabel];
        [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.nameLabel.mas_width);
        }];
        
        
        // 分割线
        _seperatorLine = [[UIImageView alloc] init];
        _seperatorLine.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self.contentView addSubview:_seperatorLine];
        [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle*2, 1));
        }];
        
        
        // 购买状态虚线
        _purchasedLine = [[UIImageView alloc] init];
        _purchasedLine.backgroundColor = RGBA(0, 0, 0, 0.1);
        _purchasedLine.hidden = YES;
        [self.contentView addSubview:_purchasedLine];
        [_purchasedLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth - 30, 1));
        }];
    }
    return self;
}

- (void)setIngredient:(XCFRecipeIngredient *)ingredient {
    _ingredient = ingredient;

    if (ingredient.state == XCFIngredientStatePurchased) { // 如果是已购买的原料（菜篮子中会用到）
        self.purchasedLine.hidden = NO;
        self.nameLabel.textColor = XCFLabelColorGray;
        self.amountLabel.textColor = XCFLabelColorGray;
    } else if (ingredient.state == XCFIngredientStateNone) { // 一般状态
        self.purchasedLine.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
        self.amountLabel.textColor = [UIColor blackColor];
    }
    self.nameLabel.text = ingredient.name;
    self.amountLabel.text = ingredient.amount;
}

- (void)setCreateIngredient:(XCFCreateIngredient *)createIngredient {
    _createIngredient = createIngredient;
    self.nameLabel.text = createIngredient.name;
    self.amountLabel.text = createIngredient.amount;
}

- (void)cellDidClicked {
    !self.cellDidClickedBlock ? : self.cellDidClickedBlock();
}

@end
