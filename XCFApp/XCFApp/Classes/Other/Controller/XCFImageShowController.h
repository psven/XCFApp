//
//  XCFImageShowController.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/28.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFImageShowController : UIViewController

@property (nonatomic, assign) NSUInteger imageIndex;    // 图片下标
@property (nonatomic, strong) NSArray *imageArray;      // 图片数据
@property (nonatomic, strong) NSValue *rectValue;       // frame
/** cell滚动回调 */
@property (nonatomic, copy) void (^imageViewDidScrolledBlock)(CGFloat);


@end
