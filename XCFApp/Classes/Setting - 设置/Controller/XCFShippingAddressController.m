//
//  XCFShippingAddressController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFShippingAddressController.h"
#import "XCFAddressEditingController.h"
#import "XCFAddAddressView.h"
#import "XCFShippingAddressCell.h"
#import "XCFAddressInfo.h"
#import "XCFAddressInfoTool.h"

@interface XCFShippingAddressController ()
@property (nonatomic, assign) NSInteger selectedRow; // 记录被选中的收货地址
@end

@implementation XCFShippingAddressController

static NSString *const addressCellIdentifier = @"addressCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 编辑完成pop回来刷新界面，刷新 纪录的收货地址（默认选中第一个）
    [XCFAddressInfoTool updateInfoAfterDeleted];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [XCFAddressInfoTool totalAddressInfo].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFShippingAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellIdentifier forIndexPath:indexPath];
    cell.addressInfo = [XCFAddressInfoTool totalAddressInfo][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *infoArray = [XCFAddressInfoTool totalAddressInfo];
    NSMutableArray *newArray = [NSMutableArray array];
    // 遍历整个收货地址数组，点击哪一个，就将哪一个设置为选中，其他设置为不选中
    for (NSUInteger index=0; index<infoArray.count; index++) {
        XCFAddressInfo *info = infoArray[index];
        if (index == indexPath.row) info.state = XCFAddressInfoCellStateSelected;
        if (index != indexPath.row) info.state = XCFAddressInfoCellStateNone;
        [newArray addObject:info];
    }
        [XCFAddressInfoTool setSelectedAddressInfoByNewInfoArray:newArray];
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
}

- (void)editing {
    if ([XCFAddressInfoTool totalAddressInfo].count) {
        // 获取selectedCell的数据跳转到地址编辑界面
        XCFAddressEditingController *editingCon = [[XCFAddressEditingController alloc] init];
        editingCon.infoIndex = self.selectedRow;
        editingCon.addressInfo = [XCFAddressInfoTool totalAddressInfo][self.selectedRow];
        editingCon.title = @"编辑收货地址";
        [self.navigationController pushViewController:editingCon animated:YES];
    } else {
        [UILabel showStats:@"请先添加收货地址！" atView:self.view];
    }
}


#pragma mark - 属性

- (void)setupTableView {
    self.title = @"选择收货地址";
    self.tableView.rowHeight = 100;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"编辑"
                                                                              target:self
                                                                              action:@selector(editing)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFShippingAddressCell class]) bundle:nil]
         forCellReuseIdentifier:addressCellIdentifier];
}

- (void)setupHeader {
    XCFAddAddressView *header = [[XCFAddAddressView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 44)];
    WeakSelf;
    header.addAddressBlock = ^{
        XCFAddressEditingController *addCon = [[XCFAddressEditingController alloc] init];
        addCon.title = @"添加收货地址";
        [weakSelf.navigationController pushViewController:addCon animated:YES];
    };
    self.tableView.tableHeaderView = header;
}

- (NSInteger)selectedRow {
    NSArray *infoArray = [XCFAddressInfoTool totalAddressInfo];
    for (NSInteger index=0; index<infoArray.count; index++) {
        XCFAddressInfo *info = infoArray[index];
        if (info.state == XCFAddressInfoCellStateSelected) {
            _selectedRow = index;
            return _selectedRow;
        }
    }
    return _selectedRow;
}

@end
