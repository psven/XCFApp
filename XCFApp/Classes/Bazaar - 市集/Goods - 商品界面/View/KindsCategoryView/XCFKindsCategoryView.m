//
//  XCFKindsCategoryView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/5/1.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFKindsCategoryView.h"
#import "XCFKindsView.h"

#import "XCFCartItem.h"
#import "XCFGoods.h"

#import <POP.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface XCFKindsCategoryView () <UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XCFKindsView *kindsView;
@end

@implementation XCFKindsCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
        
        // 承载作用的tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
        
        // 商品分类view
        _kindsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFKindsView class])
                                                    owner:nil options:nil] lastObject];
        WeakSelf;
        // 确认回调
        _kindsView.confirmBlock = ^(XCFCartItem *item) {
            // 传递数据给控制器
            !weakSelf.confirmBlock ? : weakSelf.confirmBlock(item);
            [weakSelf dismiss];
        };
        // 取消回调
        _kindsView.dismissBlock = ^{
            [weakSelf dismiss];
        };
        // 动画回调
        _kindsView.animationBlock = ^(UIImage *image, CGRect rect) {
            // 加入购物车才有动画
            if (weakSelf.type == XCFKindsViewTypeOrder) return;
            
            // 添加临时作动画的图片
            UIImageView *animateImage = [[UIImageView alloc] initWithImage:image];
            animateImage.frame = rect;
            [weakSelf addSubview:animateImage];
            
            // 位移
            CABasicAnimation *translateAni = [CABasicAnimation animationWithKeyPath:@"position"];
            translateAni.fromValue = [NSValue valueWithCGPoint:rect.origin];
            translateAni.toValue = [NSValue valueWithCGPoint:CGPointMake(XCFScreenWidth-60, 60)];
            translateAni.removedOnCompletion = YES;
            // 形变
            CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAni.fromValue = [NSNumber numberWithFloat:1.0];
            scaleAni.toValue = [NSNumber numberWithFloat:0.3];
            scaleAni.removedOnCompletion = YES;
            // 旋转
            CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotateAni.fromValue = [NSNumber numberWithFloat:0];
            rotateAni.toValue = [NSNumber numberWithFloat:2*M_PI];
            rotateAni.repeatCount = 3;
            rotateAni.removedOnCompletion = YES;
            // 组合
            CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
            aniGroup.animations = @[translateAni, scaleAni, rotateAni];
            aniGroup.duration = 1;
            [animateImage.layer addAnimation:aniGroup forKey:nil];
            
            // 动画结束后移除
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [animateImage removeFromSuperview];
            });
        };
        
        self.tableView.tableHeaderView = _kindsView;
    }
    return self;
}


#pragma mark - 事件处理

- (void)dismiss {
    // 消失动画
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0, self.item.goods.goodsCategoryViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        !self.cancelBlock ? : self.cancelBlock();
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 向下拖动大于70，松手即消失
    if (scrollView.contentOffset.y < -70) {
        [self dismiss];
    }
}



- (void)setItem:(XCFCartItem *)item {
    _item = item;
    
    self.kindsView.item = item;
    
    XCFGoods *goods = item.goods;
    
    // 根据模型数据设置frame
    self.tableView.frame = CGRectMake(0, XCFScreenHeight, XCFScreenWidth, goods.goodsCategoryViewHeight);
    self.kindsView.frame = CGRectMake(0, 0, XCFScreenWidth, goods.goodsCategoryViewHeight);
    
    // 重力动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.fromValue = [NSValue valueWithCGRect:self.tableView.frame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0,
                                                       XCFScreenHeight-goods.goodsCategoryViewHeight,
                                                       XCFScreenWidth,
                                                       goods.goodsCategoryViewHeight)];
    animation.springBounciness = 5;
    animation.springSpeed = 13;
    [self.tableView pop_addAnimation:animation forKey:nil];
}

- (void)setType:(XCFKindsViewType)type {
    _type = type;
    self.kindsView.type = type;
}

@end
