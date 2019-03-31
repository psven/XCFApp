//
//  XCFKitchenBuyViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFKitchenBuyViewController.h"
#import "XCFGoodsViewController.h"
#import "XCFDishViewCell.h"

#import "XCFReview.h"
#import "XCFReviewPhoto.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#import "XCFCartViewController.h"

@interface XCFKitchenBuyViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) NSMutableArray *reviewsArray;
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray; // 存储cell内图片轮播器滚动位置
@end

@implementation XCFKitchenBuyViewController

static NSString *const dishViewCellIdentifier = @"dishViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shoppingCartIconWithTarget:self
                                                                                  action:@selector(goToShoppingCart)];
    
}

- (void)dealloc {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToShoppingCart) name:@"abc" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 购物车
- (void)goToShoppingCart {
    [self.navigationController pushViewController:[[XCFCartViewController alloc] init] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.reviewsArray.count) self.tableView.mj_footer.hidden = NO;
    return self.reviewsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFDishViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dishViewCellIdentifier
                                                            forIndexPath:indexPath];
    if (self.reviewsArray.count) {
        XCFReview *review = self.reviewsArray[indexPath.row];
        
        // 添加主图、附加图到要显示的图片数组
        NSMutableArray *imageArray = [NSMutableArray array];
        [imageArray addObjectsFromArray:review.photos];
        if (review.additional_review_photos.count) {
            NSArray *photosArray = [XCFReviewPhoto mj_objectArrayWithKeyValuesArray:review.additional_review_photos];
            [imageArray addObjectsFromArray:photosArray];
        }
        
        cell.type = XCFShowViewTypeReview;
        cell.review = review;
        cell.imageArray = imageArray;
        cell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
        
        WeakSelf;
        // 防止cell的复用机制导致图片轮播器的位置错乱
        cell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
            weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
        };
        
        cell.actionBlock = ^(DishViewAction action) {
            if (action == DishViewActionName) { // 点击了标题view
                [weakSelf.navigationController pushViewController:[[XCFGoodsViewController alloc] init]
                                                         animated:YES];
            }
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[[XCFGoodsViewController alloc] init]
                                             animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.reviewsArray.count) {
        XCFReview *review = self.reviewsArray[indexPath.row];
        return review.buyCellHeight;
    }
    return 0;
}


#pragma mark - 网络请求

- (void)loadNewData {
    [SVProgressHUD show];
    [self.mananger GET:XCFRequestKitchenBuy
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.reviewsArray = [XCFReview mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"reviews"]];

                   // 如果位置数组数量 > 模型数据，删除多余的数据
                   if (self.imageViewCurrentLocationArray.count > self.reviewsArray.count) {
                       // 多余的数量
                       NSUInteger length = self.imageViewCurrentLocationArray.count - self.reviewsArray.count;
                       NSRange shouldRemoveRange = NSMakeRange(self.reviewsArray.count, length);
                       [self.imageViewCurrentLocationArray removeObjectsInRange:shouldRemoveRange];
                       
                   } else if (self.imageViewCurrentLocationArray.count == 0){
                       for (NSInteger index=0; index<self.reviewsArray.count; index++) {
                           [self.imageViewCurrentLocationArray addObject:@(0)];
                       }
                   }
                   [self.tableView reloadData];
                   
                   [SVProgressHUD dismiss];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   [SVProgressHUD dismiss];
               }];
}

- (void)loadMoreData {
    [self.mananger GET:XCFRequestKitchenBuy
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSArray *newContent = [XCFReview mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"reviews"]];
                   [self.reviewsArray addObjectsFromArray:newContent];
                   
                   for (NSInteger index=0; index<newContent.count; index++) {
                       [self.imageViewCurrentLocationArray addObject:@(0)];
                   }
                   
                   [self.tableView reloadData];
                   [self.tableView.mj_footer endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   [self.tableView.mj_footer endRefreshing];
               }];
}


#pragma mark - 属性

- (void)setupTableView {
    self.title = @"社区";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDishViewCell class]) bundle:nil]
         forCellReuseIdentifier:dishViewCellIdentifier];
}

- (void)setupRefresh {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    if (!self.reviewsArray.count) self.tableView.mj_footer.hidden = YES;
}

- (NSMutableArray *)reviewsArray {
    if (!_reviewsArray) {
        _reviewsArray = [NSMutableArray array];
    }
    return _reviewsArray;
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


@end
