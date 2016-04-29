//
//  XCFRecipeInstruction.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeInstruction.h"

@implementation XCFRecipeInstruction

- (CGFloat)cellHeight {
    
    CGFloat descHeight = [self.text boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle * 4, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]}
                                                 context:nil].size.height;
    
    if (self.url.length) {
        _cellHeight = 180 + descHeight + XCFRecipeCellMarginTitle * 3;
    } else {
        _cellHeight = descHeight + XCFRecipeCellMarginTitle * 2;
    }
    
    return _cellHeight;
}


@end
