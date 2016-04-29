//
//  XCFOrderSectionFooter.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/24.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCartItem;

@interface XCFOrderSectionFooter : UITableViewHeaderFooterView
@property (nonatomic, strong) NSArray<XCFCartItem *> *shopArray; // 模型数据
@end
