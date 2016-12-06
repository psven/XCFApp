//
//  XCFAddTagViewController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddTagViewController.h"

@interface XCFAddTagViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XCFAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加标签";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                             target:self
                                                                             action:@selector(cancel)];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 80, XCFScreenWidth-75, 30)];
    textField.backgroundColor = XCFDishViewBackgroundColor;
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = @"请输入标签";
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *addButton = [UIButton buttonWithBackgroundColor:XCFGlobalBackgroundColor
                                                        title:@"添加"
                                               titleLabelFont:[UIFont systemFontOfSize:14]
                                                   titleColor:XCFThemeColor target:self
                                                       action:@selector(addTag)
                                                clipsToBounds:NO];
    addButton.frame = CGRectMake(CGRectGetMaxX(textField.frame), 80, 60, 30);
    [self.view addSubview:addButton];
}

- (void)addTag {
    if (self.callBack && self.textField.text.length) {
        self.callBack(self.textField.text);
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end
