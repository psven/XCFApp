//
//  XCFStarView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/14.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFStarView : UIView

/** 评分 */
@property (nonatomic, assign) CGFloat rate;

+ (instancetype)starViewWithRate:(CGFloat)rate;

@end
