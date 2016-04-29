//
//  XCFProfileEditingHeader.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFProfileEditingHeader : UIView
@property (nonatomic, strong) UIImage *displayImage;
@property (nonatomic, copy) void (^uploadIconBlock)();
@end
