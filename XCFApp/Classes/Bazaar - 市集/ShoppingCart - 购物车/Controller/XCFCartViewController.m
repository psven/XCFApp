//
//  XCFCartViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/23.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCartViewController.h"
#import "XCFOrderViewController.h"
#import "XCFGoodsViewController.h"

#import "XCFCartSettlementView.h"
#import "XCFCartItemShopView.h"
#import "XCFCartItemCell.h"

#import "XCFCartItemTool.h"
#import "XCFCartItem.h"
#import "XCFGoods.h"
#import "XCFShop.h"

@interface XCFCartViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) XCFCartSettlementView *settlementView; // 底部结算view
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XCFCartViewController

static NSString *const cellReuseIdentifier = @"cartItemCell";
static NSString *const headerReuseIdentifier = @"cartItemHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupTableView];
    [self setupSettlementView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 每次pop回来就重置购物车商品点选状态
    [XCFCartItemTool resetItemState];
    [self.tableView reloadData];
}

#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.settlementView.totalItemsArray = [XCFCartItemTool totalItems];
    [self updateCheckAllMarkState];
    return [XCFCartItemTool totalItems].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *shopArray = [XCFCartItemTool totalItems][section];
    return shopArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    cell.style = XCFCartViewChildControlStyleCart; // cell类型为购物车类型
    NSArray *shopArray = [XCFCartItemTool totalItems][indexPath.section];
    XCFCartItem *item = shopArray[indexPath.row];
    cell.cartItem = item;

    WeakSelf;
    cell.selectedItemBlock = ^(XCFCartItemState state) { // 勾选商品回调
        item.state = state;
        [XCFCartItemTool updateItemAtIndexPath:indexPath withItem:item];
        [weakSelf.tableView reloadData];
    };
    
    cell.itemNumberChangeBlock = ^(NSUInteger number) { // 修改商品个数回调
        
        // 拿到最新的数据，再修改数量
        // 如果不拿到最新数据，在编辑商品数量时点击店铺全选 会导致正在编辑的商品无法同步选中状态的bug
        NSArray *newShopArray = [XCFCartItemTool totalItems][indexPath.section];
        XCFCartItem *newItem = newShopArray[indexPath.row];
        
        newItem.number = number;
        [XCFCartItemTool updateItemAtIndexPath:indexPath withItem:newItem];
        [weakSelf.tableView reloadData];
    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XCFCartItemShopView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    NSArray *shopArray = [XCFCartItemTool totalItems][section];
    header.style = XCFCartViewChildControlStyleCart;
    header.cartItem = shopArray[0];
    
    BOOL yesMarkSelected = YES; // 记录店铺全选状态
    for (XCFCartItem *item in shopArray) {
        if (item.state == XCFCartItemStateNone) {
            yesMarkSelected = NO; // 只要有一个不是选中状态，就取消店铺选中
            break;
        }
    }
    header.state = yesMarkSelected;
    
    WeakSelf;
    header.selectedShopItemsBlock = ^(XCFCartShopState state) { // 店铺全选回调
        // 同步店铺内商品与店铺的点选状态
        XCFCartItemState itemState = (XCFCartItemState)state;
        for (XCFCartItem *item in shopArray) {
            item.state = itemState;
        }
        [XCFCartItemTool updateShopArrayAtIndex:section withShopArray:shopArray];
        [weakSelf.tableView reloadData];
    };
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

#pragma mark - tableView Delegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[XCFGoodsViewController alloc] init] animated:YES];
}

#pragma mark - 事件处理
// 根据“编辑”按钮状态，进入对应模式（编辑/删除）
- (void)editCart:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.settlementView.style = sender.isSelected;
    [self.tableView reloadData];
}


#pragma mark - 属性

