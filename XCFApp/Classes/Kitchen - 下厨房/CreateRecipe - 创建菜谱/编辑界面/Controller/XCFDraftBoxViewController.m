//
//  XCFDraftBoxViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDraftBoxViewController.h"
#import "XCFCreateRecipeController.h"
#import "XCFCreateRecipe.h"
#import "XCFRecipeDraftTool.h"
#import "XCFDraftRecipeCell.h"


@implementation XCFDraftBoxViewController

#pragma mark - Table view data source

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDraftRecipeCell class]) bundle:nil]
         forCellReuseIdentifier:@"recipeDraftCell"];
}

// 从上一个界面pop回来之后刷新界面
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [XCFRecipeDraftTool totalRecipeDrafts].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFDraftRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeDraftCell"
                                                               forIndexPath:indexPath];
    cell.recipeDraft = [XCFRecipeDraftTool totalRecipeDrafts][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 295;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFCreateRecipeController *vc = [[XCFCreateRecipeController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.createRecipe = [XCFRecipeDraftTool totalRecipeDrafts][indexPath.row];
    vc.draftIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
