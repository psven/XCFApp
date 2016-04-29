//
//  XCFTagView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTagView.h"

@interface XCFTagView ()
@property (weak, nonatomic) IBOutlet UILabel *tagText;
@property (weak, nonatomic) IBOutlet UIButton *deleteTagButton;

@end

@implementation XCFTagView

- (void)awakeFromNib {
    [self.deleteTagButton addTarget:self
                             action:@selector(deleteTag)
                   forControlEvents:UIControlEventTouchUpInside];
}

+ (instancetype)tagViewWithString:(NSString *)string deleteTagBlock:(deleteTagBlock)callBack {
    XCFTagView *tagView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                         owner:self options:nil] lastObject];
    tagView.tagText.text = string;
    tagView.callBack = callBack;
    return tagView;
}

- (void)deleteTag {
    !self.callBack ? : self.callBack();
}

@end
