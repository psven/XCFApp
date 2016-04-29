//
//  XCFAuthor.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/3.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAuthor.h"
#import "XCFAuthorDetail.h"

@implementation XCFAuthor

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name    forKey:@"name"];
    [aCoder encodeObject:_image   forKey:@"image"];
    [aCoder encodeObject:_photo   forKey:@"photo"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name    = [decoder decodeObjectForKey:@"name"];
        self.image   = [decoder decodeObjectForKey:@"image"];
        self.photo   = [decoder decodeObjectForKey:@"photo"];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (instancetype)me {
    XCFAuthor *me = [[XCFAuthor alloc] init];
    XCFAuthorDetail *meDetail = [XCFMyInfo info];
    me.name = meDetail.name;
    me.image = meDetail.image;
    return me;
}

@end
