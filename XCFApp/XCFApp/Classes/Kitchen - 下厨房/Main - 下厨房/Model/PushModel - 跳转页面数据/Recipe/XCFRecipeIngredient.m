//
//  XCFRecipeIngredient.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeIngredient.h"

@implementation XCFRecipeIngredient

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name      forKey:@"name"];
    [aCoder encodeObject:_amount    forKey:@"amount"];
    [aCoder encodeInteger:_state    forKey:@"state"];
    [aCoder encodeFloat:_cellHeight forKey:@"cellHeight"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name            = [decoder decodeObjectForKey:@"name"];
        self.amount          = [decoder decodeObjectForKey:@"amount"];
        self.state           = [decoder decodeIntegerForKey:@"state"];
        self.cellHeight      = [decoder decodeFloatForKey:@"cellHeight"];
    }
    return self;
}

/**
 *  为了节约时间就没有把各个常量重新定义
 */
- (CGFloat)cellHeight {
    CGFloat nameHeight = [self.name boundingRectWithSize:CGSizeMake(XCFScreenWidth*0.5 - 40, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                  context:nil].size.height;
    
    CGFloat amountHeight = [self.amount boundingRectWithSize:CGSizeMake(XCFScreenWidth*0.5 - 40, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                 context:nil].size.height;
    
    _cellHeight = (nameHeight > amountHeight) ? nameHeight : amountHeight;
    _cellHeight += 30;
    
    return _cellHeight;
}

@end
