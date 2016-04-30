//
//  XCFMeInfoView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMeInfoView.h"
#import "XCFAuthorDetail.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFMeInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *authorIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *follow;
@property (weak, nonatomic) IBOutlet UILabel *follower;
@property (weak, nonatomic) IBOutlet UILabel *otherInfoLabel;
@property (nonatomic, strong)        UIButton *followButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorheight;

@end

@implementation XCFMeInfoView

- (void)awakeFromNib {
    // 添加蒙版
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.backImageView.bounds];
    [self.backImageView addSubview:toolbar];
}

- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                      title:@"关注"
                                             titleLabelFont:[UIFont systemFontOfSize:14]
                                                 titleColor:XCFLabelColorWhite
                                                     target:self action:@selector(followAuthor) clipsToBounds:YES];
        [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
        [self addSubview:_followButton];
        [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.name);
            make.top.equalTo(self.otherInfoLabel.mas_bottom).offset(8);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
    }
    return _followButton;
}


- (void)setAuthorDetail:(XCFAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
    if (authorDetail.type == XCFAuthorTypeOther) {
        self.followButton.hidden = NO;
        self.authorWidth.constant = 110;
        self.authorheight.constant = 110;
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:authorDetail.photo]];
        [self.authorIcon setHeaderWithURL:[NSURL URLWithString:authorDetail.photo]];
    } else {
        self.backImageView.image = authorDetail.image;
        self.authorIcon.image = [authorDetail.image circleImage];
    }
    
    self.name.text = authorDetail.name;
    if (!authorDetail.nfollow.length) authorDetail.nfollow = @"0";
    if (!authorDetail.nfollowed.length) authorDetail.nfollowed = @"0";
    
    NSString *followStr = [NSString stringWithFormat:@"%@ 关注", authorDetail.nfollow];
    [self.follow setAttributeTextWithString:followStr
                                      range:NSMakeRange(0, authorDetail.nfollow.length)];
    NSString *followerStr = [NSString stringWithFormat:@"%@ 粉丝", authorDetail.nfollowed];
    [self.follower setAttributeTextWithString:followerStr
                                        range:NSMakeRange(0, authorDetail.nfollowed.length)];
    
    NSMutableString *otherInfo = [NSMutableString string];
    if (authorDetail.gender.length)  [otherInfo appendString:[NSString stringWithFormat:@"%@  ", authorDetail.gender]];
    if (authorDetail.profession.length)  [otherInfo appendString:[NSString stringWithFormat:@"%@  ", authorDetail.profession]];
    
    NSDateFormatter *dmt = [[NSDateFormatter alloc] init];
    dmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dmt dateFromString:authorDetail.create_time];
    dmt.dateFormat = @"yyyy-MM-dd";
    NSString *joinDate = [dmt stringFromDate:date];
    [otherInfo appendString:[NSString stringWithFormat:@"%@ 加入", joinDate]];
    self.otherInfoLabel.text = otherInfo;
    
    
}

- (void)followAuthor {
    self.followButton.selected = !self.followButton.isSelected;
    
}

@end
