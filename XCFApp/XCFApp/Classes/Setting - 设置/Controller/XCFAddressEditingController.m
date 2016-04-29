//
//  XCFAddressEditingController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddressEditingController.h"
#import "XCFAddressEditingView.h"
#import "XCFAddressInfo.h"
#import "XCFAddressInfoTool.h"

@interface XCFAddressEditingController ()

@end

@implementation XCFAddressEditingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupHeader];
}

#pragma mark - 存储
- (void)save {
    if ([self.title isEqualToString:@"添加收货地址"]) {
        self.addressInfo.state = XCFAddressInfoCellStateSelected; // 默认使用新添加的收货地址
        [XCFAddressInfoTool addInfo:self.addressInfo];
    } else if ([self.title isEqualToString:@"编辑收货地址"]) {
        [XCFAddressInfoTool updateInfoAtIndex:self.infoIndex withInfo:self.addressInfo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

#pragma mark - 属性
- (void)setupTableView {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"保存"
                                                                              target:self
                                                                              action:@selector(save)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = XCFGlobalBackgroundColor;
}

- (void)setupHeader {
    XCFAddressEditingView *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFAddressEditingView class])
                                                                   owner:nil options:nil] lastObject];
    header.addressInfo = self.addressInfo;
    header.frame = CGRectMake(0, 0, XCFScreenWidth, 350);
    self.tableView.tableHeaderView = header;
    WeakSelf;
    // 编辑回调，根据对应内容设置数据
    header.editingBlock = ^(XCFAddressEditingContent content, NSString *result) {
        if (content == XCFAddressEditingContentName) weakSelf.addressInfo.name = result;
        if (content == XCFAddressEditingContentPhone) weakSelf.addressInfo.phone = result;
        if (content == XCFAddressEditingContentDetailAddress) weakSelf.addressInfo.detailAddress = result;
    };
    // 选择地址回调
    header.editingLocationBlock = ^(NSString *result) {
        weakSelf.addressInfo.province = result;
    };
    // 删除收货地址
    header.deleteBlock = ^{
        if ([weakSelf.title isEqualToString:@"编辑收货地址"]) {
            [XCFAddressInfoTool removeInfoAtIndex:weakSelf.infoIndex];
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

- (XCFAddressInfo *)addressInfo {
    if (!_addressInfo) {
        _addressInfo = [[XCFAddressInfo alloc] init];
    }
    return _addressInfo;
}


@end
