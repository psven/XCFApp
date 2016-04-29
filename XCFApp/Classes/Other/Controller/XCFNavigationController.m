//
//  XCFNavigationController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFNavigationController.h"

@interface XCFNavigationController ()

@end

@implementation XCFNavigationController

+ (void)initialize {
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    attrs[NSForegroundColorAttributeName] = XCFThemeColor;
//    
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    [appearance setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 替换back按钮
        UIBarButtonItem *backBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"backStretchBackgroundNormal"
                                                                           imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                    target:self
                                                                                    action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
