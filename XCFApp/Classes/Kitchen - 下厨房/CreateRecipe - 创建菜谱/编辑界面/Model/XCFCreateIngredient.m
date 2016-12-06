//
//  XCFCreateIngredient.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateIngredient.h"

@implementation XCFCreateIngredient

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_amount forKey:@"amount"];
    [aCoder encodeObject:_name   forKey:@"ingredientName"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.amount = [decoder decodeObjectForKey:@"amount"];
        self.name   = [decoder decodeObjectForKey:@"ingredientName"];
    }
    return self;
}

- (CGFloat)cellHeight {
    CGFloat nameHeight = [self.name boundingRectWithSize:CGSizeMake(XCFScreenWidth*0.5 - 45, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                 context:nil].size.height;
    CGFloat amountHeight = [self.amount boundingRectWithSize:CGSizeMake(XCFScreenWidth*0.5 - 45, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                     context:nil].size.height;
    
    _cellHeight = (nameHeight > amountHeight) ? nameHeight : amountHeight;
    _cellHeight += 30;
    
    return _cellHeight;
}

@end
