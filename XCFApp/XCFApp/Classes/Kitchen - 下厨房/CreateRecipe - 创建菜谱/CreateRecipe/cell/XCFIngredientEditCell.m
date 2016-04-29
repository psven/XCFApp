//
//  XCFIngredientEditCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientEditCell.h"
#import "XCFCreateIngredient.h"

@interface XCFIngredientEditCell () //<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@end

@implementation XCFIngredientEditCell

- (void)awakeFromNib {
    // 这种情况下不适合用代理
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldEndEditing)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldEndEditing)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.amountField];
}

- (void)textFieldEndEditing {
    XCFCreateIngredient *ingredient = [[XCFCreateIngredient alloc] init];
    ingredient.name = self.nameField.text;
    ingredient.amount = self.amountField.text;
    !self.editCallBackBlock ? : self.editCallBackBlock(ingredient);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholderArray:(NSArray *)placeholderArray {
    _placeholderArray = placeholderArray;
    self.nameField.placeholder = placeholderArray[0];
    self.amountField.placeholder = placeholderArray[1];
}

- (void)setIngredient:(XCFCreateIngredient *)ingredient {
    _ingredient = ingredient;
    self.nameField.text = ingredient.name;
    self.amountField.text = ingredient.amount;
}

- (void)becomeFirstResponder {
    [self.nameField becomeFirstResponder];
}


@end
