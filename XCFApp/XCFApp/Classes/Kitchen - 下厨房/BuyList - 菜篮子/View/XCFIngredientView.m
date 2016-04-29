//
//  XCFIngredientView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientView.h"
#import "XCFRecipeIngredientCell.h"
#import "XCFRecipe.h"
#import "XCFRecipeIngredient.h"
#import <Masonry.h>

@interface XCFIngredientView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *recipeIngredient; // 菜谱内的原料
@end

@implementation XCFIngredientView

static NSString *const reuseCellIdentifier = @"ingredientCell";

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[XCFRecipeIngredientCell class] forCellReuseIdentifier:reuseCellIdentifier];
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeIngredient.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFRecipeIngredientCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    cell.ingredient = self.recipeIngredient[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFRecipeIngredient *ingredient = self.recipeIngredient[indexPath.row];
    ingredient.state = !ingredient.state;
    [XCFIngredientTool updateSingleIngredientWithRecipe:self.recipe index:indexPath.row];
    [self.tableView reloadData]; // 嵌套tableView会导致代理混乱，直接调用当前tableView，而不是self.tableView
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFRecipeIngredient *ingredient = self.recipeIngredient[indexPath.row];
    return ingredient.cellHeight;
}

#pragma mark - 属性

- (NSArray *)recipeIngredient {
    if (!_recipeIngredient) {
        _recipeIngredient = [NSArray arrayWithArray:self.recipe.ingredient];
    }
    return _recipeIngredient;
}


@end
