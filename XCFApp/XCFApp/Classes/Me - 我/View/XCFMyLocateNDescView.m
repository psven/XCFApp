//
//  XCFMyLocateNDescView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMyLocateNDescView.h"
#import "XCFAuthorDetail.h"
#import <Masonry.h>

@interface XCFMyLocateNDescView ()
@property (weak, nonatomic) IBOutlet UILabel *locate;
@property (weak, nonatomic) IBOutlet UIImageView *seperator;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *dishCount;
@property (weak, nonatomic) IBOutlet UILabel *recipeCount;
@property (nonatomic, strong) UIButton *showMoreButton;
@end

@implementation XCFMyLocateNDescView

- (UIButton *)showMoreButton {
    if (!_showMoreButton) {
        _showMoreButton = [UIButton borderButtonWithBackgroundColor:[UIColor clearColor]
                                                              title:@"阅读更多"
                                                     titleLabelFont:[UIFont systemFontOfSize:14]
                                                         titleColor:XCFThemeColor
                                                             target:self action:@selector(showMore) clipsToBounds:YES];
        [_showMoreButton setTitle:@"收起" forState:UIControlStateSelected];
        [self addSubview:_showMoreButton];
        [_showMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.summary.mas_bottom).offset(20);
            make.size.mas_equalTo(CGSizeMake(60, 35));
        }];
    }
    return _showMoreButton;
}


- (void)setAuthorDetail:(XCFAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
    
    NSMutableString *location = [NSMutableString string];
    if (authorDetail.hometown_location.length)  [location appendString:[NSString stringWithFormat:@"家乡：%@", authorDetail.hometown_location]];
    if (authorDetail.current_location.length)  [location appendString:[NSString stringWithFormat:@"  现居：%@", authorDetail.current_location]];
    self.locate.text = location;
    if (!location.length) {
        self.locate.hidden = YES;
        self.seperator.hidden = YES;
        [self.summary mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
        }];
    }
    
    self.summary.text = authorDetail.desc;
    if (!authorDetail.desc) {
        self.seperator.hidden = YES;
        self.summary.hidden = YES;
    }
    if (!authorDetail.ndishes.length) authorDetail.ndishes = @"0";
    if (!authorDetail.nrecipes.length) authorDetail.nrecipes = @"0";
    self.dishCount.text = [NSString stringWithFormat:@"作品%@", authorDetail.ndishes];
    self.recipeCount.text = [NSString stringWithFormat:@"菜谱%@", authorDetail.nrecipes];
    
}


- (void)showMore {
    self.showMoreButton.selected = !self.showMoreButton.isSelected;
    
}

@end
