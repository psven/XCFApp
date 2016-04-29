//
//  XCFEditingTextCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFEditingTextCell.h"

@interface XCFEditingTextCell () //<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation XCFEditingTextCell

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEndEditing) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)textFieldEndEditing {
    !self.editingTextBlock ? : self.editingTextBlock(self.textField.text);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setDisplayName:(NSString *)displayName {
    _displayName = displayName;
    self.textField.text = displayName;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
