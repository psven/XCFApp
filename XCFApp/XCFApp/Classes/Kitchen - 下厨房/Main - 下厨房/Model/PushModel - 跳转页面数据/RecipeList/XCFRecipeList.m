//
//  XCFRecipeList.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeList.h"
#import "XCFRecipe.h"
#import "XCFAuthor.h"

@implementation XCFRecipeList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"recipes" : [NSString class],
             @"sample_recipes" : [XCFRecipe class]};
}


/**
 *  整个header高度
 */
- (CGFloat)headerheight {
    CGFloat titleHeight = [self.name boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginFirstTitle * 2, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle]}
                                                 context:nil].size.height;
    if (self.desc.length) {
        CGFloat descHeight = [self.desc boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle * 2, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]}
                                                     context:nil].size.height;
        _headerheight = XCFRecipeListViewMarginHeadTitle + titleHeight + XCFRecipeListViewMarginHeadTitle2Name*5 + XCFRecipeListViewHeightAuthorName + descHeight + XCFRecipeListViewHeightCollectButton;
    } else {
        _headerheight = XCFRecipeListViewMarginHeadTitle + titleHeight + XCFRecipeListViewMarginHeadTitle2Name*5 + XCFRecipeListViewHeightAuthorName + XCFRecipeListViewHeightCollectButton;
    }
    
    return _headerheight * 1.2;
}

/**
 *  作者名字承载view宽度
 */
- (CGFloat)authorNameViewWidth {
    CGFloat authorNameWidth = [self.author.name boundingRectWithSize:CGSizeMake(MAXFLOAT, XCFRecipeListViewHeightAuthorName)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]}
                                                          context:nil].size.width;
    
//    NSString *string = @"来自：";
//    CGFloat comeLabelWidth = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, XCFRecipeListViewHeightAuthorName)
//                                                             options:NSStringDrawingUsesLineFragmentOrigin
//                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]}
//                                                             context:nil].size.width;
//    
//    XCFLog(@"%f", comeLabelWidth);
    CGFloat comeLabelWidth = 36;
    
    if (self.author.is_expert) {
        _authorNameViewWidth = authorNameWidth + comeLabelWidth + XCFRecipeListViewHeightExpertIcon + 10;
    } else {
        _authorNameViewWidth = authorNameWidth + comeLabelWidth + 5;
    }
    return _authorNameViewWidth;
}

@end
