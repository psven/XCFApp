//
//  XCFRecipeDish.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeDish.h"
#import "XCFDish.h"

@implementation XCFRecipeDish

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dishes" : [XCFDish class]};
}

@end
