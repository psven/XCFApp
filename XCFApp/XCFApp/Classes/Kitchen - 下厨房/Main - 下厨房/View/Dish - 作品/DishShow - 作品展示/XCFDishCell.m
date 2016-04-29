//
//  XCFDishCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜谱中的作品视图cell、商品中的评价视图cell
 */


#import "XCFDishCell.h"
#import "XCFDish.h"
#import "XCFAuthor.h"

#import "XCFStarView.h"
#import "XCFReview.h"
#import "XCFReviewPhoto.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFDishCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;        // 图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;     // 头像
@property (weak, nonatomic) IBOutlet UILabel *authorName;       // 作者名称
@property (weak, nonatomic) IBOutlet UILabel *descLabel;        // 描述
@property (weak, nonatomic) IBOutlet UIButton *diggsButton;     // 点赞
@property (nonatomic, strong) UIButton *createTimeButton;       // 创建时间
@property (nonatomic, strong) UIButton *loveFreshButton;        // 爱尝鲜
@property (nonatomic, strong) XCFStarView *starView;            // 评分
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descLabelTopCon; // 描述label距离作者名称label约束

@end

@implementation XCFDishCell

#pragma mark - 懒加载

- (UIButton *)createTimeButton {
    if (!_createTimeButton) {
        _createTimeButton = [UIButton buttonWithBackgroundColor:RGBA(0, 0, 0, 0.5)
                                                         title:@""
                                                titleLabelFont:[UIFont systemFontOfSize:12]
                                                    titleColor:XCFLabelColorWhite
                                                         target:nil action:nil clipsToBounds:YES];
        [self addSubview:_createTimeButton];
        [_createTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    }
    return _createTimeButton;
}

- (UIButton *)loveFreshButton {
    if (!_loveFreshButton) {
        _loveFreshButton = [UIButton buttonWithBackgroundColor:[UIColor orangeColor]
                                                         title:@"爱尝鲜"
                                                titleLabelFont:[UIFont systemFontOfSize:12]
                                                    titleColor:XCFLabelColorWhite
                                                        target:nil action:nil clipsToBounds:YES];
        [self addSubview:_loveFreshButton];
        [_loveFreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(46, 20));
        }];
    }
    return _loveFreshButton;
}

- (XCFStarView *)starView {
    if (!_starView) {
        _starView = [[XCFStarView alloc] init];
        [self addSubview:_starView];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorName.mas_bottom).offset(7);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
    }
    return _starView;
}


#pragma mark - 构造方法

- (void)setDish:(XCFDish *)dish {
    _dish = dish;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:dish.thumbnail]];
    [self.iconView setHeaderWithURL:[NSURL URLWithString:dish.author.photo]];
    self.authorName.text = dish.author.name;
    self.descLabel.text = dish.desc;
    if (dish.digged_by_me) self.diggsButton.selected = dish.digged_by_me;
    [self.diggsButton setTitle:dish.ndiggs forState:UIControlStateNormal];
    [self.diggsButton setTitle:[NSString stringWithFormat:@"%zd", [dish.ndiggs integerValue] + 1] forState:UIControlStateSelected];
    
    [self.createTimeButton setTitle:dish.friendly_create_time forState:UIControlStateNormal];
    CGFloat buttonWidth = [dish.friendly_create_time getSizeWithTextSize:CGSizeMake(MAXFLOAT, 20) fontSize:12].width + 10;
    [_createTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
    }];
}

- (void)setReview:(XCFReview *)review {
    _review = review;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:review.photos[0].url]];
    [self.iconView setHeaderWithURL:[NSURL URLWithString:review.author.photo]];
    
    self.diggsButton.hidden = YES;
    [self.starView setRate:review.rate];
    
    self.authorName.textColor = [UIColor blackColor];
    self.authorName.text = review.author.name;
    
    self.descLabel.numberOfLines = 3;
    self.descLabelTopCon.constant = 10+13+7;
    self.descLabel.text = review.review;
    
    [self.createTimeButton setTitle:review.friendly_create_time forState:UIControlStateNormal];
    CGFloat buttonWidth = [self.review.friendly_create_time getSizeWithTextSize:CGSizeMake(MAXFLOAT, 20) fontSize:12].width + 10;
    [_createTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, 20));
    }];
}


#pragma mark - 事件处理
// 点赞
- (IBAction)like:(UIButton *)sender {
    !self.diggsButtonClickedBlock ? : self.diggsButtonClickedBlock(sender);
    sender.selected = !sender.selected;
}

@end
