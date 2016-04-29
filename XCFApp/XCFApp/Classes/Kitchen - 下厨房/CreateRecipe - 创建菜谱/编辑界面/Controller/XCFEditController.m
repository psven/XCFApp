//
//  XCFEditController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFEditController.h"

@interface XCFEditController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation XCFEditController

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.backgroundColor = [UIColor clearColor];
        [_textView becomeFirstResponder];
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"保存"
                                                                              target:self
                                                                              action:@selector(save)];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                              target:self
                                                                              action:@selector(cancel)];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
}


- (void)save {
    !self.doneEditBlock ? : self.doneEditBlock(self.textView.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)initWithTitle:(NSString *)title
               currentContent:(NSString *)currentContent
                doneEditBlock:(doneEditBlock)block {
    if (self = [super init]) {
        self.title = title;
        self.textView.text = currentContent;
        self.doneEditBlock = block;
    }
    return self;
}


@end
