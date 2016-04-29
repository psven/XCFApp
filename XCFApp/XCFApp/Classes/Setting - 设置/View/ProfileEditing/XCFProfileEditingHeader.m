//
//  XCFProfileEditingHeader.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFProfileEditingHeader.h"

@interface XCFProfileEditingHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *uploadIcon;
@end

@implementation XCFProfileEditingHeader

- (void)awakeFromNib {
    [self.icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upload)]];
    [self.uploadIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upload)]];
}

- (void)setDisplayImage:(UIImage *)displayImage {
    _displayImage = displayImage;
    if (displayImage) self.icon.image = displayImage;
}

- (void)upload {
    !self.uploadIconBlock ? : self.uploadIconBlock();
}

@end
