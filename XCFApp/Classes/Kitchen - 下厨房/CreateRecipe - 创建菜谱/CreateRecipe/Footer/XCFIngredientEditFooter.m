//
//  XCFIngredientEditFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientEditFooter.h"
#import "XCFAddMark.h"
#import <Masonry.h>

@interface XCFIngredientEditFooter ()

@property (nonatomic, strong) XCFAddMark *addLineMark;
@property (nonatomic, strong) UIButton *adjustButton;

@end

@implementation XCFIngredientEditFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = XCFGlobalBackgroundColor;
        
        UIImageView *seperator = [[UIImageView alloc] init];
        seperator.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self addSubview:seperator];
        [seperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@(1));
        }];
        
        _addLineMark = [XCFAddMark ingredientMarkWithTarget:self action:@selector(addLine)];
        _addLineMark.title = @"增加一行";
        _addLineMark.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addLineMark];
        [_addLineMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(seperator.mas_bottom);
            make.left.right.equalTo(self);
            make.height.equalTo(@(40));
        }];
        
        _adjustButton = [UIButton buttonWithBackgroundColor:XCFDishViewBackgroundColor
                                                      title:@"调整"
                                             titleLabelFont:[UIFont systemFontOfSize:13]
                                                 titleColor:RGB(25, 25, 25)
                                                     target:self action:@selector(adjust) clipsToBounds:NO];
        [_adjustButton setTitle:@"调整完成" forState:UIControlStateSelected];
        [self addSubview:_adjustButton];
        [_adjustButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(100);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@(30));
        }];
    }
    return self;
}


#pragma mark - 事件处理

- (void)addLine {
    !self.addLineBlock ? : self.addLineBlock();
}

- (void)adjust {
    self.addLineMark.hidden = !self.adjustButton.isSelected;
    self.adjustButton.selected = !self.adjustButton.isSelected;
    !self.adjustBlock ? : self.adjustBlock(self.adjustButton.isSelected);
}

@end
