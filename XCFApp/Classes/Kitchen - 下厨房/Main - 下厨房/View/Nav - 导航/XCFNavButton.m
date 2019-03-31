//
//  XCFNavButton.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFNavButton.h"
#import "XCFNav.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFNavButton ()

/** 图片 */
@property (nonatomic, strong) UIImageView *image;
/** 标题 */
@property (nonatomic, strong) UILabel *title;
/** url */
@property (nonatomic, copy) NSString *url;

@end

@implementation XCFNavButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderColor = XCFGlobalBackgroundColor.CGColor;
        self.layer.borderWidth = 0.5;
        
        _image = [[UIImageView alloc] init];
        [self addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-15);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:12];
        [self addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(15);
        }];
        
    }
    return self;
}

+ (XCFNavButton *)buttonWithNav:(XCFNav *)nav
                         target:(id)target
                         action:(SEL)action {
    XCFNavButton *button = [[XCFNavButton alloc] init];
    [button.image sd_setImageWithURL:[NSURL URLWithString:nav.picurl]];
    button.title.text = nav.name;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return button;
}

+ (XCFNavButton *)buttonWithImageName:(NSString *)name
                                title:(nonnull NSString *)title
                               target:(id)target
                               action:(SEL)action {
    XCFNavButton *button = [[XCFNavButton alloc] init];
    button.image.contentMode = UIViewContentModeScaleAspectFill;
    [button.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    button.image.image = [UIImage imageNamed:name];
    button.title.text = title;
    [button.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button.image.mas_bottom).offset(5);
    }];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return button;
}

@end
