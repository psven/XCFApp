//
//  XCFTextAndPhotoView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFTextAndPhotoView : UIView
@property (nonatomic, strong) NSArray *photosArray; // 标签数组
@property (nonatomic, copy) void (^editingTextBlock)(NSString *);   // 编辑文字
@property (nonatomic, copy) void (^addPhotoBlock)();                // 添加图片
@property (nonatomic, copy) void (^deletePhotoBlock)(NSUInteger);   // 添加图片
@end
