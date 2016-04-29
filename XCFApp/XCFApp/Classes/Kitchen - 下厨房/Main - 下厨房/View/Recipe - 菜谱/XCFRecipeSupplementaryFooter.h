//
//  XCFRecipeSupplementaryFooter.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFRecipeSupplementaryFooter : UITableViewHeaderFooterView

/** 上传按钮点击block */
@property (nonatomic, copy) void (^uploadButtonClickedBlock)();

@end
