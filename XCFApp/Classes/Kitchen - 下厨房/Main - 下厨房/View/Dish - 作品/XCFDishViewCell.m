//
//  XCFDishViewCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/10.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  关注动态cell、商品评论cell
 */

#import "XCFDishViewCell.h"
#import "XCFImageShowView.h"
#import "XCFStarView.h"
// 关注动态 - 作品
#import "XCFDish.h"
#import "XCFEvents.h"
#import "XCFComment.h"
#import "XCFAuthor.h"
// 买买买 - 评价
#import "XCFReview.h"
#import "XCFReviewCommodity.h"
#import "XCFGoods.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>

@interface XCFDishViewCell ()

@property (nonatomic, strong) XCFImageShowView *showView;           // 图片轮播器
@property (nonatomic, strong) XCFStarView *starView;                // 分数view
@property (weak, nonatomic) IBOutlet UIView *imageShowView;         // 图片展示
@property (weak, nonatomic) IBOutlet UIImageView *iconView;         // 头像
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;      // 作者昵称
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;          // 动态类型
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;      // 创建时间
@property (weak, nonatomic) IBOutlet UIView *dishNameView;          // 作品名称view
@property (weak, nonatomic) IBOutlet UILabel *dishNameLabel;        // 作品名称
@property (weak, nonatomic) IBOutlet UILabel *descLabel;            // 作品描述
@property (weak, nonatomic) IBOutlet UILabel *diggsCountLabel;      // 点赞数量

@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;    // 评论数量
@property (weak, nonatomic) IBOutlet UILabel *firstCommentLabel;    // 第一个评论
@property (weak, nonatomic) IBOutlet UILabel *secondCommentLabel;   // 第二个评论
@property (weak, nonatomic) IBOutlet UIButton *diggsButton;         // 点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *commentButton;       // 评论按钮
@property (weak, nonatomic) IBOutlet UIButton *moreButton;          // 更多按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dishNameViewTopCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentLabelHeightCon; // 评论数量Label高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstCon;              // 第一个评论高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCon;             // 第二个评论高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *diggsButtonCon;        // 点赞按钮top约束

@property (weak, nonatomic) IBOutlet UIImageView *bottomSeperator;  // 因为之前没有考虑好数据对控件的影响，Xib的约束拖得蛋疼
@property (weak, nonatomic) IBOutlet UILabel *diggs;                // 为了不浪费时间我就直接一个一个拉过来隐藏了 =。=
@property (weak, nonatomic) IBOutlet UIImageView *topSeperator;

@end


@implementation XCFDishViewCell

static NSString * const imageCellIdentifier = @"imageCell";

