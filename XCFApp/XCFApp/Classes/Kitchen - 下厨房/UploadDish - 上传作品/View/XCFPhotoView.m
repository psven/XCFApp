//
//  XCFPhotoView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFPhotoView.h"

@interface XCFPhotoView ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation XCFPhotoView

- (void)awakeFromNib {
    [self.deleteButton addTarget:self
                          action:@selector(deletePhoto)
                forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)photoViewWithImage:(UIImage *)image
                  deletePhotoBlock:(deletePhotoBlock)callBack {
    XCFPhotoView *photoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                             owner:self options:nil] lastObject];
    photoView.photoView.image = image;
    photoView.callBack = callBack;
    return photoView;
}

- (void)deletePhoto {
    !self.callBack ? : self.callBack();
}


@end
