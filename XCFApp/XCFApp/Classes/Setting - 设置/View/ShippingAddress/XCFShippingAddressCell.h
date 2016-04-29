//
//  XCFShippingAddressCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFAddressInfo;

@interface XCFShippingAddressCell : UITableViewCell
@property (nonatomic, strong) XCFAddressInfo *addressInfo;
@end
