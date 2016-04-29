//
//  XCFBottomView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/10.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFBottomView.h"
#import <Masonry.h>

@interface XCFBottomView ()
/** 左边按钮 */
@property (nonatomic, strong) UIButton *leftButton;
/** 右边按钮 */
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation XCFBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _leftButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                    title:@"收藏"
                                           titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                               titleColor:XCFLabelColorWhite
                                                   target:self
                                                   action:@selector(leftButtonClicked:)
                                            clipsToBounds:NO];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake((XCFScreenWidth-1)*0.5, 44));
        }];
        
        _rightButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                     title:@"丢进菜篮子"
                                            titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                titleColor:XCFLabelColorWhite
                                                    target:self
                                                    action:@selector(rightButtonClicked:)
                                             clipsToBounds:NO];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self);
            make.size.equalTo(self.leftButton);
        }];
        
    }
    return self;
}

- (void)leftButtonClicked:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(BottomViewClickedCollect);
}

- (void)rightButtonClicked:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(BottomViewClickedAddToList);
}

@end
