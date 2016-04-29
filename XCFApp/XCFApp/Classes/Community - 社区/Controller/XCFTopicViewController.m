//
//  XCFTopicViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopicViewController.h"
#import "XCFTopicDetailController.h"

#import "XCFTopicCell.h"
#import "XCFTopic.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface XCFTopicViewController ()
@property (nonatomic, strong) NSMutableArray *topicArray;
@end

@implementation XCFTopicViewController

static NSString *const reuseIdentifier = @"topicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"发主题"
                                                                              target:self
                                                                              action:@selector(publishTopic)];
    [self setupTableView];
    [self loadNewData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.topic = self.topicArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFTopicDetailController *topicVC = [[XCFTopicDetailController alloc] init];
    topicVC.topic = self.topicArray[indexPath.row];
    [self.navigationController pushViewController:topicVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.topicArray[indexPath.row] cellHeight];
}


#pragma mark - 网络请求

- (void)loadNewData {
    [[AFHTTPSessionManager manager] GET:XCFRequestTopic
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    self.topicArray = [XCFTopic mj_objectArrayWithKeyValuesArray:responseObject[@"content"][@"topics"]];
                                    [self.tableView reloadData];
                                    [self.tableView.mj_header endRefreshing];
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    [self.tableView.mj_header endRefreshing];
                                }];
}


#pragma mark - 属性

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = XCFGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFTopicCell class]) bundle:nil]
         forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewData)];
}

- (NSMutableArray *)topicArray {
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}

- (void)publishTopic {
    
}

@end
