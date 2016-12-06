//
//  XCFRecipeListViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/6.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeListViewController.h"
#import "XCFRecipeCell.h"
#import "XCFRecipeListHeader.h"

#import "XCFRecipeList.h"
#import "XCFRecipe.h"

#import <AFNetworking.h>
#import <MJExtension.h>

@interface XCFRecipeListViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) XCFRecipeList *recipeList;
@property (nonatomic, strong) XCFRecipeListHeader *recipeListHeader;
@end


@implementation XCFRecipeListViewController

static CGFloat const recipeListCellHeight = 295;
static NSString *const recipeListCellIdentifier = @"RecipeListCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单";
    self.tableView.backgroundColor = XCFGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[XCFRecipeCell class]
           forCellReuseIdentifier:recipeListCellIdentifier];
    
    [self loadData];
}


#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeList.sample_recipes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:recipeListCellIdentifier];
    XCFRecipe *recipe = self.recipeList.sample_recipes[indexPath.row];
    cell.recipe = recipe;
    WeakSelf;
    cell.authorIconClickedBlock = ^{ // 点击头像回调
        UIViewController *authorViewController = [[UIViewController alloc] init];
        authorViewController.view.backgroundColor = XCFGlobalBackgroundColor;
        [weakSelf.navigationController pushViewController:authorViewController animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return recipeListCellHeight;
}



#pragma mark - Config

- (void)loadData {
    [self.mananger GET:XCFRequestKitchenRecipeList
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.recipeList = [XCFRecipeList mj_objectWithKeyValues:responseObject[@"content"]];
                   [self.tableView reloadData];
                   
                   // 返回数据后才设置header
                   self.recipeListHeader = [[XCFRecipeListHeader alloc] initWithFrame:CGRectMake(0,
                                                                                                 0,
                                                                                                 XCFScreenWidth,
                                                                                                 self.recipeList.headerheight)];
                   self.recipeListHeader.recipeList = self.recipeList;
                   self.tableView.tableHeaderView = self.recipeListHeader;
                   
                   self.recipeListHeader.collectActionBlock = ^{
                       // 收藏菜单到本地 然后在个人中心“收藏”中获取数据刷新表格
                   };
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               }];
}

- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}

@end
