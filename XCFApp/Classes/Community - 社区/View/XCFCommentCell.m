//
//  XCFCommentCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCommentCell.h"
#import "XCFTopicComment.h"
#import "XCFAuthor.h"

@interface XCFCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation XCFCommentCell

- (void)setComment:(XCFTopicComment *)comment {
    _comment = comment;
    
    if ([comment.author.name isEqualToString:[[XCFAuthor me] name]]) {
        self.icon.image = [comment.author.image circleImage];
    } else {
        [self.icon setHeaderWithURL:[NSURL URLWithString:comment.author.photo60]];
    }
    
    self.nameLabel.text = comment.author.name;
    self.content.text = comment.txt;
    self.createTime.text = comment.create_time;
}

@end
