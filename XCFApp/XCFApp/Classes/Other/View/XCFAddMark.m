//
//  XCFAddMark.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddMark.h"
#import <Masonry.h>

@interface XCFAddMark ()
@property (nonatomic, strong) UIImageView *addMark;
@property (nonatomic, strong, nonnull) UILabel *markLabel;
@end

@implementation XCFAddMark

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _addMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addMark"]];
        [self addSubview:_addMark];
        [_addMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textColor = XCFLabelColorGray;
        [self addSubview:_markLabel];
        [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.centerY.equalTo(self);
        }];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}


// 简介
+ (instancetype)summaryMarkWithTarget:(id)target
                               action:(SEL)action {
    XCFAddMark *mark = [[XCFAddMark alloc] init];
    mark.markLabel.text = @"添加简介";
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [mark addGestureRecognizer:tapGes];
    return mark;
}

// 用料
+ (instancetype)ingredientMarkWithTarget:(id)target
                                  action:(SEL)action {
    XCFAddMark *mark = [[XCFAddMark alloc] init];
    mark.markLabel.text = @"添加用料";
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [mark addGestureRecognizer:tapGes];
    return mark;
}

// 小贴士
+ (instancetype)tipsMarkWithTarget:(id)target
                            action:(SEL)action {
    XCFAddMark *mark = [[XCFAddMark alloc] init];
    mark.markLabel.text = @"增加小贴士";
    [mark.addMark mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
//    [mark addGestureRecognizer:tapGes];
    return mark;
}

// 步骤
+ (instancetype)instructionMarkWithTarget:(id)target
                                   action:(SEL)action {
    XCFAddMark *mark = [[XCFAddMark alloc] init];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [mark addGestureRecognizer:tapGes];
    return mark;
}

+ (instancetype)addMarkWithTitle:(NSString *)title
                          Target:(id)target
                          action:(SEL)action {
    XCFAddMark *mark = [[XCFAddMark alloc] init];
    mark.markLabel.text = title;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [mark addGestureRecognizer:tapGes];
    return mark;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.markLabel.text = title;
}

@end
