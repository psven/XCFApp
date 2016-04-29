//
//  XCFShippingAddressCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFShippingAddressCell.h"
#import "XCFAddressInfo.h"

@interface XCFShippingAddressCell ()
@property (weak, nonatomic) IBOutlet UIButton *yesMark;
@property (weak, nonatomic) IBOutlet UILabel *nameAndPhone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@end

@implementation XCFShippingAddressCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setAddressInfo:(XCFAddressInfo *)addressInfo {
    _addressInfo = addressInfo;
    if (addressInfo.state == XCFAddressInfoCellStateSelected) {
        self.yesMark.selected = YES;
        self.nameAndPhone.textColor = [UIColor blackColor];
        self.address.textColor = [UIColor blackColor];
        self.contentView.backgroundColor = XCFAddressCellColor;
    } else if (addressInfo.state == XCFAddressInfoCellStateNone) {
        self.yesMark.selected = NO;
        self.nameAndPhone.textColor = [UIColor darkGrayColor];
        self.address.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
    }
    self.nameAndPhone.text = [NSString stringWithFormat:@"%@ %@", addressInfo.name, addressInfo.phone];
    self.address.text = [NSString stringWithFormat:@"%@ %@", addressInfo.province, addressInfo.detailAddress];
}


@end
