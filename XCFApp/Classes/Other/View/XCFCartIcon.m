//
//  XCFCartIcon.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartIcon.h"
#import "XCFCartItemTool.h"

@interface XCFCartIcon ()
@property (weak, nonatomic) IBOutlet UIButton *countButton;

@end

@implementation XCFCartIcon

- (void)awakeFromNib {
    // 监听“添加商品到购物车”的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cartDidAddedGoods:)
                                                 name:XCFCartDidAddedGoodsNotification
                                               object:nil];
    NSUInteger count = [XCFCartItemTool totalNumber];
    if (count) { // 有商品才显示数量标签
        self.countButton.hidden = NO;
        [self.countButton setTitle:[NSString stringWithFormat:@"%zd", count]
                          forState:UIControlStateNormal];
    }
}

- (void)cartDidAddedGoods:(NSNotification *)note {
    self.countButton.hidden = NO;
    NSDictionary *dict = note.userInfo;
    // 取得商品数量
    NSUInteger count = [dict[@"goodsCount"] integerValue];
    // 延时作动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            // 购物车图标执行放大动画
            self.countButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            // 改变显示的商品数
            [self.countButton setTitle:[NSString stringWithFormat:@"%zd", count]
                              forState:UIControlStateNormal];
            // 还原图标大小
            [UIView animateWithDuration:0.5 animations:^{
                self.countButton.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
