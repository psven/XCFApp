//
//  FeedBackView.m
//  XCFApp
//
//  Created by Joey on 2019/3/31.
//  Copyright © 2019 Joey. All rights reserved.
//

#import "FeedBackView.h"

@interface FeedBackView ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedBackView

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.textView becomeFirstResponder];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEdit)]];
}

- (void)cancelEdit {
    [self.textView resignFirstResponder];
}

- (IBAction)commit:(id)sender {
    
    if (self.textView.text.length < 1) {
        [UILabel showStats:@"请输入反馈意见！" atView:self];
        return;
    }
    self.commitBlock();
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
