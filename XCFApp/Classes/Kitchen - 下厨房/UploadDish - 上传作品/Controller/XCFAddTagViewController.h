//
//  XCFAddTagViewController.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFAddTagViewController : UIViewController
@property (nonatomic, copy) void (^callBack)(NSString *); // 返回编辑好的标签文字
@end
