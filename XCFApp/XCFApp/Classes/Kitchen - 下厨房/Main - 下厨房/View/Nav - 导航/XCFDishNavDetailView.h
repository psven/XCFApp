//
//  XCFDishNavDetailView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFPopEvent;

@interface XCFDishNavDetailView : UIView

@property (nonatomic, strong) XCFPopEvent *popEvent;

+ (nonnull XCFDishNavDetailView *)viewWithPopEvent:(nonnull XCFPopEvent *)popEvent
                                            target:(nullable id)target
                                            action:(nullable SEL)action;

@end
