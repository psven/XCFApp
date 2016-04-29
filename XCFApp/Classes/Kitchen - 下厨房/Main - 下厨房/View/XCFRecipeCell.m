//
//  XCFRecipeCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  这是项目开始时写的第一个界面，不合理的地方（根据数据内容动态改变布局）导致了卡顿，没什么参考性，界面搭建也比较简单
 */

#import "XCFRecipeCell.h"
#import "XCFItems.h"
#import "XCFContents.h"
#import "XCFImage.h"
#import "XCFAuthor.h"
#import "XCFRecipe.h"
#import "XCFRecipeStats.h"
#import "XCFCreateRecipe.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFRecipeCell ()
/** 图片 */
@property (nonatomic, strong) UIImageView *image;
/** 分割线 */
@property (nonatomic, strong) UIView *separator;
/** 视频播放按钮 */
@property (nonatomic, strong) UIImageView *videoIcon;
/** 模板1描述 */
@property (nonatomic, strong) UILabel *descLabel;
/** 模板1标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 底部描述view */
@property (nonatomic, strong) UIView *bottomView;
/** 模板2大标题 */
@property (nonatomic, strong) UILabel *firstTitleLabel;
/** 模板2小标题 */
@property (nonatomic, strong) UILabel *secondTitleLabel;
/** 模板4标题 */
@property (nonatomic, strong) UILabel *whisperLabel;
/** coverView */
@property (nonatomic, strong) UIView *coverView;
/** 模板5作者头像 */
@property (nonatomic, strong) UIImageView *authorIcon;
/** 模板5人数 */
@property (nonatomic, strong) UILabel *cookedLabel;

/******************************************************************/

/** 分数 */
@property (nonatomic, strong) UILabel *scoreLabel;
/** 作者名称 */
@property (nonatomic, strong) UILabel *authorName;
/** 独家图标 */
@property (nonatomic, strong) UIButton *exclusiveButton;

@end

@implementation XCFRecipeCell

#pragma mark - 构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        // 大图
        _image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.height.equalTo(@(230));
        }];
        
        
        // 遮盖
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = RGBA(0, 0, 0, 0.2);
        [self.image addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
            make.size.equalTo(self.image);
        }];
        
        
        // 底部描述视图
        _bottomView = [[UIView alloc] init];
        _bottomView.hidden = YES;
        [self.contentView addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.image.mas_bottom);
        }];
        
        
        // 底部描述标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        [self.bottomView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_left).offset(15);
            make.right.equalTo(self.bottomView.mas_right).offset(-15);
            make.top.equalTo(self.bottomView.mas_top).offset(10);
        }];
        
        
        // 底部描述详情
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.numberOfLines = 0;
        [self.bottomView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(XCFRecipeCellMarginTitle2Desc);
        }];
        
        
        // 更新约束
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.descLabel.mas_bottom).offset(XCFRecipeCellMarginTitle);
        }];
        
        
        /******************************************************************/
        
        
        // 分数
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc];
        _scoreLabel.textColor = XCFThemeColor;
        [self.bottomView addSubview:_scoreLabel];
        [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(XCFRecipeCellMarginTitle2Desc);
        }];
        
        
        // 作者名称
        
        _authorName = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                   textColor:[UIColor grayColor]
                               numberOfLines:1
                               textAlignment:NSTextAlignmentRight];
        [self.bottomView addSubview:_authorName];
        [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(XCFRecipeCellMarginTitle2Desc);
            make.right.equalTo(self.bottomView.mas_right).offset(-12);
        }];
        
        
        // 独家图标
        _exclusiveButton = [UIButton exclusiveButton];
        _exclusiveButton.hidden = YES;
        [self.contentView addSubview:_exclusiveButton];
        [_exclusiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        /********************************/
        
        /**
         *  视频播放按钮
         */
        _videoIcon = [[UIImageView alloc] init];
        _videoIcon.image = [UIImage imageNamed:@"playButton"];
        [self.image addSubview:_videoIcon];
        [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        /**
         *  coverView
         */
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = XCFCoverViewColor;
        [self.image addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
            make.size.equalTo(self.image);
        }];
        
        /**
         *  大标题
         */
        _firstTitleLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle]
                                        textColor:XCFLabelColorWhite
                                    numberOfLines:0
                                    textAlignment:NSTextAlignmentCenter];
        [self.image addSubview:_firstTitleLabel];
        [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.image.mas_width).offset(- XCFRecipeCellMarginFirstTitle*2);
            make.centerX.equalTo(self.image.mas_centerX);
            make.bottom.equalTo(self.image.mas_centerY).offset(-10);
        }];
        
        /**
         *  小标题
         */
        _secondTitleLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeSecondTitle]
                                         textColor:XCFLabelColorWhite
                                     numberOfLines:0
                                     textAlignment:NSTextAlignmentCenter];
        [self.image addSubview:_secondTitleLabel];
        [_secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.image.mas_centerX);
            make.top.equalTo(self.firstTitleLabel.mas_bottom).offset(20);
        }];
        
        /**
         *  模板4标题
         */
        _whisperLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle]
                                     textColor:XCFLabelColorWhite
                                 numberOfLines:0
                                 textAlignment:NSTextAlignmentCenter];
        [self.image addSubview:_whisperLabel];
        [_whisperLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.image);
        }];
        
        /**
         *  作者头像
         */
        _authorIcon = [[UIImageView alloc] init];
        _authorIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(authorIconClick)];
        [_authorIcon addGestureRecognizer:tap];
        [self.contentView addSubview:_authorIcon];
        [_authorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(XCFAuthorHeaderWidth, XCFAuthorHeaderWidth));
            make.top.equalTo(self.image.mas_bottom).offset(- XCFAuthorHeaderWidth*0.5);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        /**
         *  做过的人数
         */
        _cookedLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                    textColor:XCFThemeColor
                                numberOfLines:1
                                textAlignment:NSTextAlignmentRight];
        [self.bottomView addSubview:_cookedLabel];
        [self.cookedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.descLabel.mas_bottom);
            make.right.equalTo(self.bottomView.mas_right).offset(-12);
        }];
        
    }
    return self;
}

