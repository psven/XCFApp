//
//  XCFImageShowController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/28.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFImageShowController.h"
#import "XCFImageShowView.h"
#import "XCFReviewPhoto.h"
#import <UIImageView+WebCache.h>

@interface XCFImageShowController ()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) XCFImageShowView *showView;
@end

@implementation XCFImageShowController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 关闭按钮
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    [dismissButton setImage:[UIImage imageNamed:@"closeLandscape"] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.alpha = 0;
    [self.view addSubview:dismissButton];
    self.closeButton = dismissButton;
    
    // 图片轮播器
    CGRect displayRect = CGRectMake(0, XCFScreenHeight*0.5-175, XCFScreenWidth, 350);
    XCFImageShowView *showView = [[XCFImageShowView alloc] initWithFrame:displayRect];
    // 设置属性
    showView.type = XCFShowViewTypeDetail;
    showView.imageArray = self.imageArray;
    showView.currentIndex = self.imageIndex;
    showView.imageViewDidScrolledBlock = self.imageViewDidScrolledBlock;
    // 默认先隐藏
    showView.hidden = YES;
    [self.view addSubview:showView];
    self.showView = showView;
    
    // 临时添加一个imageView 作动画
    CGRect rect = [self.rectValue CGRectValue];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    XCFReviewPhoto *photo = self.imageArray[self.imageIndex];
    [imageView sd_setImageWithURL:[NSURL URLWithString:photo.url]];
    [self.view addSubview:imageView];
    
    // 动画
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = displayRect;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        showView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.closeButton.alpha = 1;
        }];
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
