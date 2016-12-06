//
//  XCFImageShowView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFImageShowView.h"

#import "XCFPicture.h"
#import "XCFReviewPhoto.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>


@interface XCFImageShowView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;     // 图片轮播
@property (nonatomic, strong) UILabel *pageLabel;                   // 图片下标
@end


@implementation XCFImageShowView

static NSString *const imageCellIdentifier = @"imageCell";

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (self.imageArray.count) return self.imageArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier
                                                                           forIndexPath:indexPath];
    
    NSInteger tag = 3;
    UIImageView *imageView = [cell.contentView viewWithTag:tag];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = tag;
        [cell.contentView addSubview:imageView];
    }
    
    if (self.imageArray.count) {
        // 作品界面
        if (self.type == XCFShowViewTypeDish) {
            XCFPicture *imageData = self.imageArray[indexPath.row];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageData.bigPhoto]];
            
        }
        // 评价晒图、商品、图片展示界面
        else if (self.type == XCFShowViewTypeReview || self.type == XCFShowViewTypeGoods || self.type == XCFShowViewTypeDetail) {
            XCFReviewPhoto *photo = self.imageArray[indexPath.row];
            [imageView sd_setImageWithURL:[NSURL URLWithString:photo.url]];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 传递下标 图片相对window的frame 到控制器
    CGRect currentRect = [self convertRect:self.bounds toView:nil];
    !self.showImageBlock ? : self.showImageBlock(indexPath.item, currentRect);
    
}

+ (instancetype)imageShowViewWithShowImageBlock:(ShowImageBlock)block {
    XCFImageShowView *view = [[XCFImageShowView alloc] init];
    view.showImageBlock = block;
    return view;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + self.collectionView.frame.size.width*0.5) / self.collectionView.frame.size.width;
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", index+1, self.imageArray.count];
}

// scrollView停止滚动后记录contentOffset.x
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    !self.imageViewDidScrolledBlock ? : self.imageViewDidScrolledBlock(scrollView.contentOffset.x);
}


#pragma mark - 构造方法

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [self.collectionView reloadData];
    self.pageLabel.hidden = YES;
    if (imageArray.count > 1) {
        self.pageLabel.hidden = NO;
        self.pageLabel.text = [NSString stringWithFormat:@"1/%zd", imageArray.count];
    }
}

- (void)setImageViewCurrentLocation:(CGFloat)imageViewCurrentLocation {
    _imageViewCurrentLocation = imageViewCurrentLocation;
    
    // 恢复显示collectionView滚动的位置
    [self.collectionView setContentOffset:CGPointMake(imageViewCurrentLocation, 0)];

    // 恢复显示pageLabel的下标
    if (!self.pageLabel.hidden && self.imageArray.count) {
        NSInteger currentIndex = imageViewCurrentLocation / self.collectionView.frame.size.width + 1;
        self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", currentIndex, self.imageArray.count];
    }
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
    // 恢复显示collectionView滚动的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    // 恢复显示pageLabel的下标
    if (!self.pageLabel.hidden && self.imageArray.count) {
        self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", currentIndex+1, self.imageArray.count];
    }
}

- (void)setType:(XCFShowViewType)type {
    _type = type;
    if (type == XCFShowViewTypeDetail) {
        self.collectionView.backgroundColor = [UIColor clearColor];
//        self.pageLabel.frame = CGRectMake(XCFScreenWidth-35, 600, 25, 25);
//        self.pageLabel.font = [UIFont systemFontOfSize:14];
//        self.pageLabel.backgroundColor = [UIColor clearColor];
//        self.pageLabel.textColor = XCFLabelColorWhite;
    }
}


#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(XCFScreenWidth, 350);
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 350) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:imageCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(XCFScreenWidth-35, 315, 25, 25)];
        _pageLabel.font = [UIFont systemFontOfSize:12];
        _pageLabel.layer.cornerRadius = 12;
        _pageLabel.clipsToBounds = YES;
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pageLabel];
    }
    return _pageLabel;
}


@end
