//
//  XCFTopNavImageView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopNavImageView.h"
#import <Masonry.h>

@interface XCFTopNavImageView ()
/** coverView */
@property (nonatomic, strong) UIImageView *coverView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XCFTopNavImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        _coverView = [[UIImageView alloc] init];
        _coverView.backgroundColor = RGBA(0, 0, 0, 0.2);
        [self addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
        }];
        
    }
    return self;
}

+ (XCFTopNavImageView *)imageViewWithTitle:(NSString *)title
                                    target:(id)target
                                    action:(SEL)action{
    XCFTopNavImageView *imageView = [[XCFTopNavImageView alloc] init];
    imageView.titleLabel.text = title;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    return imageView;
}

@end