- (XCFImageShowView *)showView {
    if (!_showView) {
        _showView = [[XCFImageShowView alloc] init];
        [self.imageShowView addSubview:_showView];
        [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageShowView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _showView;
}

- (XCFStarView *)starView {
    if (!_starView) {
        _starView = [[XCFStarView alloc] init];
        [self.contentView addSubview:_starView];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.authorNameLabel);
            make.top.equalTo(self.authorNameLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
    }
    return _starView;
}

- (void)awakeFromNib {
    [self.dishNameView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(dishNameViewDidClicked)]];
}


#pragma mark - 构造方法

/**
 *  关注动态 - 作品数据
 */
- (void)setDish:(XCFDish *)dish {
    _dish = dish;
    
    [self.iconView setHeaderWithURL:[NSURL URLWithString:dish.author.photo]];
    self.authorNameLabel.text = dish.author.name;
    self.createTimeLabel.text = dish.friendly_create_time;
    self.dishNameLabel.text = dish.name;
    self.descLabel.text = dish.desc;
    self.diggsCountLabel.text = [NSString stringWithFormat:@"%@人", dish.ndiggs];
    
    if (dish.is_orphan) {
        self.actionLabel.text = @"分享到";
    } else {
        self.actionLabel.text = @"做过";
    }
    
    self.commentCountLabel.text = @"";
    self.firstCommentLabel.text = @"";
    self.secondCommentLabel.text = @"";
    // 调整点赞按钮约束
    self.diggsButtonCon.constant = dish.commentViewHeight;

    if (dish.latest_comments.count) { // 如果有评论
        
        // 显示第1条评论
        self.firstCon.active = NO;
        XCFComment *firstComment = [dish.latest_comments lastObject];
        [self.firstCommentLabel setAttributeTextWithString:[NSString stringWithFormat:@"%@：%@", firstComment.author.name, firstComment.txt]
                                                     range:NSMakeRange(0, firstComment.author.name.length)];
        
        // 如果有1条以上评论
        if (dish.latest_comments.count > 1) {
            
            // 显示第2条评论
            self.secondCon.active = NO;
            XCFComment *secondComment = dish.latest_comments[dish.latest_comments.count - 2];
            [self.secondCommentLabel setAttributeTextWithString:[NSString stringWithFormat:@"%@：%@", secondComment.author.name, secondComment.txt]
                                                          range:NSMakeRange(0, secondComment.author.name.length)];
            
//            if ([secondComment.txt rangeOfString:@"@"].location != NSNotFound) {
//                
//                NSRange range1 = [secondComment.txt rangeOfString:@"@"];
//                NSRange range2 = [secondComment.txt rangeOfString:@" "];
//                NSRange result = NSMakeRange(range1.location, range2.location-range1.location);
//                XCFLog(@"%zd %zd", result.location, result.length);
//            }
            // 如果有2条以上评论
            if (dish.latest_comments.count > 2) {
                
                // 显示评论总数Label
                self.commentLabelHeightCon.active = NO;
                self.commentCountLabel.text = [NSString stringWithFormat:@"所有%ld条评论", (long)dish.ncomments];
            }
        }
    }
    
}

/**
 *  买买买 - 评价数据
 */
- (void)setReview:(XCFReview *)review {
    _review = review;
    
    self.dishNameViewTopCon.constant = 30; // 更改标题view的top约束
    self.starView.rate = review.rate;      // 评分
    
    [self.iconView setHeaderWithURL:[NSURL URLWithString:review.author.photo]];
    self.authorNameLabel.text = review.author.name;
    self.createTimeLabel.text = review.friendly_create_time;
    self.dishNameLabel.text = review.commodity.goods.name;
    self.descLabel.text = review.review;
    self.actionLabel.text = @"评价";
    
    // 粗。。粗略隐藏一下
    self.topSeperator.hidden = YES;
    self.bottomSeperator.hidden = YES;
    self.diggsCountLabel.hidden = YES;
    self.diggs.hidden = YES;
    self.diggsButton.hidden = YES;
    self.commentButton.hidden = YES;
    self.moreButton.hidden = YES;
    
}


#pragma mark - 图片数据传递

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.showView.imageArray = imageArray;
}

- (void)setImageViewCurrentLocation:(CGFloat)imageViewCurrentLocation {
    _imageViewCurrentLocation = imageViewCurrentLocation;
    self.showView.imageViewCurrentLocation = imageViewCurrentLocation;
}

- (void)setType:(XCFShowViewType)type {
    _type = type;
    self.showView.type = type;
}

- (void)setImageViewDidScrolledBlock:(void (^)())imageViewDidScrolledBlock {
    _imageViewDidScrolledBlock = imageViewDidScrolledBlock;
    self.showView.imageViewDidScrolledBlock = imageViewDidScrolledBlock;
}


#pragma mark - 事件处理

- (void)dishNameViewDidClicked {
    !self.actionBlock ? : self.actionBlock(DishViewActionName);
}

- (IBAction)digg:(UIButton *)sender {
    // 控制器发送网络请求修改点赞数据 → 数据返回刷新ui
    !self.actionBlock ? : self.actionBlock(DishViewActionDigg);
    XCFLog(@"点赞！");
}

- (IBAction)comment:(UIButton *)sender {
    XCFLog(@"评论");
    !self.actionBlock ? : self.actionBlock(DishViewActionCommment);
}

- (IBAction)more:(UIButton *)sender {
    XCFLog(@"更多");
    !self.actionBlock ? : self.actionBlock(DishViewActionMore);
}

@end


