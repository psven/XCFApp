//
//  XCFRecipeViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  菜谱控制器
 */

#import "XCFRecipeViewController.h"
#import "XCFDishViewController.h"

#import "XCFRecipeHeader.h"
#import "XCFRecipeIngredientCell.h"
#import "XCFRecipeInstructionCell.h"
#import "XCFDishViewCell.h"
#import "XCFDishShowCell.h"
#import "XCFAddedRecipeListViewCell.h"
#import "XCFRecipeSupplementaryFooter.h"
#import "XCFBottomView.h"

#import "XCFRecipeIngredient.h"
#import "XCFRecipeInstruction.h"
#import "XCFRecipe.h"
#import "XCFDish.h"
#import "XCFRecipeList.h"
#import "XCFAuthor.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <Masonry.h>

@interface XCFRecipeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) AFHTTPSessionManager *mananger;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XCFRecipeHeader *recipeHeader;
@property (nonatomic, strong) XCFRecipe *recipe;
@property (nonatomic, strong) NSMutableArray *dish;
@property (nonatomic, strong) NSMutableArray *addedList;
@end

@implementation XCFRecipeViewController

static NSString *const recipeHeaderIdentifier              = @"RecipeHeader";              // header
static NSString *const recipeIngredientCellIdentifier      = @"RecipeIngredientCell";      // 用料
static NSString *const recipeInstructionCellIdentifier     = @"RecipeInstructionCell";     // 做法
static NSString *const recipeTipsCellIdentifier            = @"RecipeTipsCell";            // 小贴士
static NSString *const recipeDishShowCellIdentifier        = @"RecipeDishShowCell";        // 作品
static NSString *const recipeAddedRecipeListCellIdentifier = @"RecipeAddedRecipeListCell"; // 被加入的菜单
static NSString *const recipeSupplementaryFooterIdentifier = @"RecipeSupplementaryFooter"; // 第3组footer
static NSString *const recipeAddListFooterIdentifier       = @"RecipeAddListFooter";       // 第4组footer

#pragma mark - Config

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavButton];
    [self setupTableView];
    [self loadData];
    [self setupBottomView];
    
    // 恢复侧滑返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}


#pragma mark - tableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) count = self.recipe.ingredient.count;
    if (section == 1) count = self.recipe.instruction.count;
    if (section == 2) count = self.recipe.tips.length ? 1 : 0;
    if (section == 3) count = 1;
    if (section == 4) count = self.addedList.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) { // 用料
        XCFRecipeIngredientCell *ingredientCell = [tableView dequeueReusableCellWithIdentifier:recipeIngredientCellIdentifier
                                                                                  forIndexPath:indexPath];
        ingredientCell.ingredient = self.recipe.ingredient[indexPath.row];
        cell = ingredientCell;
    }
    
    else if (indexPath.section == 1) { // 步骤
        XCFRecipeInstructionCell *instructionCell = [tableView dequeueReusableCellWithIdentifier:recipeInstructionCellIdentifier
                                                                                    forIndexPath:indexPath];
        instructionCell.instruction = self.recipe.instruction[indexPath.row];
        cell = instructionCell;
    }
    
    else if (indexPath.section == 2) { // 小贴士
        if (self.recipe.tips.length) {
            UITableViewCell *tipsCell = [tableView dequeueReusableCellWithIdentifier:recipeTipsCellIdentifier
                                                                        forIndexPath:indexPath];
            tipsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            tipsCell.backgroundColor = XCFGlobalBackgroundColor;
            tipsCell.textLabel.numberOfLines = 0;
            tipsCell.textLabel.font = [UIFont systemFontOfSize:14];
            tipsCell.textLabel.text = self.recipe.tips;
            cell = tipsCell;
        }
    }
    
    else if (indexPath.section == 3) { // 作品
        XCFDishShowCell *dishViewCell = [tableView dequeueReusableCellWithIdentifier:recipeDishShowCellIdentifier
                                                                        forIndexPath:indexPath];
        WeakSelf;
        dishViewCell.type = XCFVerticalCellTypeDish;
        dishViewCell.recipe = self.recipe;
        dishViewCell.dish = self.dish;
        // 点击作品后弹出作品控制器
        dishViewCell.collectionViewCellClickedBlock = ^(NSInteger index) {
            XCFDishViewController *dishViewVC = [[XCFDishViewController alloc] initWithStyle:UITableViewStyleGrouped];
            dishViewVC.dish = weakSelf.dish[index];
            [weakSelf.navigationController pushViewController:dishViewVC animated:YES];
        };
        // 点赞回调，发送网络请求给数据库，然后接收新数据，刷新界面
        dishViewCell.diggsButtonClickedBlock = ^(UIButton *sender) {
        };
        // 作品view左滑刷新 加载更多作品
        dishViewCell.refreshBlock = ^{
            [self.mananger GET:XCFRequestKitchenRecipeDish
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSArray *moreDish = [XCFDish mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"dishes"]];
                [self.dish addObjectsFromArray:moreDish];
                [self.tableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
        };
        cell = dishViewCell;
    }
    
    else if (indexPath.section == 4) { // 被加入的菜单
        XCFAddedRecipeListViewCell *addedListViewCell = [tableView dequeueReusableCellWithIdentifier:recipeAddedRecipeListCellIdentifier
                                                                                        forIndexPath:indexPath];
        addedListViewCell.addedList = self.addedList[indexPath.row];
        cell = addedListViewCell;
    }
    
    if (!cell) cell = [[UITableViewCell alloc] init];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 100;
    if (indexPath.section == 0) height = [self.recipe.ingredient[indexPath.row] cellHeight];
    if (indexPath.section == 1) height = [self.recipe.instruction[indexPath.row] cellHeight];
    if (indexPath.section == 2) height = self.recipe.tips.length ? 50 : 0;
    if (indexPath.section == 3) height = self.dish.count ? XCFScreenHeight*0.5 + 160 : 0;
    if (indexPath.section == 4) height = 80;
    return height;
}


