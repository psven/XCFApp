//
//  XCFOrderAddressView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFOrderAddressView.h"

@interface XCFOrderAddressView ()
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *addAddress;

@end

@implementation XCFOrderAddressView

- (void)awakeFromNib {
    [self.addressView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(goToAddressController)]];
}

- (void)goToAddressController {
    !self.goToAddressBlock ? : self.goToAddressBlock();
}

- (void)setAddressInfo:(XCFAddressInfo *)addressInfo {
    _addressInfo = addressInfo;
    if (addressInfo) {
        self.nameLabel.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.addressLabel.hidden = NO;
        self.addAddress.hidden = YES;
        
        self.nameLabel.text = addressInfo.name;
        self.phoneLabel.text = addressInfo.phone;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", addressInfo.province, addressInfo.detailAddress];
    } else {
        self.nameLabel.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.addressLabel.hidden = YES;
        self.addAddress.hidden = NO;
    }
}

@end
