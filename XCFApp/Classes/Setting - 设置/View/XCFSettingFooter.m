//
//  XCFSettingFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSettingFooter.h"
#import <Masonry.h>

@interface XCFSettingFooter ()
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIButton *signUpButton;
@end

@implementation XCFSettingFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = XCFGlobalBackgroundColor;
        
        
        _signUpButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                      title:@"退出账号"
                                             titleLabelFont:[UIFont systemFontOfSize:14]
                                                 titleColor:XCFLabelColorWhite
                                                     target:self action:@selector(signUp) clipsToBounds:YES];
//        [self addSubview:_signUpButton];
//        [_signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).offset(20);
//            make.left.equalTo(self).offset(10);
//            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth-20, 35));
//        }];
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = [UIFont systemFontOfSize:14];
        _versionLabel.numberOfLines = 0;
        _versionLabel.textColor = XCFThemeColor;
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.text = @"美食牌坊\nv1.0";
        [self addSubview:_versionLabel];
        [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
//            make.top.equalTo(self.signUpButton.mas_bottom).offset(10);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (void)signUp {

}

@end
