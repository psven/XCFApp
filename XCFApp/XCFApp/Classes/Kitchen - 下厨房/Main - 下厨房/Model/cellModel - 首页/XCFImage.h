//
//  XCFImage.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFImage : NSObject

/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;

@end
