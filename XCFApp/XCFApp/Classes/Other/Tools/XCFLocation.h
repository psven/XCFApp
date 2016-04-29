//
//  XCFLocation.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFCity;

@interface XCFLocation : NSObject
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, strong) NSArray<XCFCity *> *cities;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)locationWithDict:(NSDictionary *)dict;

@end
