//
//  XCFFeedsViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFFeedsViewController.h"

#import "XCFDishViewCell.h"

#import "XCFFeeds.h"
#import "XCFDish.h"
#import "XCFPicture.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface XCFFeedsViewController () <UIActionSheetDelegate>
@property (nonatomic, strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) NSMutableArray *feedsArray;
@property (nonatomic, strong) NSMutableArray *imageViewCurrentLocationArray; // 存储cell内图片轮播器滚动位置
@end

@implementation XCFFeedsViewController

static NSString * const dishViewCellIdentifier = @"dishViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self setupRefresh];
    [self loadNewData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.feedsArray.count) self.tableView.mj_footer.hidden = NO;
    return self.feedsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFDishViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dishViewCellIdentifier forIndexPath:indexPath];
    if (self.feedsArray.count) {
        XCFFeeds *feeds = self.feedsArray[indexPath.row];
        
        // 添加主图、附加图到要显示的图片数组
        NSMutableArray *imageArray = [NSMutableArray array];
        if (feeds.dish) [imageArray addObject:feeds.dish.main_pic];
        if (feeds.dish.extra_pics.count) {
            NSArray *extraPicArray = [XCFPicture mj_objectArrayWithKeyValuesArray:feeds.dish.extra_pics];
            [imageArray addObjectsFromArray:extraPicArray];
        }
        cell.type = XCFShowViewTypeDish;
        cell.dish = feeds.dish;
        cell.imageArray = imageArray;
        
        // 赋值每个cell对应的图片滚动位置
        cell.imageViewCurrentLocation = [self.imageViewCurrentLocationArray[indexPath.row] floatValue];
        
        WeakSelf;
        
        // 大图拖拽回调：防止cell的复用机制导致图片轮播器的位置错乱
        cell.imageViewDidScrolledBlock = ^(CGFloat finalContentOffsetX) {
            // 拿到最后的位置保存到数组中
            weakSelf.imageViewCurrentLocationArray[indexPath.row] = @(finalContentOffsetX);
        };
        
        // 控件点击回调
        cell.actionBlock = ^(DishViewAction action) {
            // 标题
            if (action == DishViewActionName) {
                XCFLog(@"%zd", indexPath.row);
            }
            // 点赞
            else if (action == DishViewActionDigg) {
            
            }
            // 评论
            else if (action == DishViewActionCommment) {
                
            }
            // 更多
            else if (action == DishViewActionMore) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"取消"
                                                           destructiveButtonTitle:@"举报作品"
                                                                otherButtonTitles:@"分享作品", nil];
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:weakSelf.view];
            }
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.feedsArray.count) {
        XCFFeeds *feeds = self.feedsArray[indexPath.row];
        return feeds.dish.dishCellHeight + feeds.dish.commentViewHeight;
    }
    return 0;
}


#pragma mark - 网络请求

- (void)loadNewData {
    [self.tableView.mj_footer endRefreshing];
    [self.mananger GET:XCFRequestKitchenFeeds
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.feedsArray = [XCFFeeds mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"feeds"]];
                   // 图片数组进行处理
                   // 如果位置数组数量 > 模型数据，删除多余的数据
                   if (self.imageViewCurrentLocationArray.count > self.feedsArray.count) {
                       NSUInteger length = self.imageViewCurrentLocationArray.count - self.feedsArray.count;
                       NSRange shouldRemoveRange = NSMakeRange(self.feedsArray.count, length);
                       [self.imageViewCurrentLocationArray removeObjectsInRange:shouldRemoveRange];
                   }
                   // 如果数组为空，添加与模型数据数量相等的 位移数据
                   else if (self.imageViewCurrentLocationArray.count == 0){
                       for (NSInteger index=0; index<self.feedsArray.count; index++) {
                           [self.imageViewCurrentLocationArray addObject:@(0)];
                       }
                   }
                   [self.tableView reloadData];
                   [self.tableView.mj_header endRefreshing];
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   [self.tableView.mj_header endRefreshing];
               }];
}

- (void)loadMoreData {
    [self.tableView.mj_header endRefreshing];
    [self.mananger GET:XCFRequestKitchenFeeds
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSArray *newContent = [XCFFeeds mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"feeds"]];
                   [self.feedsArray addObjectsFromArray:newContent];
                   // 添加了数据，也添加对应个数的图片位置到数组中
                   for (NSInteger index=0; index<newContent.count; index++) {
                       [self.imageViewCurrentLocationArray addObject:@(0)];
                   }
                   
                   [self.tableView reloadData];
                   [self.tableView.mj_footer endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   [self.tableView.mj_footer endRefreshing];
               }];
}


#pragma mark - 事件处理
- (void)uploadMyDish {
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:[[XCFUploadDishViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    [self.navigationController presentViewController:navCon animated:YES completion:nil];
}

- (void)messageSetting {
    
}


#pragma mark - 属性

- (void)setupNavigationBar {
    UIBarButtonItem *uploadDish = [UIBarButtonItem barButtonRightItemWithImageName:@"creatdishicon"
                                                                            target:self
                                                                            action:@selector(uploadMyDish)];
    UIBarButtonItem *messageSetting = [UIBarButtonItem barButtonRightItemWithImageName:@"notification"
                                                                                target:self
                                                                                action:@selector(messageSetting)];
    
    [self.navigationItem setRightBarButtonItems:@[messageSetting, uploadDish]];
    
}

- (void)setupTableView {
    self.title = @"关注动态";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDishViewCell class]) bundle:nil]
         forCellReuseIdentifier:dishViewCellIdentifier];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    
    
    if (!self.feedsArray.count) self.tableView.mj_footer.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)feedsArray {
    if (!_feedsArray) {
        _feedsArray = [NSMutableArray array];
    }
    return _feedsArray;
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
