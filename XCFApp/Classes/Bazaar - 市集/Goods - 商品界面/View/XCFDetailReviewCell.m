//
//  XCFDetailReviewCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDetailReviewCell.h"
#import "XCFStarView.h"
#import "XCFReviewPhoto.h"
#import "XCFReview.h"
#import "XCFAuthor.h"
#import "XCFReviewCommodity.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFDetailReviewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *authorIcon;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, strong) XCFStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@end

@implementation XCFDetailReviewCell

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

- (void)setReview:(XCFReview *)review {
    _review = review;
    
    [self.authorIcon setHeaderWithURL:[NSURL URLWithString:review.author.photo]];
    self.authorNameLabel.text = review.author.name;
    self.starView.rate = review.rate;
    self.reviewLabel.text = review.review;
    self.createTimeLabel.text = review.friendly_create_time;
    self.kindLabel.text = [NSString stringWithFormat:@"种类：%@", review.commodity.kind_name];
    
    // 如果有晒图，就根据数据动态添加图片，我这里用的是自动布局，也可以用frame
    if (review.photos.count) {
        for (NSInteger index=0; index<review.photos.count; index++) {
            UIImageView *reviewPhoto = [[UIImageView alloc] init];
            reviewPhoto.tag = index;
            // 添加点击事件 传递下标
            reviewPhoto.userInteractionEnabled = YES;
            [reviewPhoto addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(showImage:)]];
            
            if (index == 0) { // 第一张图片]
                [reviewPhoto sd_setImageWithURL:[NSURL URLWithString:[review.photos[index] url]]];
                [self.contentView addSubview:reviewPhoto];
                [reviewPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.authorIcon);
                    make.top.equalTo(self.reviewLabel.mas_bottom).offset(5);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
            } else { // 如果有多张图片
                NSMutableArray *photoArray = [NSMutableArray array];
                for (UIView *subview in self.contentView.subviews) {
                    if ([subview isKindOfClass:[UIImageView class]]) [photoArray addObject:subview];
                }
                [reviewPhoto sd_setImageWithURL:[NSURL URLWithString:[review.photos[index] url]]];
                [self.contentView addSubview:reviewPhoto];
                UIImageView *lastPhoto = [photoArray lastObject];
                [reviewPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastPhoto.mas_right).offset(10);
                    make.top.equalTo(lastPhoto);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
                
                // 如果图片多到需要换行显示就再写一层判断 这里就不写了 有兴趣的童鞋可以自己尝试实现一下
            }
        }
    } else {
        // 解决复用：没有图片的就隐藏
        for (UIView *subview in self.contentView.subviews) {
            if ([subview isKindOfClass:[UIImageView class]] && subview.frame.size.height == 60) subview.hidden = YES;
        }
    }
}

- (void)showImage:(UITapGestureRecognizer *)ges {
    UIView *view = ges.view;
    CGRect currentRect = [view convertRect:view.bounds toView:nil];
    !self.showImageBlock ? : self.showImageBlock(view.tag, currentRect);
}


@end
