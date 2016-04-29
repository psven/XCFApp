//
//  XCFOrderAddressView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCFAddressInfo.h"

@interface XCFOrderAddressView : UIView
@property (nonatomic, strong) XCFAddressInfo *addressInfo;
@property (nonatomic, copy) void (^goToAddressBlock)();
@end
