//
//  XCFMyInfo.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthorDetail;

@interface XCFMyInfo : NSObject

+ (XCFAuthorDetail *)info;
+ (void)updateInfoWithNewInfo:(XCFAuthorDetail *)info;

@end
