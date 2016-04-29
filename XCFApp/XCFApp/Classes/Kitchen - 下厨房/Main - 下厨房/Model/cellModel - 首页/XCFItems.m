//
//  XCFItems.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFItems.h"
#import "XCFContents.h"
#import "XCFImage.h"
#import <MJExtension.h>

@implementation XCFItems

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (CGFloat)cellHeight {
    
    if (self.template == XCFCellTemplateTopic || self.template == XCFCellTemplateRecipe) {
        
        CGFloat imageHeight = self.contents.image.height;
        
        CGFloat titleHeight = [self.contents.title boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle * 3, MAXFLOAT)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle]}
                                                                context:nil].size.height;
        CGFloat descHeight = [self.contents.desc boundingRectWithSize:CGSizeMake(XCFScreenWidth - XCFRecipeCellMarginTitle * 2, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:XCFRecipeCellFontSizeDesc]}
                                                              context:nil].size.height;
        _cellHeight = imageHeight + XCFRecipeCellMarginTitle + titleHeight + XCFRecipeCellMarginTitle2Desc + descHeight + XCFRecipeCellMarginTitle2Desc;
        
        
    } else if (self.template == XCFCellTemplateRecipeList || self.template == XCFCellTemplateDish || self.template == XCFCellTemplateWeeklyMagazine) {
        _cellHeight = self.contents.image.height;
    }
    
    return _cellHeight;
}

@end
