//
//  XCFGoodsHeaderView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsHeaderView.h"
#import "XCFImageShowView.h"
#import "XCFGoodsDetailView.h"
#import "XCFGoodsShopPromotionView.h"

#import "XCFGoods.h"
#import "XCFReviewPhoto.h"

#import <Masonry.h>
#import <MJExtension.h>

@interface XCFGoodsHeaderView ()

@property (nonatomic, strong) XCFImageShowView *showView;
@property (nonatomic, strong) XCFGoodsDetailView *detailView;
@property (nonatomic, strong) XCFGoodsShopPromotionView *shopPromotionView;


@end

@implementation XCFGoodsHeaderView

- (XCFImageShowView *)showView {
    if (!_showView) {
        _showView = [[XCFImageShowView alloc] init];
        _showView.showImageBlock = self.showImageBlock;
        [self addSubview:_showView];
        [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@350);
        }];
    }
    return _showView;
}

- (XCFGoodsDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFGoodsDetailView class])
                                                     owner:self options:nil] lastObject];
        [self addSubview:_detailView];
        [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.showView.mas_bottom);
        }];
    }
    return _detailView;
}

- (XCFGoodsShopPromotionView *)shopPromotionView {
    if (!_shopPromotionView) {
        _shopPromotionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFGoodsShopPromotionView class])
                                                            owner:self options:nil] lastObject];
        [self addSubview:_shopPromotionView];
        [_shopPromotionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.detailView.mas_bottom);
        }];
    }
    return _shopPromotionView;
}

- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    [imageArray addObject:goods.main_pic];
    if (goods.extra_pics.count) {
        NSArray *photosArray = [XCFReviewPhoto mj_objectArrayWithKeyValuesArray:goods.extra_pics];
        [imageArray addObjectsFromArray:photosArray];
    }
    self.showView.imageArray = goods.totalPics;
    self.showView.type = XCFShowViewTypeGoods;
    
    self.detailView.goods = goods;
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(goods.goodsDetailViewHeight));
    }];
    
    self.shopPromotionView.goods = goods;
    [self.shopPromotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(goods.shopPromotionViewHeight));
    }];
}

- (void)setImageViewCurrentLocation:(CGFloat)imageViewCurrentLocation {
    _imageViewCurrentLocation = imageViewCurrentLocation;
    self.showView.imageViewCurrentLocation = imageViewCurrentLocation;
}

@end
