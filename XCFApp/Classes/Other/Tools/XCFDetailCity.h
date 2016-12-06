//
//  XCFDetailCity.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFDetailArea;

@interface XCFDetailCity : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSArray *arealist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailCityWithDict:(NSDictionary *)dict;

@end
