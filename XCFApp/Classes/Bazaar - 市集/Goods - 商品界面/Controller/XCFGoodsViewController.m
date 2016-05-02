//
//  XCFGoodsViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsViewController.h"
#import "XCFKindsCategoryView.h"            // 商品分类选择view
#import "XCFImageShowController.h"          // 图片展示
#import "XCFGoodsReviewController.h"        // 评价
#import "XCFDetailReviewViewController.h"   // 全部评价
#import "XCFCartViewController.h"           // 购物车
#import "XCFOrderViewController.h"          // 订单

#import "XCFGoodsHeaderView.h"
#import "XCFGoodsFooterView.h"
#import "XCFGoodsShopCell.h"
#import "XCFDishShowCell.h"
#import "XCFGoodsImageTextView.h"
#import "XCFGoodsBottomView.h"

#import "XCFCartItem.h"
#import "XCFCartItemTool.h"
#import "XCFGoods.h"
#import "XCFShop.h"

#import <Masonry.h>
#import <AFNetworking.h>
#import <MJExtension.h>

@interface XCFGoodsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XCFGoodsHeaderView *headerView;
@property (nonatomic, strong) XCFGoodsImageTextView *imageTextView;
@property (nonatomic, strong) XCFGoodsBottomView *bottomView;
@property (nonatomic, strong) XCFGoods *goods;
@end

@implementation XCFGoodsViewController

static NSString * const shopCellIdentifier = @"shopCell";
static NSString * const reviewCellIdentifier = @"reviewCell";
static NSString * const headerIdentifier = @"header";


#pragma mark - Config

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self loadData];
    [self setupNavButton];
    [self setupFooterView];
    [self setupBottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    // 店铺
    if (indexPath.section == 0) {
        XCFGoodsShopCell *shopCell = [tableView dequeueReusableCellWithIdentifier:shopCellIdentifier];
        shopCell.shop = self.goods.shop;
        cell = shopCell;
        
    }
    // 评价view
    else if (indexPath.section == 1) {
        XCFDishShowCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:reviewCellIdentifier];
        WeakSelf;
        reviewCell.type = XCFVerticalCellTypeReview;
        reviewCell.goods = self.goods;
        
        // 点击评价cell的回调
        reviewCell.collectionViewCellClickedBlock = ^(NSInteger index) {
            // 评价详情
            XCFDetailReviewViewController *detailReviewVC = [[XCFDetailReviewViewController alloc] initWithStyle:UITableViewStyleGrouped];
            detailReviewVC.review = weakSelf.goods.reviews[index];
            [weakSelf.navigationController pushViewController:detailReviewVC animated:YES];
        };
        // 查看全部评价
        reviewCell.showAll = ^{
            XCFGoodsReviewController *reviewCon = [[XCFGoodsReviewController alloc] init];
            reviewCon.goods = weakSelf.goods;
            [weakSelf.navigationController pushViewController:reviewCon animated:YES];
        };
        cell = reviewCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) [self goToShop];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.section == 0) {
        height = 130;
    } else if (indexPath.section == 1) {
        height = XCFScreenHeight*0.5 + 180;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (void)setupHeaderView {
    CGFloat headerViewHeight = 350 + self.goods.goodsDetailViewHeight + self.goods.shopPromotionViewHeight;
    XCFGoodsHeaderView *headerView = [[XCFGoodsHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                                          0,
                                                                                          self.view.bounds.size.width,
                                                                                          headerViewHeight)];
    // 拿到点击的下标、图片数组、当前图片frame
    // 图片展示
    WeakSelf;
    __weak XCFGoodsHeaderView *view = headerView;
    headerView.showImageBlock = ^(NSUInteger imageIndex, CGRect imageRect) {
        NSValue *rectValue = [NSValue valueWithCGRect:imageRect];
        XCFImageShowController *imageShowVC = [[XCFImageShowController alloc] init];
        imageShowVC.imageIndex = imageIndex;                // 当前图片下标
        imageShowVC.rectValue = rectValue;                  // 当前图片在窗口的位置
        imageShowVC.imageArray = weakSelf.goods.totalPics;  // 当前图片数组
        imageShowVC.imageViewDidScrolledBlock = ^(CGFloat currentX) { // 关闭图片展示后，同步图片滚动的位置
            view.imageViewCurrentLocation = currentX;
        };
        [weakSelf.navigationController presentViewController:imageShowVC animated:NO completion:nil];
        
    };
    headerView.goods = self.goods;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)setupFooterView {
    XCFGoodsFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFGoodsFooterView class])
                                                                    owner:self options:nil] lastObject];
    footerView.frame = CGRectMake(0, 0, XCFScreenWidth, 60);
    self.tableView.tableFooterView = footerView;
    
}


#pragma mark - UIScrollViewDelegate
// 向上拖动到一定程度，切换至图文详情界面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 预定值为100
    if (scrollView.contentOffset.y > self.tableView.contentSize.height - self.tableView.frame.size.height + 100) {
        // 隐藏商品信息
        self.tableView.hidden = YES;
        // 动画
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.size.height-44-64));
            self.imageTextView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.size.height-44));
        } completion:^(BOOL finished) {
            [UILabel showStats:@"未解决webView导致的内存泄漏问题" atView:self.view];
        }];
    }
}


#pragma mark - 事件处理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 进入店铺
- (void)goToShop {
    [self pushWebViewWithURL:self.goods.shop.url];
}

// 返回
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

// 购物车
- (void)goToShoppingCart {
    [self.navigationController pushViewController:[[XCFCartViewController alloc] init] animated:YES];
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


#pragma mark - 属性

- (void)loadData {
    [[AFHTTPSessionManager manager] GET:XCFRequestGoods
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    self.goods = [XCFGoods mj_objectWithKeyValues:responseObject[@"content"][@"goods"]];
                                    
                                    [self.tableView reloadData];
                                    self.imageTextView.goods = self.goods;
                                    [self setupHeaderView];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"loadNewData --- failure");
                                }];
}

