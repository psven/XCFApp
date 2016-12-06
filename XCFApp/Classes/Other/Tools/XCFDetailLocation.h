//
//  XCFDetailLocation.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFDetailCity;

@interface XCFDetailLocation : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, strong) NSArray *citylist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailLocationWithDict:(NSDictionary *)dict;

@end
