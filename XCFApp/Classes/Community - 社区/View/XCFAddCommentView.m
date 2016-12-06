//
//  XCFAddCommentView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddCommentView.h"
#import "XCFAuthor.h"

@interface XCFAddCommentView () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, assign) NSUInteger length;        // 记录文字长度
@property (nonatomic, strong) NSMutableArray *atUsers;  // 记录被@的用户（发送评论时通过闭包传递给控制器，控制器发送网络请求到服务器）
@end

@implementation XCFAddCommentView

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self.textView];
    self.textView.delegate = self;
    [self.sendButton addTarget:self
                        action:@selector(send)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 事件处理

// 每次编辑都取出最后一个字符，判断是否显示“能@的用户界面”
- (void)textViewDidChange:(UITextView *)textView {
    NSString *lastString;
    NSUInteger location = textView.text.length-1; // 取出最后一个字符
    if (self.textView.text.length>0) {
        lastString = [self.textView.text substringWithRange:NSMakeRange(location, 1)];
    }
    !self.atUserBlock ? : self.atUserBlock(lastString);
}

// 回传textView上的文字
- (void)textViewTextDidChange:(NSNotification *)note {
    !self.editingTextBlock ? : self.editingTextBlock(self.textView.text);
}

- (void)send {
    !self.sendCmtBlock ? : self.sendCmtBlock(self.textView.text, self.atUsers);
    // 重置编辑框frame
    if (self.textView.text.length) {
        self.frame = CGRectMake(0, XCFScreenHeight-44, XCFScreenWidth, 44);
    }
    // 发送完清空输入框的文字
    self.textView.text = @"";
}


#pragma mark - 属性

- (void)setAuthor:(XCFAuthor *)author {
    _author = author;
    NSMutableString *displayString = [NSMutableString stringWithString:self.textView.text];
    NSRange range = [self.textView.text rangeOfString:author.name];
    if (range.location == NSNotFound) { // 不存在相同昵称
        // 添加字符串
        [displayString appendString:[NSString stringWithFormat:@"@%@ ", author.name]];
        // 添加到@用户数组
        [self.atUsers addObject:author];
        
    } else {
        NSRange fullRange = NSMakeRange(range.location-1, range.length+2);
        [displayString deleteCharactersInRange:fullRange];
        [self.atUsers removeObject:author];
    }
    
    self.textView.text = displayString;
    [self.textView becomeFirstResponder]; // @用户 弹出键盘
    !self.editingTextBlock ? : self.editingTextBlock(self.textView.text); // 更新输入框frame
}

- (NSMutableArray *)atUsers {
    if(!_atUsers) _atUsers = [NSMutableArray array];
    return _atUsers;
}


+ (instancetype)addCommentViewWithEditingTextBlock:(EditingTextBlock)editingTextBlock
                                      sendCmtBlock:(SendCmtBlock)sendCmtBlock {
    XCFAddCommentView *cmtView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                                owner:nil options:nil] lastObject];
    cmtView.editingTextBlock = editingTextBlock;
    cmtView.sendCmtBlock = sendCmtBlock;
    return cmtView;
}



@end