#pragma mark - UITableViewHeaderFooterView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeHeaderIdentifier];
    headerView.frame = CGRectMake(0, 0, XCFScreenWidth, 50);
    headerView.contentView.backgroundColor = XCFGlobalBackgroundColor;
    NSInteger tag = 11;
    UILabel *label = [headerView.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:16];
        label.frame = CGRectMake(15, 15, 200, 40);
        [headerView.contentView addSubview:label];
    }
    if (section == 0) label.text = @"用料";
    if (section == 1) label.text = @"做法";
    if (section == 2) label.text = @"小贴士";
    if (section == 3) label.text = @"";
    if (section == 4) label.text = @"被加入的菜单";
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer;
    if (section == 3) {
        XCFRecipeSupplementaryFooter *supplementaryFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeSupplementaryFooterIdentifier];
        supplementaryFooter.frame = CGRectMake(0, 0, XCFScreenWidth, 200);
        WeakSelf;
        supplementaryFooter.uploadButtonClickedBlock = ^{ // 上传作品
            UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:[[XCFUploadDishViewController alloc]
                                                                                                         initWithStyle:UITableViewStyleGrouped]];
            [weakSelf.navigationController presentViewController:navCon animated:YES completion:nil];
        };
        footer = supplementaryFooter;
        
    } else if (section == 4) { // 第4组footer
        footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:recipeAddListFooterIdentifier];
        NSInteger tag = 12;
        UIButton *addListButton = [footer viewWithTag:tag];
        if (!addListButton) {
            addListButton = [UIButton borderButtonWithBackgroundColor:XCFGlobalBackgroundColor
                                                                title:@"加入菜单"
                                                       titleLabelFont:[UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]
                                                           titleColor:XCFThemeColor
                                                               target:self
                                                               action:@selector(addToList)
                                                        clipsToBounds:YES];
            addListButton.tag = tag;
            [footer addSubview:addListButton];
            [addListButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(footer).offset(20);
                make.centerX.equalTo(footer);
                make.size.mas_equalTo(CGSizeMake(120, 40));
            }];
        }
    }
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ((section == 2 && self.recipe.tips.length == 0) || section == 3) return 0;
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 200;
    } else if (section == 4) {
        return 80;
    }
    return 0;
}


#pragma mark - 属性


