//
//  XCFMealViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMealViewController.h"
#import "XCFMealHeader.h"
#import "XCFMealDishCell.h"

#import "XCFMealInfo.h"
#import "XCFDish.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <Masonry.h>

@interface XCFMealViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XCFMealInfo *mealInfo;
@property (nonatomic, strong) NSArray *mealDishArray;
@end

@implementation XCFMealViewController

static NSString * const reuseIdentifier = @"mealDishCell";
static NSString * const headerIdentifier = @"mealHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self loadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.mealDishArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XCFMealDishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.dish = self.mealDishArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reuseView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XCFMealHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                   withReuseIdentifier:headerIdentifier
                                                                          forIndexPath:indexPath];
        header.mealInfo = self.mealInfo;
        reuseView = header;
    }
    return reuseView;
}


#pragma mark - 事件处理
- (void)uploadMyDish {
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:[[XCFUploadDishViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    [self.navigationController presentViewController:navCon animated:YES completion:nil];
}


#pragma mark - 属性

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((XCFScreenWidth-5)*0.5, 300);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.headerReferenceSize = CGSizeMake(XCFScreenWidth, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = XCFGlobalBackgroundColor;
        [self.view addSubview:_collectionView];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFMealDishCell class]) bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFMealHeader class]) bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:headerIdentifier];
    }
    return _collectionView;
}

- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    NSMutableString *displayTitle = [NSMutableString stringWithString:self.mealInfo.name];
    [displayTitle deleteCharactersInRange:NSMakeRange(3, 5)];
    titleLabel.text = displayTitle;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView);
        make.top.equalTo(titleView);
    }];
    UILabel *dishCountLabel = [[UILabel alloc] init];
    dishCountLabel.font = [UIFont systemFontOfSize:11];
    dishCountLabel.textColor = [UIColor lightGrayColor];
    dishCountLabel.text = [NSString stringWithFormat:@"%@作品", self.mealInfo.n_dishes];
    [titleView addSubview:dishCountLabel];
    [dishCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
    }];
    self.navigationItem.titleView = titleView;
}

- (void)setupBottomView {
    NSString *displayTitle = [NSString stringWithFormat:@"上传我做的%@", [self.mealInfo.name substringToIndex:2]];
    UIButton *uploadMyDishButton = [UIButton buttonWithBackgroundColor:XCFThemeColor
                                                                 title:displayTitle
                                                        titleLabelFont:[UIFont systemFontOfSize:14]
                                                            titleColor:XCFLabelColorWhite
                                                                target:self action:@selector(uploadMyDish)
                                                         clipsToBounds:YES];
    [self.view insertSubview:uploadMyDishButton aboveSubview:self.collectionView];
    [uploadMyDishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.bottom.equalTo(self.view).offset(-5);
        make.size.mas_equalTo(CGSizeMake(XCFScreenWidth-10, 44));
    }];
}


#pragma mark - 网络请求

- (void)loadData {
    [[AFHTTPSessionManager manager] GET:XCFRequestKitchenBreakfast
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    self.mealInfo = [XCFMealInfo mj_objectWithKeyValues:responseObject[@"content"][@"event"]];
                                    [self setupTitleView];
                                    [self setupBottomView];
                                    [self.collectionView reloadData];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                }];
    
    // XCFRequestKitchenBreakfastDishes 如果没有数据请重新抓取接口
    [[AFHTTPSessionManager manager] GET:XCFRequestKitchenBreakfastDishes
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    self.mealDishArray = [XCFDish mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"dishes"]];
                                    if (!self.mealDishArray.count) [UILabel showStats:@"接口已经失效，请重新抓取！" atView:self.view];
                                    [self.collectionView reloadData];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                }];
}

@end



