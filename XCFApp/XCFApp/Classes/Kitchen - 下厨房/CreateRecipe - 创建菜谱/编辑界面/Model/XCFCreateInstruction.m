//
//  XCFCreateInstruction.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateInstruction.h"

@implementation XCFCreateInstruction

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_image forKey:@"instructionImage"];
    [aCoder encodeObject:_text  forKey:@"instructionText"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.image = [decoder decodeObjectForKey:@"instructionImage"];
        self.text  = [decoder decodeObjectForKey:@"instructionText"];
    }
    return self;
}


- (CGFloat)cellHeight {
    CGFloat imageHeight = 100;
    
    if (self.text.length) {
        CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(XCFScreenWidth - 60, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                     context:nil].size.height;
        _cellHeight = imageHeight + textHeight + 30;
    } else {
        _cellHeight = imageHeight + 30 + 30;
    }
    
    return _cellHeight;
}

@end
