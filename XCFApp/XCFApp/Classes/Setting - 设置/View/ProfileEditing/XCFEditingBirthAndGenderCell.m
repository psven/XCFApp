//
//  XCFEditingBirthAndGenderCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFEditingBirthAndGenderCell.h"

@interface XCFEditingBirthAndGenderCell () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *birthdayPicker;
@property (weak, nonatomic) IBOutlet UIButton *male;
@property (weak, nonatomic) IBOutlet UIButton *female;
@property (weak, nonatomic) IBOutlet UIButton *otherSex;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation XCFEditingBirthAndGenderCell

- (void)awakeFromNib {
    [self setupDatePicker];
    
    [self.male addTarget:self action:@selector(setSexToMale:) forControlEvents:UIControlEventTouchUpInside];
    [self.female addTarget:self action:@selector(setSexToFemale:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherSex addTarget:self action:@selector(setSexToOtherSex:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDatePicker {
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = XCFDishViewBackgroundColor;
    self.birthdayPicker.inputView = _datePicker;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 44)];
    toolbar.backgroundColor = XCFDishViewBackgroundColor;
    UIBarButtonItem *cancelButton = [UIBarButtonItem barButtonItemWithTitle:@"取消" target:self action:@selector(cancelPicking)];
    UIBarButtonItem *doneButton = [UIBarButtonItem barButtonItemWithTitle:@"完成" target:self action:@selector(done)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[cancelButton, flexible, doneButton];
    self.birthdayPicker.inputAccessoryView = toolbar;
}

#pragma mark - 事件处理

- (void)cancelPicking {
    [self endEditing:YES];
}

- (void)done {
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dmt = [[NSDateFormatter alloc] init];
    dmt.dateFormat = @"yyyy-MM-dd";
    NSString *displayDate = [dmt stringFromDate:date];
    self.birthdayPicker.text = displayDate;
    [self endEditing:YES];
    !self.editingBirthBlock ? : self.editingBirthBlock(displayDate);
}

- (void)setSexToMale:(UIButton *)sender {
    sender.selected = YES;
    self.female.selected = NO;
    self.otherSex.selected = NO;
    !self.editingSexBlock ? : self.editingSexBlock(sender.titleLabel.text);
}

- (void)setSexToFemale:(UIButton *)sender {
    sender.selected = YES;
    self.male.selected = NO;
    self.otherSex.selected = NO;
    !self.editingSexBlock ? : self.editingSexBlock(sender.titleLabel.text);
}

- (void)setSexToOtherSex:(UIButton *)sender {
    sender.selected = YES;
    self.male.selected = NO;
    self.female.selected = NO;
    !self.editingSexBlock ? : self.editingSexBlock(sender.titleLabel.text);
}


#pragma mark - 构造方法

- (void)setDisplaySex:(NSString *)displaySex {
    _displaySex = displaySex;
    if ([self.male.titleLabel.text isEqualToString:displaySex] || !displaySex.length) self.male.selected = YES;
    if ([self.female.titleLabel.text isEqualToString:displaySex]) self.female.selected = YES;
    if ([self.otherSex.titleLabel.text isEqualToString:displaySex]) self.otherSex.selected = YES;
}

- (void)setDisplayBirth:(NSString *)displayBirth {
    _displayBirth = displayBirth;
    self.birthdayPicker.text = displayBirth;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
