//
//  XCFDishViewController.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/10.
//  Copyright © 2016年 Joey. All rights reserved.
//


#import <UIKit/UIKit.h>
@class XCFDish;

@interface XCFDishViewController : UITableViewController
/** 模型数据 */
@property (nonatomic, strong) XCFDish *dish;

@end
