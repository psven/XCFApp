//
//  XCFKitchenHeader.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFKitchenHeader.h"
#import "XCFTopNavImageView.h"
#import "XCFNavButton.h"
#import "XCFDishNavDetailView.h"

#import "XCFNavContent.h"
#import "XCFDish.h"
#import "XCFPopEvents.h"
#import "XCFPopEvent.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XCFKitchenHeader () <UIScrollViewDelegate>

/** 流行菜谱 */
@property (nonatomic, strong) XCFTopNavImageView *popRecipeView;
/** 关注动态 */
@property (nonatomic, strong) XCFTopNavImageView *feedsView;
/** 导航按钮view */
@property (nonatomic, strong) UIView *navButtonView;
/** 餐导航view */
@property (nonatomic, strong) UIView *dishNavView;
/** scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 指示器 */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 个数 */
@property (nonatomic, assign) NSInteger count;

@end

@implementation XCFKitchenHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        // 流行菜谱
        _popRecipeView = [XCFTopNavImageView imageViewWithTitle:@"流行菜谱"
                                                         target:self
                                                         action:@selector(popDidClicked)];
        [self addSubview:_popRecipeView];
        [_popRecipeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self.mas_width).offset(-0.5).multipliedBy(0.5);
            make.height.equalTo(@(XCFKitchenViewHeightTopNav));
        }];
        
        
        // 关注动态
        _feedsView = [XCFTopNavImageView imageViewWithTitle:@"我的作品"
                                                     target:self
                                                     action:@selector(feedsDidClicked)];
        [self addSubview:_feedsView];
        [_feedsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.popRecipeView);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(self.popRecipeView);
            make.width.equalTo(self.popRecipeView);
        }];
        
        
        // 导航按钮view
        _navButtonView = [[UIView alloc] init];
        [self addSubview:_navButtonView];
        [_navButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.popRecipeView.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(XCFKitchenViewHeightNavButton));
        }];
        
        
        // 餐导航
        _dishNavView = [[UIView alloc] init];
        [self addSubview:_dishNavView];
        [_dishNavView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navButtonView.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(@(XCFKitchenViewHeightNavButton1));
        }];
        
        
        // scrollView
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        [self.dishNavView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.dishNavView);
        }];
        
        
        // 餐导航指示器
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = XCFThemeColor;
        [self.dishNavView addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.dishNavView);
            make.centerY.equalTo(self.dishNavView.mas_bottom).offset(-10);
        }];
        
        UIButton *createButton = [UIButton new];
        createButton.layer.borderColor = XCFGlobalBackgroundColor.CGColor;
        createButton.layer.borderWidth = 0.5;
        [createButton setTitle:@"创建我的菜谱" forState:UIControlStateNormal];
        [createButton setTitleColor:XCFThemeColor forState:UIControlStateNormal];
        createButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        createButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        createButton.backgroundColor = [UIColor whiteColor];
        [createButton addTarget:self action:@selector(createRecipe) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:createButton];
        [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dishNavView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(XCFKitchenViewHeightCreateButton);
        }];
    }
    return self;
}

#pragma mark - 传入模型
- (void)setNavContent:(XCFNavContent *)navContent {
    _navContent = navContent;
    
    
    // 流行菜谱图片
    [self.popRecipeView sd_setImageWithURL:[NSURL URLWithString:navContent.pop_recipe_picurl]];
    
    XCFPopEvents *popEvents = navContent.pop_events;
    XCFPopEvent *event = popEvents.events[0];
    [self.feedsView sd_setImageWithURL:[NSURL URLWithString:event.thumbnail_280]];
    
    
    // 添加4个导航按钮
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat buttonWidth = self.navButtonView.frame.size.width / 2;
    CGFloat buttonHeight = self.navButtonView.frame.size.height / 2;
    for (NSInteger index = 0; index<navContent.navs.count; index++) {
        XCFNavButton *button = [XCFNavButton buttonWithNav:navContent.navs[index]
                                                    target:self
                                                    action:@selector(buttonDidClicked:)];
        x = index % 2 * buttonWidth;
        y = index / 2 * buttonHeight;
        button.frame = CGRectMake(x, y, buttonWidth, buttonHeight);
        button.tag = index + 2;
        [self.navButtonView addSubview:button];
    }
    
    
    // 添加餐导航图片
    self.count = popEvents.count;
    y = 0;
    
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewheight = self.scrollView.frame.size.height;
    for (NSInteger index = 0; index<popEvents.count; index++) {
        XCFDishNavDetailView *detailView = [XCFDishNavDetailView viewWithPopEvent:popEvents.events[index]
                                                                           target:self
                                                                           action:@selector(viewDidClicked:)];
        x = index * scrollViewWidth;
        detailView.frame = CGRectMake(x, y, scrollViewWidth, scrollViewheight);
        detailView.tag = index + 6;
        [self.scrollView addSubview:detailView];
    }
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth * popEvents.count, 0);
    self.pageControl.numberOfPages = popEvents.count;
    
}

/**
 *  接收模型设置关注动态图片
 */
- (void)setDish:(XCFDish *)dish {
    _dish = dish;
    [self.feedsView sd_setImageWithURL:[NSURL URLWithString:dish.thumbnail]];
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.scrollView.frame.size.width;
    self.pageControl.currentPage = (scrollView.contentOffset.x + width * 0.5) / width;
}

#pragma mark - 事件处理

- (void)createRecipe {
    !self.clickBlock ? : self.clickBlock(viewDidClickedActionCreate);
    
}

/**
 *  流行菜谱点击事件
 */
- (void)popDidClicked {
    !self.clickBlock ? : self.clickBlock(viewDidClickedActionPopRecipeView);
}

/**
 *  关注动态点击事件
 */
- (void)feedsDidClicked {
    !self.clickBlock ? : self.clickBlock(viewDidClickedActionFeedsView);
}

/**
 *  导航按钮点击事件
 *
 *  @param sender 导航按钮（XCFNavButton）
 */
- (void)buttonDidClicked:(XCFNavButton *)sender {
    !self.clickBlock ? : self.clickBlock(sender.tag);
}

/**
 *  点击view调用此方法
 *
 *  @param sender UITapGestureRecognizer实例对象，非view
 */
- (void)viewDidClicked:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    !self.clickBlock ? : self.clickBlock(tap.view.tag);
}


@end
