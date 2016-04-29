//
//  XCFTabBarController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTabBarController.h"
#import "XCFNavigationController.h"

#import "XCFKitchenViewController.h"
#import "XCFBazaarController.h"
#import "XCFCommunityViewController.h"
#import "XCFMeController.h"

@interface XCFTabBarController ()

@end

@implementation XCFTabBarController

+ (void)initialize {
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = XCFTabBarNormalColor;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = XCFThemeColor;
    
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [self setupChildViewController:[[XCFKitchenViewController alloc] initWithStyle:UITableViewStyleGrouped]
                             title:@"下厨房"
                             image:@"tabADeselected"
                     selectedImage:@"tabASelected"];
    [self setupChildViewController:[[XCFBazaarController alloc] init]
                             title:@"市集"
                             image:@"tabBDeselected"
                     selectedImage:@"tabBSelected"];
    [self setupChildViewController:[[XCFCommunityViewController alloc] init]
                             title:@"社区"
                             image:@"tabCDeselected"
                     selectedImage:@"tabCSelected"];
    [self setupChildViewController:[[XCFMeController alloc] init]
                             title:@"我"
                             image:@"tabDDeselected"
                     selectedImage:@"tabDSelected"];
}

- (void)setupChildViewController:(UIViewController *)childController
                           title:(NSString *)title
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    childController.title = title;
    [childController.tabBarItem setImage:[UIImage imageNamed:image]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    XCFNavigationController *navCon = [[XCFNavigationController alloc] initWithRootViewController:childController];
    navCon.title = title;
    
    [self addChildViewController:navCon];
}


@end
