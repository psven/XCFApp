//
//  XCFIngredientListTopView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientListTopView.h"

@interface XCFIngredientListTopView ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@end

@implementation XCFIngredientListTopView

- (void)awakeFromNib {
    [self.stateButton addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeView {
    !self.changeViewBlock ? : self.changeViewBlock();
}

- (void)setStyle:(XCFBuyListStyle)style {
    _style = style;
    self.stateButton.selected = style;
}

- (void)setCount:(NSUInteger)count {
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"已添加%zd个", count];
}

@end
