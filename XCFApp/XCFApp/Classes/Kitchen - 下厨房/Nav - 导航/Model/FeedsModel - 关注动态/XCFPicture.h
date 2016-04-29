//
//  XCFPicture.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFPicture : NSObject

/** 大图片（尺寸600）*/
@property (nonatomic, copy) NSString *bigPhoto;
/** 小图片（尺寸280）*/
@property (nonatomic, copy) NSString *smallPhoto;
/** 标识 */
@property (nonatomic, copy) NSString *ident;

@end
