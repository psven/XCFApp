//
//  XCFDetailArea.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFDetailArea : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *areaName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailAreaWithDict:(NSDictionary *)dict;

@end
