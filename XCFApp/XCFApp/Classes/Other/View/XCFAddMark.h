//
//  XCFAddMark.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

// 添加按钮
#import <UIKit/UIKit.h>

@interface XCFAddMark : UIView

@property (nonatomic, strong, nullable) NSString *title;
// 简介
+ (nonnull instancetype)summaryMarkWithTarget:(nullable id)target
                                       action:(nullable SEL)action;
// 用料
+ (nonnull instancetype)ingredientMarkWithTarget:(nullable id)target
                                          action:(nullable SEL)action;
// 小贴士
+ (nonnull instancetype)tipsMarkWithTarget:(nullable id)target
                                    action:(nullable SEL)action;
// 步骤
+ (nonnull instancetype)instructionMarkWithTarget:(nullable id)target
                                           action:(nullable SEL)action;
+ (nonnull instancetype)addMarkWithTitle:(nullable NSString *)title
                          Target:(nullable id)target
                          action:(nullable SEL)action;

@end
