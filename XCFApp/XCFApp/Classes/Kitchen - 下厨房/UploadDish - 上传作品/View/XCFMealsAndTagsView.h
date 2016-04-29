//
//  XCFMealsAndTagsView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFMealsAndTagsView : UIView
@property (nonatomic, strong) NSArray *tagsArray; // 标签数组
@property (nonatomic, copy) void (^selectedMealBlock)(NSString *);
@property (nonatomic, copy) void (^addTagBlock)();
@property (nonatomic, copy) void (^deleteTagBlock)(NSUInteger); // 删除标签回调
@end
