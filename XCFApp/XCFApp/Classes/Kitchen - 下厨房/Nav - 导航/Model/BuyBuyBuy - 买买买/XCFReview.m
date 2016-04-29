//
//  XCFReview.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFReview.h"
#import "XCFReviewPhoto.h"
#import "XCFComment.h"

@implementation XCFReview

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"photos" : [XCFReviewPhoto class],
             @"additional_review_photos" : [XCFReviewPhoto class],
             @"lasted_comments" : [XCFComment class]};
}


- (CGFloat)buyCellHeight {
    
    CGFloat dishNameLabelMaxY = XCFScreenWidth + 100;
    CGFloat totalMarginHeight = 30;
    
    if (self.review.length) {
        CGFloat descHeight = [self.review boundingRectWithSize:CGSizeMake(XCFScreenWidth - 75, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                     context:nil].size.height;
        
        _buyCellHeight = dishNameLabelMaxY + descHeight + totalMarginHeight;
    } else {
        _buyCellHeight = dishNameLabelMaxY + totalMarginHeight;
    }
    
    return _buyCellHeight;
}

- (CGFloat)reviewCellHeight {
    
    CGFloat aleadyKnowHeight = 105;
    _reviewCellHeight = aleadyKnowHeight;
    
    if (self.review.length) {
        CGFloat reviewHeight = [self.review boundingRectWithSize:CGSizeMake(XCFScreenWidth - 30, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                       context:nil].size.height;
        _reviewCellHeight += reviewHeight;
    }
    if (self.photos.count) {
        _reviewCellHeight += 60; // 60 图片高度
    }
    
    return _reviewCellHeight;
}

@end