- (void)setupNavButton {
    UIBarButtonItem *back = [UIBarButtonItem barButtonItemWithImageName:@"backStretchBackgroundNormal"
                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                 target:self
                                                                 action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"buylistButtonImage"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
                                                                                  target:self
                                                                                  action:@selector(buylist)];
    
    UIBarButtonItem *pyq = [UIBarButtonItem barButtonRightItemWithImageName:@"convenient_share_pyq"
                                                                     target:self
                                                                     action:@selector(sharePYQ)];
    UIBarButtonItem *wx = [UIBarButtonItem barButtonRightItemWithImageName:@"convenient_share_wx"
                                                                    target:self
                                                                    action:@selector(shareWeChat)];
    UIBarButtonItem *other = [UIBarButtonItem barButtonRightItemWithImageName:@"convenient_share_other"
                                                                       target:self
                                                                       action:@selector(shareOther)];
    
    [self.navigationItem setLeftBarButtonItems:@[back, pyq, wx, other]];
    
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
    [self.tableView registerClass:[XCFRecipeIngredientCell      class]
           forCellReuseIdentifier:recipeIngredientCellIdentifier];      // 原料
    [self.tableView registerClass:[XCFRecipeInstructionCell     class]
           forCellReuseIdentifier:recipeInstructionCellIdentifier];     // 步骤
    [self.tableView registerClass:[UITableViewCell              class]
           forCellReuseIdentifier:recipeTipsCellIdentifier];            // 小贴士
    [self.tableView registerClass:[XCFDishShowCell              class]
           forCellReuseIdentifier:recipeDishShowCellIdentifier];        // 作品
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFAddedRecipeListViewCell class]) bundle:nil]
         forCellReuseIdentifier:recipeAddedRecipeListCellIdentifier];   // 底部“被添加的菜单”
    
    [self.tableView registerClass:[UITableViewHeaderFooterView  class]
forHeaderFooterViewReuseIdentifier:recipeHeaderIdentifier];             // header
    [self.tableView registerClass:[XCFRecipeSupplementaryFooter class]
forHeaderFooterViewReuseIdentifier:recipeSupplementaryFooterIdentifier];// “上传我做的这道菜”
    [self.tableView registerClass:[UITableViewHeaderFooterView  class]
forHeaderFooterViewReuseIdentifier:recipeAddListFooterIdentifier];      // 加入菜单
}


- (void)setupBottomView {
    XCFBottomView *bottomView = [[XCFBottomView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 44));
    }];
    bottomView.actionBlock = ^(NSInteger type) {
        if (type == BottomViewClickedCollect) {
            // 收藏
        } else if (type == BottomViewClickedAddToList) {
            // 加入菜篮子
        }
    };
}

/**
 *  网络请求
 */
- (void)loadData {
    // 菜谱
    [self.mananger GET:XCFRequestKitchenRecipe
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.recipe = [XCFRecipe mj_objectWithKeyValues:responseObject[@"content"][@"recipe"]];
                   [self.tableView reloadData];
                   self.recipeHeader = [[XCFRecipeHeader alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, self.recipe.headerheight)];
                   self.recipeHeader.recipe = self.recipe;
                   self.tableView.tableHeaderView = self.recipeHeader;
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   XCFLog(@"%@", error);
               }];
    
    // 作品
    [self.mananger GET:XCFRequestKitchenRecipeDish
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.dish = [XCFDish mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"dishes"]];
                   [self.tableView reloadData];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   XCFLog(@"%@", error);
               }];
    
    // 被加入菜单
    [self.mananger GET:XCFRequestKitchenAddedRecipeList
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   self.addedList = [XCFRecipeList mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"recipe_lists"]];
                   [self.tableView reloadData];
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   XCFLog(@"%@", error);
               }];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (AFHTTPSessionManager *)mananger {
    if (!_mananger) {
        _mananger = [AFHTTPSessionManager manager];
    }
    return _mananger;
}

- (NSMutableArray *)dish {
    if (!_dish) {
        _dish = [NSMutableArray array];
    }
    return _dish;
}

- (NSMutableArray *)addedList {
    if (!_addedList) {
        _addedList = [NSMutableArray array];
    }
    return _addedList;
}


#pragma mark - NavMethor
// 返回
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

// 菜篮子
- (void)buylist {
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}

// 分享到朋友圈
- (void)sharePYQ {

}

// 分享到微信
- (void)shareWeChat {
    
}

// 分享到其他
- (void)shareOther {
    
}

// 加入菜单
- (void)addToList {
    [[NSNotificationCenter defaultCenter] postNotificationName:XCFBasketListDidAddIngredientNotification object:self userInfo:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
