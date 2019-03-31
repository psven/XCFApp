//
//  XCFBazaarController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFBazaarController.h"
#import "XCFCartViewController.h"
#import "XCFCartItemTool.h"


@interface XCFBazaarController () <UIWebViewDelegate>

@end

@implementation XCFBazaarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
//    [UILabel showStats:@"没有接口。。" atView:self.view];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    webView.delegate = self;
//    webView.backgroundColor = XCFGlobalBackgroundColor;
//    [self.view addSubview:webView];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.xiachufang.com/page/ec-tab/?version=12"]];
//    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}


- (void)setupNavigationBar {
//    self.navigationItem.titleView = [XCFSearchBar searchBarWithPlaceholder:@"搜索商品"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"leftPageButtonBackgroundNormal"
                                                                        imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                 target:self
                                                                                 action:@selector(leftPage)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem shoppingCartIconWithTarget:self
                                                                                  action:@selector(goToShoppingCart)];
}

- (void)leftPage {

}

- (void)goToShoppingCart {
    [self.navigationController pushViewController:[[XCFCartViewController alloc] init] animated:YES];
}

@end
