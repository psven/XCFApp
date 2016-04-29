//
//  XCFIngredientListViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientListViewController.h"

//#import "XCFBuyListSectionHeader.h"
#import "XCFIngredientListTopView.h"
#import "XCFIngredientListViewCell.h"
#import "XCFRecipeIngredientCell.h"
#import "XCFIngredientView.h"

#import "XCFRecipe.h"
#import "XCFRecipeIngredient.h"

@interface XCFIngredientListViewController () <UITableViewDataSource, UITableViewDelegate>
// 菜谱
@property (nonatomic, strong) UITableView *recipeTableView;
@property (nonatomic, strong) NSMutableArray *recipeArray;
// 主料
@property (nonatomic, strong) UITableView *statTableView;
@property (nonatomic, strong) NSMutableArray *statArray;

@end

@implementation XCFIngredientListViewController

static NSString *const reuseHeaderIdentifier    = @"XCFIngredientView";             // 顶部header
//static NSString *const sectionHeaderIdentifier  = @"XCFBuyListSectionHeader";       // sectionHeader
static NSString *const recipeCellIdentifier     = @"XCFIngredientListViewCell";     // 菜谱cell
static NSString *const statCellIdentifier       = @"XCFRecipeIngredientCell";       // 主料cell

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self setupRecipeTableView];
    [self setupRecipeTableViewHeader];
    [self setupStatTableView];
    [self setupStatTableViewHeader];
    [UILabel showStats:@"界面未完成。。😢" atView:self.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.statTableView) return 1;
    return self.recipeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.statTableView) return self.statArray.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.recipeTableView) {
        XCFIngredientListViewCell *recipeCell = [tableView dequeueReusableCellWithIdentifier:recipeCellIdentifier forIndexPath:indexPath];
        recipeCell.name = [self.recipeArray[indexPath.section] name];
        cell = recipeCell;
    } else if (tableView == self.statTableView) {
        XCFRecipeIngredientCell *statCell = [tableView dequeueReusableCellWithIdentifier:statCellIdentifier forIndexPath:indexPath];
        
//        XCFIngredientState state = XCFIngredientStatePurchased;
//        for (XCFRecipeIngredient *existIng in self.statArray) {
//            if (existIng.state == XCFIngredientStateNone) { // 所有同名原料中，如果有一个没选中，就将主料cell设置为未购买
//                state = XCFIngredientStateNone;
//                break;
//            }
//        }
        XCFRecipeIngredient *ingredient = self.statArray[indexPath.row];
//        ingredient.state = state;
        statCell.ingredient = ingredient;
        cell = statCell;
    }
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (tableView == self.recipeTableView) {
//        XCFBuyListSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderIdentifier];
//        XCFRecipe *recipe = self.recipeArray[section];
//        header.recipe = recipe;
//        return header;
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    XCFIngredientView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseHeaderIdentifier];
//    XCFRecipe *recipe = [XCFIngredientTool totalRecipeIngredients][section];
//    XCFRecipeIngredient *ing = recipe.ingredient[0];
//    XCFLog(@"%zd  -  %@  -  %@", section, recipe.name, ing.name);
    
    // 未解决tableView嵌套tableView导致的循环利用问题，这里直接不循环利用
    
    if (tableView == self.recipeTableView) {
        XCFIngredientView *footer = [[XCFIngredientView alloc] initWithReuseIdentifier:reuseHeaderIdentifier];
        XCFRecipe *recipe = self.recipeArray[section];
        footer.recipe = recipe;
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (tableView == self.recipeTableView) {
        height = 65;
        
    } else if (tableView == self.statTableView) {
        XCFRecipeIngredient *ingredient = self.statArray[indexPath.row];
        height = ingredient.cellHeight;
    }
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    CGFloat height = 0;
//    if (tableView == self.recipeTableView) height = 65;
//    return height;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0;
    if (tableView == self.recipeTableView) {
        XCFRecipe *recipe = self.recipeArray[section];
        for (XCFRecipeIngredient *ingredient in recipe.ingredient) {
            height += ingredient.cellHeight;
        }
    }
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.statTableView) {
        XCFRecipeIngredient *ingredient = self.statArray[indexPath.row];
        ingredient.state = !ingredient.state;
        [XCFIngredientTool updateIngredient:ingredient];
        [self.recipeTableView reloadData];
        [self.statTableView reloadData];
    }
}

#pragma mark - 属性

// 菜谱
- (void)setupRecipeTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    tableView.sectionHeaderHeight = 0.1;
    tableView.backgroundColor = XCFGlobalBackgroundColor;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFIngredientListViewCell class]) bundle:nil]
     forCellReuseIdentifier:recipeCellIdentifier];
//    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFBuyListSectionHeader class]) bundle:nil]
//forHeaderFooterViewReuseIdentifier:sectionHeaderIdentifier];
    [tableView registerClass:[XCFIngredientView class] forHeaderFooterViewReuseIdentifier:reuseHeaderIdentifier];
    [self.view addSubview:tableView];
    self.recipeTableView = tableView;
}

- (void)setupRecipeTableViewHeader {
    XCFIngredientListTopView *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFIngredientListTopView class])
                                                                      owner:nil options:nil] lastObject];
    header.frame = CGRectMake(0, 0, XCFScreenWidth, 40);
    header.style = XCFBuyListStyleRecipe;
    header.count = self.recipeArray.count;
    WeakSelf;
    header.changeViewBlock = ^{
        weakSelf.recipeTableView.hidden = YES;
        weakSelf.statTableView.hidden = NO;
    };
    self.recipeTableView.tableHeaderView = header;
    
}

- (NSMutableArray *)recipeArray {
    if (!_recipeArray) {
        _recipeArray = [NSMutableArray array];
        _recipeArray = [NSMutableArray arrayWithArray:[XCFIngredientTool totalRecipeIngredients]];
    }
    return _recipeArray;
}

// 主料
- (void)setupStatTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    tableView.backgroundColor = XCFGlobalBackgroundColor;
    [tableView registerClass:[XCFRecipeIngredientCell class] forCellReuseIdentifier:statCellIdentifier];
    [self.view insertSubview:tableView belowSubview:self.recipeTableView];
    self.statTableView = tableView;
}

- (void)setupStatTableViewHeader {
    XCFIngredientListTopView *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFIngredientListTopView class])
                                                                      owner:nil options:nil] lastObject];
    header.frame = CGRectMake(0, 0, XCFScreenWidth, 40);
    header.style = XCFBuyListStyleStat;
    header.count = self.recipeArray.count;
    WeakSelf;
    header.changeViewBlock = ^{
        weakSelf.recipeTableView.hidden = NO;
        weakSelf.statTableView.hidden = YES;
    };
    self.statTableView.tableHeaderView = header;
}

- (NSMutableArray *)statArray {
    if (!_statArray) {
        _statArray = [NSMutableArray array];
        _statArray = [NSMutableArray arrayWithArray:[XCFIngredientTool totalIngredients]];
    }
    return _statArray;
}


@end
