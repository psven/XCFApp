//
//  UIButton+Extension.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/6.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  快速创建独家图标
 */
+ (UIButton *)exclusiveButton;


/**
 *  快速创建一个button
 */
+ (UIButton *)buttonWithBackgroundColor:(UIColor *)backgroundColor
                                  title:(NSString *)title
                         titleLabelFont:(UIFont *)font
                             titleColor:(UIColor *)titleColor
                                 target:(id)target
                                 action:(SEL)action
                          clipsToBounds:(BOOL)clipsToBounds;

/**
 *  快速创建一个带边框的button
 */
+ (UIButton *)borderButtonWithBackgroundColor:(UIColor *)backgroundColor
                                        title:(NSString *)title
                               titleLabelFont:(UIFont *)font
                                   titleColor:(UIColor *)titleColor
                                       target:(id)target
                                       action:(SEL)action
                                clipsToBounds:(BOOL)clipsToBounds;

@end
