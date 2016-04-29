//
//  XCFMyViewHeader.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMyViewHeader.h"
#import "XCFMeInfoView.h"
#import "XCFMeSwitchView.h"
#import "XCFMyLocateNDescView.h"
#import "XCFAuthorDetail.h"

#import <Masonry.h>

@interface XCFMyViewHeader ()
@property (nonatomic, strong) XCFMeInfoView *infoView;
@property (nonatomic, strong) XCFMeSwitchView *switchView;
@property (nonatomic, strong) XCFMyLocateNDescView *bottomView;
@end

@implementation XCFMyViewHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _infoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFMeInfoView class])
                                                   owner:self options:nil] lastObject];
        [self addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 120));
        }];
        
        _switchView = [[XCFMeSwitchView alloc] init];
        [self addSubview:_switchView];
        [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.infoView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 60));
        }];
        
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFMyLocateNDescView class])
                                                     owner:self options:nil] lastObject];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.switchView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 200));
        }];
    }
    return self;
}


- (void)setAuthorDetail:(XCFAuthorDetail *)authorDetail {
    _authorDetail = authorDetail;
    if (authorDetail.type == XCFAuthorTypeOther) {
        [self.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 150));
        }];
        [self.switchView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 0));
        }];
    }
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, authorDetail.descHeight+44+40+40));
    }];
    
    self.infoView.authorDetail = authorDetail;
    self.bottomView.authorDetail = authorDetail;
}

@end
