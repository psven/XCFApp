//
//  XCFAddAddressView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddAddressView.h"
#import <Masonry.h>

@interface XCFAddAddressView ()
@property (nonatomic, strong) XCFAddMark *addMark;
@end

@implementation XCFAddAddressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _addMark = [XCFAddMark addMarkWithTitle:@"添加地址" Target:self action:@selector(addAddress)];
        [self addSubview:_addMark];
        [_addMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 30));
        }];
    }
    return self;
}

- (void)addAddress {
    !self.addAddressBlock ? : self.addAddressBlock();
}


@end
