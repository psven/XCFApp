//
//  XCFGoodsReviewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsReviewController.h"
#import "XCFImageShowController.h"
#import "XCFGoodsViewController.h"
#import "XCFDetailReviewViewController.h"

#import "XCFDishViewCell.h"
#import "XCFDetailReviewCell.h"

#import "XCFGoods.h"
#import "XCFReview.h"
#import "XCFReviewPhoto.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <Masonry.h>

@interface XCFGoodsReviewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *showPhotoButton;
@property (nonatomic, strong) UIButton *showReviewButton;
@property (nonatomic, strong) UITableView *photoReviewView;
@property (nonatomic, strong) UITableView *allReviewView;
@property (nonatomic, strong) AFHTTPSessionManager *mananger;

@property (nonatomic, strong) NSMutableArray *allReviewsArray;
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray;

@end

@implementation XCFGoodsReviewController

static NSString * const dishViewCellIdentifier = @"dishViewCell";
static NSString * const detailReviewCellIdentifier = @"detailReviewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self setNavTitleView];
    [self setupRefresh];
}


- (void)setupRefresh {
    self.photoReviewView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                          refreshingAction:@selector(loadMorePhoto)];
    if (!self.goods.reviews.count) self.photoReviewView.mj_footer.hidden = YES;
    self.allReviewView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(loadMoreReview)];
    if (!self.allReviewsArray.count) self.allReviewView.mj_footer.hidden = YES;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (tableView == self.photoReviewView) {
        if (self.goods.reviews.count) self.photoReviewView.mj_footer.hidden = NO;
        count = self.goods.reviews.count;
    } else if (tableView == self.allReviewView) {
        if (self.allReviewsArray.count) self.allReviewView.mj_footer.hidden = NO;
        count = self.allReviewsArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.photoReviewView) { // 晒图
        XCFDishViewCell *photoCell = [tableView dequeueReusableCellWithIdentifier:dishViewCellIdentifier];
        if (self.goods.reviews.count) {
            XCFReview *review = self.goods.reviews[indexPath.row];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            [imageArray addObjectsFromArray:review.photos];
            if (review.additional_review_photos.count) {
                NSArray *photosArray = [XCFReviewPhoto mj_objectArrayWithKeyValuesArray:review.additional_review_photos];
                [imageArray addObjectsFromArray:photosArray];
            }
            photoCell.type = XCFShowViewTypeReview;
            photoCell.review = review;
            photoCell.imageArray = imageArray;
            photoCell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
            
            WeakSelf;
            // 防止cell的复用机制导致图片轮播器的位置错乱
            photoCell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
                weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
            };
            photoCell.actionBlock = ^(DishViewAction action) {
                if (action == DishViewActionName) {
                    [weakSelf.navigationController pushViewController:[[XCFGoodsViewController alloc] init] animated:YES];
                }
            };
        }
        cell = photoCell;
    }
    
    else if (tableView == self.allReviewView) { // 全部
        XCFDetailReviewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:detailReviewCellIdentifier];
        XCFReview *review = self.allReviewsArray[indexPath.row];
        if (self.allReviewsArray.count) reviewCell.review = review;
        WeakSelf;
        reviewCell.showImageBlock = ^(NSUInteger imageIndex, CGRect imageRect) {
            NSValue *rectValue = [NSValue valueWithCGRect:imageRect];
            XCFImageShowController *imageShowVC = [[XCFImageShowController alloc] init];
            imageShowVC.imageIndex = imageIndex;
            imageShowVC.rectValue = rectValue;
            imageShowVC.imageArray = review.photos;
            [weakSelf.navigationController presentViewController:imageShowVC animated:NO completion:nil];
            
        };
        cell = reviewCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.allReviewView) {
        XCFDetailReviewViewController *detailReviewVC = [[XCFDetailReviewViewController alloc] initWithStyle:UITableViewStyleGrouped];
        detailReviewVC.review = self.allReviewsArray[indexPath.row];
        [self.navigationController pushViewController:detailReviewVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (tableView == self.photoReviewView) {
        if (self.goods.reviews.count) {
            XCFReview *review = self.goods.reviews[indexPath.row];
            height = review.buyCellHeight;
        }
    } else if (tableView == self.allReviewView) {
        if (self.allReviewsArray.count) {
            XCFReview *review =self.allReviewsArray[indexPath.row];
            height = review.reviewCellHeight;
        }
    }
    return height;
}


#pragma mark - 事件处理

- (void)showPhoto {
    self.showPhotoButton.selected = YES;
    self.photoReviewView.hidden = NO;
    self.showReviewButton.selected = NO;
    self.allReviewView.hidden = YES;
}

- (void)showReview {
    if (!self.allReviewsArray.count) [self loadAllReview];
    self.showPhotoButton.selected = NO;
    self.photoReviewView.hidden = YES;
    self.showReviewButton.selected = YES;
    self.allReviewView.hidden = NO;
}


#pragma mark - 属性

- (void)setNavTitleView {
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _showPhotoButton = [[UIButton alloc] init];
    _showPhotoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _showPhotoButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_showPhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_showPhotoButton setTitleColor:XCFThemeColor forState:UIControlStateSelected];
    [_showPhotoButton setTitle:@"晒图" forState:UIControlStateNormal];
    _showPhotoButton.selected = YES;
    [navView addSubview:_showPhotoButton];
    [_showPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(navView);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    [_showPhotoButton addTarget:self action:@selector(showPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    _showReviewButton = [[UIButton alloc] init];
    _showReviewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _showReviewButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_showReviewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_showReviewButton setTitleColor:XCFThemeColor forState:UIControlStateSelected];
    [_showReviewButton setTitle:@"全部" forState:UIControlStateNormal];
    [navView addSubview:_showReviewButton];
    [_showReviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(navView);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    [_showReviewButton addTarget:self action:@selector(showReview) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = navView;
}

- (UITableView *)photoReviewView {
    if (!_photoReviewView) {
        _photoReviewView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, XCFScreenHeight)];
        [self.view addSubview:_photoReviewView];
        _photoReviewView.dataSource = self;
        _photoReviewView.delegate = self;
        _photoReviewView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _photoReviewView.backgroundColor = [UIColor clearColor];
        [_photoReviewView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDishViewCell class]) bundle:nil] forCellReuseIdentifier:dishViewCellIdentifier];
    }
    return _photoReviewView;
}

