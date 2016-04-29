//
//  XCFCreateTipsCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateTipsCell.h"
#import <Masonry.h>

@interface XCFCreateTipsCell ()

@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) XCFAddMark *tipsMark;

@end


@implementation XCFCreateTipsCell

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.font = [UIFont systemFontOfSize:14];
        _tipsLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }
    return _tipsLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        
        _tipsMark = [XCFAddMark tipsMarkWithTarget:nil action:nil];
        [self.contentView addSubview:_tipsMark];
        [_tipsMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 30));
        }];
    }
    return self;
}

- (void)setTips:(NSString *)tips {
    _tips = tips;
    if (tips.length) {
        self.tipsMark.hidden = YES;
        self.tipsLabel.hidden = NO;
        self.tipsLabel.text = tips;
    } else {
        self.tipsMark.hidden = NO;
        self.tipsLabel.hidden = YES;
    }
}

@end
