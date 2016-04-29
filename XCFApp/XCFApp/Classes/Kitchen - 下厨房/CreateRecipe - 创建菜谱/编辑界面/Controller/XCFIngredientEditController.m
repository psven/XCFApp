//
//  XCFIngredientEditController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientEditController.h"
#import "XCFIngredientEditFooter.h"
#import "XCFIngredientEditCell.h"
#import "XCFCreateIngredient.h"

@interface XCFIngredientEditController ()

@end

@implementation XCFIngredientEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupFooter];
}


#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ingredientArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFIngredientEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ingredientEditCell"];
    
    // 设置对应的placeholder
    if (indexPath.row == 0) {
        cell.placeholderArray = @[@"例：鸡蛋", @"1只"];
        [cell becomeFirstResponder];
    } else if (indexPath.row == 1) {
        cell.placeholderArray = @[@"猪肉", @"500克"];
    }

    if (self.ingredientArray.count == 1 && indexPath.row == 0) {
        cell.ingredient = self.ingredientArray[indexPath.row];
    } else if (self.ingredientArray.count > 1) {
        cell.ingredient = self.ingredientArray[indexPath.row];
    }
    
    WeakSelf;
    cell.editCallBackBlock = ^(XCFCreateIngredient *editedIngredient) {
        
        NSUInteger count = weakSelf.ingredientArray.count;
        if (count < indexPath.row+1) {
            for (NSInteger i=0; i < (indexPath.row+1-count); i++) {
                XCFCreateIngredient *originIgt = [[XCFCreateIngredient alloc] init];
                [weakSelf.ingredientArray addObject:originIgt];
            }
        }
//        if (editedIngredient.name.length || editedIngredient.amount.length) { // 有内容才保留
            [weakSelf.ingredientArray replaceObjectAtIndex:indexPath.row withObject:editedIngredient];
//        } else {
//            [weakSelf.ingredientArray removeObjectAtIndex:indexPath.row];
//        }
    };

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.ingredientArray.count) [self.ingredientArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 同步数据在数组中的位置
    XCFCreateIngredient *movingObj = self.ingredientArray[sourceIndexPath.row];     // 取出
    [self.ingredientArray removeObjectAtIndex:sourceIndexPath.row];
    [self.ingredientArray insertObject:movingObj atIndex:destinationIndexPath.row]; // 插入
    
}


#pragma mark - 关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - 属性

- (void)setupBasic {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"保存"
                                                                              target:self
                                                                              action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                             target:self
                                                                             action:@selector(cancel)];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFIngredientEditCell class]) bundle:nil]
         forCellReuseIdentifier:@"ingredientEditCell"];
}

- (void)setupFooter {
    XCFIngredientEditFooter *footer = [[XCFIngredientEditFooter alloc] init];
    footer.frame = CGRectMake(0, 0, XCFScreenWidth, 200);
    self.tableView.tableFooterView = footer;
    WeakSelf;
    footer.addLineBlock = ^{ // 点击“增加一行”后的回调
        [weakSelf.view endEditing:YES];
        // 添加一行空的原料
        [weakSelf.ingredientArray addObject:[[XCFCreateIngredient alloc] init]];
        NSInteger row = weakSelf.ingredientArray.count - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationBottom];
    };
    
    footer.adjustBlock = ^(tableViewAdjustStyle style) { // 调整
        if (style == tableViewAdjustStyleNone) {
            [self.tableView setEditing:NO animated:YES];
        } else if (style == tableViewAdjustStyleAdjusting) {
            [self.tableView endEditing:YES];
            [self.tableView setEditing:YES animated:YES];
        }
    };
}


#pragma mark - 事件处理

- (void)save {
    // 去除没有文字内容的用料
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger index=0; index<self.ingredientArray.count; index++) {
        XCFCreateIngredient *ingredient = self.ingredientArray[index];
        if (ingredient.name.length || ingredient.amount.length) [newArray addObject:ingredient];
    }
    !self.doneEditBlock ? : self.doneEditBlock(newArray);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setIngredientArray:(NSMutableArray<XCFCreateIngredient *> *)ingredientArray {
    _ingredientArray = ingredientArray;
    if (!ingredientArray.count) {   // 如果没有内容，自动创建两个空用料
        for (NSInteger i=0; i<2; i++) {
            [self.ingredientArray addObject:[[XCFCreateIngredient alloc] init]];
        }
    }
}

@end