- (UITableView *)allReviewView {
    if (!_allReviewView) {
        _allReviewView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, XCFScreenHeight)];
        [self.view addSubview:_allReviewView];
        _allReviewView.dataSource = self;
        _allReviewView.delegate = self;
        _photoReviewView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _allReviewView.backgroundColor = XCFGlobalBackgroundColor;
        [_allReviewView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDetailReviewCell class]) bundle:nil] forCellReuseIdentifier:detailReviewCellIdentifier];
        _allReviewView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _allReviewView.hidden = YES;
    }
    return _allReviewView;
}

- (NSMutableArray *)allReviewsArray {
    if (!_allReviewsArray) {
        _allReviewsArray = [NSMutableArray array];
    }
    return _allReviewsArray;
}

- (NSMutableArray *)imageViewCurrentLocationArray {
    if (!_imageViewCurrentLocationArray) {
        _imageViewCurrentLocationArray = [NSMutableArray array];
    }
    return _imageViewCurrentLocationArray;
}

- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}

- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    
    // 如果位置数组数量 > 模型数据，删除多余的数据
    if (self.imageViewCurrentLocationArray.count > goods.reviews.count) {
        NSUInteger length = self.imageViewCurrentLocationArray.count - goods.reviews.count;
        NSRange shouldRemoveRange = NSMakeRange(goods.reviews.count, length);
        [self.imageViewCurrentLocationArray removeObjectsInRange:shouldRemoveRange];
        
    } else if (self.imageViewCurrentLocationArray.count == 0){
        for (NSInteger index=0; index<goods.reviews.count; index++) {
            [self.imageViewCurrentLocationArray addObject:@(0)];
        }
    }
}


#pragma mark - 网络请求

- (void)loadMorePhoto {
    [self.mananger GET:XCFRequestKitchenBuy
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSArray *newContent = [XCFReview mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"reviews"]];
                   NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.goods.reviews];
                   [mArray addObjectsFromArray:newContent];
                   self.goods.reviews = mArray;
                   for (NSInteger index=0; index<newContent.count; index++) {
                       [self.imageViewCurrentLocationArray addObject:@(0)];
                   }
                   [self.photoReviewView reloadData];
                   [self.photoReviewView.mj_footer endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"loadMoreData --- failure");
                   [self.photoReviewView.mj_footer endRefreshing];
               }];
}

- (void)loadAllReview {
    [self.mananger GET:XCFRequestGoodsReview
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.allReviewsArray = [XCFReview mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"reviews"]];
                   [self.allReviewView reloadData];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"loadMoreData --- failure");
               }];
}

- (void)loadMoreReview {
    [self.mananger GET:XCFRequestGoodsReview
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSArray *newContent = [XCFReview mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"reviews"]];
                   [self.allReviewsArray addObjectsFromArray:newContent];
                   [self.allReviewView reloadData];
                   [self.allReviewView.mj_footer endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"loadMoreData --- failure");
                   [self.allReviewView.mj_footer endRefreshing];
               }];
}

@end
