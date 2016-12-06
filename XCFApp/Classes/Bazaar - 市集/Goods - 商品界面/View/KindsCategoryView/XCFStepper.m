//
//  XCFStepper.m
//  XCFApp
//
//  Created by 彭世朋 on 16/5/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFStepper.h"

@interface XCFStepper ()
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (weak, nonatomic) IBOutlet UILabel *stepValue;
@property (nonatomic, assign) NSUInteger number; // 购买数量
@end

@implementation XCFStepper

- (void)awakeFromNib {
    self.number = 1;
    [self.decreaseButton addTarget:self action:@selector(decrease:) forControlEvents:UIControlEventTouchUpInside];
    [self.increaseButton addTarget:self action:@selector(increase:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件处理

- (void)decrease:(UIButton *)sender {
    self.number--;
}

- (void)increase:(UIButton *)sender {
    self.number++;
}


- (void)setNumber:(NSUInteger)number {
    _number = number;
    if (number < 1) {
        number = 1;
        self.decreaseButton.enabled = NO;
    } else if (number > 1) {
        self.decreaseButton.enabled = YES;
    } else if (number == self.stock) {
        // 达到最大库存
        number = self.stock;
    }
    self.stepValue.text = [NSString stringWithFormat:@"%zd", number];
    !self.goodsNumberChangedBlock ? : self.goodsNumberChangedBlock(self.number);
}

- (void)setEnabled:(BOOL)enabled {
    self.increaseButton.enabled = enabled;
}

@end
