//
//  XCFNavButton.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//


#import <UIKit/UIKit.h>
@class XCFNav;

@interface XCFNavButton : UIButton

+ (nonnull XCFNavButton *)buttonWithNav:(nonnull XCFNav *)nav
                                 target:(nullable id)target
                                 action:(nullable SEL)action;
+ (nonnull XCFNavButton *)buttonWithImageName:(nonnull NSString *)imageName
                                        title:(nonnull NSString *)title
                                       target:(nullable id)target
                                       action:(nullable SEL)action;

@end
