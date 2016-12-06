//
//  XCFAddressEditingController.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFAddressInfo;

@interface XCFAddressEditingController : UITableViewController
@property (nonatomic, assign) NSInteger infoIndex; // 收货地址数据的下标
@property (nonatomic, strong) XCFAddressInfo *addressInfo;
@end
