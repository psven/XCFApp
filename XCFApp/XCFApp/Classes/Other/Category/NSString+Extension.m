//
//  NSString+Extension.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)getSizeWithTextSize:(CGSize)size fontSize:(CGFloat)fontSize {
    CGSize resultSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                           context:nil].size;
    return resultSize;
}

@end
