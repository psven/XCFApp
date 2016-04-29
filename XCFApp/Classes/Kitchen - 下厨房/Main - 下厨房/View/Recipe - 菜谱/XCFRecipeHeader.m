//
//  XCFRecipeHeader.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeHeader.h"
#import "XCFRecipe.h"
#import "XCFRecipeStats.h"
#import "XCFAuthor.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFRecipeHeader ()

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 菜谱标题 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 独家图标 */
@property (nonatomic, strong) UIButton *exclesiveIcon;
/** view */
@property (nonatomic, strong) UIView *statsView;
/** 分数 */
@property (nonatomic, strong) UILabel *scoreLabel;
/** 做过的人数 */
@property (nonatomic, strong) UILabel *cookedLabel;

/** 分割线 */
@property (nonatomic, strong) UIImageView *seperatorLine;

/** 菜谱描述 */
@property (nonatomic, strong) UILabel *descLabel;
/** 作者头像 */
@property (nonatomic, strong) UIImageView *authorIcon;
/** 作者名字 */
@property (nonatomic, strong) UILabel *authorNameLabel;
/** 创建时间 */
@property (nonatomic, strong) UILabel *createTimeLabel;

@end

@implementation XCFRecipeHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XCFLabelColorWhite;
        // 顶部大图
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 250));
        }];
        
        // 菜谱标题
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle);
        }];
        
        // 独家图标
        _exclesiveIcon = [UIButton exclusiveButton];
        [self addSubview:_exclesiveIcon];
        [_exclesiveIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        
        // view
        _statsView = [[UIView alloc] init];
        [self addSubview:_statsView];
        [_statsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.exclesiveIcon.mas_bottom).offset(10);
            make.height.equalTo(@(XCFRecipeListViewHeightAuthorName));
        }];
        
        
        // 分数
        _scoreLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                  textColor:[UIColor grayColor]
                              numberOfLines:1
                              textAlignment:NSTextAlignmentLeft];
        [self.statsView addSubview:_scoreLabel];
        [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.statsView);
        }];
        
        
        // 做过人数
        _cookedLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                   textColor:[UIColor grayColor]
                               numberOfLines:1
                               textAlignment:NSTextAlignmentLeft];
        [self.statsView addSubview:_cookedLabel];
        [_cookedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statsView);
            make.left.equalTo(self.scoreLabel.mas_right).offset(15);
        }];
        
        
        // 分割线
        _seperatorLine = [[UIImageView alloc] init];
        _seperatorLine.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self addSubview:_seperatorLine];
        [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.statsView.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 1));
        }];
        
        
        // 菜谱描述
        _descLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                  textColor:[UIColor blackColor]
                              numberOfLines:0
                              textAlignment:NSTextAlignmentLeft];
        [self addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.seperatorLine.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle);
            make.left.equalTo(self.mas_left).offset(XCFRecipeCellMarginTitle);
            make.right.equalTo(self.mas_right).offset(-XCFRecipeCellMarginTitle);
        }];
        
        
        // 作者头像
        _authorIcon = [[UIImageView alloc] init];
        [self addSubview:_authorIcon];
        [_authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.descLabel.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
            make.size.mas_equalTo(CGSizeMake(XCFAuthorHeaderWidth + 10, XCFAuthorHeaderWidth + 10));
        }];
        
        
        // 作者名字
        _authorNameLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                        textColor:[UIColor grayColor]
                                    numberOfLines:1
                                    textAlignment:NSTextAlignmentCenter];
        [self addSubview:_authorNameLabel];
        [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.authorIcon.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
        }];
        
        
        // 创建时间
        _createTimeLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                        textColor:[UIColor grayColor]
                                    numberOfLines:1
                                    textAlignment:NSTextAlignmentCenter];
        [self addSubview:_createTimeLabel];
        [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(5);
        }];
        
    }
    return self;
}


- (void)setRecipe:(XCFRecipe *)recipe {
    _recipe = recipe;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:recipe.photo]];
    self.nameLabel.text = recipe.name;
    self.cookedLabel.text = [NSString stringWithFormat:@"%@人最近7天做过",recipe.stats.n_cooked];
    self.descLabel.text = recipe.desc;
    [self.authorIcon setHeaderWithURL:[NSURL URLWithString:recipe.author.photo]];
    self.authorNameLabel.text = recipe.author.name;
    self.createTimeLabel.text = [NSString stringWithFormat:@"创建于%@",recipe.create_time];
    

    if (!recipe.is_exclusive) { // 如果是独家菜谱
        self.exclesiveIcon.hidden = YES;
        [self.statsView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.equalTo(@(XCFRecipeListViewHeightAuthorName));
            make.top.equalTo(self.nameLabel.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
        }];
    }
    
    [self.statsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(recipe.statsViewWidth));
    }];
    
    
    if (recipe.score.length) { // 如果有综合评分
        self.scoreLabel.text = [NSString stringWithFormat:@"%@综合评分",recipe.score];
    } else {
        self.scoreLabel.hidden = YES;
        [self.cookedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statsView);
            make.left.equalTo(self.statsView);
        }];
    }
    
    
}

@end
