//
//  XCFGoodsAttrsViewCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsAttrsViewCell.h"
#import "XCFGoodsAttrs.h"
#import "XCFAttrsCell.h"

@interface XCFGoodsAttrsViewCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XCFGoodsAttrsViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = XCFGlobalBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XCFAttrsCell class] forCellReuseIdentifier:@"attrsCell"];
        [self.contentView addSubview:_tableView];
        _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.attrsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCFAttrsCell *attrsCell = [tableView dequeueReusableCellWithIdentifier:@"attrsCell"];
    if (!attrsCell) {
        attrsCell = [[XCFAttrsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"attrsCell"];
    }
    if (self.attrsArray.count) attrsCell.attrs = self.attrsArray[indexPath.row];
    return attrsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.attrsArray.count) return [self.attrsArray[indexPath.row] cellHeight] + 10;
    return 0;
}

- (void)setAttrsArray:(NSArray *)attrsArray {
    _attrsArray = attrsArray;
    
    [self.tableView reloadData];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
        if (scrollView.contentOffset.y < -100) !self.viewWillDismissBlock ? : self.viewWillDismissBlock();
}

@end
