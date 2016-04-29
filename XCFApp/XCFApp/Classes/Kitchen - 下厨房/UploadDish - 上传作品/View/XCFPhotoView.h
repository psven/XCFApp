//
//  XCFPhotoView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^deletePhotoBlock)();

@interface XCFPhotoView : UIView

@property (nonatomic, strong) UIImage *image; // 图片
@property (nonatomic, copy) deletePhotoBlock callBack; // 删除图片回调

+ (instancetype)photoViewWithImage:(UIImage *)image deletePhotoBlock:(deletePhotoBlock)callBack;

@end
