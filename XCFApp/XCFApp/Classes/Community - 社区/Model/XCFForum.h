//
//  XCFForum.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFAuthor;

@interface XCFForum : NSObject
@property (nonatomic, strong) NSArray<XCFAuthor *> *latest_authors; // 最后发表主题的作者
@property (nonatomic, copy) NSString *name; // 社区名称
@property (nonatomic, copy) NSString *desc; // 最后主题的内容
@end
