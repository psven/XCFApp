//
//  XCFReviewPhoto.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFReviewPhoto : NSObject <NSCoding>
/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 标识 */
@property (nonatomic, copy) NSString *ident;
@end
