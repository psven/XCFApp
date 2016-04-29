//
//  XCFGoodsAttrs.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFGoodsAttrs.h"

@implementation XCFGoodsAttrs

- (CGFloat)cellHeight {
    NSString *string = [NSString stringWithFormat:@"%@：%@", self.name, self.value];
    _cellHeight = [string boundingRectWithSize:CGSizeMake(XCFScreenWidth-30, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                                       context:nil].size.height;
    return _cellHeight;
}


//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeInteger:_index      forKey:@"index"];
//    [aCoder encodeObject:_value       forKey:@"value"];
//    [aCoder encodeObject:_name        forKey:@"name"];
//    [aCoder encodeFloat:_cellHeight   forKey:@"cellHeight"];
//}
//
//- (instancetype)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        self.index        = [decoder decodeIntegerForKey:@"index"];
//        self.value        = [decoder decodeObjectForKey:@"value"];
//        self.name         = [decoder decodeObjectForKey:@"name"];
//        self.cellHeight   = [decoder decodeFloatForKey:@"cellHeight"];
//    }
//    return self;
//}

@end
