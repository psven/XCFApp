//
//  XCFTopicCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopicCell.h"
#import "XCFTopic.h"
#import "XCFAuthor.h"

@interface XCFTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;         // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;        // 作者名称
@property (weak, nonatomic) IBOutlet UIImageView *stickIcon;    // 置顶标识
@property (weak, nonatomic) IBOutlet UILabel *topicTitle;       // 标题
@property (weak, nonatomic) IBOutlet UILabel *updateTime;       // 最后回应
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;    // 评论数
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topicLabelLeftCon;
@end

@implementation XCFTopicCell

- (void)setTopic:(XCFTopic *)topic {
    _topic = topic;
    
    if (topic.is_sticked) {
        self.stickIcon.hidden = NO;
        self.topicLabelLeftCon.constant = 30;
    } else {
        self.stickIcon.hidden = YES;
        self.topicLabelLeftCon.constant = 15;
    }
    
    [self.icon setHeaderWithURL:[NSURL URLWithString:topic.author.photo]];
    self.nameLabel.text = topic.author.name;
    self.topicTitle.text = topic.content;
    self.updateTime.text = [NSString stringWithFormat:@"最后回应：%@", topic.update_time];
    self.commentsCount.text = [NSString stringWithFormat:@"%@评论", topic.n_comments];
    
}

@end
