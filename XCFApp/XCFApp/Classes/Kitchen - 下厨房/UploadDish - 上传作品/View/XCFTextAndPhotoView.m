//
//  XCFTextAndPhotoView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTextAndPhotoView.h"
#import "XCFPhotoView.h"
#import <Masonry.h>

@interface XCFTextAndPhotoView () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UIView *photosView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTopCon;
@end

@implementation XCFTextAndPhotoView

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingText)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self.textView];
    [self.addPhotoButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)editingText {
    !self.editingTextBlock ? : self.editingTextBlock(self.textView.text);
}

- (void)addPhoto {
    !self.addPhotoBlock ? : self.addPhotoBlock();
}

- (void)setPhotosArray:(NSArray *)photosArray {
    _photosArray = photosArray;
    
    // 每次进来就清空存在的图片
    for (id subview in self.photosView.subviews) {
        if (![subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    
    NSInteger lineCount = 4;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 88;
    CGFloat height = width;
    
    for (NSInteger index=0; index<photosArray.count; index++) {
        // 计算位置
        NSInteger line = index / lineCount;
        NSInteger colunms = index % lineCount;
        x = 10 + width*colunms;
        y = height * line;
        
        WeakSelf;
        XCFPhotoView *photoView = [XCFPhotoView photoViewWithImage:photosArray[index] deletePhotoBlock:^{
            !weakSelf.deletePhotoBlock ? : weakSelf.deletePhotoBlock(index);
        }];
        photoView.frame = CGRectMake(x, y, width, height);
        [self.photosView addSubview:photoView];
    }
    
    if (photosArray.count) { // 如果存在图片就更新 添加按钮 的约束
        NSInteger addBtnLine = photosArray.count / lineCount;
        NSInteger addBtnColunms = photosArray.count % lineCount;
        self.buttonLeftCon.constant = 10 + width * addBtnColunms;
        self.buttonTopCon.constant = height * addBtnLine;
    } else {
        self.buttonLeftCon.constant = 10;
        self.buttonTopCon.constant = 0;
    }
}


@end
