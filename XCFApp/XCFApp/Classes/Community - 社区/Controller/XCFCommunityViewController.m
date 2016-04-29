//
//  XCFCommunityViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCommunityViewController.h"
#import "XCFTopicViewController.h"
#import "XCFForumViewCell.h"
#import "XCFForum.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface XCFCommunityViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XCFForum *forums; // 市集讨论区
@property (nonatomic, strong) XCFForum *shouts; // 周边

@end

@implementation XCFCommunityViewController

static NSString *const reuseIdentifier = @"forumCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonRightItemWithImageName:@"notification" target:self action:@selector(notification)];
    [self setupTableView];
    [self addFeedbackButton];
    [self loadNewData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFForumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (indexPath.row == 0) cell.forum = self.forums;
    if (indexPath.row == 1) cell.forum = self.shouts;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[XCFTopicViewController alloc] init] animated:YES];
    }
}


#pragma mark - 网络请求

- (void)loadNewData {
    [[AFHTTPSessionManager manager] GET:XCFRequestCommunity
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    self.forums = [XCFForum mj_objectWithKeyValues:responseObject[@"content"][@"forums"][0]];
                                    self.shouts = [XCFForum mj_objectWithKeyValues:responseObject[@"content"][@"shouts"]];
                                    [self.tableView reloadData];
                                    [self.tableView.mj_header endRefreshing];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_header endRefreshing];
                                }];
}


#pragma mark - 属性

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = XCFGlobalBackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 80;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFForumViewCell class]) bundle:nil]
    forCellReuseIdentifier:reuseIdentifier];
    self.tableView = tableView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
}

- (void)addFeedbackButton {
    UIButton *feedbackButton = [UIButton buttonWithBackgroundColor:XCFGlobalBackgroundColor
                                                             title:@"意见反馈"
                                                    titleLabelFont:[UIFont systemFontOfSize:12]
                                                        titleColor:XCFLabelColorGray
                                                            target:self action:@selector(feedback) clipsToBounds:NO];
    CGFloat width = 60;
    CGFloat height = 30;
    CGFloat x = (XCFScreenWidth-width) * 0.5;
    CGFloat y = XCFScreenHeight - 85;
    feedbackButton.frame = CGRectMake(x, y, width, height);
    [self.view insertSubview:feedbackButton aboveSubview:self.tableView];
}


#pragma mark - 事件处理

- (void)feedback {
    
}

- (void)notification {

}


@end
