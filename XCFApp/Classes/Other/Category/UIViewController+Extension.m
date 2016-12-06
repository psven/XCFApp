//
//  UIViewController+Extension.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)pushWebViewWithURL:(NSString *)URL {
    UIViewController *viewCon = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:viewCon.view.bounds];
    webView.backgroundColor = XCFGlobalBackgroundColor;
    [viewCon.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [webView loadRequest:request];
    [self.navigationController pushViewController:viewCon animated:YES];
}

@end
