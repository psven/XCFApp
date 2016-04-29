//
//  XCFTopNavImageView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFTopNavImageView : UIImageView

+ (nonnull XCFTopNavImageView *)imageViewWithTitle:(nonnull NSString *)title
                                            target:(nullable id)target
                                            action:(nullable SEL)action;

@end