- (void)setupNavButton {
    UIBarButtonItem *back = [UIBarButtonItem barButtonItemWithImageName:@"backStretchBackgroundNormal"
                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                 target:self
                                                                 action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shoppingCartIconWithTarget:self
                                                                                  action:@selector(goToShoppingCart)];
    
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

- (void)setupBottomView {
    
    _bottomView = [[XCFGoodsBottomView alloc] initWithFrame:CGRectMake(0,
                                                                       self.view.bounds.size.height-44,
                                                                       self.view.bounds.size.width,
                                                                       44)];
    [self.view insertSubview:_bottomView aboveSubview:self.imageTextView];
    WeakSelf;
    _bottomView.actionBlock = ^(BottomViewClicked type) {
        
        // 随机添加一样商品
        XCFCartItem *randomItem = [XCFCartItemTool randomItem];
        XCFGoods *randomGoods = randomItem.goods;
        // 店铺
        if (type == BottomViewClickedGoToShop) {
            [weakSelf goToShop];
        }
        
        // 加入购物车
        else if (type == BottomViewClickedAddToShoppingCart) {
            
            // 如果该商品有多种类型，就弹窗让用户选择具体购买哪种类型
            if (randomGoods.kinds.count > 1) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                // 缩小当前界面
                [UIView animateWithDuration:0.3 animations:^{
                    window.rootViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }];
                
                // 显示商品分类view
                XCFKindsCategoryView *kindsView = [[XCFKindsCategoryView alloc] initWithFrame:window.bounds];
                // 分类view的弹出类型（购物车）
                kindsView.type = XCFKindsViewTypeCart;
                kindsView.item = randomItem;
                [window addSubview:kindsView];
                // 确认购买回调
                kindsView.confirmBlock = ^(XCFCartItem *item) {
                    // 本地购物车数据添加商品
                    [XCFCartItemTool addItem:item];
                    [UILabel showStats:[NSString stringWithFormat:@"添加:\n%@", item.kind_name] atView:weakSelf.view];
                };
                // 取消回调
                kindsView.cancelBlock = ^{
                    // 恢复界面大小
                    [UIView animateWithDuration:0.3 animations:^{
                        window.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                    }];
                };
                
            } else { // 如果只有一个商品，直接加入购物车
                [XCFCartItemTool addItemRandomly:^(NSString *goodsName) {
                    [UILabel showStats:[NSString stringWithFormat:@"随机添加:\n%@", goodsName] atView:weakSelf.view];
                }];
            }
        }
        
        
        
        // 立即购买
        else if (type == BottomViewClickedBuyNow) {
            // 随机购买一样商品
            
            // 如果该商品有多种类型，就弹窗让用户选择具体购买哪种类型
            if (randomGoods.kinds.count > 1) {
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                // 缩小当前界面
                [UIView animateWithDuration:0.3 animations:^{
                    window.rootViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                }];
                // 显示商品分类view
                XCFKindsCategoryView *kindsView = [[XCFKindsCategoryView alloc] initWithFrame:window.bounds];
                // 分类view的弹出类型（立即购买）
                kindsView.type = XCFKindsViewTypeOrder;
                kindsView.item = randomItem;
                [window addSubview:kindsView];
                kindsView.confirmBlock = ^(XCFCartItem *item) {
                    // 进入下订单界面
                    XCFOrderViewController *orderVC = [[XCFOrderViewController alloc] init];
                    // 将要购买的商品数据赋值给“下订单”控制器
                    orderVC.buyItems = [XCFCartItemTool buyItem:item];
                    [weakSelf.navigationController pushViewController:orderVC animated:YES];
                };
                // 取消回调
                kindsView.cancelBlock = ^{
                    // 恢复界面大小
                    [UIView animateWithDuration:0.3 animations:^{
                        window.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                    }];
                };
                
            } else { // 如果只有一个商品，直接进入下订单界面
                XCFOrderViewController *orderVC = [[XCFOrderViewController alloc] init];
                orderVC.buyItems = [XCFCartItemTool buyItem:randomItem];
                [weakSelf.navigationController pushViewController:orderVC animated:YES];
            }
        }
    };
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.view.bounds.size.width,
                                                                   self.view.bounds.size.height-44)
                                                  style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFGoodsShopCell class]) bundle:nil]
         forCellReuseIdentifier:shopCellIdentifier];
        [_tableView registerClass:[XCFDishShowCell class]
           forCellReuseIdentifier:reviewCellIdentifier];
        [_tableView registerClass:[UITableViewHeaderFooterView class]
forHeaderFooterViewReuseIdentifier:headerIdentifier];
    }
    return _tableView;
}

- (XCFGoodsImageTextView *)imageTextView {
    if (!_imageTextView) {
        _imageTextView = [[XCFGoodsImageTextView alloc] initWithFrame:CGRectMake(0,
                                                                                 self.view.bounds.size.height+20,
                                                                                 self.view.bounds.size.width,
                                                                                 self.view.bounds.size.height-44)];
        [self.view addSubview:_imageTextView];
        WeakSelf;
        _imageTextView.viewWillDismissBlock = ^{ // 返回商品界面
            weakSelf.tableView.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.tableView.transform = CGAffineTransformMakeTranslation(0, 0);
                weakSelf.imageTextView.transform = CGAffineTransformMakeTranslation(0, weakSelf.view.bounds.size.height-44);
            }];
        };
        
    }
    return _imageTextView;
}


@end
