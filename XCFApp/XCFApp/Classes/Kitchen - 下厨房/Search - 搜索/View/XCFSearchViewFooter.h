//
//  XCFSearchViewFooter.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFSearchViewFooter : UIView
@property (nonatomic, strong) NSArray *keywords;                // 流行搜索
@property (nonatomic, copy) void (^searchCallBack)(NSUInteger); // 点击按钮的搜索回调
@end
