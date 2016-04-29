//
//  XCFForumViewCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFForumViewCell.h"
#import "XCFForum.h"
#import "XCFAuthor.h"
#import <UIImageView+WebCache.h>

@interface XCFForumViewCell ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation XCFForumViewCell

- (void)setForum:(XCFForum *)forum {
    _forum = forum;
    
    for (NSUInteger index=0; index<forum.latest_authors.count; index++) {
        UIImageView *icon = self.headView.subviews[index];
        NSURL *url = [NSURL URLWithString:[forum.latest_authors[index] photo]];
        [icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"jamFilter2"]];
    }
    self.nameLabel.text = forum.name;
    self.descLabel.text = forum.desc;
}

@end