/**
 *  这个界面是项目开始的时候写的，频繁的判断调整应该是导致界面卡顿的原因。
 */
#pragma mark - item模型
- (void)setItem:(XCFItems *)item {
    _item = item;
    
    // 接收到模型数据后设置图片，图片高度
    [self.image sd_setImageWithURL:[NSURL URLWithString:item.contents.image.url] placeholderImage:nil];
    [self.image mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(item.contents.image.height));
    }];
    
    
    // 隐藏所有控件
    self.firstTitleLabel.hidden = YES;
    self.secondTitleLabel.hidden = YES;
    self.bottomView.hidden = YES;
    self.authorIcon.hidden = YES;
    self.whisperLabel.hidden = YES;
    self.cookedLabel.hidden = YES;
    self.videoIcon.hidden = YES;
    self.descLabel.hidden = YES;
    
    self.exclusiveButton.hidden = YES;
    self.scoreLabel.hidden = YES;
    self.authorName.hidden = YES;
    
    
    
    // 根据模板设置控件
    if (item.template == XCFCellTemplateTopic || item.template == XCFCellTemplateRecipe) { // 模板1帖子 或者 模板5菜谱
        self.bottomView.hidden = NO;
        self.descLabel.hidden = NO;
        self.descLabel.text = item.contents.desc;
        self.titleLabel.text =  item.contents.title;
        //
        //        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.bottomView.mas_left).offset(XCFRecipeCellMarginTitle);
        //            make.right.equalTo(self.bottomView.mas_right).offset(-XCFRecipeCellMarginTitle);
        //            make.top.equalTo(self.bottomView.mas_top).offset(10);
        //        }];
        
        if (item.template == XCFCellTemplateRecipe) { // 模板5菜谱
            self.videoIcon.hidden = !item.contents.video_url.length;
            self.cookedLabel.hidden = NO;
            self.authorIcon.hidden = NO;
            [self.authorIcon setHeaderWithURL:[NSURL URLWithString:item.contents.author.photo]];
            self.cookedLabel.text = [NSString stringWithFormat:@"%zd人做过", item.contents.n_cooked];
            //
            //            [self.cookedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //                make.bottom.equalTo(self.descLabel.mas_bottom);
            //                make.right.equalTo(self.bottomView.mas_right).offset(-12);
            //            }];
        }
        
    } else if (item.template == XCFCellTemplateRecipeList) { // 模板2菜单
        self.firstTitleLabel.hidden = NO;
        self.secondTitleLabel.hidden = NO;
        self.firstTitleLabel.text = item.contents.title_1st;
        self.secondTitleLabel.text = item.contents.title_2nd;
        
        
    } else if (item.template == XCFCellTemplateDish) { // 模板4作品
        self.whisperLabel.hidden = NO;
        self.whisperLabel.text = item.contents.whisper;
        
        
    } else if (item.template == XCFCellTemplateWeeklyMagazine) { // 模板6
        
    }
    
}


#pragma mark - recipe模型
- (void)setRecipe:(XCFRecipe *)recipe {
    _recipe = recipe;
    
    self.firstTitleLabel.hidden = YES;
    self.secondTitleLabel.hidden = YES;
    self.whisperLabel.hidden = YES;
    self.descLabel.hidden = YES;
    self.bottomView.hidden = NO;
    self.videoIcon.hidden = !recipe.video_url.length;
    self.exclusiveButton.hidden = !recipe.is_exclusive;
    
    // 图片、头像
    self.image.contentMode = UIViewContentModeScaleToFill;
    if (recipe.photo526.length) [self.image sd_setImageWithURL:[NSURL URLWithString:recipe.photo526]];
    self.authorIcon.hidden = NO;
    [self.authorIcon setHeaderWithURL:[NSURL URLWithString:recipe.author.photo]];
    
    // 标题、标题行数、设置图片标题右边约束
    self.titleLabel.text = recipe.name;
    self.titleLabel.numberOfLines = 1;
    //    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.bottomView.mas_left).offset(15);
    //        make.right.equalTo(self.authorIcon.mas_left).offset(-10);
    //        make.top.equalTo(self.bottomView.mas_top).offset(10);
    //    }];
    
    // 作者名称
    self.authorName.text = recipe.author.name;
    
    // 做过的人数、调整位置
    self.cookedLabel.textColor = [UIColor grayColor];
    self.cookedLabel.text = [NSString stringWithFormat:@"%@人做过", recipe.stats.n_cooked];
    //    [self.cookedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    //        make.left.equalTo(self.scoreLabel.mas_right).offset(8);
    //    }];
    
    
    self.scoreLabel.hidden = YES;
    // 分数、如果没有更新约束
    if (recipe.score.length) {
        self.scoreLabel.hidden = NO;
        self.scoreLabel.text = [NSString stringWithFormat:@"%@分", recipe.score];
    } else {
        //        [self.cookedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.titleLabel.mas_bottom).offset(XCFRecipeCellMarginTitle2Desc);
        //            make.left.equalTo(self.titleLabel.mas_left);
        //        }];
    }
    
}

#pragma mark - 点击事件
- (void)authorIconClick {
    !self.authorIconClickedBlock ? : self.authorIconClickedBlock();
};


@end
