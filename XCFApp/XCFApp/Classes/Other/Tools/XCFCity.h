//
//  XCFCity.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCFCity : NSObject
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *city_id;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
