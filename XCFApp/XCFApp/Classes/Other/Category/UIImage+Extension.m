//
//  UIImage+Extension.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)circleImage {
    
    // 1. 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 2. 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3. 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 4. 裁剪
    CGContextClip(ctx);
    // 5. 画上图片
    [self drawInRect:rect];
    // 6. 取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 7. 终止上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
