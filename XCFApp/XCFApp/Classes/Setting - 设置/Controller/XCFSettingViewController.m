//
//  XCFSettingViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFSettingViewController.h"
#import "XCFProfileEditingController.h"
#import "XCFShippingAddressController.h"
#import "XCFMyInfoCell.h"
#import "XCFSettingFooter.h"
#import "XCFAuthorDetail.h"

@interface XCFSettingViewController ()
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@end

@implementation XCFSettingViewController

static NSString *const myInfoCellIdentifier = @"myInfoCellIdentifier";
static NSString *const normalCellIdentifier = @"normalCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupTableViewFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authorDetail = [XCFMyInfo info];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        XCFMyInfoCell *myInfoCell = [tableView dequeueReusableCellWithIdentifier:myInfoCellIdentifier forIndexPath:indexPath];
        myInfoCell.authorDetail = self.authorDetail;
        cell = myInfoCell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section < 3) cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
//        self.authorDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"kMyInfo"];
//        if (!self.authorDetail) self.authorDetail = [[XCFAuthorDetail alloc] init];
        [self.navigationController pushViewController:[[XCFProfileEditingController alloc] init] animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        [self.navigationController pushViewController:[[XCFShippingAddressController alloc] init] animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    if (section == 1) return 3;
    if (section == 2) return 2;
    if (section == 3) return 2;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 60;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


#pragma mark - 属性

- (void)setupTableView {
    self.title = @"设置";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFMyInfoCell class]) bundle:nil]
         forCellReuseIdentifier:myInfoCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCellIdentifier];
}

- (void)setupTableViewFooter {
    XCFSettingFooter *footer = [[XCFSettingFooter alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 100)];
    self.tableView.tableFooterView = footer;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        NSArray *section1 = @[];
        NSArray *section2 = @[@"账号管理", @"设置密码", @"收货地址"];
        NSArray *section3 = @[@"发现好友", @"消息推送"];
        NSArray *section4 = @[@"把下厨房告诉朋友", @"帮助下厨房评分"];
        [_titleArray addObject:section1];
        [_titleArray addObject:section2];
        [_titleArray addObject:section3];
        [_titleArray addObject:section4];
    }
    return _titleArray;
}

- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}

@end
