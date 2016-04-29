//
//  XCFRecipeListHeader.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/6.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeListHeader.h"
#import "XCFRecipeList.h"
#import "XCFAuthor.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFRecipeListHeader ()

/** 菜单标题 */
@property (nonatomic, strong) UILabel *nameLabel;
/** view */
@property (nonatomic, strong) UIView *authorNameView;
/** “来自” */
@property (nonatomic, strong) UILabel *comeLabel;
/** 作者名字 */
@property (nonatomic, strong) UILabel *authorNameLabel;
/** 菜单描述 */
@property (nonatomic, strong) UILabel *descLabel;
/** 认证厨师标识 */
@property (nonatomic, strong) UIImageView *expertIcon;
/** 收藏按钮 */
@property (nonatomic, strong) UIButton *collectButton;

@end

@implementation XCFRecipeListHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = XCFGlobalBackgroundColor;
        // 菜单标题
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(XCFRecipeListViewMarginHeadTitle);
        }];
        
        
        // 作者名字
        _authorNameLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]
                                        textColor:[UIColor lightGrayColor]
                                    numberOfLines:1
                                    textAlignment:NSTextAlignmentLeft];
        [self addSubview:_authorNameLabel];
        [_authorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
        }];
        
        
        // 认证厨师图标
        _expertIcon = [[UIImageView alloc] init];
        _expertIcon.image = [UIImage imageNamed:@"userIsExpertIcon28x28"];
        [self addSubview:_expertIcon];
        [_expertIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorNameLabel);
            make.left.equalTo(self.authorNameLabel.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(XCFRecipeListViewHeightExpertIcon, XCFRecipeListViewHeightExpertIcon));
        }];
        
        
        // 菜单描述
        _descLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                  textColor:[UIColor blackColor]
                              numberOfLines:0
                              textAlignment:NSTextAlignmentLeft];
        [self addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
            make.left.equalTo(self.mas_left).offset(XCFRecipeCellMarginTitle);
            make.right.equalTo(self.mas_right).offset(-XCFRecipeCellMarginTitle);
        }];
        
        // 收藏按钮
        _collectButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                       title:@"收藏"
                                              titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                  titleColor:XCFLabelColorWhite
                                                      target:self
                                                      action:@selector(collectButtonClicked)
                                               clipsToBounds:YES];
        [self addSubview:_collectButton];
        [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.descLabel.mas_bottom).offset(XCFRecipeListViewMarginHeadTitle2Name);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth / 3, XCFRecipeListViewHeightCollectButton));
        }];
        
    }
    return self;
}


- (void)setRecipeList:(XCFRecipeList *)recipeList {
    _recipeList = recipeList;
    
    self.nameLabel.text = recipeList.name;
    self.descLabel.text = recipeList.desc;
    self.expertIcon.hidden = !recipeList.author.is_expert;
    
    NSString *displayAuthorName = [NSString stringWithFormat:@"来自：%@", recipeList.author.name];
    [self.authorNameLabel setAttributeTextWithString:displayAuthorName
                                               range:NSMakeRange(3, recipeList.author.name.length)];
}

- (void)collectButtonClicked {
    !self.collectActionBlock ? : self.collectActionBlock();
}

@end
