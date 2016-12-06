//
//  XCFMyInfoCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMyInfoCell.h"
#import "XCFAuthorDetail.h"

@interface XCFMyInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *signInInfo;
@end

@implementation XCFMyInfoCell

- (void)setAuthorDetail:(XCFAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
//    [self.iconView setHeaderWithURL:[NSURL URLWithString:authorDetail.photo]];
    if (authorDetail.image) self.iconView.image = [authorDetail.image circleImage];
    self.name.text = authorDetail.name;
}

@end
