//
//  XCFKitchenViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFKitchenViewController.h"
// 功能界面
#import "XCFSearchViewController.h"         // 搜索
#import "XCFIngredientListViewController.h" // 菜篮子
#import "XCFRecipeCreateController.h"       // 创建菜谱
// topNav
#import "XCFFeedsViewController.h"          // 关注动态
//#import "XCFVideoViewController.h"        // 看视频
#import "XCFKitchenBuyViewController.h"     // 买买买
#import "XCFMealViewController.h"           // 三餐
// 跳转界面
#import "XCFRecipeListViewController.h"     // 菜单
#import "XCFRecipeViewController.h"         // 菜谱
#import "XCFDishViewController.h"           // 作品

#import "XCFRecipeCell.h"
#import "XCFKitchenHeader.h"
// Model
#import "XCFNavContent.h"
#import "XCFFeeds.h"
#import "XCFDish.h"
#import "XCFContent.h"
#import "XCFIssues.h"
#import "XCFItems.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <Masonry.h>


@interface XCFKitchenViewController () <UISearchBarDelegate>
@property (nonatomic, strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) XCFKitchenHeader *kitchenHeader;  // 顶部导航View
@property (nonatomic, strong) XCFNavContent *navContent;        // 导航数据
@property (nonatomic, strong) NSMutableArray *feedsArray;       // 动态数据
@property (nonatomic, strong) NSMutableArray *issuesArray;      // 菜谱数据
@property (nonatomic, assign) NSInteger sectionCount;           // 组数
@end


@implementation XCFKitchenViewController

static CGFloat const headerHeight = 50;
static NSString *const recipeCellIdentifier = @"RecipeCell";
static NSString *const recipeHeaderIdentifier = @"RecipeHeader";


