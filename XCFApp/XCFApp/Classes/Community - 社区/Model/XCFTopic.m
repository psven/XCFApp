//
//  XCFTopic.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopic.h"

@implementation XCFTopic

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (CGFloat)cellHeight {
    CGFloat contentHeight = [self.content getSizeWithTextSize:CGSizeMake(XCFScreenWidth-80, MAXFLOAT) fontSize:15].height;
    if (contentHeight > 20 || self.is_sticked) {
        _cellHeight = 110;
    } else {
        _cellHeight = 90;
    }
    return  _cellHeight;
}

@end
