//
//  XCFRecipe.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipe.h"
#import "XCFRecipeInstruction.h"
#import "XCFRecipeIngredient.h"
#import "XCFAuthor.h"
#import "XCFRecipeStats.h"

@implementation XCFRecipe

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name          forKey:@"name"];
    [aCoder encodeObject:_ingredient    forKey:@"ingredient"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name           = [decoder decodeObjectForKey:@"name"];
        self.ingredient     = [decoder decodeObjectForKey:@"ingredient"];
    }
    return self;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"instruction" : [XCFRecipeInstruction class],
             @"ingredient"  : [XCFRecipeIngredient class],
             @"dish_author" : [XCFAuthor class]};
}

/**
 *  整个header高度 为了节约时间就没有把各个常量重新定义
 */
- (CGFloat)headerheight {
    CGFloat titleHeight = [self.name boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginFirstTitle * 2, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle]}
                                                  context:nil].size.height;
    
    CGFloat exclusiveIconHeight = self.is_exclusive ? 20 : 0;
    
    if (self.desc.length) {
        CGFloat descHeight = [self.desc boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle * 2, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]}
                                                     context:nil].size.height;
        
        
        _headerheight = 250 + XCFRecipeListViewMarginHeadTitle*3 + titleHeight + XCFRecipeListViewMarginHeadTitle2Name*3 + XCFRecipeListViewHeightAuthorName*3 + descHeight + XCFAuthorHeaderWidth+10 + exclusiveIconHeight + 10*2 + 5;
    } else {
        _headerheight = 250 + XCFRecipeListViewMarginHeadTitle*2 + titleHeight + XCFRecipeListViewMarginHeadTitle2Name*3 + XCFRecipeListViewHeightAuthorName*3 + XCFAuthorHeaderWidth+10 + exclusiveIconHeight + 10*2 + 5;
    }
    
    return _headerheight;
}

/**
 *  菜谱评分、做过人数承载view宽度
 */
- (CGFloat)statsViewWidth {
    
    NSString *cookedText = [NSString stringWithFormat:@"%@人最近7天做过", self.stats.n_cooked];
    CGFloat cookedLabelWidth = [cookedText boundingRectWithSize:CGSizeMake(MAXFLOAT, XCFRecipeListViewHeightAuthorName)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]}
                                                        context:nil].size.width;
    
    if (self.score.length) {
        NSString *scoreText = [NSString stringWithFormat:@"%@综合评分", self.score];
        CGFloat scoreLabelWidth = [scoreText boundingRectWithSize:CGSizeMake(MAXFLOAT, XCFRecipeListViewHeightAuthorName)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]}
                                                          context:nil].size.width;
        
        _statsViewWidth = scoreLabelWidth + cookedLabelWidth + 15;
    } else {
        
        _statsViewWidth = cookedLabelWidth;
    }
    return _statsViewWidth;
}


@end