#pragma mark - Config

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美食牌坊";
//    [self setupNavigationBar];
    [self setupTableView];
    [self setupTableViewHeaderView];
    [self setupRefresh];
    [self loadNewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.issuesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 错误写法啊啊啊啊！
    [self loadNavData]; // 下拉刷新同时刷新顶部导航数据
    self.tableView.mj_footer.hidden = YES;
    return 0;
    return [self.issuesArray[section] items_count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeCellIdentifier
                                                          forIndexPath:indexPath];
    XCFIssues *issues = self.issuesArray[indexPath.section];
    XCFItems *item = issues.items[indexPath.row];
    cell.item = item;
    
    WeakSelf;
    cell.authorIconClickedBlock = ^{ // 头像点击回调
        UIViewController *authorViewController = [[UIViewController alloc] init];
        authorViewController.view.backgroundColor = XCFGlobalBackgroundColor;
        [weakSelf.navigationController pushViewController:authorViewController animated:YES];
    };
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFIssues *issues = self.issuesArray[indexPath.section];
    XCFItems *item = issues.items[indexPath.row];
    
    if (item.template == XCFCellTemplateTopic || item.template == XCFCellTemplateWeeklyMagazine) { // 帖子、周刊
        [self pushWebViewWithURL:item.url];
    }
    else if (item.template == XCFCellTemplateRecipeList) { // 菜单
        [self.navigationController pushViewController:[[XCFRecipeListViewController alloc] init]
                                             animated:YES];
    }
    else if (item.template == XCFCellTemplateDish) { // 作品
        [self.navigationController pushViewController:[[XCFDishViewController alloc] init]
                                             animated:YES];
    }
    else if (item.template == XCFCellTemplateRecipe) { // 菜谱
        [self.navigationController pushViewController:[[XCFRecipeViewController alloc] init]
                                             animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFIssues *issues = self.issuesArray[indexPath.section];
    XCFItems *item = issues.items[indexPath.row];
    return item.cellHeight + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

/**
 *  sectionHeader
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeHeaderIdentifier];
    headerView.frame = CGRectMake(0, 0, XCFScreenWidth, headerHeight);
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    NSInteger tag = 10;
    UILabel *label = [headerView.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeSecondTitle];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = headerView.contentView.bounds;
        [headerView.contentView addSubview:label];
    }
    XCFIssues *issues = self.issuesArray[section];
    label.text = issues.title;
    
    return headerView;
}


#pragma mark - 点击事件处理
// 创建菜谱
- (void)createRecipe {
    [self.navigationController pushViewController:[[XCFRecipeCreateController alloc] init] animated:YES];
}
// 菜篮子（购买清单）
- (void)buylist {
    [self.navigationController pushViewController:[[XCFIngredientListViewController alloc] init] animated:YES];
}


#pragma mark - 属性

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    XCFSearchViewController *searchCon = [[XCFSearchViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:searchCon animated:YES];
    return NO;
}


- (UISearchBar *)searchBarWithPlaceholder:(NSString *)placeholder {
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = placeholder;
    searchBar.tintColor = XCFSearchBarTintColor;
    [searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    UIView *searchBarSub = searchBar.subviews[0];
    for (UIView *subView in searchBarSub.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            [subView setBackgroundColor:RGB(247, 247, 240)];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
    }
    return searchBar;
}

- (void)setupNavigationBar {
    UISearchBar *searchBar = [self searchBarWithPlaceholder:@"菜谱、食材"];
    self.navigationItem.titleView = searchBar;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"homepageCreateRecipeButton"
                                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                 target:self
                                                                                 action:@selector(createRecipe)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"buylistButtonImage"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
                                                                                  target:self
                                                                                  action:@selector(buylist)];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerClass:[XCFRecipeCell class]
           forCellReuseIdentifier:recipeCellIdentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:recipeHeaderIdentifier]; // sectionHeader
}

- (void)setupTableViewHeaderView {
    // 顶部导航视图（流行菜谱、关注动态）高度 + 导航按钮高度 + 三餐导航按钮高度
    CGFloat reciperHeaderHeight = XCFKitchenViewHeightTopNav + XCFKitchenViewHeightNavButton + XCFKitchenViewHeightNavButton1 + XCFKitchenViewHeightCreateButton;
    self.kitchenHeader = [[XCFKitchenHeader alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, reciperHeaderHeight)];
    self.kitchenHeader.navContent = self.navContent;
    self.tableView.tableHeaderView = self.kitchenHeader;
    
    WeakSelf;
    self.kitchenHeader.clickBlock = ^(NSInteger clickedAction) {
        // 本周流行菜谱
        if (clickedAction == viewDidClickedActionPopRecipeView) {
//            [UILabel showStats:@"界面跟主页差不多，就没抓数据了~~" atView:weakSelf.view];
            [weakSelf.navigationController pushViewController:[[XCFKitchenBuyViewController alloc] init] animated:YES];
        }
        // 关注动态
        else if (clickedAction == viewDidClickedActionFeedsView) {
            [weakSelf.navigationController pushViewController:[[XCFFeedsViewController alloc] init] animated:YES];
        }
        // 排行榜
        else if (clickedAction == viewDidClickedActionTopListButton) {
            [weakSelf pushWebViewWithURL:XCFRequestKitchenTopList];
        }
        // 看视频
        else if (clickedAction == viewDidClickedActionVideoButton) {
//            [UILabel showStats:@"该界面数据未抓取" atView:weakSelf.view];
            [weakSelf.navigationController pushViewController:[[XCFKitchenBuyViewController alloc] init] animated:YES];
        }
        // 买买买
        else if (clickedAction == viewDidClickedActionBuyButton) {
            [weakSelf.navigationController pushViewController:[[XCFKitchenBuyViewController alloc] init] animated:YES];
        }
        // 菜谱分类
        else if (clickedAction == viewDidClickedActionRecipeCategoryButton) {
            [weakSelf pushWebViewWithURL:XCFRequestKitchenRecipeCategory];
        } else if (clickedAction == viewDidClickedActionCreate) {
            [weakSelf createRecipe];
        }
        // 三餐
        else if (clickedAction == viewDidClickedActionBreakfast
            || clickedAction == viewDidClickedActionLunch
            || clickedAction == viewDidClickedActionSupper) {
            [weakSelf.navigationController pushViewController:[[XCFMealViewController alloc] init]animated:YES];
        }
    };
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadMoreData)];
    
    if (!self.issuesArray.count) self.tableView.mj_footer.hidden = YES;
}


#pragma mark - 网络请求

- (void)loadNewData {
    [self.tableView.mj_footer endRefreshing];
    [self.mananger GET:XCFRequestKitchenCell
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.issuesArray = [XCFIssues mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"issues"]];
                   [self.tableView reloadData];
                   [self.tableView.mj_header endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"loadNewData --- failure");
                   [self.tableView.mj_header endRefreshing];
               }];
}

- (void)loadMoreData {
    [self.tableView.mj_header endRefreshing];
    [self.mananger GET:XCFRequestKitchenCellMore
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   NSArray *newContent = [XCFIssues mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"issues"]];
                   [self.issuesArray addObjectsFromArray:newContent];
                   [self.tableView reloadData];
                   [self.tableView.mj_footer endRefreshing];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"loadMoreData --- failure");
                   [self.tableView.mj_footer endRefreshing];
               }];
}

/**
 *  加载headerView中导航的数据
 */
- (void)loadNavData {
    
    [self.mananger GET:XCFRequestKitchenNav
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.kitchenHeader.navContent = [XCFNavContent mj_objectWithKeyValues:responseObject[@"content"]];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   XCFLog(@"loadNavData --- failure");
               }];
    
     
}


#pragma mark - 懒加载

- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}

- (NSMutableArray *)issuesArray {
    if (!_issuesArray) {
        _issuesArray = [NSMutableArray array];
    }
    return _issuesArray;
}

- (NSMutableArray *)feedsArray {
    if (!_feedsArray) {
        _feedsArray = [NSMutableArray array];
    }
    return _feedsArray;
}



@end
