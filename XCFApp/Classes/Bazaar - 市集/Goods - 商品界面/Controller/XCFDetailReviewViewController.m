//
//  XCFDetailReviewViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDetailReviewViewController.h"
#import "XCFImageShowController.h"
#import "XCFDetailReviewCell.h"
#import "XCFReview.h"

@interface XCFDetailReviewViewController ()

@end

@implementation XCFDetailReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"shareIcon"
//                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
//                                                                                  target:self
//                                                                                  action:@selector(share)];
    [self setupHeader];
}

- (void)setupHeader {
    
    XCFDetailReviewCell *detailReview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFDetailReviewCell class])
                                                                       owner:self options:nil] lastObject];
    detailReview.frame = CGRectMake(0, 0, XCFScreenWidth, self.review.reviewCellHeight);
    detailReview.review = self.review;
    WeakSelf;
    // 展示图片
    detailReview.showImageBlock = ^(NSUInteger imageIndex, CGRect imageRect) {
        NSValue *rectValue = [NSValue valueWithCGRect:imageRect];
        XCFImageShowController *imageShowVC = [[XCFImageShowController alloc] init];
        imageShowVC.imageIndex = imageIndex;
        imageShowVC.rectValue = rectValue;
        imageShowVC.imageArray = self.review.photos;
        [weakSelf.navigationController presentViewController:imageShowVC animated:NO completion:nil];
        
    };
    self.tableView.tableHeaderView = detailReview;
}

#pragma mark - 事件处理
- (void)share {

}

@end
