//
//  XCFDishViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/10.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDishViewController.h"
#import "XCFDishViewCell.h"

#import "XCFDish.h"
#import "XCFPicture.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface XCFDishViewController ()

@end

@implementation XCFDishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    if (!self.dish) { // 如果没有数据就发送网络请求
        [[AFHTTPSessionManager manager] GET:XCFRequestKitchenDish
                                 parameters:nil
                                   progress:nil
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.dish = [XCFDish mj_objectWithKeyValues:responseObject[@"content"][@"dish"]];
            [self setupHeader];
            self.title = self.dish.name;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }];
    }
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFDishViewCell class]) bundle:nil] forCellReuseIdentifier:@"dishViewCell"];
}

- (void)setupHeader {
    
    XCFDishViewCell *dishView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFDishViewCell class])
                                                                       owner:self options:nil] lastObject];
    dishView.frame = CGRectMake(0, 0, XCFScreenWidth, self.dish.dishCellHeight + self.dish.commentViewHeight);
    
    NSMutableArray *imageArray = [NSMutableArray array];
    if (self.dish) [imageArray addObject:self.dish.main_pic];
    if (self.dish.extra_pics.count) {
        NSArray *extraPicArray = [XCFPicture mj_objectArrayWithKeyValuesArray:self.dish.extra_pics];
        [imageArray addObjectsFromArray:extraPicArray];
    }
    dishView.dish = self.dish;
    dishView.imageArray = imageArray;
    self.tableView.tableHeaderView = dishView;
}

- (void)setDish:(XCFDish *)dish {
    _dish = dish;
    self.title = self.dish.name;
    [self setupHeader];
}


#pragma mark - 事件处理

- (void)share {
    
}

@end
