//
//  XCFKindsView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/5/1.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFKindsView.h"
#import "XCFStepper.h"

#import "XCFCartItem.h"
#import "XCFGoods.h"
#import "XCFGoodsKind.h"
#import "XCFReviewPhoto.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface XCFKindsView ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *priceRangeLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIView *kindsButtonPlaceView;
@property (nonatomic, strong) XCFStepper *stepper;           // 计数器

@property (nonatomic, strong) XCFCartItem *cartItem; // 记录属性，确定购买时通过回调传递给控制器

@end

@implementation XCFKindsView

- (XCFCartItem *)cartItem {
    if (!_cartItem) {
        _cartItem = self.item;
        _cartItem.number = 1;
    }
    return _cartItem;
}

- (void)awakeFromNib {
    // 添加计数器
    _stepper = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFStepper class])
                                              owner:nil options:nil] lastObject];
    _stepper.enabled = NO;
    [self addSubview:_stepper];
    [_stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.confirmButton.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    WeakSelf;
    // 数量变更回调
    _stepper.goodsNumberChangedBlock = ^(NSUInteger number) {
        weakSelf.cartItem.number = number;
    };
    
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.enabled = NO;
}


#pragma mark - 事件处理

- (void)choose:(UIButton *)sender {
    sender.selected = YES;
    sender.backgroundColor = XCFThemeColor;
    
    // 取出选中的商品分类数据
    XCFGoodsKind *kind = self.item.goods.kinds[sender.tag];
    // 显示对应价格
    self.priceRangeLabel.text = [NSString stringWithFormat:@"¥ %.1f0", kind.price];
    // 设置"确定"按钮，计数器属性
    self.confirmButton.alpha = 1;
    self.confirmButton.enabled = YES;
    self.stepper.enabled = YES;
    self.stepper.stock = kind.stock;
    // 保存数据
    self.cartItem.kind_name = kind.name;
    
    // 取消其他商品分类选中状态
    for (UIButton *subButton in self.kindsButtonPlaceView.subviews) {
        if (subButton.tag != sender.tag) {
            subButton.selected = NO;
            subButton.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)close {
    !self.dismissBlock ? : self.dismissBlock();
}

- (void)confirm {
    // 取出图片在窗口的位置
    CGRect wRect = [self.goodsImage convertRect:self.goodsImage.frame toView:nil];
    // 通过执行回调，在父控件执行动画
    !self.animationBlock ? : self.animationBlock(self.goodsImage.image, wRect);
    
    // 如果是购物车，就延时执行添加操作（等待购物车动画完成）
    if (self.type == XCFKindsViewTypeCart) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            !self.confirmBlock ? : self.confirmBlock(self.cartItem);
        });
    }
    // 如果是立即购买，直接回调
    else if (self.type == XCFKindsViewTypeOrder) {
        !self.confirmBlock ? : self.confirmBlock(self.cartItem);
    }
    
}



- (void)setItem:(XCFCartItem *)item {
    _item = item;
    XCFGoods *goods = item.goods;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:goods.main_pic.url]];
    self.goodsName.text = goods.name;
    self.priceRangeLabel.text = [NSString stringWithFormat:@"¥ %.1f0", [goods.display_price floatValue]];
    
    // 添加商品分类按钮
    CGFloat currentX = 15;
    CGFloat currentY = 8;
    for (NSInteger index=0; index<goods.kinds.count; index++) {
        NSString *kindName = goods.kinds[index].name;
        CGFloat textWidth = [kindName getSizeWithTextSize:CGSizeMake(MAXFLOAT, 20) fontSize:13].width;
        CGFloat displayWidth = textWidth + 16;
        
        if ((currentX+displayWidth+15) > XCFScreenWidth) { // 如果当前x+标签宽度大于屏幕高度，就转行
            currentX = 15;
            if (index > 0) currentY += 33;
            if (displayWidth >= XCFScreenWidth) displayWidth = XCFScreenWidth; // 如果单个标签宽度大于屏幕宽度
        }
        
        UIButton *kindButton = [UIButton borderButtonWithBackgroundColor:[UIColor clearColor]
                                                                   title:kindName
                                                          titleLabelFont:[UIFont systemFontOfSize:13]
                                                              titleColor:[UIColor blackColor]
                                                                  target:self
                                                                  action:@selector(choose:)
                                                           clipsToBounds:NO];
        kindButton.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        [kindButton setTitleColor:XCFLabelColorWhite forState:UIControlStateSelected];
        kindButton.tag = index;
        [self.kindsButtonPlaceView addSubview:kindButton];
        [kindButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kindsButtonPlaceView).offset(currentX);
            make.top.equalTo(self.kindsButtonPlaceView).offset(currentY);
            make.size.mas_equalTo(CGSizeMake(displayWidth, 25));
        }];
        
        currentX += displayWidth+8;
    }
    
}

@end
