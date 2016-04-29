//
//  XCFDetailReviewCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFReview, XCFGoodsKind;

@interface XCFDetailReviewCell : UITableViewCell
@property (nonatomic, strong) XCFReview *review;
@property (nonatomic, copy) void (^showImageBlock)(NSUInteger, CGRect); // 展示图片
@end