- (void)setupBasic {
    self.title = @"购物车";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"编辑"
                                                                       selectedTitle:@"完成"
                                                                              target:self
                                                                              action:@selector(editCart:)];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, XCFScreenHeight-60) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    _tableView.sectionFooterHeight = 10;
    _tableView.backgroundColor = XCFGlobalBackgroundColor;
    _tableView.contentInset = UIEdgeInsetsMake(10, 0, -20, 0);
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFCartItemCell class]) bundle:nil]
     forCellReuseIdentifier:cellReuseIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFCartItemShopView class]) bundle:nil]
forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
    
}

- (void)setupSettlementView {
    self.settlementView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFCartSettlementView class])
                                                     owner:self options:nil] lastObject];
    self.settlementView.frame = CGRectMake(0, XCFScreenHeight-60, XCFScreenWidth, 60);
    self.settlementView.totalItemsArray = [XCFCartItemTool totalItems];
//    [self updateCheckAllMarkState]; // 刚进入购物车，无点选商品，不需要更新状态
    self.settlementView.style = XCFCartEditStyleSettlement; // 默认为结算模式
    [self.view addSubview:_settlementView];
    WeakSelf;
    self.settlementView.selectedAllItemBlock = ^(XCFCartItemState state) { // 全选回调
        [XCFCartItemTool updateAllItemState:state];
        [weakSelf.tableView reloadData];
    };
    
    self.settlementView.settleOrDeleteBlock = ^{
        if (weakSelf.settlementView.style == XCFCartEditStyleSettlement) { // 结算模式
            // 判断有无商品
            NSUInteger totalNumber = 0;
            for (NSArray *shopArray in [XCFCartItemTool totalItems]) {
                for (XCFCartItem *item in shopArray) {
                    if (item.state == XCFCartItemStateSelected) totalNumber += item.number;
                }
            }
            if (totalNumber) { // 有商品就跳转到订单界面
                [weakSelf.navigationController pushViewController:[[XCFOrderViewController alloc] init] animated:YES];
            } else {
                [UILabel showStats:@"请选择要支付的商品" atView:weakSelf.view];
            }
            
        } else if (weakSelf.settlementView.style == XCFCartEditStyleDelete) { // 删除模式
            
            NSArray *totalItemsArray = [XCFCartItemTool totalItems];
            NSUInteger totalGoods = 0;  // 总商品数  （删除时显示）
            for (NSArray *shopArray in totalItemsArray) {
                for (XCFCartItem *item in shopArray) {
                    if (item.state == XCFCartItemStateSelected) totalGoods++;
                }
            }
            if (totalGoods) { // 如果有选中的商品
                NSString *displayTitle = [NSString stringWithFormat:@"确定要删除这%zd种商品吗", totalGoods];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:displayTitle
                                                                                         message:nil
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     [XCFCartItemTool removeSelectedItem]; // 删除选中的商品
                                                                     [weakSelf.tableView reloadData];
                                                                     // 提示：因为数据是本地的，所以购物车为空的话，购物车会重新加载本地的数据
                                                                     // 并不是bug
                                                                 }];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
                [weakSelf.navigationController presentViewController:alertController animated:YES completion:nil];
                
            } else { // 没有商品
                [UILabel showStats:@"请选择要删除的商品" atView:weakSelf.view];
            }
        }
    };
}

// 更新全选状态
- (void)updateCheckAllMarkState {
    NSArray *totalItemsArray = [XCFCartItemTool totalItems];
    BOOL yesMarkSelected = YES;
    for (NSArray *shopArray in totalItemsArray) {
        for (XCFCartItem *item in shopArray) {
            if (item.state == XCFCartItemStateNone) {
                yesMarkSelected = NO; // 只要有一个不是选中，就取消全选
                break;
            }
        }
    }
    if (yesMarkSelected == YES) self.settlementView.state = XCFCartShopStateSelected;
    if (yesMarkSelected == NO) self.settlementView.state = XCFCartShopStateNone;
}

// 不保存购物车商品的点选状态
- (void)dealloc {
    [XCFCartItemTool resetItemState];
}

@end
