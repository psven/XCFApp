//
//  XCFCreateInstructionFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateInstructionFooter.h"
#import <Masonry.h>

@interface XCFCreateInstructionFooter ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *adjustButton;
@end

@implementation XCFCreateInstructionFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        
        _addButton = [UIButton buttonWithBackgroundColor:XCFDishViewBackgroundColor
                                                   title:@"添加步骤"
                                          titleLabelFont:[UIFont systemFontOfSize:14]
                                              titleColor:RGB(25, 25, 20)
                                                  target:self
                                                  action:@selector(addInstruction)
                                           clipsToBounds:NO];
        [self.contentView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake((XCFScreenWidth-50)*0.5, 40));
        }];
        
        _adjustButton = [UIButton buttonWithBackgroundColor:XCFDishViewBackgroundColor
                                                      title:@"调整步骤"
                                             titleLabelFont:[UIFont systemFontOfSize:14]
                                                 titleColor:RGB(25, 25, 20)
                                                     target:self
                                                     action:@selector(adjustInsturction)
                                              clipsToBounds:NO];
        [_adjustButton setTitle:@"调整完成" forState:UIControlStateSelected];
        [self.contentView addSubview:_adjustButton];
        [_adjustButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.addButton.mas_right).offset(15);
            make.top.equalTo(self.addButton);
            make.size.mas_equalTo(CGSizeMake((XCFScreenWidth-50)*0.5, 40));
        }];
    }
    return self;
}


- (void)setStyle:(tableViewAdjustStyle)style {
    _style = style;
    self.addButton.hidden = style;
    self.adjustButton.selected = style;
    
}

#pragma mark - 事件处理

- (void)addInstruction {
    !self.addInstructionBlock ? : self.addInstructionBlock();
}

- (void)adjustInsturction {
    self.addButton.hidden = !self.adjustButton.isSelected;
    self.adjustButton.selected = !self.adjustButton.isSelected;
    !self.adjustBlock ? : self.adjustBlock(self.adjustButton.isSelected); // 根据按钮状态决定编辑类型
}



@end
