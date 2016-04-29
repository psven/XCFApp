//
//  XCFGoodsImageTextView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsImageTextView.h"
#import "XCFGoodsAttrsViewCell.h"
#import "XCFGoods.h"


@interface XCFGoodsImageTextView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIView            *navView;           // 导航view
@property (nonatomic, strong) UIButton          *detailButton;      // 详情btn
@property (nonatomic, strong) UIButton          *attrsButton;       // 规格btn
@property (nonatomic, strong) UIView            *indexView;         // 下标view
@property (nonatomic, strong) UICollectionView  *collectionView;    // 主体
@property (nonatomic, assign) NSInteger         index;              // 当前下标
@end

@implementation XCFGoodsImageTextView

static NSString * const detailCellIdentifier = @"detailCell";
static NSString * const attrsCellIdentifier = @"attrsCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat navViewWidth = self.bounds.size.width;
        CGFloat navViewHeight = 44;
        // 导航
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, navViewWidth, navViewHeight)];
        [self addSubview:_navView];
        
        
        // 详情
        _detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, navViewWidth*0.5, navViewHeight)];
        _detailButton.backgroundColor = XCFDishViewBackgroundColor;
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_detailButton setTitle:@"详情" forState:UIControlStateNormal];
        [_detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_detailButton setTitleColor:XCFThemeColor forState:UIControlStateSelected];
        [self.navView addSubview:_detailButton];
        _detailButton.selected = YES;
        [_detailButton addTarget:self action:@selector(scrollToDetailView) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 规格
        _attrsButton = [[UIButton alloc] initWithFrame:CGRectMake(navViewWidth*0.5, 0, navViewWidth*0.5, navViewHeight)];
        _attrsButton.backgroundColor = XCFDishViewBackgroundColor;
        _attrsButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_attrsButton setTitle:@"规格" forState:UIControlStateNormal];
        [_attrsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_attrsButton setTitleColor:XCFThemeColor forState:UIControlStateSelected];
        [self.navView addSubview:_attrsButton];
        [_attrsButton addTarget:self action:@selector(scrollToAttrsView) forControlEvents:UIControlEventTouchUpInside];
        
        // 下标
        _indexView = [[UIView alloc] initWithFrame:CGRectMake(0, navViewHeight-2, navViewWidth*0.5, 2)];
        _indexView.backgroundColor = XCFThemeColor;
        [self.navView addSubview:_indexView];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height-44);
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, self.bounds.size.width, self.bounds.size.height-44) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:detailCellIdentifier];
        [_collectionView registerClass:[XCFGoodsAttrsViewCell class] forCellWithReuseIdentifier:attrsCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = XCFGlobalBackgroundColor;
        [self addSubview:_collectionView];
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    if (indexPath.row == 0) { // 详情
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailCellIdentifier forIndexPath:indexPath];
        NSInteger tag = 111;
        UIWebView *webView = [cell.contentView viewWithTag:tag];
        if (!webView) {
            webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  cell.contentView.bounds.size.width,
                                                                  cell.contentView.bounds.size.height-44)];
            webView.backgroundColor = XCFGlobalBackgroundColor;
            webView.tag = tag;
            webView.scrollView.delegate = self;
            [cell.contentView addSubview:webView];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.goods.img_txt_detail_url]];
            [webView loadRequest:request];
        }
        
    } else if (indexPath.row == 1) { // 属性
        XCFGoodsAttrsViewCell *attrsCell = [collectionView dequeueReusableCellWithReuseIdentifier:attrsCellIdentifier forIndexPath:indexPath];
        attrsCell.attrsArray = self.goods.attrs;
        attrsCell.viewWillDismissBlock = self.viewWillDismissBlock; // 传递block
        cell = attrsCell;
    }
    return  cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([scrollView.superview isKindOfClass:[UIWebView class]]) {
        if (scrollView.contentOffset.y < -100) !self.viewWillDismissBlock ? : self.viewWillDismissBlock();
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView.superview isKindOfClass:[self class]]) {    // collectionView
        CGFloat width = self.collectionView.frame.size.width;
        NSInteger index = scrollView.contentOffset.x / width;
        [self refreshNavViewByIndex:index];
    }
}

#pragma mark - 事件处理
- (void)scrollToDetailView {
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self refreshNavViewByIndex:0];
}

- (void)scrollToAttrsView {
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width, 0) animated:YES];
    [self refreshNavViewByIndex:1];
}

- (void)refreshNavViewByIndex:(NSInteger)index {
    CGFloat width = self.collectionView.frame.size.width;
    if (index == 0) {
        self.detailButton.selected = YES;
        self.attrsButton.selected = NO;
    } else if (index == 1) {
        self.detailButton.selected = NO;
        self.attrsButton.selected = YES;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.indexView.transform = CGAffineTransformMakeTranslation(index * width*0.5, 0);
    }];
}

- (void)setGoods:(XCFGoods *)goods {
    _goods = goods;
    [self.collectionView reloadData];
}

@end
