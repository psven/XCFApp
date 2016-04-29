//
//  XCFDishShowCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/8.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜谱中的作品视图、商品中的评价视图
 */

#import "XCFDishShowCell.h"
#import "XCFRecipe.h"
#import "XCFRecipeStats.h"
#import "XCFDishCell.h"
#import "XCFDish.h"

#import "XCFStarView.h"
#import "XCFGoods.h"
#import "XCFReview.h"

#import <Masonry.h>

@interface XCFDishShowCell () <UICollectionViewDataSource, UICollectionViewDelegate>
/** 作品、评价 */
@property (nonatomic, strong) UILabel *label;
/** 按钮 */
@property (nonatomic, strong) UIButton *button;
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 评价分数view */
@property (nonatomic, strong) UIView *rateView;
/** 评价 */
@property (nonatomic, strong) XCFStarView *starView;
/** 评分Label */
@property (nonatomic, strong) UILabel *rateLabel;
/** 指示器 */
@property (nonatomic, strong) UILabel *progressLabel;
/** 是否刷新 */
@property (nonatomic, assign) BOOL readyToRefresh;
/** 是否跳转 */
@property (nonatomic, assign) BOOL readyToPush;

@end

@implementation XCFDishShowCell

- (UIView *)rateView {
    if (!_rateView) {
        _rateView = [[UIView alloc] init];
        [self.contentView addSubview:_rateView];
        [_rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_bottom).offset(7);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(110, 15));
        }];
    }
    return _rateView;
}

- (XCFStarView *)starView {
    if (!_starView) {
        _starView = [[XCFStarView alloc] init];
        [self.rateView addSubview:_starView];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.rateView);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
    }
    return _starView;
}


- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.font = [UIFont systemFontOfSize:12];
        [self.rateView addSubview:_rateLabel];
        [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.rateView);
        }];
    }
    return _rateLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = XCFDishViewBackgroundColor;
        
        // 作品数、评价数
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(XCFRecipeCellMarginTitle);
            make.centerX.equalTo(self.contentView);
        }];
        
        // 作品、购买记录collectionView
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(XCFScreenWidth*0.5+10, XCFScreenHeight*0.5+25);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDishCell class]) bundle:nil] forCellWithReuseIdentifier:@"RecipeDishCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = XCFDishViewBackgroundColor;
        
        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_bottom).offset(XCFRecipeCellMarginTitle);
            make.left.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, XCFScreenHeight*0.5 + 25));
        }];
        
        
        // 所有作品、查看评价按钮
        _button = [UIButton borderButtonWithBackgroundColor:XCFDishViewBackgroundColor
                                                      title:@"所有作品"
                                             titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                 titleColor:XCFThemeColor
                                                     target:self
                                                     action:@selector(showAllDishes)
                                              clipsToBounds:YES];
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).offset(20);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(120, 40));
        }];
        
    }
    return self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    NSInteger count;
    if (self.type == XCFVerticalCellTypeDish) { // 作品
        count = self.dish.count;
    } else if (self.type == XCFVerticalCellTypeReview) { // 评价
        count = self.goods.reviews.count;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XCFDishCell *cell = (XCFDishCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RecipeDishCell"
                                                                                 forIndexPath:indexPath];
    if (self.type == XCFVerticalCellTypeDish) { // 作品
        if (self.dish.count) cell.dish = self.dish[indexPath.row];
        cell.diggsButtonClickedBlock = self.diggsButtonClickedBlock; // 传递点赞事件block
    } else if (self.type == XCFVerticalCellTypeReview) { // 评价
        cell.review = self.goods.reviews[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.collectionViewCellClickedBlock ? : self.collectionViewCellClickedBlock(indexPath.row);
}


#pragma mark - UIScrollViewDelegate

/**
 *  通过判断滚动的位置，决定是否刷新
 *  40 -> sectionInset.left + sectionInset.right
 *  10 -> flowLayout.minimumLineSpacing
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat itemWidth = XCFScreenWidth*0.5+10;
    
    if (self.type == XCFVerticalCellTypeDish) { // 作品刷新
        CGFloat dishContentSizeWidth = (itemWidth + 10) * self.dish.count - 10 + 40;
        self.readyToRefresh = (scrollView.contentOffset.x > dishContentSizeWidth - XCFScreenWidth + 50);
        
    } else if (self.type == XCFVerticalCellTypeReview) { // 评价跳转
        CGFloat reviewContentSizeWidth = itemWidth * 4 + 30 + 40;
        self.readyToPush = (scrollView.contentOffset.x > reviewContentSizeWidth - XCFScreenWidth + 50);
    }
}

/**
 *  松开的一瞬间调用block，刷新数据
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 作品刷新
    !(self.refreshBlock && self.readyToRefresh && self.dish.count<[self.recipe.stats.n_dishes integerValue]) ? : self.refreshBlock();
    // 评价跳转
    !(self.showAll && self.readyToPush) ? : self.showAll();
}


#pragma mark - 构造方法

- (void)setRecipe:(XCFRecipe *)recipe {
    _recipe = recipe;
    self.label.text = [NSString stringWithFormat:@"%@个作品", recipe.stats.n_dishes];
}

- (void)setDish:(NSMutableArray *)dish {
    _dish = dish;
    [self.collectionView reloadData]; // 接收到数据后刷新列表
}

- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    self.label.text = [NSString stringWithFormat:@"%@人评价", goods.n_reviews];
    self.rateLabel.text = [NSString stringWithFormat:@"%@星", goods.average_rate];
    [self.starView setRate:[goods.average_rate floatValue]];
    [self.button setTitle:@"查看评价" forState:UIControlStateNormal];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rateView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, XCFScreenHeight*0.5 + 25));
    }];
    [self.collectionView reloadData]; // 接收到数据后刷新列表
}

#pragma mark - 点击事件
- (void)showAllDishes {
    !self.showAll ? : self.showAll();
}

@end
