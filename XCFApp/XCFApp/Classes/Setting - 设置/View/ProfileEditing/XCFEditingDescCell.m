//
//  XCFEditingDescCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFEditingDescCell.h"

@interface XCFEditingDescCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation XCFEditingDescCell


- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEditing) name:UITextViewTextDidChangeNotification object:self.textView];
}

- (void)textFieldEndEditing {
    !self.editingDescBlock ? : self.editingDescBlock(self.textView.text);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setDisplayDesc:(NSString *)displayDesc {
    _displayDesc = displayDesc;
    self.textView.text = displayDesc;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
