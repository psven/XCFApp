//
//  XCFMeController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMeController.h"
#import "XCFSettingViewController.h"
#import "XCFMyViewHeader.h"
#import "XCFAuthorDetail.h"
#import "XCFDish.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface XCFMeController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@property (nonatomic, strong) NSMutableArray *authorDishArray;
@end

@implementation XCFMeController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self setupNavigationBar];
    [self setupCollectionView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authorDetail = [XCFMyInfo info];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.authorDishArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    NSInteger tag = 555;
    UIImageView *imageView = [cell viewWithTag:tag];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.frame = cell.contentView.bounds;
        imageView.tag = tag;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
    }
    NSString *imageURL = [self.authorDishArray[indexPath.item] photo60];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reuseView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XCFMyViewHeader *infoView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                       withReuseIdentifier:@"MyInfoHeader" forIndexPath:indexPath];
//        self.authorDetail.type = XCFAuthorTypeOther;
        infoView.authorDetail = self.authorDetail;
        reuseView = infoView;
    }
    return reuseView;
}


#pragma mark - 网络请求
- (void)loadData {
    if (!self.authorDetail) {
        [[AFHTTPSessionManager manager] GET:XCFAuthorInfo
                                 parameters:nil
                                   progress:nil
                                    success:^(NSURLSessionDataTask * _Nonnull task,
                                              id  _Nullable responseObject) {
                                        self.authorDetail = [XCFAuthorDetail mj_objectWithKeyValues:responseObject[@"content"]];
                                        [self.collectionView reloadData];
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    }];
    }
    
    [[AFHTTPSessionManager manager] GET:XCFAuthorDish
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task,
                                          id  _Nullable responseObject) {
                                    self.authorDishArray = [XCFDish mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"dishes"]];
                                    [self.collectionView reloadData];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                }];
}

#pragma mark - 属性
- (void)setupNavigationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navFindFriendsImage"
                                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                 target:self
                                                                                 action:@selector(findFriends)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"rightPageSetting"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
                                                                                  target:self
                                                                                  action:@selector(setting)];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((XCFScreenWidth-10)/3, (XCFScreenWidth-10)/3);
    flowLayout.headerReferenceSize = CGSizeMake(XCFScreenWidth, self.authorDetail.headerHeight+40);
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 2;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = XCFGlobalBackgroundColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentSize = self.view.bounds.size;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class]
        forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[XCFMyViewHeader class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"MyInfoHeader"];
}

- (NSMutableArray *)authorDishArray {
    if (!_authorDishArray) {
        _authorDishArray = [NSMutableArray array];
    }
    return _authorDishArray;
}

- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}

#pragma mark - 点击事件
- (void)findFriends {

}

- (void)setting {
    [self.navigationController pushViewController:[[XCFSettingViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}


@end
