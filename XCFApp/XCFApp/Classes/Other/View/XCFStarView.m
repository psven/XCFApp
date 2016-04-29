//
//  XCFStarView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFStarView.h"
#import <Masonry.h>

@interface XCFStarView ()

@end

@implementation XCFStarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat iconWidth = 13;
        for (NSUInteger index=0; index<5; index++) {
            UIImageView *icon = [[UIImageView alloc] init];
            [self addSubview:icon];
            [icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(iconWidth*index);
                make.top.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(iconWidth, iconWidth));
            }];
        }
        
    }
    return self;
}

- (void)setRate:(CGFloat)rate {
    _rate = rate;
    
    NSUInteger number = rate * 10;
    NSUInteger enableStarCount = number / 10;
    NSUInteger remainder = number % 10;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSUInteger index=0; index<enableStarCount; index++) {
        [imageArray addObject:enabledStar];
    }
    
    if (0<remainder && remainder <= 5) { // 如果0<余数<=5， 显示enableStarCount个enableStar + 一个halfStar
        [imageArray addObject:halfStar];
    } else if (remainder > 5) { // 如果余数大于5，显示一个star，即 enableStarCount + 1 个enableStar
        [imageArray addObject:enabledStar];
    }
    
    if (imageArray.count < 5) {
        NSUInteger delta = 5 - imageArray.count;
        for (NSUInteger index=0; index<delta; index++) {
            [imageArray addObject:disabledStar];
        }
    }
    
    for (NSUInteger index=0; index<5; index++) {
        UIImageView *subView = self.subviews[index];
        subView.image = [UIImage imageNamed:imageArray[index]];
    }
    
}

+ (instancetype)starViewWithRate:(CGFloat)rate {
//    NSUInteger number = rate * 10;
//    NSUInteger enableStarCount = number / 10;
//    NSUInteger remainder = number % 10;
//    
//    NSMutableArray *imageArray = [NSMutableArray array];
//    for (NSUInteger index=0; index<enableStarCount; index++) {
//        [imageArray addObject:enabledStar];
//    }
//    
//    if (0<remainder && remainder <= 5) { // 如果0<余数<=5， 显示enableStarCount个enableStar + 一个halfStar
//        [imageArray addObject:halfStar];
//    } else if (remainder > 5) { // 如果余数大于5，显示一个star，即 enableStarCount + 1 个enableStar
//        [imageArray addObject:enabledStar];
//    }
//    
//    if (imageArray.count < 5) {
//        for (NSUInteger index=0; index<(5-imageArray.count); index++) {
//            [imageArray addObject:disabledStar];
//        }
//    }
    
//    for (NSUInteger index=0; index<5; index++) {
//        UIImageView *subView = starView.subviews[index];
//        subView.image = [UIImage imageNamed:imageArray[index]];
//    }
    
    XCFStarView *starView = [[XCFStarView alloc] init];
    starView.rate = rate;
    return starView;
}



@end
