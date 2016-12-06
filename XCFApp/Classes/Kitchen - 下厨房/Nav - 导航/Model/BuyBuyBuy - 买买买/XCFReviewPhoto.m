//
//  XCFReviewPhoto.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFReviewPhoto.h"

@implementation XCFReviewPhoto

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_url forKey:@"url"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.url = [decoder decodeObjectForKey:@"url"];
    }
    return self;
}
@end
