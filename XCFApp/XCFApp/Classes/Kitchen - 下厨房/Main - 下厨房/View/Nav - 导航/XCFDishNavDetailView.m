//
//  XCFDishNavDetailView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDishNavDetailView.h"
#import "XCFPopEvent.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFDishNavDetailView ()
/** 背景图 */
@property (nonatomic, strong) UIImageView *backImageView;
/** 右侧小图 */
@property (nonatomic, strong) UIImageView *rightImageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 作品数label */
@property (nonatomic, strong) UILabel *dishCountLabel;

@end

@implementation XCFDishNavDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _backImageView = [[UIImageView alloc] init];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        _rightImageView = [[UIImageView alloc] init];
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(15);
            make.bottom.equalTo(self).offset(-15);
            make.width.equalTo(@(60));
        }];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-5);
        }];
        
        
        _dishCountLabel = [[UILabel alloc] init];
        _dishCountLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc];
        _dishCountLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_dishCountLabel];
        [_dishCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(5);
        }];
    }
    return self;
}

- (void)setPopEvent:(XCFPopEvent *)popEvent {
    _popEvent = popEvent;
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:popEvent.thumbnail_280]];
    
    NSString *name = [popEvent.name substringToIndex:2];
    self.titleLabel.text = [NSString stringWithFormat:@"— %@ —", name];
    self.dishCountLabel.text = [NSString stringWithFormat:@"%@作品", popEvent.n_dishes];
    
    if ([name isEqualToString:@"早餐"]) {
        self.backImageView.image = [UIImage imageNamed:@"themeSmallPicForBreakfast"];
    } else if ([name isEqualToString:@"午餐"]) {
        self.backImageView.image = [UIImage imageNamed:@"themeSmallPicForLaunch"];
    } else if ([name isEqualToString:@"晚餐"]) {
        self.backImageView.image = [UIImage imageNamed:@"themeSmallPicForSupper"];
    }
}

+ (XCFDishNavDetailView *)viewWithPopEvent:(XCFPopEvent *)popEvent
                                    target:(id)target
                                    action:(SEL)action {
    XCFDishNavDetailView *navView = [[XCFDishNavDetailView alloc] init];
    navView.popEvent = popEvent;
    [navView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    return navView;
}

@end
