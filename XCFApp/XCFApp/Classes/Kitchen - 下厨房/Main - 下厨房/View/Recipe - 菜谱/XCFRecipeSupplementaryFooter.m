//
//  XCFRecipeSupplementaryFooter.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeSupplementaryFooter.h"
#import <Masonry.h>

@interface XCFRecipeSupplementaryFooter ()
/** 上传 */
@property (nonatomic, strong) UIButton *uploadButton;
/** 评论 */
@property (nonatomic, strong) UILabel *commentLabel;
/** 举报 */
@property (nonatomic, strong) UILabel *reportLabel;
/** 喜欢这道菜的还喜欢 */
@property (nonatomic, strong) UILabel *likeLabel;
/** 分割线 */
@property (nonatomic, strong) UIImageView *seperatorLine;
@end

@implementation XCFRecipeSupplementaryFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        
        // 所有作品、查看评价按钮
        _uploadButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                      title:@"上传我做的这道菜"
                                             titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                 titleColor:XCFLabelColorWhite
                                                     target:self
                                                     action:@selector(collectButtonClicked)
                                              clipsToBounds:YES];
//        [_uploadButton setImage:[UIImage imageNamed:@"recipeDetailPortraitCameraIcon"] forState:UIControlStateNormal];
        [self addSubview:_uploadButton];
        [_uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth-XCFRecipeCellMarginTitle*2, 50));
        }];
        [_uploadButton addTarget:self action:@selector(uploadRecipe) forControlEvents:UIControlEventTouchUpInside];
        
        // 评价
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _commentLabel.textColor = XCFThemeColor;
        _commentLabel.text = @"0条评论";
        [self addSubview:_commentLabel];
        [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.uploadButton.mas_bottom).offset(50);
            make.left.equalTo(self).offset(XCFRecipeCellMarginTitle);
        }];
        
        // 举报
        _reportLabel = [[UILabel alloc] init];
        _reportLabel.font = [UIFont systemFontOfSize:14];
        _reportLabel.textColor = XCFLabelColorGray;
        _reportLabel.text = @"举报此菜谱";
        [self addSubview:_reportLabel];
        [_reportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentLabel);
            make.right.equalTo(self).offset(-XCFRecipeCellMarginTitle);
        }];
        
        // 喜欢
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _likeLabel.textColor = XCFThemeColor;
        _likeLabel.text = @"喜欢这道菜的也喜欢";
        [self addSubview:_likeLabel];
        [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentLabel.mas_bottom).offset(20);
            make.left.equalTo(self.commentLabel);
        }];
        
        // 分割线
        _seperatorLine = [[UIImageView alloc] init];
        _seperatorLine.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self.contentView addSubview:_seperatorLine];
        [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).insets(UIEdgeInsetsMake(0, XCFRecipeCellMarginTitle, 0, -XCFRecipeCellMarginTitle));
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle*2, 1));
        }];
        
    }
    return self;
}

- (void)uploadRecipe {
    !self.uploadButtonClickedBlock ? : self.uploadButtonClickedBlock();
}


- (void)collectButtonClicked {
    
}

@end