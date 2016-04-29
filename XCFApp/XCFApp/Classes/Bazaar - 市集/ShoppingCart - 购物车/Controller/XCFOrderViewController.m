//
//  XCFOrderViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFOrderViewController.h"
#import "XCFShippingAddressController.h"

#import "XCFOrderAddressView.h"     // 收货地址
#import "XCFCartItemShopView.h"     // 店铺view（sectionHeader）
#import "XCFCartItemCell.h"         // 商品cell
#import "XCFOrderSectionFooter.h"   // 店铺订单信息（sectionFooter）
#import "XCFOrderFooterView.h"      // 支付信息view
#import "XCFOrderPayView.h"         // 底部付款view

#import "XCFAddressInfoTool.h"
#import "XCFCartItemTool.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"

@interface XCFOrderViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XCFOrderAddressView *addressView; // 收货地址view
@property (nonatomic, strong) XCFOrderPayView *payView;         // 底部付款view
@end

@implementation XCFOrderViewController

static NSString *const cellReuseIdentifier = @"cartItemCell";
static NSString *const headerReuseIdentifier = @"cartItemHeader";
static NSString *const footerReuseIdentifier = @"cartItemfooter";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupTableView];
    [self setupTableHeaderView];
    [self setupTableFooterView];
    [self setupPayView];
}

// 刷新收货地址
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.addressView.addressInfo = [XCFAddressInfoTool currentSelectedAddress];
    self.tableView.tableHeaderView = self.addressView;
    [self.tableView reloadData];
}


#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [XCFCartItemTool totalBuyItems].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *shopArray = [XCFCartItemTool totalBuyItems][section];
    return shopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    NSArray *shopArray = [XCFCartItemTool totalBuyItems][indexPath.section];
    XCFCartItem *item = shopArray[indexPath.row];
    cell.style = XCFCartViewChildControlStyleOrder; // cell类型为订单类型
    cell.cartItem = item;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XCFCartItemShopView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    NSArray *shopArray = [XCFCartItemTool totalBuyItems][section];
    header.style = XCFCartViewChildControlStyleOrder;
    header.cartItem = shopArray[0];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    XCFOrderSectionFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerReuseIdentifier];
    footer.shopArray = [XCFCartItemTool totalBuyItems][section];
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height;
    NSArray *shopArray = [XCFCartItemTool totalBuyItems][section];
    double totalOriginPrice = 0;      // 总原价格
    double totalPayPrice = 0;         // 总支付价格
    for (XCFCartItem *item in shopArray) {
        // 如果是勾选状态，说明是要购买的商品
        if (item.state == XCFCartItemStateSelected) {
            totalOriginPrice += item.displayOriginPrice * item.number;
            totalPayPrice    += item.displayPrice       * item.number;
        }
    }
    // 店铺优惠价格 = 原价 - 实付
    double promotionPrice = totalOriginPrice - totalPayPrice;
    if (!promotionPrice) { // 没有店铺优惠，调整高度
        height = 138;
    } else {
        height = 178;
    }
    return height;
}


#pragma mark - 属性

- (void)setupBasic {
    self.title = @"确认订单";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, XCFScreenHeight-60) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 80;
    _tableView.backgroundColor = XCFGlobalBackgroundColor;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFCartItemCell class]) bundle:nil]
     forCellReuseIdentifier:cellReuseIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFCartItemShopView class]) bundle:nil]
forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFOrderSectionFooter class]) bundle:nil]
forHeaderFooterViewReuseIdentifier:footerReuseIdentifier];
    
}

- (void)setupTableHeaderView {
    XCFOrderAddressView *addressView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFOrderAddressView class])
                                                                      owner:nil options:nil] lastObject];
    addressView.frame = CGRectMake(0, 0, XCFScreenWidth, 90);
    addressView.addressInfo = [XCFAddressInfoTool currentSelectedAddress];
    self.tableView.tableHeaderView = addressView;
    self.addressView = addressView;
    WeakSelf;
    addressView.goToAddressBlock = ^{ // 选择收货地址
        [weakSelf.navigationController pushViewController:[[XCFShippingAddressController alloc] init] animated:YES];
    };
}

- (void)setupTableFooterView {
    XCFOrderFooterView *payRelatedInfoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFOrderFooterView class])
                                                                            owner:nil options:nil] lastObject];
    payRelatedInfoView.frame = CGRectMake(0, 0, XCFScreenWidth, 137);
    self.tableView.tableFooterView = payRelatedInfoView;
}

- (void)setupPayView {
    self.payView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFOrderPayView class])
                                                  owner:nil options:nil] lastObject];
    self.payView.frame = CGRectMake(0, XCFScreenHeight-60, XCFScreenWidth, 60);
    [self.view addSubview:self.payView];
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}



@end
